<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'];
    $name = $_POST['name'];
    $end_date = $_POST['end_date'];

    $subject = "Gym Membership Expiry Alert";
    $message = "Hi $name,\n\nThis is a reminder that your gym membership will expire on $end_date. Please visit the gym to renew and continue enjoying the services.\n\n- CTU Danao Gym Admin";

    if (mail($email, $subject, $message)) {
        echo "<script>alert('Alert sent to $email successfully.'); window.history.back();</script>";
    } else {
        echo "<script>alert('Failed to send alert.'); window.history.back();</script>";
    }
}
?>
