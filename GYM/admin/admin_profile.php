<?php
session_start();
include('../user/db_connection.php');

if (!isset($_SESSION['admin_id'])) {
    header("Location: admin_login.php");
    exit();
}

$adminId = $_SESSION['admin_id'];

// Get admin info
$query = $conn->prepare("SELECT * FROM admin WHERE admin_id = ?");
$query->bind_param("i", $adminId);
$query->execute();
$result = $query->get_result();
$admin = $result->fetch_assoc();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Profile</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/all.min.css">
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #e8f5e9, #f1f8e9);
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            padding: 40px 20px;
        }

        .back-button {
            position: absolute;
            top: 20px;
            left: 20px;
            z-index: 100;
        }

        .back-button a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background-color: #4CAF50;
            color: white;
            border-radius: 8px;
            font-size: 18px;
            text-decoration: none;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: background 0.3s ease;
        }

        .back-button a:hover {
            background-color: #43a047;
        }

        .container {
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(10px);
            border-radius: 16px;
            padding: 30px;
            max-width: 700px;
            width: 100%;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
            animation: fadeIn 0.4s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .container h2 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 26px;
            color: #2e7d32;
        }

        .profile-header {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }

        .profile-header img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #4CAF50;
        }

        .profile-info {
            flex: 1;
        }

        .profile-info .name {
            font-size: 24px;
            font-weight: bold;
            color: #1b5e20;
        }

        .profile-info .title {
            font-size: 16px;
            color: #4e944f;
        }

        .profile-field {
            margin: 12px 0;
            display: flex;
            flex-wrap: wrap;
        }

        .label {
            font-weight: 600;
            width: 130px;
            color: #2e7d32;
        }

        .value {
            color: #1b5e20;
        }

        .actions {
            text-align: center;
            margin-top: 30px;
        }

        .actions a {
            display: inline-block;
            margin: 8px;
            padding: 10px 18px;
            font-size: 14px;
            border-radius: 6px;
            text-decoration: none;
            background-color: #4CAF50;
            color: white;
            transition: background 0.3s ease;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .actions a:hover {
            background-color: #43a047;
        }

        @media (max-width: 600px) {
            .profile-header {
                flex-direction: column;
                align-items: center;
                text-align: center;
            }

            .profile-info .name {
                font-size: 20px;
            }

            .profile-info .title {
                font-size: 14px;
            }

            .label {
                width: 100%;
                margin-bottom: 4px;
            }

            .value {
                width: 100%;
                margin-bottom: 10px;
            }

            .actions a {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<div class="back-button">
    <a href="admin_dashboard.php" title="Back"><i class="fas fa-arrow-left"></i></a>
</div>

<div class="container">
    <h2>Admin Profile</h2>

    <?php if ($admin): ?>
        <div class="profile-header">
            <img src="<?= !empty($admin['profile_picture']) ? '../uploads/admins/' . htmlspecialchars($admin['profile_picture']) : 'default_user.png' ?>" alt="Admin Photo">
            <div class="profile-info">
                <div class="name"><?= htmlspecialchars($admin['full_name'] ?? 'N/A') ?></div>
                <div class="title"><?= htmlspecialchars($admin['title'] ?? 'N/A') ?></div>
            </div>
        </div>

        <div class="profile-field">
            <div class="label">Full Name:</div>
            <div class="value"><?= htmlspecialchars($admin['full_name'] ?? 'N/A') ?></div>
        </div>

        <div class="profile-field">
            <div class="label">Username:</div>
            <div class="value"><?= htmlspecialchars($admin['username'] ?? 'N/A') ?></div>
        </div>

        <div class="profile-field">
            <div class="label">Email:</div>
            <div class="value"><?= htmlspecialchars($admin['email'] ?? 'N/A') ?></div>
        </div>

        <div class="profile-field">
            <div class="label">Title:</div>
            <div class="value"><?= htmlspecialchars($admin['title'] ?? 'N/A') ?></div>
        </div>

        <div class="actions">
            <a href="admin_edit_profile.php"><i class="fas fa-edit"></i> Edit Info</a>
            <a href="admin_change_password.php"><i class="fas fa-key"></i> Change Password</a>
        </div>
    <?php else: ?>
        <p style="color: red; text-align:center;">Admin profile not found.</p>
    <?php endif; ?>
</div>

</body>
</html>
