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
<title>ColdFusion MyVirtual RCCB Example</title>
</head>

<body>

<!---Setting variables that get sent to MyGate --->

<cfset Webservice = "https://virtual.mygateglobal.com/PaymentPage.cfm" />

<!---Be sure to populate these variables with the ones you generated in the MyGate Developer Center. Go there now by going to http://developer.mygateglobal.com--->
<cfset MerchantUID="" />
<cfset ApplicationUID="" />

<cfset Terminal="Terminal" />

<!---0 = Test Mode. 1 = Live Mode--->
<cfset Mode="0" />

<!---The amount to be processed--->
<cfset Amount="0.01" />

<!---The authorisation and settlement currency--->
<cfset Currency="ZAR" />

<!---The result pages (Where MyGate returns the card holder to after the transaction)--->
<cfset RedirectSuccessURL="http://localhost/RCCVVirtual/processResults.cfm" />
<cfset RedirectFailedURL="http://localhost/RCCVVirtual/processResults.cfm" />

<!---RCCB Variables--->
<!---The frequency determines when the transaction will go off.--->
<cfset Frequency = "M|1" />
<!---This is the start date of the first reocurring transaction.--->
<cfset StartDate = "01-JUN-2012" />
<cfset EndDate = "01-JUN-2013" />

<!---The amount that is to go ff after the initial amount specified above--->
<cfset RecurringAmount = "0.01" />

<!---Client details are used for reporting features in the MyGate web console--->
<cfset ClientName = "Mr J Soap" />
<cfset ClientAccountNo = "Client12345" />
<cfset ClientEmailAddress = "joe.soap@gmail.com" />
<cfset ClientMobileNumber = "0821234567" />

<!---These flags indicate whether you want MyGate to notify the client of the upcoming transaction via SMS and/or email. 0 = No. 1 = Yes.--->
<cfset SMSClient = "0" />
<cfset EmailClient = "0" />

<h1>My Virtual RCCB Example</h1>

<cfform name="Virtual Post" action="#Webservice#" method="post">
    <cfinput name="Mode" type="hidden" value="#Mode#" /> <br />
    <cfinput name="MerchantID" type="hidden" value="#MerchantUID#" /><br />
    <cfinput name="ApplicationID" type="hidden" value="#ApplicationUID#" /><br />
    Amount: R<cfinput name="Amount" type="text" value="#Amount#" /><br />
    <cfinput name="Currency" type="hidden" value="#Currency#" /><br />
    <cfinput name="RedirectSuccessfulURL" type="hidden" value="#RedirectSuccessURL#" /><br />
    <cfinput name="RedirectFailedURL" type="hidden" value="#RedirectFailedURL#" /><br />
    <cfinput type="hidden" name="ACCB_Frequency" value="#Frequency#">
	<cfinput type="hidden" name="ACCB_StartDate" value="#StartDate#">
	<cfinput type="hidden" name="ACCB_EndDate" value="#EndDate#">
	<cfinput type="hidden" name="ACCB_Amount" value="#RecurringAmount#">
	<cfinput type="hidden" name="ACCB_ClientName" value="#ClientName#">
	<cfinput type="hidden" name="ACCB_ClientAccountNo" value="#ClientAccountNo#">
	<cfinput type="hidden" name="ACCB_ClientEmailAddress" value="#ClientEmailAddress#">
	<cfinput type="hidden" name="ACCB_ClientMobileNumber" value="#ClientMobileNumber#">
	<cfinput type="hidden" name="ACCB_ClientSendSMS" value="#SMSClient#">
	<cfinput type="hidden" name="ACCB_ClientSendEmail" value="#EmailClient#">
    <cfinput type="submit" name="submit" value="Process Transaction">
</cfform>

</body>
</html>