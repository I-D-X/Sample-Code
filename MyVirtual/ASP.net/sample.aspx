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
<title>ASP.NET MyVirtual Example</title>  
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
string Price = "0.01";
string Currency = "ZAR";

//Merchant Reference
string MerchantReference = "";

//Redirect Details
string RedirectSuccess = "http://localhost:8888/CodeSnippets/Virtual/processResults.aspx";
string RedirectFailed = "http://localhost:8888/CodeSnippets/Virtual/processResults.aspx";


%>

<h1>My Virtual Example</h1>

<form name="Virtual Post" action="<% Response.Write(URL); %>" method="post">
    <input name="Mode" type="hidden" value="<% Response.Write(TransactionMode); %>" /> <br />
    <input name="txtMerchantID" type="hidden" value="<% Response.Write(MerchantID); %>" /><br />
    <input name="txtApplicationID" type="hidden" value="<% Response.Write(ApplicationID); %>" /><br />
    <input name="txtMerchantReference" type="hidden" value="<% Response.Write(MerchantReference); %>" /><br />
    <input name="txtRedirectSuccessfulURL" type="hidden" value="<% Response.Write(RedirectSuccess); %>" /><br />
    <input name="txtRedirectFailedURL" type="hidden" value="<% Response.Write(RedirectFailed); %>" /><br />	
    Amount: R<input name="txtPrice" type="text" value="<% Response.Write(Price); %>" /><br />
    <input name="txtCurrencyCode" type="hidden" value="<% Response.Write(Currency); %>" /><br />
    <input name="txtDisplayPrice" type="hidden" value="<% Response.Write(Price); %>" /><br />
    <input name="txtDisplayCurrencyCode" type="hidden" value="<% Response.Write(Currency); %>" /><br />
    <input type="submit" name="submit" value="Process Transaction">
</form>

</body>  
</html>  