<?php
session_start();
echo "Logout Successfully ";
session_destroy();   // function that Destroys Session
header("Location:http://192.168.99.100:4000/index.php.html");
?>


