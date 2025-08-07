<?php 
session_start();
include('../user/db_connection.php');

if (!isset($_SESSION['admin_id'])) {
    header("Location: admin_login.php");
    exit();
}

// Fetch admin profile picture
$adminId = $_SESSION['admin_id'];
$adminQuery = $conn->prepare("SELECT profile_picture FROM admin WHERE admin_id = ?");
$adminQuery->bind_param("i", $adminId);
$adminQuery->execute();
$adminResult = $adminQuery->get_result();
$adminData = $adminResult->fetch_assoc();
$adminPhoto = !empty($adminData['profile_picture']) ? '../uploads/admins/' . htmlspecialchars($adminData['profile_picture']) : 'default_user.png';

// Count new notifications
$newUsersQuery = "SELECT COUNT(*) as count FROM users WHERE created_at >= NOW() - INTERVAL 1 DAY";
$newUsersCount = $conn->query($newUsersQuery)->fetch_assoc()['count'];

$expiringMembershipsQuery = "
    SELECT COUNT(*) as count
    FROM memberships m
    JOIN users u ON u.id = m.user_id
    WHERE DATE_ADD(m.start_date, INTERVAL m.duration DAY) <= NOW() + INTERVAL 1 DAY
      AND DATE_ADD(m.start_date, INTERVAL m.duration DAY) > NOW()
";
$expiringCount = $conn->query($expiringMembershipsQuery)->fetch_assoc()['count'];

$notificationCount = $newUsersCount + $expiringCount;

