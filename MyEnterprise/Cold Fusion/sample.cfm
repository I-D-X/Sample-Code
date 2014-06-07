<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>ColdFusion Enterprise Example</title>
</head>

<body>

<!---
+-----------------------------------------------------------------------------+
| MyGate Communications - ColdFusion Enterprise Auth and Settle Sample        |
| Copyright (c) 2007 MyGate Communications (Pty) Ltd                  		  |
| All rights reserved.                                                        |
+-----------------------------------------------------------------------------+
| The initial developer of the original code is MyGate Global		          |
+-----------------------------------------------------------------------------+


 * "ColdFusion Enterprise Sample" payment page
 *
 * @category   Code Sample
 * @package    MyGate Communications (Pty) Ltd
 * @subpackage Enterprise Auth and Settle
 * @author     MyGate Global - support@mygateglobal.com
 * @copyright  Copyright (c) 2007 MyGate Communications (Pty) Ltd
 * @link       http://www.mygateglobal.com/
 * 
 * @Note	   This code serves as an example only. It is not recommended that you use this code for production purposes. This code sample does not include               3D-Secure integration and as such should not be used for production purposes.
--->

<!---Setting variables that get sent to MyGate --->

<cfset Webservice = "https://enterprise.mygateglobal.com/5x0x0/wsCCPayments.wsdl" />

<cfset GatewayID="22" />

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

<!---The card holder details--->
<cfset CardHolder="Mr J Soap" />
<cfset CardNumber="4111111111111111" />
<cfset ExpiryMonth="12" />
<cfset ExpiryYear="2015" />
<cfset CVV="123" />
<cfset CardType="4" />

<!---A U T H O R I S E  P U R C H A S E     (A C T I O N  =  1)--->
<cfinvoke webservice="#Webservice#" method="fProcess" returnvariable="arrReturnAuthorisation">
    <cfinvokeargument name="GatewayID" value="#GatewayID#">
    <cfinvokeargument name="MerchantID" value="#MerchantUID#">
    <cfinvokeargument name="ApplicationID" value="#ApplicationUID#">
    <cfinvokeargument name="Action" value="1">
    <cfinvokeargument name="TransactionIndex" value="">
    <cfinvokeargument name="Terminal" value="#Terminal#">
    <cfinvokeargument name="Mode" value="#Mode#">
    <cfinvokeargument name="MerchantReference" value="">
    <cfinvokeargument name="Amount" value="#Amount#">
    <cfinvokeargument name="Currency" value="#Currency#">
    <cfinvokeargument name="CashBackAmount" value="">
    <cfinvokeargument name="CardType" value="#CardType#">
    <cfinvokeargument name="AccountType" value="">
    <cfinvokeargument name="CardNumber" value="#CardNumber#">
    <cfinvokeargument name="CardHolder" value="#CardHolder#">
    <cfinvokeargument name="CVVNumber" value="#CVV#">
    <cfinvokeargument name="ExpiryMonth" value="#ExpiryMonth#">
    <cfinvokeargument name="ExpiryYear" value="#ExpiryYear#">
    <cfinvokeargument name="Budget" value="0">
    <cfinvokeargument name="BudgetPeriod" value="">
    <cfinvokeargument name="AuthorisationNumber" value="">
    <cfinvokeargument name="PIN" value="">
    <cfinvokeargument name="DebugMode" value="">
    <cfinvokeargument name="eCommerceIndicator" value="07">
    <cfinvokeargument name="verifiedByVisaXID" value="">
    <cfinvokeargument name="verifiedByVisaCAFF" value="">
    <cfinvokeargument name="SecureCodeUCAF" value="">
    <cfinvokeargument name="UCI" omit="yes" value="">
    <cfinvokeargument name="IPAddress" value="">
    <cfinvokeargument name="ShippingCountryCode" value="">
    <cfinvokeargument name="PurchaseItemsID" value="">
		
</cfinvoke>

<!---Results are returned from MyGate in an array format with the return parameter name and value seperated by a double-pipe (||)--->
<cfset strAuthorisationResult = GetResultItem(arrReturnAuthorisation, "Result") />
<cfset TransactionIndex = ListLast(GetResultItem(arrReturnAuthorisation, "TransactionIndex"),"||")/>

