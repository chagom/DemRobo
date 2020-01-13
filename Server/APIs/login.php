<?php
ini_set("display_errors", "1");
include 'config.php';

header('Content-Type: application/json; charset=utf8');

$data = json_decode(file_get_contents('php://input'), true);
//print_r($data);
//echo $data['info']['PAT_ID'];
//echo $data['info']['PAT_PW'];
$conn = mysqli_connect($serverName, $userName, $password, $dbName) or die('mysql connection error'.mysqli_error($conn));

if($conn->connect_error) {
	die('[ERROR] : DB connection has failed');
}


$userId = $data['info']['PAT_ID'];
$userPw = $data['info']['PAT_PW'];
//$sessionId = $data['info']['PAT_SESSION'];

$query = "SELECT EXISTS(SELECT (PAT_NAME, PAT_PW) from demrobo_patients values ('$userId', '$userPw'))";


$repsonse = array();

if($conn->query($query) == TRUE)
{
	array_push($response, array('result' => 'success',
								'info' => array('')
								));
	session_save_path('./session');
	session_start();
	$_SESSION['arg'] = $
}
else
{	
	array($response, array('result' => 'failure'));
}

echo json_decode($response);

mysqli_close($conn);
*/
?>