// Count data for dashboard
$userCount = $conn->query("SELECT COUNT(*) as total_users FROM users")->fetch_assoc()['total_users'];
$equipmentCount = $conn->query("SELECT COUNT(*) as total_equipment FROM equipment")->fetch_assoc()['total_equipment'];
$activeNow = $conn->query("
    SELECT COUNT(*) AS active_now 
    FROM attendance 
    WHERE DATE(timestamp) = CURDATE() AND status = 'Login' AND logout_time IS NULL
")->fetch_assoc()['active_now'];
$membershipCount = $conn->query("SELECT COUNT(*) as total_memberships FROM memberships")->fetch_assoc()['total_memberships'];
$totalToday = $conn->query("SELECT COUNT(*) as total_today FROM attendance WHERE DATE(timestamp) = CURDATE()")->fetch_assoc()['total_today'];

$recentResult = $conn->query("
    SELECT 
        a.id, 
        CONCAT(u.first_name, ' ', u.last_name) AS full_name, 
        u.role, 
        a.status, 
        a.login_time, 
        a.logout_time 
    FROM attendance a
    JOIN users u ON a.user_id = u.id
    WHERE DATE(a.timestamp) = CURDATE()
    ORDER BY a.timestamp DESC
    LIMIT 5
");

$rows = $recentResult->fetch_all(MYSQLI_ASSOC);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/all.min.css">
    <style>
        .blinking {
            animation: blink 1s infinite;
        }
        @keyframes blink {
            0%, 100% { opacity: 1; }
            50% { opacity: 0; }
        }

        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
        }
        .dashboard-wrapper {
            display: flex;
            height: 100vh;
            overflow: hidden;
        }
        .sidebar {
            width: 290px;
            background-color: #111;
            color: #fff;
            padding: 20px;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
        }
        .sidebar .logo {
            text-align: center;
            padding: 30px 0 20px;
            border-bottom: 1px solid #444;
            margin-bottom: 30px;
        }
        .sidebar .logo h2 {
            margin: 0;
            font-size: 28px;
            font-weight: 600;
        }
        .sidebar .nav ul {
            list-style: none;
            padding: 0;
        }
        .sidebar .nav ul li {
            margin: 18px 0;
        }
        .sidebar .nav ul li a {
            font-size: 18px;
            color: #fff;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 15px;
            border-radius: 6px;
            transition: background 0.3s;
        }
        .sidebar .nav ul li a:hover {
            background-color: #333;
            color: #4caf50;
        }
        .sidebar-logout a {
            color: #fff;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 60px;
            font-weight: bold;
            font-size: 18px;
            padding: 10px 15px;
            border-radius: 6px;
            transition: background 0.3s;
        }
        .sidebar-logout a:hover {
            background-color: #333;
            color: #f44336;
        }
        .main-content {
            margin-left: 290px;
            padding: 40px;
            flex: 1;
            overflow-y: auto;
        }
        h1 {
            font-size: 2.2rem;
            margin-bottom: 20px;
            color: #333;
        }
        .dashboard-cards {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            margin-bottom: 40px;
        }
        .card-link {
            text-decoration: none;
            color: inherit;
            flex: 1;
            min-width: 250px;
        }
        .card {
            background-color: #ffffff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0 25px rgba(0, 0, 0, 0.15);
        }
        .card i {
            font-size: 40px;
            margin-bottom: 10px;
            color: #4CAF50;
        }
        .card h3 {
            margin: 10px 0 5px;
            font-size: 22px;
        }
        .card .count {
            font-size: 28px;
            font-weight: bold;
            color: #222;
        }
        .attendance-tracking {
            background: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        .attendance-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .attendance-header h2 {
            font-size: 1.6rem;
            color: #222;
            margin: 0;
        }
        .view-all {
            font-size: 14px;
            text-decoration: none;
            color: #4CAF50;
            font-weight: bold;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #f9f9f9;
            margin-top: 15px;
        }
        thead {
            background-color: #ddd;
        }
        table th, table td {
            padding: 14px;
            text-align: left;
            border-bottom: 1px solid #ccc;
        }
        .status-login {
            color: #4CAF50;
            font-weight: bold;
        }
        .status-logout {
            color: #F44336;
            font-weight: bold;
        }

        /* 👤 Profile + 🔔 Notification */
        .top-icons {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1000;
            display: flex;
            align-items: center;
            gap: 20px;
        }
        .top-icons a {
            text-decoration: none;
            position: relative;
        }
        .top-icons .notification-icon i {
            font-size: 22px;
            color: #333;
        }
        .top-icons .notification-icon:hover i {
            color: #4CAF50;
        }
        .top-icons .profile-pic img {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #4CAF50;
        }
        .badge {
            position: absolute;
            top: -6px;
            right: -6px;
            background: red;
            color: white;
            font-size: 10px;
            font-weight: bold;
            padding: 2px 6px;
            border-radius: 50%;
        }

        @media (max-width: 768px) {
            .dashboard-wrapper {
                flex-direction: column;
            }
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }
            .main-content {
                margin-left: 0;
                padding: 20px;
            }
            .dashboard-cards {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>

<!-- 👤 Profile + 🔔 Notification Icons -->
<audio id="notifSound" src="../assets/notification.mp3" preload="auto"></audio>

<!-- 👤 Profile + 🔔 Notification Icons -->
<div class="top-icons">
    <a href="notifications.php" class="notification-icon" id="notifBell" title="Notifications">
        <i class="fas fa-bell"></i>
        <?php if ($notificationCount > 0): ?>
        <span class="badge"><?= $notificationCount ?></span>
        <?php endif; ?>
    </a>
    <a href="admin_profile.php" class="profile-pic" title="Admin Profile">
        <img src="<?= $adminPhoto ?>" alt="Admin">
    </a>
</div>

<script>
    let currentCount = <?= $notificationCount ?>;
    let notifSound = document.getElementById("notifSound");

    function checkNotifications() {
        fetch('fetch_notifications.php')
            .then(res => res.json())
            .then(data => {
                const newCount = data.total;
                const bell = document.getElementById("notifBell");
                const badge = bell.querySelector(".badge");

                if (newCount > currentCount) {
                    notifSound.play();
                    bell.classList.add("blinking");
                }
                if (newCount > 0) {
                    if (badge) badge.textContent = newCount;
                    else bell.insertAdjacentHTML('beforeend', `<span class="badge">${newCount}</span>`);
                } else {
                    bell.classList.remove("blinking");
                    if (badge) badge.remove();
                }

                currentCount = newCount;
            });
    }

    document.getElementById("notifBell").addEventListener("click", () => {
        currentCount = 0;
        fetch("reset_notification_count.php", { method: "POST" });
        document.querySelector("#notifBell .badge")?.remove();
        document.querySelector("#notifBell").classList.remove("blinking");
    });

    setInterval(checkNotifications, 10000);
</script>

<div class="dashboard-wrapper">
    <aside class="sidebar">
        <div class="logo">
            <h2>Gym Admin</h2>
        </div>
        <nav class="nav">
            <ul>
                <li><a href="admin_dashboard.php"><i class="fas fa-chart-line"></i> Dashboard</a></li>
                <li><a href="attendance_tracking.php"><i class="fas fa-calendar-check"></i> Attendance Tracking</a></li>
                <li><a href="manage_users.php"><i class="fas fa-user-friends"></i> Manage Users</a></li>
                <li><a href="manage_equipment.php"><i class="fas fa-dumbbell"></i> Equipment</a></li>
                <li><a href="announcement.php"><i class="fas fa-bullhorn"></i> Announcements</a></li>
                <li><a href="manage_membership.php"><i class="fas fa-credit-card"></i> Membership</a></li>
            </ul>
        </nav>
        <div class="sidebar-logout">
            <a href="admin_logout.php"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </aside>

    <div class="main-content">
        <h1>Welcome to Dashboard</h1>
        <section class="dashboard-cards">
            <a class="card-link" href="attendance_tracking.php">
                <div class="card">
                    <i class="fas fa-user-check"></i>
                    <h3>Active Today</h3>
                    <p>Total Active: <span class="count"><?= $activeNow ?></span></p>
                </div>
            </a>
            <a class="card-link" href="manage_users.php">
                <div class="card">
                    <i class="fas fa-user-friends"></i>
                    <h3>Users</h3>
                    <p>Total Users: <span class="count"><?= $userCount ?></span></p>
                </div>
            </a>
            <a class="card-link" href="manage_equipment.php">
                <div class="card">
                    <i class="fas fa-dumbbell"></i>
                    <h3>Equipment</h3>
                    <p>Total Equipment: <span class="count"><?= $equipmentCount ?></span></p>
                </div>
            </a>
            <a class="card-link" href="manage_membership.php">
                <div class="card">
                    <i class="fas fa-credit-card"></i>
                    <h3>Membership</h3>
                    <p>Total Plans: <span class="count"><?= $membershipCount ?></span></p>
                </div>
            </a>
        </section>

        <section class="attendance-tracking">
            <div class="attendance-header">
                <h2>Today's Attendance Records</h2>
                <a href="view_full_attendance.php" class="view-all">View All</a>
            </div>
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
                    <?php if (count($rows) > 0): ?>
                        <?php foreach ($rows as $index => $row): ?>
                            <tr>
                                <td><?= $totalToday - $index ?></td>
                                <td><?= htmlspecialchars($row['full_name']) ?></td>
                                <td><?= htmlspecialchars($row['role']) ?></td>
                                <td class="<?= $row['status'] === 'Login' ? 'status-login' : 'status-logout' ?>">
                                    <?= htmlspecialchars($row['status']) ?>
                                </td>
                                <td><?= $row['login_time'] ?: '—' ?></td>
                                <td><?= $row['logout_time'] ?: '—' ?></td>
                            </tr>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <tr><td colspan="6">No attendance records found for today.</td></tr>
                    <?php endif; ?>
                </tbody>
            </table>
        </section>
    </div>
</div>
</body>
</html>


