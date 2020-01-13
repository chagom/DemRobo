<?php
ini_set("display_errors", "1");
echo(getcwd());

session_save_path('./session');
session_start();
$_SESSION['title'] = 'hello';
echo $_SESSION['title'];
echo file_get_contents('./session/sess_'.session_id());


?>
