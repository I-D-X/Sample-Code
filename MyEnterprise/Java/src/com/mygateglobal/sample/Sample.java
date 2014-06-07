package com.mygateglobal.sample;

import com.mygateglobal.enterprise._5x0x0.epayservice_cfc.EPayService_ServiceLocator;
import com.mygateglobal.enterprise._5x0x0.epayservice_cfc.EpayserviceCfcSoapBindingStub;


public class Sample {
	
	//Setting variables for use in the webservice invokation...
	
	//Be sure to populate these variables with the ones you generated in the MyGate Developer Center. Go there now by going to http://developer.mygateglobal.com
	private String MerchantUID = "592fee9e-c4fa-44da-8deb-bdd272291987";
	private String ApplicationUID = "73ddb801-dd2c-47f1-ba68-21ca7bde7711";
	
	//The GatewayID associated to your Application UID.
	private String GatewayID = "22";
	
	private String Terminal = "Terminal";
	
	//0 = Test Mode. 1 = Live Mode
	private String Mode = "0";
	
	//Currency and price of transaction
	private String Currency = "ZAR";
	private String Amount = "0.01";
	
	//Credit Card details
	private String CardHolder = "Mr J Soap";
	private String CardNumber = "4242424242424242";
	private String ExpiryMonth = "12";
	private String ExpiryYear = "2015";
	private String CVV = "123";
	private String CardType = "4";
	
	public static void main (String [] args) {
		Sample sample = new Sample();
		sample.processAuthorization();
	}
	
	private void processAuthorization() {
		try {
			EpayserviceCfcSoapBindingStub proxy = (EpayserviceCfcSoapBindingStub) new EPayService_ServiceLocator().getEpayserviceCfc();
			
			Object ret[] = (Object[])proxy.fProcess(
			GatewayID,
		    MerchantUID,
		    ApplicationUID,
		    "1",
		    "",
		    Terminal,
		    Mode,
		    "12345",
		    Amount,
		    Currency,
		    "",
		    CardType,
		    "",
		    CardNumber, 
		    CardHolder, 
		    CVV, 
		    ExpiryMonth, 
		    ExpiryYear, 
		    "0",
		    "",
		    "",
		    "",
		    "",
		    "00",
		    "",
		    "",
		    "",
		    "",
		    "",
		    "",
		    "");
			
			/*Results are returned from MyGate in an array format with the return parameter name and value seperated by a double-pipe (||)
		    The first element of the retrn array ($arrResults[0]) is the Result. 0=Successful, 1=Warning (A result of 1 is returned either 
		    when the fraud module is providing a flag or if unnecessary parameters were sent to the API in the request message).*/
		    if(Integer.parseInt(ret[0].toString().substring(ret[0].toString().indexOf("||")+2, ret[0].toString().length())) >= 0) {
			    //Successful Authorization
			    System.out.println();
			    System.out.println("Successful Authorization");
			    //Loop through the result object and print out the results
			    for (int p = 0; p < ret.length; p ++)
			    {	
			        System.out.println(ret[p]);
			    }
			    
			    //The TransactionIndex is needed for any further transaction attempts on an authorisation. It is the second array element that is returned (ret[1]).
			    String transactionIndex = ret[1].toString().substring(ret[1].toString().indexOf("||")+2, ret[1].toString().length());
			    
			    //If the authorization was successful, the processSettlement function is called to perform the settlement.
			    processSettlement(transactionIndex);
		    }
		    else {
			    //Failed Authorization
			    System.out.println();
			    System.out.println("Failed Authorization");
			    
			    //Loop through the result object and print out the results
			    for (int p = 0; p < ret.length; p ++)
			    {
			        System.out.println(ret[p]);
			    }
		    }
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}
	
	private void processSettlement(String transactionIndex) {
		try {	
EpayserviceCfcSoapBindingStub proxy = (EpayserviceCfcSoapBindingStub) new EPayService_ServiceLocator().getEpayserviceCfc();
			
			Object ret[] = (Object[])proxy.fProcess(
		   	GatewayID,
		   	MerchantUID,
		   	ApplicationUID,
		   	"3",
		   	transactionIndex,
		   	"",
		   	"",
		   	"",
		   	"",
		   	"",
		   	"",
		   	"",
		   	"",
		   	"", 
		   	"", 
		   	"", 
		   	"", 
		   	"", 
		   	"",
		   	"",
		   	"",
		   	"",
		   	"",
		   	"",
		   	"",
		   	"",
		   	"",
		   	"",
		   	"",
		   	"",
		   	"");
		   
		   	if(Integer.parseInt(ret[0].toString().substring(ret[0].toString().indexOf("||")+2, ret[0].toString().length())) >= 0) {
		   		//Successful Settlement
		   		System.out.println();
		   		System.out.println("Successful Settlement");
		   		//Loop through the result object and print out the results
		   		for (int p = 0; p < ret.length; p ++)
		   		{	
		   			System.out.println(ret[p]);
		   		}
		   	}
		   	else {
		   		//Failed Settlement
		   		System.out.println();
		   		System.out.println("Failed Settlement");
		   		//Loop through the result object and print out the results
		   		for (int p = 0; p < ret.length; p ++)
		   		{	
		   			System.out.println(ret[p]);
		   		}
		   	}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
}