<?php include('login.php'); // Includes Login Script

if(isset($_SESSION['login_user'])){
//header("location: welcome.php");
}

 echo gethostname();
  echo "hostname";

 ?>  




<!DOCTYPE html>
<html>
<head>
<title>Performance 360</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<style>
body {
  font-family: "Open Sans", sans-serif;
  height: 100vh;
  background: url("https://i.imgur.com/HgflTDf.jpg") 50% fixed;
  background-size: cover;
}
.form-wrapper input[type="submit"] {
   display: block;
   background: #0dd39d;
   border: none;
   padding: 10px 20px;
   -moz-border-radius: 2px;
   border-radius: 2px;
   cursor: pointer;
 }

img {
    position: absolute;
	right: 300px;
    bottom: 0px;
}
</style>
<body>
<div id="main">
<h1>ADP Performance 360 Application</h1>
<fieldset >
<legend>Login</legend>
<input type='hidden' name='submitted' id='submitted' value='1'/>

<label for='username' >UserName*:</label>
<input type='text' name='username' id='username' placeholder="username"  maxlength="50" />

<label for='password' >Password*:</label>
<input type='password' name='password' id='password' placeholder="**********" maxlength="50" />
<form enctype="multipart/form-data" action="/welcome.php" method="POST">
<input type='submit' name='Submit' value='Login' style='width: 10%;height:6%; position: absolute; right: 600px; margin-top: -32px;' />
</form>
</fieldset>
</div>

</body>

<img src="adp logo" alt="W3Schools.com" style='width: 50%; float: bottom;'>
</html>


