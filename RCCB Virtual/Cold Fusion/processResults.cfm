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
<title>ColdFusion MyVirtual Results</title>
</head>

<body>

<!---Populate PHP variables with the POST back variables MyGate sends--->
<cfset Result = "#POST._RESULT#" />
<cfset ErrorCode = "#POST._ERROR_CODE#" />
<cfset ErrorSource = "#POST._ERROR_SOURCE#" />
<cfset ErrorMessage = "#POST._ERROR_MESSAGE#" />
<cfset ErrorDetail = "#POST._ERROR_DETAIL#" />

<cfset Variable1 = "#POST.VARIABLE1#" />

<cfset bankErrorCode = "#POST._BANK_ERROR_CODE#" />
<cfset bankErrorMessage = "#POST._BANK_ERROR_MESSAGE#" />

<cfset CardCountry = "#POST._CARDCOUNTRY#" />
<cfset Price = "#POST.TXTPRICE#" />
<cfset ThreeDSecure = "#POST._3DSTATUS#" />

<!---The POST._RESULT element of the form post is the transaction result. 0=Successful, 1=Warning (A result of 1 is returned either when the fraud module is providing a flag or if unnecessary parameters were sent to the API in the request message). Note: A result code of 1 is still a successful transaction.--->
<cfif Result GTE 0>
	<cfoutput>
        Successful Transaction
        Card Country: #CardCountry#
        Processed Amount: #Price#
        3D-Secure Status: #ThreeDSecure#
        Custom Variable: #Variable1#
    </cfoutput>
<cfelse>
	<!---In the event of a failed transaction, most merchants will only display the bank error message to the client as this will often give the most descriptive message relevant to the client. E.g. Insufficient funds, Blocked Card, etc. --->
	<cfoutput>
        Failed Transaction
        Error Code: #ErrorCode#
        Error Message: #ErrorMessage#
        Error Details: #ErrorDetail#
        Custom Variable: #Variable1#
        
        Bank Error Code: #bankErrorCode#
        Bank Error Message: #bankErrorMessage#
    </cfoutput>
</cfif>

</body>
</html>