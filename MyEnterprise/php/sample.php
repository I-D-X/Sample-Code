<?php
/*****************************************************************************\
+-----------------------------------------------------------------------------+
| MyGate Communications - PHP Enterprise Auth and Settle Sample               |
| Copyright (c) 2007 MyGate Communications (Pty) Ltd                  		  |
| All rights reserved.                                                        |
+-----------------------------------------------------------------------------+
| The initial developer of the original code is MyGate Global		          |
+-----------------------------------------------------------------------------+
\*****************************************************************************/

/**
 * "PHP Enterprise Sample" payment page
 *
 * @category   Code Sample
 * @package    MyGate Communications (Pty) Ltd
 * @subpackage Enterprise Auth and Settle
 * @author     MyGate Global - support@mygateglobal.com
 * @copyright  Copyright (c) 2007 MyGate Communications (Pty) Ltd
 * @link       http://www.mygateglobal.com/
 * 
 * @Note	   This code serves as an example only. It is not recommended that you use this code for production purposes. This code sample does not include               3D-Secure integration and as such should not be used for production purposes.
 */
 
 //Setting variables for use in the webservice invokation...

$URL = 'https://enterprise.mygateglobal.com/5x0x0/wsCCPayments.wsdl';

$Mode = '0'; //0 = Test Mode. 1 = Live Mode

//Be sure to populate these variables with the ones you generated in the MyGate Developer Center. Go there now by going to http://developer.mygateglobal.com
$MerchantID = '';
$ApplicationID = '';

//The GatewayID associated to your Application UID.
$GatewayID = '22';

//Currency and price of transaction
$Currency = 'ZAR';
$Amount = '0.01';

//Credit Card details
$CCName = 'Mr J Soap';
$PAN = '4111111111111111';
$ExpMonth = '10';
$ExpYear  = '2015';
$CVC = '123';
$CardType = '4';

//A U T H O R I S E  P U R C H A S E     (A C T I O N  =  1)

//Ensure that PHP is installed and has the php_soap extension enabled.
$client = new SoapClient($URL);
echo("<br/> Authorization - Action 1 <br/>");	
$arrResults = $client->fProcess(
	$GLOBALS['GatewayID'],             	//Gateway
	$GLOBALS['MerchantID'],          	//MerchantID
	$GLOBALS['ApplicationID'],     		//ApplicationID
	'1',      							//Action
	'',                    				//TransactionIndex
	'Terminal',            				//Terminal
	$GLOBALS['Mode'],                	//Mode
	'',        							//MerchantReference
	$GLOBALS['Amount'],            	    //Amount
	$GLOBALS['Currency'],            	//Currency
	'',                    				//CashBackAmount                                        
	$GLOBALS['CardType'],            	//CardType
	'',                    				//AccountType
	$GLOBALS['PAN'],        			//CardNumber
	$GLOBALS['CCName'],        			//CardHolder
	$GLOBALS['CVC'],                	//CCVNumber
	$GLOBALS['ExpMonth'],            	//ExpiryMonth
	$GLOBALS['ExpYear'],            	//ExpiryYear
	'0',                					//Budget
	'',                    				//BudgetPeriod
	'',                    				//AuthorizationNumber
	'',                    				//PIN
	'',                    				//DebugMode
	'07',               				//eCommerceIndicator                            
	'',                    				//verifiedByVisaXID
	'',                    				//verifiedByVisaCAFF
	'',                    				//secureCodeUCAF
	'',                    				//Unique Client Index - this is used to uniquely identify the client and is used by the MyGate Fraud module. It is an optional parameter. Please see online documentation for details.
	'',                    				//IP Address - this is the IP address of the user using the online gateway (retrieved by yourselves), and is used by the MyGate Fraud module. It is an optional parameter.     Please see online documentation for details.
	'',									//Shipping Country Code - this is the 2-digit shipping country code of the user, and is used by the MyGate Fraud module. It is an optional parameter. Please see online documentation for details.    
	''              
);

//Results are returned from MyGate in an array format with the return parameter name and value seperated by a double-pipe (||)
list($ResultName, $ResultValue) = explode("||",$arrResults[0]);

//The first element of the retrn array ($arrResults[0]) is the Result. 0=Successful, 1=Warning (A result of 1 is returned either when the fraud module is providing a flag or if unnecessary parameters were sent to the API in the request message).
if ($ResultValue >= 0)
{
	//If successful, loop through result array and output results
	echo("Successful Authorization");
	echo("<br />");	
	foreach ($arrResults as $result)
	{
		echo($result);
		echo("<br />");    
	}
	
	echo("<br/> Settlement - Action 3 <br/>");	
	//The TransactionIndex is needed for any further transaction attempts on an authorisation. It is the second array element that is returned ($arrResults[1]).
	list($ResultName, $TransactionID) = explode("||",$arrResults[1]);
	$arrResults2 = $client->fProcess(
		$GLOBALS['GatewayID'], 		//Gateway
		$GLOBALS['MerchantID'],  	//MerchantID
		$GLOBALS['ApplicationID'], 	//ApplicationID
		'3',						//Action
		$TransactionID,				//TransactionIndex
		'',							//Terminal
		'',							//Mode
		'',							//MerchantReference
		'',							//Amount
		'',							//Currency
		'',							//CashBackAmount										
		'',							//CardType
		'',							//AccountType
		'',							//CardNumber
		'',							//CardHolder
		'',							//CCVNumber
		'',							//ExpiryMonth
		'',							//ExpiryYear
		'',							//Budget
		'',							//BudgetPeriod
		'',							//AuthorizationNumber
		'',							//PIN
		'',							//DebugMode
		'',							//eCommerceIndicator							
		'',							//verifiedByVisaXID
		'',							//verifiedByVisaCAFF
		'',							//secureCodeUCAF
		'',                    		//Unique Client Index - this is used to uniquely identify the client and is used by the MyGate Fraud module. It is an optional parameter. Please see online documentation for details.
		'',                    		//IP Address - this is the IP address of the user using the online gateway (retrieved by yourselves), and is used by the MyGate Fraud module. It is an optional parameter.     Please see online documentation for details.
		'',							//Shipping Country Code - this is the 2-digit shipping country code of the user, and is used by the MyGate Fraud module. It is an optional parameter. Please see online documentation for details.    
		''
		);
		
		list($ResultName2, $ResultValue2) = explode("||",$arrResults2[0]);
		
		if ($ResultValue2 >= 0) {
			echo("Successful Settlement");
			echo("<br />");	
			foreach ($arrResults2 as $result2)
			{
				echo($result2);
				echo("<br />");	
			}
		}
		else {
			echo("Failed Settlement");
			echo("<br />");	
			foreach ($arrResults2 as $result2)
			{
				echo($result2);
				echo("<br />");	
			}
		}
}
else {
	echo("Failed Authorization");
	echo("<br />");	
	foreach ($arrResults as $result)
	{
		echo($result);
		echo("<br />");	
	}
}