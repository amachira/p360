<?php  session_start();   // session starts with the help of this function 
?>

<?php



if(isset($_POST['submit']))   // it checks whether the user clicked login button or not 
{

if (empty($_POST['username']) || empty($_POST['password'])) {

header('location:index.php?msg=Please enter some username and password');

$error = "Username or Password is invalid";
echo "Enter the Username and password";
}
else
{
     $username = $_POST['username'];
     $password = $_POST['password'];

      if($username == "testuser" && $password == "1234")  
       {	  
		          
        //echo '<script type="text/javascript"> window.open("welcome.php","_self");</script>';         
		header('Location:welcome.php');
        }

        else
        {
            echo "invalid UserName or Password";    
			header('location:index.php?msg=Please enter some username and password');			
        }
}
}
 ?>


