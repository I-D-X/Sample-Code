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
<title>PHP MyVirtual RCCB Example</title>
</head>

<body>

<?php

//Setting variables for use in the webservice invokation...

$URL = "https://virtual.mygateglobal.com/PaymentPage.cfm";

$Mode = "0"; //0 = Test Mode. 1 = Live Mode

//Be sure to populate these variables with the ones you generated in the MyGate Developer Center. Go there now by going to http://developer.mygateglobal.com
$MerchantID = "";
$ApplicationID = "";

//Currency and price of initial transaction
$Currency = "ZAR";
$Amount = "0.01";

//Redirect Details
$RedirectSuccess = "http://localhost:8888/CodeSnippets/RCCBVirtual/processResults.php";
$RedirectFailed = "http://localhost:8888/CodeSnippets/RCCBVirtual/processResults.php";

//RCCB Variables
//The frequency determines when the transaction will go off.
$Frequency = "M|1";
//This is the start date of the first reocurring transaction.
$StartDate = "01-JUN-2012";
$EndDate = "01-JUN-2013";

//The amount that is to go ff after the initial amount specified above
$RecurringAmount = "0.01";

//Client details are used for reporting features in the MyGate web console
$ClientName = "Mr J Soap";
$ClientAccountNo = "Client12345";
$ClientEmailAddress = "joe.soap@gmail.com";
$ClientMobileNumber = "0821234567";

//These flags indicate whether you want MyGate to notify the client of the upcoming transaction via SMS and/or email. 0 = No. 1 = Yes.
$SMSClient = "0";
$EmailClient = "0";

?>

<h1>My Virtual RCCB Example</h1>

<form name="Virtual Post" action="<?php echo($URL); ?>" method="post">
    <input name="Mode" type="hidden" value="<?php echo($Mode); ?>" /> <br />
    <input name="MerchantID" type="hidden" value="<?php echo($MerchantID); ?>" /><br />
    <input name="ApplicationID" type="hidden" value="<?php echo($ApplicationID); ?>" /><br />
    Amount: R<input name="Amount" type="text" value="<?php echo($Amount); ?>" /><br />
    <input name="Currency" type="hidden" value="<?php echo($Currency); ?>" /><br />
    <input name="RedirectSuccessfulURL" type="hidden" value="<?php echo($RedirectSuccess); ?>" /><br />
    <input name="RedirectFailedURL" type="hidden" value="<?php echo($RedirectFailed); ?>" /><br />
    <input type="hidden" name="ACCB_Frequency" value="<?php echo($Frequency); ?>">
	<input type="hidden" name="ACCB_StartDate" value="<?php echo($StartDate); ?>">
	<input type="hidden" name="ACCB_EndDate" value="<?php echo($EndDate); ?>">
	<input type="hidden" name="ACCB_Amount" value="<?php echo($RecurringAmount); ?>">
	<input type="hidden" name="ACCB_ClientName" value="<?php echo($ClientName); ?>">
	<input type="hidden" name="ACCB_ClientAccountNo" value="<?php echo($ClientAccountNo); ?>">
	<input type="hidden" name="ACCB_ClientEmailAddress" value="<?php echo($ClientEmailAddress); ?>">
	<input type="hidden" name="ACCB_ClientMobileNumber" value="<?php echo($ClientMobileNumber); ?>">
	<input type="hidden" name="ACCB_ClientSendSMS" value="<?php echo($SMSClient); ?>">
	<input type="hidden" name="ACCB_ClientSendEmail" value="<?php echo($EmailClient); ?>">
    <input type="submit" name="submit" value="Process Transaction">
</form>

</body>
</html>