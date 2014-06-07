<?php
/*****************************************************************************\
+-----------------------------------------------------------------------------+
| MyGate Communications - PHP Enterprise 3D-Secure with Auth and Settle Sample|
| Copyright (c) 2007 MyGate Communications (Pty) Ltd                  		  |
| All rights reserved.                                                        |
+-----------------------------------------------------------------------------+
| The initial developer of the original code is MyGate Global		          |
+-----------------------------------------------------------------------------+
\*****************************************************************************/

/**
 * "PHP Enterprise with 3D-Secure Sample" payment page
 *
 * @category   Code Sample
 * @package    MyGate Communications (Pty) Ltd
 * @subpackage Enterprise 3D-Secure with Auth and Settle
 * @author     MyGate Global - support@mygateglobal.com
 * @copyright  Copyright (c) 2007 MyGate Communications (Pty) Ltd
 * @link       http://www.mygateglobal.com/
 * 
 * @Note	   This code serves as an example only. It is not recommended that you use this code for production purposes. This code sample includes               3D-Secure integration.
 */
 
 //Setting variables for use in the webservice invokation...

$theeDSecureURL = 'https://dev-3dsecure.mygateglobal.com/ws3DSecure.wsdl';
$URL = 'https://dev-enterprise.mygateglobal.com/5x0x0/wsCCPayments.wsdl';

$Mode = '0'; //0 = Test Mode. 1 = Live Mode

//Be sure to populate these variables with the ones you generated in the MyGate Developer Center. Go there now by going to http://developer.mygateglobal.com
$MerchantID = '722e564e-62d5-41fe-a1e5-cf1fb2c199a8';
$ApplicationID = 'c433d13d-9f88-4781-8177-6b777aaa7875';

//The GatewayID associated to your Application UID.
$GatewayID = '01';

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
$PanExp = substr($ExpYear, 2) . $ExpMonth;

//Get the browser header and user agent form the clients browser.
$BrowserHeader = $_SERVER['HTTP_USER_AGENT'];
$UserAgent = $_SERVER['HTTP_ACCEPT'];

//Set the recurring values for 3D-Secure request
$Recurring = "N";
$RecurringFrequency = "";
$RecurringEnd = "";
$Installament = "";

//The URL that the card holder should be posted back to after they have entered their 3D-Secure PIN. In this case, it is the same page. Once redirected, the cmpi_authenticate function should be called.
$ACSCallbackURL = 'http://localhost:8888/CodeSnippets/Enterprise/3D-Secure/sample.php?Step=2';

//logic to check whether the Step query string parameter is set indicating it has come back from the ACS.
if (!isset($_GET['Step']))
	$step = 1;
else 
	$step = $_GET['Step'];
	
switch ($step){
	case 1:
		cmpi_lookup();
		break;
	case 2:
		cmpi_authenticate();
		break;
}

//3D-SECURE PROCESS