<!---The first element of the retrn array (arrReturnAuthorisation[1]) is the Result. 0=Successful, 1=Warning (A result of 1 is returned either when the fraud module is providing a flag or if unnecessary parameters were sent to the API in the request message).--->
<cfif ListLast(strAuthorisationResult,"||") GTE 0>

	<!---If successful, output the results--->
	<cfoutput>
    Successful Authorization <br />
	</cfoutput>
	<cfdump var="#arrReturnAuthorisation#">

	<!---The TransactionIndex is needed for any further transaction attempts on an authorisation. It is the second array element that is returned (arrReturnAuthorisation[2]).--->
	<cfinvoke webservice="#Webservice#" method="fProcess" returnvariable="arrReturnSettlement">
    <cfinvokeargument name="GatewayID" value="#GatewayID#">
    <cfinvokeargument name="MerchantID" value="#MerchantUID#">
    <cfinvokeargument name="ApplicationID" value="#ApplicationUID#">
    <cfinvokeargument name="Action" value="3">
    <cfinvokeargument name="TransactionIndex" value="#TransactionIndex#">
    <cfinvokeargument name="Terminal" value="">
    <cfinvokeargument name="Mode" value="">
    <cfinvokeargument name="MerchantReference" value="">
    <cfinvokeargument name="Amount" value="">
    <cfinvokeargument name="Currency" value="">
    <cfinvokeargument name="CashBackAmount" value="">
    <cfinvokeargument name="CardType" value="">
    <cfinvokeargument name="AccountType" value="">
    <cfinvokeargument name="CardNumber" value="">
    <cfinvokeargument name="CardHolder" value="">
    <cfinvokeargument name="CVVNumber" value="">
    <cfinvokeargument name="ExpiryMonth" value="">
    <cfinvokeargument name="ExpiryYear" value="">
    <cfinvokeargument name="Budget" value="">
    <cfinvokeargument name="BudgetPeriod" value="">
    <cfinvokeargument name="AuthorisationNumber" value="">
    <cfinvokeargument name="PIN" value="">
    <cfinvokeargument name="DebugMode" value="">
    <cfinvokeargument name="eCommerceIndicator" value="">
    <cfinvokeargument name="verifiedByVisaXID" value="">
    <cfinvokeargument name="verifiedByVisaCAFF" value="">
    <cfinvokeargument name="SecureCodeUCAF" value="">
    <cfinvokeargument name="UCI" omit="yes" value="">
    <cfinvokeargument name="IPAddress" value="">
    <cfinvokeargument name="ShippingCountryCode" value="">
    <cfinvokeargument name="PurchaseItemsID" value="">
		
	</cfinvoke>
    
    <cfset strSettlementResult = GetResultItem(arrReturnSettlement, "Result") />
	<cfset SettlementTransactionIndex = ListLast(GetResultItem(arrReturnSettlement, "TransactionIndex"),"||")/>
    
    <!---If the settlement is successful, output the results--->
    <cfif ListLast(strSettlementResult,"||") GTE 0>
    	<cfoutput>
        Successful Settlement <br />
        </cfoutput>
        <cfdump var="#arrReturnSettlement#">
    <!---If the settlement is unsuccessful, output the results--->
    <cfelse>
		<cfoutput>
        Failed Settlement <br />
        </cfoutput>
        <cfdump var="#arrReturnSettlement#">
    </cfif>
    
    <!---If the authorisation is unsuccessful, output the results--->	
    <cfelse>
        <cfoutput>
        Failed Authorization <br />
        </cfoutput>
        <cfdump var="#arrReturnAuthorisation#">
    </cfif>

<!--- Function that splits the array element and returns the value --->
<cffunction name="GetResultItem" access="private" output="false" returntype="string">
    <cfargument name="arrResult" type="array" required="yes" />
    <cfargument name="strItem" type="string" required="yes" />
    <cfset var strReturn = "" />
    <cfset var intArrayCount = 0 />

    <cfloop from="1" to="#ArrayLen(arrResult)#" index="intArrayCount">
        <cfif ListFirst(arrResult[intArrayCount], "||") EQ strItem>
            <cfset strReturn = arrResult[intArrayCount] />
        </cfif>
    </cfloop>
                    
    <cfreturn strReturn />
</cffunction>

</body>
</html>