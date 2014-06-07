<!---
+-----------------------------------------------------------------------------+
| MyGate Communications - ColdFusion Enterprise Auth and Settle Sample        |
| Copyright (c) 2007 MyGate Communications (Pty) Ltd                  		  |
| All rights reserved.                                                        |
+-----------------------------------------------------------------------------+
| The initial developer of the original code is MyGate Global		          |
+-----------------------------------------------------------------------------+

 * "ColdFusion MyVirtual Sample" payment page
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
<title>ColdFusion MyVirtual Example</title>
</head>

<body>

<!---Setting variables that get sent to MyGate --->

<cfset Webservice = "https://virtual.mygateglobal.com/PaymentPage.cfm" />

<!---0 = Test Mode. 1 = Live Mode--->
<cfset Mode="0" />

<!---Be sure to populate these variables with the ones you generated in the MyGate Developer Center. Go there now by going to http://developer.mygateglobal.com--->
<cfset MerchantUID="" />
<cfset ApplicationUID="" />

<!---The amount to be processed--->
<cfset Price="0.01" />

<!--- Currency and price of transaction --->
<cfset Currency="ZAR" />

<!--- Redirect Details --->
<cfset RedirectSuccessURL="http://localhost/processResults.cfm" />
<cfset RedirectFailedURL="http://localhost/processResults.cfm" />

<cfset MerchantReference="" />

<h1>My Virtual Example</h1>

<cfform name="Virtual Post" action="#Webservice#" method="post">
    <cfinput name="Mode" type="hidden" value="#Mode#" /> <br />
    <cfinput name="txtMerchantID" type="hidden" value="#MerchantUID#" /><br />
    <cfinput name="txtApplicationID" type="hidden" value="#ApplicationUID#" /><br />
    <cfinput name="txtMerchantReference" type="hidden" value="#MerchantReference#" /><br />
    <cfinput name="txtRedirectSuccessfulURL" type="hidden" value="#RedirectSuccessURL#" /><br />
    <cfinput name="txtRedirectFailedURL" type="hidden" value="#RedirectFailedURL#" /><br />
    Amount: R<cfinput name="txtPrice" type="text" value="#Price#" /><br />
    <cfinput name="txtCurrencyCode" type="hidden" value="#Currency#" /><br />
    <cfinput name="txtDisplayPrice" type="hidden" value="#Price#" /><br />
    <cfinput name="txtDisplayCurrencyCode" type="hidden" value="#Currency#" /><br />
    <cfinput type="submit" name="submit" value="Process Transaction">
</cfform>

</body>
</html>