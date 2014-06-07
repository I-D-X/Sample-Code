<!---
+-----------------------------------------------------------------------------+
| MyGate Communications - ASP.NET Enterprise Auth and Settle Sample           |
| Copyright (c) 2007 MyGate Communications (Pty) Ltd                  		  |
| All rights reserved.                                                        |
+-----------------------------------------------------------------------------+
| The initial developer of the original code is MyGate Global		          |
+-----------------------------------------------------------------------------+

 * "ASP.NET MyVirtual Sample" payment page
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

<%@ Page Language="C#" ContentType="text/html" ResponseEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">  
<head runat="server">  
<title>ASP.NET MyVirtual RCCB Example</title>  
</head>  
<body>  

<%
//Setting variables for use in the webservice invokation...

string URL = "https://virtual.mygateglobal.com/PaymentPage.cfm";

string TransactionMode = "0"; //0 = Test Mode. 1 = Live Mode

//Be sure to populate these variables with the ones you generated in the MyGate Developer Center. Go there now by going to http://developer.mygateglobal.com
string MerchantID = "";
string ApplicationID = "";

//Currency and price of transaction
string Currency = "ZAR";
string Amount = "0.01";

//Redirect Details
string RedirectSuccess = "http://localhost:8888/CodeSnippets/RCCBVirtual/processResults.aspx";
string RedirectFailed = "http://localhost:8888/CodeSnippets/RCCBVirtual/processResults.aspx";

//RCCB Variables
//The frequency determines when the transaction will go off.
string Frequency = "M|1";
//This is the start date of the first reocurring transaction.
string StartDate = "01-JUN-2012";
string EndDate = "01-JUN-2013";

//The amount that is to go ff after the initial amount specified above
string RecurringAmount = "0.01";

//Client details are used for reporting features in the MyGate web console
string ClientName = "Mr J Soap";
string ClientAccountNo = "Client12345";
string ClientEmailAddress = "joe.soap@gmail.com";
string ClientMobileNumber = "0821234567";

//These flags indicate whether you want MyGate to notify the client of the upcoming transaction via SMS and/or email. 0 = No. 1 = Yes.
string SMSClient = "0";
string EmailClient = "0";
%>

<h1>My Virtual RCCB Example</h1>

<form name="Virtual Post" action="<% Response.Write(URL); %>" method="post">
    <input name="Mode" type="hidden" value="<% Response.Write(TransactionMode); %>" /> <br />
    <input name="MerchantID" type="hidden" value="<% Response.Write(MerchantID); %>" /><br />
    <input name="ApplicationID" type="hidden" value="<% Response.Write(ApplicationID); %>" /><br />
    Amount: R<input name="Amount" type="text" value="<% Response.Write(Amount); %>" /><br />
    <input name="Currency" type="hidden" value="<% Response.Write(Currency); %>" /><br />
    <input name="RedirectSuccessfulURL" type="hidden" value="<% Response.Write(RedirectSuccess); %>" /><br />
    <input name="RedirectFailedURL" type="hidden" value="<% Response.Write(RedirectFailed); %>" /><br />
    <input type="hidden" name="ACCB_Frequency" value="<% Response.Write(Frequency); %>"><br />
	<input type="hidden" name="ACCB_StartDate" value="<% Response.Write(StartDate); %>"><br />
	<input type="hidden" name="ACCB_EndDate" value="<% Response.Write(EndDate); %>"><br />
	<input type="hidden" name="ACCB_Amount" value="<% Response.Write(RecurringAmount); %>"><br />
	<input type="hidden" name="ACCB_ClientName" value="<% Response.Write(ClientName); %>"><br />
	<input type="hidden" name="ACCB_ClientAccountNo" value="<% Response.Write(ClientAccountNo); %>"><br />
	<input type="hidden" name="ACCB_ClientEmailAddress" value="<% Response.Write(ClientEmailAddress); %>"><br />
	<input type="hidden" name="ACCB_ClientMobileNumber" value="<% Response.Write(ClientMobileNumber); %>"><br />
	<input type="hidden" name="ACCB_ClientSendSMS" value="<% Response.Write(SMSClient); %>"><br />
	<input type="hidden" name="ACCB_ClientSendEmail" value="<% Response.Write(EmailClient); %>"><br />
    <input type="submit" name="submit" value="Process Transaction">
</form>

</body>  
</html>  