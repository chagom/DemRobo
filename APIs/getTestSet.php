<?php
ini_set("display_errors", "1");
include 'config.php';

header('Content-Type: application/json; charset=utf8');

$conn = mysqli_connect($serverName, $userName, $password, $dbName) or die('mysql connection error'.mysqli_error($conn));

$getLastIdx = "SELECT MAX(QUESTION_IDX) AS Largetst from demrobo_question";
$lastIdx = $conn->query($getLastIdx);

if($lastIdx < 1)
{
	$randomNum = 1;
}
else
{
	$randomNum = mt_rand(1,$lastIdx);
}

$query = ("SELECT SET_FIRST, SET_SECOND from demrobo_question where SET_IDX = '$randomNum'");

$result = $conn->query($query);
$row = mysqli_fetch_array($result);

$response = array();

if($row[0] == "")
{
	$response["result"] = "failure";
	
}
else
{
	$response["result"] = "success";
	$question = array("idx"=>(string)$randomNum, "firstSet"=>(string)$row[0], "secondSet"=>(string)$row[1]);
	$response["question"] = array($question);
}

echo urldecode(json_encode($response));


?>

