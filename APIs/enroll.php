<?php
//ini_set("display_errors", "1");
include 'config.php';

header('Content-Type: application/json; charset=utf8');

//if $(_POST)
{
	$data = json_decode(file_get_contents('php://input'), true);
	//print_r($data);
}

$db_conn = mysqli_connect($serverName, $userName, $password, $dbName) or die('mysql connection error'.mysqli_error($conn));

if($db_conn->connect_error) {
	die('[ERROR] : DB CONNECTION FAILED');
}

$getLastIndex = "SELECT MAX(PAT_IDX) AS Largest from demrobo_patients";

$result = $db_conn->query($getLastIndex);
$row = mysqli_fetch_array($result);

$newIdx = $row["Largest"] + 1;
$name = $data['info']['PAT_NAME'];
$birth = $data['info']['PAT_BIRTH'];
$edu = $data['info']['PAT_EDUCATION'];
$hos = $data['info']['PAT_HOSPITAL'];
$phone = $data['info']['PAT_PHONE'];
$password = $data['info']['PAT_PW'];
$recent = $data['info']['PAT_RECENT'];

$query = ("INSERT INTO demrobo_patients (PAT_IDX, PAT_NAME, PAT_BIRTH, PAT_EDUCATION, PAT_HOSPITAL, PAT_PHONE, PAT_RECENT, PAT_ID, PAT_PW, PAT_STATE, PAT_CHARGE) values ('$newIdx', '$name', '$birth', '$edu', '$hos', '$phone', '$recent', '$name', '$password', 'NOR', '1')");

$response = array();

if($db_conn->query($query) == TRUE)
{
	
	$sessArg = $name.$newIdx;
	session_save_path('./session');
	session_start();
	$_SESSION['arg'] = $sessArg;
	
	//array_push($response, array('result'=>'success', 
	//							'info'=> array('idx'=>$newIdx, 'sess' => session_id())));
	$response["status"] = "OK";
	$info = array("idx"=>(string)$newIdx, "sess"=>session_id());
	$response["info"] = array($info);
}
else	// failure
{
	//echo mysqli_errno($db_conn) . ": " .mysqli_error($db_conn);
	//print_r(mysqli_error($db_conn));
	//array_push($response, array('result'=>'failure'));
	$response["status"] = "failure";
}

//print_r($response);

//print_r(urldecode(json_encode($response)));
//var_dump(json_encode($response));
echo json_encode($response);

mysqli_close($db_conn);
?>