function cmpi_lookup() {
	//This is the initial call to the 3D-Secure API
	$client = new SoapClient($GLOBALS['theeDSecureURL']);
	$arrResults = $client->lookup(
		$GLOBALS['MerchantID'], 			//MerchantID
		$GLOBALS['ApplicationID'],			//ApplicationID
		$GLOBALS['Mode'],  								//Mode
		$GLOBALS['PAN'], 					//Credit Card Number
		$GLOBALS['PanExp'],					//Expiry Date (YYMM)
		$GLOBALS['Amount'],		//Transaction Amount
		$GLOBALS['UserAgent'],				//Thhe HTTP User Agent
		$GLOBALS['BrowserHeader'],			//The HTTP Browser Header
		$GLOBALS['OrderNumber'],			//MerchantReference
		$GLOBALS['OrderDesc'],				//The Order Desc
		$GLOBALS['Recurring'],				//Is the transaction recurring
		$GLOBALS['RecurringFrequency'],	//What is the recurring frequency										
		$GLOBALS['RecurringEnd'],			//when is the last debit date
		$GLOBALS['Installament']			//The amount of months the recurring debits will continue
	);
	
	list($Result,$ResultValue) = explode("||",$arrResults[1]);
	list($TransactionId,$TransactionIdValue) = explode("||",$arrResults[0]);
	
	if ($ResultValue == 0){

		list($Enrolled,$EnrolledValue) = explode("||",$arrResults[2]);
		list($AcsUrl,$AcsUrlValue) = explode("||",$arrResults[3]);
		list($PAReq,$PAReqValue) = explode("||",$arrResults[4]);
		list($TransactionId,$TransactionIdValue) = explode("||",$arrResults[0]);
				
		//A 'Y' will be returned in the $arrResults[2] return parameter. In the case of a 'Y', the card holder needs to be redirected to the ACS. In all otrher cases, an Authorisation can be invoked.
		if ($EnrolledValue  == 'Y'){
			?>
				<form name="frmLaunchACS" method="POST" action="<?PHP echo $AcsUrlValue ?>">
					  <table align="center"  width='50%' style="border:1px solid black;">
						  <tr>
							  <td align="center" colspan="2" style="background-color:Red; font-size:16px;"><font color="FFFFFF">Posting data to the Issuer ACS server</font></td>
						  </tr>
						  <tr>
							  <td ><div align="right">PaReq :</div></td>
							  <td ><textarea cols="50" rows="5" style="width:400" name="PaReq" ><?PHP echo $PAReqValue ?></textarea></textarea></td>
						  </tr>
						  <tr>
							  <td ><div align="right">TermUrl :</div></td>
							  <td ><input type="text" style="width:400" name="TermUrl" value="<?php echo($GLOBALS['ACSCallbackURL']); ?>"/>
						</td>
						  </tr>
						  <tr>
							  <td ><div align="right">Transaction Index</div></td>
							  <td ><input type="text" style="width:400" name="MD" value="<?PHP echo $TransactionIdValue ?>"/></td>
						  </tr>
						  <tr>
							  <td colspan="2"><div align="center">
								<input type="submit" value="Submit Form" style="width:250" >
							  </div></td>
						  </tr>
					  </table>				
					</form>				
			<?PHP
		} 
		else 
		{ 
			//In the event of anything other than a 'Y', this will print out the results and perform an authorisation. This means that the card holders issueing bank has determined that the card holder is not enrolled for 3D-Secure and does not need to be.
			print_r($arrResults);
			performAuth($TransactionIdValue);
		}
			
	}
	else {
		//In the event of a 3D-Secure error, the transaction should still continue.
		list($ErrorNo,$ErrorNoValue) = explode("||",$arrResults[1]);
		list($ErrorDesc,$ErrorDescValue) = explode("||",$arrResults[2]);

		echo $ErrorNo . ':' .  $ErrorNoValue . '<br>'; 
		echo $ErrorDesc . ':' .  $ErrorDescValue . '<br>'; 
		performAuth($TransactionIdValue);
	}
}

function cmpi_authenticate() {
	//Once the card holder has been posted back, the cmpi_authenticate function gets invoked to verify the results.
	$TransactionId = $_POST['MD'];
	$PAResPayload = $_POST['PaRes'];
	
	$client = new SoapClient($GLOBALS['theeDSecureURL']);
	$arrResults = $client->authenticate(
	$TransactionId, 				//TransactionID
	$PAResPayload					//PaRes
	);
	
	list($Result,$ResultValue) = explode("||",$arrResults[0]);

	list($Result,$ECI) = explode("||",$arrResults[3]);
	list($Result,$XID) = explode("||",$arrResults[4]);
	list($Result,$CAVV) = explode("||",$arrResults[5]);

	//Regardless of the result, an authorisation should occur at this stage.
	performAuth($TransactionId);
}

//The function that performs the authorisation. Notice that the TransactionIndex gets passed to this function. This is the TransactionIndex that is returned from the 3D-Secure API. This is needed for MyGate to verify that the 3D-Secure process took place and to track the results for processing.
function performAuth($TransactionIndex) {
	//A U T H O R I S E  P U R C H A S E     (A C T I O N  =  1)

	//Ensure that PHP is installed and has the php_soap extension enabled.
	$client = new SoapClient($GLOBALS['URL']);
	echo("<br/> Authorization - Action 1 <br/>");	
	$arrResults = $client->fProcess(
		$GLOBALS['GatewayID'],             	//Gateway
		$GLOBALS['MerchantID'],          	//MerchantID
		$GLOBALS['ApplicationID'],     		//ApplicationID
		'1',      							//Action
		$TransactionIndex,                  //TransactionIndex from 3D-Secure API
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
		'0',                				//Budget
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
		
		performSettlement($TransactionID);
		
		
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
}

function performSettlement($TransactionIndex) {
	$client = new SoapClient($GLOBALS['URL']);
	$arrResults2 = $client->fProcess(
		$GLOBALS['GatewayID'], 		//Gateway
		$GLOBALS['MerchantID'],  	//MerchantID
		$GLOBALS['ApplicationID'], 	//ApplicationID
		'3',						//Action
		$TransactionIndex,			//TransactionIndex
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