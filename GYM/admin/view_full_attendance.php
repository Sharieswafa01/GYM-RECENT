<?php
session_start();

// Set PHP timezone to Philippine Standard Time
date_default_timezone_set('Asia/Manila');

if (!isset($_SESSION['admin_id'])) {
    header("Location: admin_login.php");
    exit();
}

include('../user/db_connection.php');

// Set MySQL timezone to Philippine time
$conn->query("SET time_zone = '+08:00'");

$today = date('Y-m-d');

$query = "
    SELECT 
        a.id, 
        CONCAT(u.first_name, ' ', u.last_name) AS full_name, 
        u.role, 
        a.status, 
        a.login_time, 
        a.logout_time 
    FROM attendance a
    JOIN users u ON a.user_id = u.id
    WHERE DATE(a.timestamp) = ?
    ORDER BY a.timestamp DESC
";

$stmt = $conn->prepare($query);
$stmt->bind_param("s", $today);
$stmt->execute();
$result = $stmt->get_result();

$total = $result->num_rows;
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Full Attendance List</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 20px;
        }

        .back-wrapper {
            margin-bottom: 20px;
        }

        .back-btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: rgb(22, 225, 83);
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
        }

        .back-btn:hover {
            background-color: #4CAF50;
        }

        .container {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            max-width: 1100px;
            margin: auto;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #f9f9f9;
        }

        table th, table td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ccc;
        }

        thead {
            background-color: #ddd;
        }

        .status-login {
            color: #4CAF50;
            font-weight: bold;
        }

        .status-logout {
            color: #F44336;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <!-- Back Button Above Container -->
    <div class="back-wrapper">
        <a class="back-btn" href="attendance_tracking.php"><i class="fas fa-arrow-left"></i> </a>
    </div>

    <div class="container">
        <h2>Full Attendance List (<?= htmlspecialchars($today) ?>)</h2>
        <table>
            <thead>
                <tr>
                    <th>No.</th>
                    <th>Full Name</th>
                    <th>Role</th>
                    <th>Status</th>
                    <th>Login Time</th>
                    <th>Logout Time</th>
                </tr>
            </thead>
            <tbody>
                <?php 
                if ($result && $result->num_rows > 0): 
                    $count = $total;
                    while($row = $result->fetch_assoc()): ?>
                        <tr>
                            <td><?= $count-- ?></td>
                            <td><?= htmlspecialchars($row['full_name']) ?></td>
                            <td><?= htmlspecialchars($row['role']) ?></td>
                            <td class="<?= $row['status'] === 'Login' ? 'status-login' : 'status-logout' ?>">
                                <?= htmlspecialchars($row['status']) ?>
                            </td>
                            <td><?= $row['login_time'] ? htmlspecialchars($row['login_time']) : '—' ?></td>
                            <td><?= $row['logout_time'] ? htmlspecialchars($row['logout_time']) : '—' ?></td>
                        </tr>
                    <?php endwhile;
                else: ?>
                    <tr><td colspan="6">No attendance records found.</td></tr>
                <?php endif; ?>
            </tbody>
        </table>
    </div>

</body>
</html>
