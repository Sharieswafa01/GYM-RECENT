<?php
session_start();
include('../user/db_connection.php');

if (!isset($_SESSION['admin_id'])) {
    header("Location: admin_login.php");
    exit();
}

$adminId = $_SESSION['admin_id'];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $current = $_POST['current_password'];
    $new = $_POST['new_password'];
    $confirm = $_POST['confirm_password'];

    $query = $conn->prepare("SELECT password FROM admin WHERE admin_id = ?");
    $query->bind_param("i", $adminId);
    $query->execute();
    $result = $query->get_result();
    $admin = $result->fetch_assoc();

    if (password_verify($current, $admin['password'])) {
        if ($new === $confirm) {
            $hashed = password_hash($new, PASSWORD_DEFAULT);
            $update = $conn->prepare("UPDATE admin SET password = ? WHERE admin_id = ?");
            $update->bind_param("si", $hashed, $adminId);
            $update->execute();
            $success = "Password updated successfully.";
        } else {
            $error = "New passwords do not match.";
        }
    } else {
        $error = "Current password is incorrect.";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
    <link rel="stylesheet" href="css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body {
            background: linear-gradient(to right, #4CAF50, #81C784);
            font-family: 'Segoe UI', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 0;
            position: relative;
        }

        .back-button {
            position: absolute;
            top: 20px;
            left: 20px;
        }

        .back-button a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background-color: white;
            color: #4CAF50;
            border-radius: 8px;
            font-size: 18px;
            text-decoration: none;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: background 0.3s;
        }

        .back-button a:hover {
            background-color: #f1f8e9;
        }

        .form-container {
            backdrop-filter: blur(12px);
            background: rgba(255, 255, 255, 0.25);
            padding: 30px 40px;
            border-radius: 20px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 450px;
            color: #fff;
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #ffffff;
        }

        label {
            margin-top: 10px;
            display: block;
            font-weight: 500;
        }

        .password-group {
            position: relative;
            margin-top: 5px;
        }

        .password-group input {
            width: 100%;
            padding: 10px 40px 10px 10px;
            border: none;
            border-radius: 8px;
            background-color: rgba(255, 255, 255, 0.95);
            color: #333;
            font-size: 14px;
            box-sizing: border-box;
        }

        .toggle-password {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #555;
        }

        .strength-meter {
            margin-top: 5px;
            font-size: 13px;
            font-weight: bold;
        }

        .strength-meter.weak { color: red; }
        .strength-meter.medium { color: orange; }
        .strength-meter.strong { color: green; }

        input[type="submit"] {
            background: #ffffff;
            color: #4CAF50;
            border: none;
            margin-top: 20px;
            padding: 12px;
            width: 100%;
            border-radius: 8px;
            font-weight: bold;
            font-size: 15px;
            cursor: pointer;
            transition: background 0.3s;
        }

        input[type="submit"]:hover {
            background: #f1f8e9;
        }

        .msg {
            color: #e8f5e9;
            background: rgba(0, 128, 0, 0.3);
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 8px;
            text-align: center;
        }

        .error {
            color: #ffebee;
            background: rgba(244, 67, 54, 0.3);
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 8px;
            text-align: center;
        }

        @media (max-width: 600px) {
            .form-container {
                padding: 20px;
                margin: 20px;
            }
            .back-button {
                top: 10px;
                left: 10px;
            }
        }
    </style>
</head>
<body>

<div class="back-button">
    <a href="admin_profile.php" title="Back"><i class="fas fa-arrow-left"></i></a>
</div>

<div class="form-container">
    <h2>Change Password</h2>

    <?php if (isset($error)): ?>
        <div class="error"><?= $error ?></div>
    <?php endif; ?>

    <?php if (isset($success)): ?>
        <div class="msg"><?= $success ?></div>
    <?php endif; ?>

    <form method="post">
        <label>Current Password</label>
        <div class="password-group">
            <input type="password" name="current_password" id="current_password" required>
            <i class="fas fa-eye toggle-password" toggle="#current_password"></i>
        </div>

        <label>New Password</label>
        <div class="password-group">
            <input type="password" name="new_password" id="new_password" required onkeyup="checkStrength()">
            <i class="fas fa-eye toggle-password" toggle="#new_password"></i>
        </div>
        <div id="strength-meter" class="strength-meter"></div>

        <label>Confirm New Password</label>
        <div class="password-group">
            <input type="password" name="confirm_password" id="confirm_password" required>
            <i class="fas fa-eye toggle-password" toggle="#confirm_password"></i>
        </div>

        <input type="submit" value="Update Password">
    </form>
</div>

<script>
    // Toggle password visibility
    document.querySelectorAll('.toggle-password').forEach(icon => {
        icon.addEventListener('click', function () {
            const input = document.querySelector(this.getAttribute('toggle'));
            if (input.type === "password") {
                input.type = "text";
                this.classList.remove("fa-eye");
                this.classList.add("fa-eye-slash");
            } else {
                input.type = "password";
                this.classList.remove("fa-eye-slash");
                this.classList.add("fa-eye");
            }
        });
    });

    // Password strength checker
    function checkStrength() {
        const pwd = document.getElementById("new_password").value;
        const meter = document.getElementById("strength-meter");

        if (pwd.length === 0) {
            meter.textContent = '';
            meter.className = 'strength-meter';
            return;
        }

        let strength = 0;
        if (pwd.length >= 8) strength++;
        if (/[a-z]/.test(pwd)) strength++;
        if (/[A-Z]/.test(pwd)) strength++;
        if (/[0-9]/.test(pwd)) strength++;
        if (/[\W]/.test(pwd)) strength++;

        if (strength <= 2) {
            meter.textContent = 'Weak';
            meter.className = 'strength-meter weak';
        } else if (strength <= 4) {
            meter.textContent = 'Medium';
            meter.className = 'strength-meter medium';
        } else {
            meter.textContent = 'Strong';
            meter.className = 'strength-meter strong';
        }
    }
</script>

</body>
</html>
