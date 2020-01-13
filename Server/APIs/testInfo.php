<?php
// enroll test results from ipad

include 'config.php';

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





$insertQuery = ("INSERT INTO demrobo_testresults (TEST_IDX, PAT_IDX, TEST_SET)");



?>
