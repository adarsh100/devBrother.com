<?php
mysql_connect("localhost","root","root");
mysql_select_db("devbrother");
extract($_POST);
$query = "INSERT INTO `subscribers` (`subscribers_name`, `subscribers_email`, `subscribe_time`) VALUES ('$name', '$email', CURRENT_TIMESTAMP)";
$var = mysql_query($query) or die(mysql_error());
echo ($var) ? "true" : "false";
?>
