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

<%@ Page Language="C#" ContentType="text/html" ResponseEncoding="iso-8859-1" %>
<html>
<head>
<title>ASP.NET Results</title>
</head>

<%
//Populate ASP.NET variables with the POST back variables MyGate sends
int result;
string errorCode;
string errorSource; 
string errorMessage;
string errorDetail;
string variable1;

string bankErrorCode;
string bankErrorMessage;

string cardCountry;
string price;
string threeDSecure;

result = Convert.ToInt32(Request["_RESULT"]);
errorCode = Request["_ERROR_CODE"];
errorSource = Request["_ERROR_SOURCE"];
errorMessage = Request["_ERROR_MESSAGE"];
errorDetail = Request["_ERROR_DETAIL"];
variable1 = Request["VARIABLE1"];

bankErrorCode = Request["_BANK_ERROR_CODE"];
bankErrorMessage = Request["_BANK_ERROR_MESSAGE"];

cardCountry = Request["_CARDCOUNTRY"];
price = Request["TXTPRICE"];
threeDSecure = Request["_3DSTATUS"];
%>

<body>
	<!---The Request["_RESULT"] element of the form post is the transaction result. 0=Successful, 1=Warning (A result of 1 is returned either when the fraud module is providing a flag or if unnecessary parameters were sent to the API in the request message). Note: A result code of 1 is still a successful transaction.--->
	<%
    if (result >= 0) //Successful
    {
    %>
        Successful Transaction <br />
        Card Country: <%Response.Write(cardCountry);%> <br />
        Processed Amount: <%Response.Write(price);%> <br />
        3D-Secure Status: <%Response.Write(threeDSecure);%> <br />
        Custom Variable: <%Response.Write(variable1);%> <br />
    <%
    } 
    else //Declined
    {
    %>
    	<!---In the event of a failed transaction, most merchants will only display the bank error message to the client as this will often give the most descriptive message relevant to the client. E.g. Insufficient funds, Blocked Card, etc. --->
        
        Failed Transaction <br />
        Error Code: <%Response.Write(errorCode);%> <br />
        Error Message: <%Response.Write(errorMessage);%> <br />
        Error Details: <%Response.Write(errorDetail);%> <br />
        Custom Variable: <%Response.Write(variable1);%> <br /> <br />
        Bank Error Code: <%Response.Write(bankErrorCode);%> <br />
        Bank Error Message: <%Response.Write(bankErrorMessage);%> <br />
    <%}%>
</body>
</html>