<!---
+-----------------------------------------------------------------------------+
| MyGate Communications - PHP Enterprise Auth and Settle Sample               |
| Copyright (c) 2007 MyGate Communications (Pty) Ltd                  		  |
| All rights reserved.                                                        |
+-----------------------------------------------------------------------------+
| The initial developer of the original code is MyGate Global		          |
+-----------------------------------------------------------------------------+

 * "PHP MyVirtual Sample" payment page
 *
 * @category   Code Sample
 * @package    MyGate Communications (Pty) Ltd
 * @subpackage Virtual Transaction (Please contact MyGate to enable immediate settlement if your account requires it)
 * @author     MyGate Global - support@mygateglobal.com
 * @copyright  Copyright (c) 2007 MyGate Communications (Pty) Ltd
 * @link       http://www.mygateglobal.com/
 * 
 * @Note	   This code serves as an example only. It is not recommended that you use this code for production purposes.
 --->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>PHP MyVirtual Results</title>
</head>

<body>

<?php

//print_r($_POST); //Uncomment this line if you want to print out every value MyGate sends back.

//Populate PHP variables with the POST back variables MyGate sends
$result=$_POST['_RESULT'];
$errorCode=$_POST['_ERROR_CODE'];
$errorSource=$_POST['_ERROR_SOURCE'];
$errorMessage=$_POST['_ERROR_MESSAGE'];
$errorDetail=$_POST['_ERROR_DETAIL'];

$variable1=$_POST["VARIABLE1"];

$bankErrorCode=$_POST["_BANK_ERROR_CODE"];
$bankErrorMessage=$_POST["_BANK_ERROR_MESSAGE"];

$cardCountry=$_POST["_CARDCOUNTRY"];
$price=$_POST["TXTPRICE"];
$threedsecure=$_POST["_3DSTATUS"];

//The $_POST['_RESULT'] element of the form post is the transaction result. 0=Successful, 1=Warning (A result of 1 is returned either when the fraud module is providing a flag or if unnecessary parameters were sent to the API in the request message). Note: A result code of 1 is still a successful transaction.
if($result >= 0) {
	echo("Successful Transaction");
	echo("<br />");
	echo("Card Country: " . $cardCountry);
	echo("<br />");
	echo("Processed Amount: " . $price);
	echo("<br />");
	echo("3D-Secure Status: " . $threedsecure);
	echo("<br />");
	echo("Custom Variable: " . $variable1);
}
else {
	//In the event of a failed transaction, most merchants will only display the bank error message to the client as this will often give the most descriptive message relevant to the client. E.g. Insufficient funds, Blocked Card, etc.
	echo("Failed Transaction");
	echo("<br />");
	echo("Error Code: " . $errorCode);
	echo("<br />");
	echo("Error Message: " . $errorMessage);
	echo("<br />");
	echo("Error Details: " . $errorDetail);
	echo("<br />");
	echo("Custom Variable: " . $variable1);
	echo("<br />");
	echo("<br />");
	echo("Bank Error Code: " . $bankErrorCode);
	echo("<br />");
	echo("Bank Error Message: " . $bankErrorMessage);
}

?>

</body>
</html>