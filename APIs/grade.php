<?php

include 'config.php';

header('Content-Type: application/json; charset=utf8');

//$reqMethod = $_SERVER['REQUEST_METHOD'];

//if(!isset($_GET['function'])) {
//    die('[ERROR] : NOT GET FUNCTION');
//}

$patientID = $_GET['patid'];

$conn = mysqli_connect($serverName, $userName, $password, $dbName) or die('mysql connection error'.mysqli_error($conn));

if($conn->connect_error) {
        die('[ERROR] : DB CONNECTION FAILED');
}

$query = "SELECT PAT_STATE FROM demrobo_patients where PAT_IDX = '$patientID' ";
$result = $conn->query($query);
//print_r($result);
$response = array();



if($result)
{
	while($row = mysqli_fetch_array($result))
	{
		//array_push($response, 
		//	array('id'=>$patientID,
		//	'state'=>$row[0]
		//));
		$response["status"] = "OK";
		$patient = array("id"=>(string)$patientID, "state"=>(string)$row[0]);
		$response["patient"] = array($patient);
		
	}

}


//print_r (urldecode (json_encode ($response) ) );
echo urldecode( json_encode ( $response ) );

mysqli_close($conn);

?>
