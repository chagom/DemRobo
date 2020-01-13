<?php
// enroll test results from ipad
ini_set("display_errors", "1");
include 'config.php';


echo "hello";

header('Content-Type: application/json; charset=utf8');
$data = json_decode(file_get_contents('php://input'), true);

$conn = mysqli_connect($serverName, $userName, $password, $dbName) or mysqli_error($conn));

if($conn-> connect_error) {
	die('[ERR] : DB CONNECTION FAILED');
}

$testIdx = $data['info']['TEST_IDX'];
$patIdx = $data['info']['PAT_IDX'];
$testSet = $data['info']['TEST_SET'];
$fourthSet = $data['info']['TEST_FOURTH_SET'];


$insertQuery = ("INSERT INTO demrobo_testresults (TEST_IDX, PAT_IDX, TEST_SET, TEST_FOURTH_SET) values ('$testIdx', '$patIdx', '$testSet', '$fourthSet')");

$response = array();

if($conn->query($insertQuery) == TRUE)
{
	$response["status"] = "OK";
}
else 
{
	$response['status'] = "failure";
}

echo json_encode($response);



?>
