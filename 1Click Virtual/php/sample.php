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
<title>PHP MyVirtual Example</title>
</head>

<body>

<?php

//Setting variables for use in the webservice invokation...

$URL = "https://www.mygate.co.za/virtual/8x0x0/dsp_ecommercepaymentparent.cfm";

$Mode = "0"; //0 = Test Mode. 1 = Live Mode

//Be sure to change these to the ones provided to you by MyGate
$MerchantID = "";
$ApplicationID = "";

//Merchant reference
$MerchantRef = "UniqueMerchantRef";

//Client Token - Must be unique
$ClientToken = "Token123";

//Currency and price of transaction
$Currency = "ZAR";
$Amount = "0.01";

//Redirect Details
$RedirectSuccess = "http://localhost:8888/CodeSnippets/1ClickVirtual/processResults.php";
$RedirectFailed = "http://localhost:8888/CodeSnippets/1ClickVirtual/processResults.php";

?>

<h1>My Virtual Example</h1>

<form name="Virtual Post" action="<?php echo($URL); ?>" method="post">
    <input name="Mode" type="hidden" value="<?php echo($Mode); ?>" /> <br />
    <input name="txtMerchantID" type="hidden" value="<?php echo($MerchantID); ?>" /><br />
    <input name="txtApplicationID" type="hidden" value="<?php echo($ApplicationID); ?>" /><br />
    <input name="txtMerchantReference" type="hidden" value="<?php echo($MerchantRef); ?>" /><br />
    <input name="txtRedirectSuccessfulURL" type="hidden" value="<?php echo($RedirectSuccess); ?>" /><br />
    <input name="txtRedirectFailedURL" type="hidden" value="<?php echo($RedirectFailed); ?>" /><br />
    Amount: R<input name="txtPrice" type="text" value="<?php echo($Amount); ?>" /><br />
    <input name="txtCurrencyCode" type="hidden" value="<?php echo($Currency); ?>" /><br />
    <input name="txtDisplayPrice" type="hidden" value="<?php echo($Amount); ?>" /><br />
    <input name="txtDisplayCurrencyCode" type="hidden" value="<?php echo($Currency); ?>" /><br />
    <input name="Variable1" type="hidden" value="My additional value that can contain letters and numbers 1234567890"><br />
    <input name="txtClientToken" type="hidden" value="<?php echo($ClientToken); ?>" /><br />
    <input type="submit" name="submit" value="Process Transaction">
</form>

</body>
</html>