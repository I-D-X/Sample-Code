/*
 * Created by SharpDevelop.
 * User: Administrator
 * Date: 9/10/2012
 * Time: 2:55 PM
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */
using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace MyGate_Global_3D_Secure_Enterprise_Example
{
	/// <summary>
	/// Description of MainForm.
	/// </summary>
	public class Default : Page
	{	
		//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		#region Data

		protected	HtmlInputButton		_Button_Ok;
		protected	HtmlInputText 		_Input_Name;

		#endregion
		//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		#region Page Init & Exit (Open/Close DB connections here...)

		protected void PageInit(object sender, EventArgs e)
		{
		}
		//----------------------------------------------------------------------
		protected void PageExit(object sender, EventArgs e)
		{
		}

		#endregion
		//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		#region Page Load
		private void Page_Load(object sender, EventArgs e)
		{
			//Response.Write(@"Hello #Develop<br>");
			//------------------------------------------------------------------
			//if(IsPostBack)
			//{
			//}
			//------------------------------------------------------------------
			
			//Setting variables for use in the webservice invokation...
	
			//Be sure to populate these variables with the ones you generated in the MyGate Developer Center. Go there now by going to http://developer.mygateglobal.com

            string MerchantUID = "";
            string ApplicationUID = "";

            //The GatewayID associated to your Application UID.
            string GatewayID = "";

            //0 = Test Mode. 1 = Live Mode
            int Mode = 0;
			



			 string Terminal = "Terminal";
			
			
			//Currency and price of transaction
			 string Currency = "ZAR";
			 string Amount = "0.01";
			
			//Credit Card details
			 string CardHolder = "Mr J Soap";
			 string CardNumber = "4111111111111111";
			 string ExpiryMonth = "02";
			 string ExpiryYear = "2016";
			 string CVV = "123";
			 string CardType = "4";
			 string PanExp = "1602";
			 
			 //Get the browser header and user agent form the clients browser.
			 string BrowserHeader = Request.ServerVariables["HTTP_USER_AGENT"];
			 string UserAgent = Request.ServerVariables["HTTP_ACCEPT"];
			 
			 //Set the recurring values for 3D-Secure request
			 string Recurring = "N";
			 string RecurringFrequency = "";
			 string RecurringEnd = "";
			 string Installament = "";
			 
			 //The URL that the card holder should be posted back to after they have entered their 3D-Secure PIN. In this case, it is the same page. Once redirected, the cmpi_authenticate function should be called.
			 string ACSCallbackURL = "http://dev.routelogix.com/aspnet3dexample/Default.aspx?Step=2";
			 
			 //logic to check whether the Step query string parameter is set indicating it has come back from the ACS.
			 string query = Request.QueryString["Step"];
			 string step = "0";
			 
			 if (query != null)
			{
			 	step = Request.QueryString["Step"];
			}
			else {
			 	step = "1";
			}
			 
			 if (step.Equals("1")) {
			 	cmpi_lookup(MerchantUID, ApplicationUID, Mode, CardNumber, 
		                        PanExp, Amount, UserAgent, BrowserHeader, Recurring, 
		                        RecurringFrequency, RecurringEnd, Installament, ACSCallbackURL,
		                        GatewayID, Terminal, Currency, CardHolder, ExpiryMonth, ExpiryYear, 
		                        CVV, CardType);
			 }
			 else if (step.Equals("2")) {
			 	cmpi_authenticate(Request.Form["MD"], Request.Form["PaRes"], GatewayID, MerchantUID, ApplicationUID, Terminal, Mode, Amount, Currency,
		                        CardType, CardNumber, CardHolder, CVV, ExpiryMonth, ExpiryYear);
			 }
			
		}
		#endregion
		//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		#region Click_Button_OK
		
		public void cmpi_lookup(string MerchantUID, string ApplicationUID, int Mode, string CardNumber, 
		                        string PanExp, string Amount, string UserAgent, string BrowserHeader, string Recurring, 
		                        string RecurringFrequency, string RecurringEnd, string Installament, string ACSCallbackURL,
		                        string GatewayID, string Terminal, string Currency, string CardHolder, string ExpiryMonth, string ExpiryYear, 
		                        string CVV, string CardType) 
        {

            //Sandbox service
            //ws3DSecure_sandbox.Item3DSecure1 lookupReference = new ws3DSecure_sandbox.Item3DSecure1();

            //Production service
            ws3DSecure.Item3DSecure1 lookupReference = new ws3DSecure.Item3DSecure1();

			
			object[] arrResults = lookupReference.lookup(
				MerchantUID,  								//MerchantUID
				ApplicationUID, 							//ApplicationUID
				Mode,										//Mode
				CardNumber,									//PAN
				PanExp,										//PANExp
				Amount,										//PurchaseAmount
				UserAgent,									//UserAgent
				BrowserHeader,								//Browser Header
				"OrderNum",									//OrderNum
				"OrderDesc",								//OrderDesc										
				Recurring,									//Recurring
				RecurringFrequency,							//RecurringFrequency
                RecurringEnd,								//RecurringEnd
                Installament								//Installment
				);
			
			System.Boolean authorisationSuccessful = false; 
			string transactionIndex = "";
			string Enrolled = "";
			string ACSUrl = "";
			string PAReqMsg = "";
			
			foreach(string result in arrResults)
			{
				//unpack result array
				int delimiter = result.IndexOf("||");
				string resultDefn = result.Substring(0, delimiter);				
				string resultValue = result.Substring(delimiter + 2);

				//if 'result' not -1, authorisation was successful
				if (resultDefn == "Result" && resultValue != "-1") authorisationSuccessful = true;
				if (resultDefn == "TransactionIndex") transactionIndex = resultValue;
				if (resultDefn == "Enrolled") Enrolled = resultValue;
				
				//A 'Y' will be returned in the $arrResults[2] return parameter. In the case of a 'Y', the card holder needs to be redirected to the ACS. In all otrher cases, an Authorisation can be invoked.
				if(Enrolled.Equals("Y")) {
					if (resultDefn == "ACSUrl") ACSUrl = resultValue;
					if (resultDefn == "PAReqMsg") PAReqMsg = resultValue;
				}
			}
			//A 'Y' will be returned in the $arrResults[2] return parameter. In the case of a 'Y', the card holder needs to be redirected to the ACS. In all otrher cases, an Authorisation can be invoked.
			if(Enrolled.Equals("Y")) {
				Response.Write("<form name='frmLaunchACS' method='POST' action='" + ACSUrl + "'>");
					Response.Write("<table align='center'  width='50%' style='border:1px solid black;'>");
					Response.Write("<tr>");
						Response.Write("<td align='center' colspan='2' style='background-color:Red; font-size:16px;'><font color='FFFFFF'>Posting data to the Issuer ACS server</font></td>");
					Response.Write("</tr>");
					Response.Write("<tr>");
						Response.Write("<td ><div align='right'>PaReq :</div></td>");
						Response.Write("<td ><textarea cols='50' rows='5' style='width:400' name='PaReq' >" + PAReqMsg + "</textarea></textarea></td>");
					Response.Write("</tr>");
					Response.Write("<tr>");
						Response.Write("<td ><div align='right'>TermUrl :</div></td>");
						Response.Write("<td ><input type='text' style='width:400' name='TermUrl' value='" + ACSCallbackURL + "'/></td>");
					Response.Write("</tr>");
					Response.Write("<tr>");
						Response.Write("<td ><div align='right'>Transaction Index :</div></td>");
						Response.Write("<td ><input type='text' style='width:400' name='MD' value='" + transactionIndex + "'/></td>");
					Response.Write("</tr>");
					Response.Write("<tr>");
						Response.Write("<td colspan='2' align='center'><input type='submit' value='Submit Form' style='width:250' ></td>");
					Response.Write("</tr>");
					Response.Write("</table>");
				Response.Write("</form>");
			}
			else {
				performAuth(transactionIndex, GatewayID, MerchantUID, ApplicationUID, Terminal, Mode, Amount, Currency,
		                        CardType, CardNumber, CardHolder, CVV, ExpiryMonth, ExpiryYear);
			}
		}
		
		public void cmpi_authenticate(string TransactionIndex, string PAResPayload, string GatewayID, string MerchantUID, string ApplicationUID, string Terminal, int Mode, string Amount, string Currency, 
		                        string CardType, string CardNumber, string CardHolder, string CVV, string ExpiryMonth, string ExpiryYear)
        {

            //Sandbox service
            //ws3DSecure_sandbox.Item3DSecure1 authenticateReference = new ws3DSecure_sandbox.Item3DSecure1(); 

            //Production service
            ws3DSecure.Item3DSecure1 authenticateReference = new ws3DSecure.Item3DSecure1();
			
			object[] arrResults = authenticateReference.authenticate(
				TransactionIndex,  						//MerchantUID
				PAResPayload 							//ApplicationUID
				);
			
			//Regardless of the result, an authorisation should occur at this stage.
			performAuth(TransactionIndex, GatewayID, MerchantUID, ApplicationUID, Terminal, Mode, Amount, Currency, 
		                        CardType, CardNumber, CardHolder, CVV, ExpiryMonth, ExpiryYear);
		}
		
		public void performAuth(string TransactionIdValue, string GatewayID, string MerchantUID, string ApplicationUID, string Terminal, 
		                        int Mode, string Amount, string Currency, string CardType, string CardNumber, string CardHolder, 
		                        string CVV, string ExpiryMonth, string ExpiryYear)
        {
            //Sandbox service
            //wsCCPayments_sandbox.ePayService authReference = new wsCCPayments_sandbox.ePayService();

            //Production service
            wsCCPayments.ePayService authReference = new wsCCPayments.ePayService();
			
			object[] arrResults = authReference.fProcess(
				GatewayID,									//GatewayID
				MerchantUID,  								//MerchantUID
				ApplicationUID, 							//ApplicationUID
				"1",										//Action
				TransactionIdValue,							//TransactionIndex
				Terminal,									//Terminal
				Mode.ToString(),							//Mode
				"Ref12345",									//MerchantReference
				Amount,										//Amount
				Currency,									//Currency
				"",											//CashBackAmount										
				CardType,									//CardType
				"",											//AccountType
				CardNumber,									//CardNumber
				CardHolder,									//CardHolder
				CVV,										//CCVNumber
				ExpiryMonth,								//ExpiryMonth
				ExpiryYear,									//ExpiryYear
				"0",										//Budget
				"",											//BudgetPeriod
				"",											//AuthorizationNumber
				"",											//PIN
				"",											//DebugMode
				"",											//eCommerceIndicator							
				"",											//verifiedByVisaXID
				"",											//verifiedByVisaCAFF
				"",											//secureCodeUCAF
				"",											//UCI
				"",											//IP Address
				"ZA",										//Shipping Country Code,
				""											//Purchase Items ID
				);
			
			Response.Write("<b>Authorisation results:</b><br>");
	
			System.Boolean authorisationSuccessful = false; 
			string transactionIndex = "";
			foreach(string result in arrResults)
			{
				//unpack result array
                if (result != null)
                {
				    int delimiter = result.IndexOf("||");
				    string resultDefn = result.Substring(0, delimiter);				
				    string resultValue = result.Substring(delimiter + 2);

				    //if 'result' not -1, authorisation was successful
				    if (resultDefn == "Result" && resultValue != "-1") authorisationSuccessful = true;
				    if (resultDefn == "TransactionIndex") transactionIndex = resultValue;
    	
				    Response.Write(resultDefn);
				    Response.Write(": ");
				    Response.Write(resultValue);
				    Response.Write("<br>");
                }
			}
			
			if (authorisationSuccessful) {
				performSettlement(transactionIndex, GatewayID, MerchantUID, ApplicationUID);
			}
		}
		
		public void performSettlement(string TransactionIdValue, string GatewayID, string MerchantUID, string ApplicationUID)
        {
            //Sandbox service
            //wsCCPayments_sandbox.ePayService settleReference = new wsCCPayments_sandbox.ePayService();

            //Production service
            wsCCPayments.ePayService settleReference = new wsCCPayments.ePayService();
			
			object[] arrResults2 = settleReference.fProcess(
				GatewayID,									//Gateway
				MerchantUID,  								//MerchantID
				ApplicationUID, 							//ApplicationID
				"3",										//Action
				TransactionIdValue,							//TransactionIndex
				"",											//Terminal
				"",											//Mode
				"",											//MerchantReference
				"",											//Amount
				"",											//Currency
				"",											//CashBackAmount										
				"",											//CardType
				"",											//AccountType
				"",											//CardNumber
				"",											//CardHolder
				"",											//CCVNumber
				"",											//ExpiryMonth
				"",											//ExpiryYear
				"",											//Budget
				"",											//BudgetPeriod
				"",											//AuthorizationNumber
				"",											//PIN
				"",											//DebugMode
				"",											//eCommerceIndicator							
				"",											//verifiedByVisaXID
				"",											//verifiedByVisaCAFF
				"",											//secureCodeUCAF
				"",											//UCI
				"",											//IP Address
				"",											//Shipping Country Code,
				""											//Purchase Items ID
				);

			#endregion
		
			#region Unpack results
			Response.Write("<br><b>Purchase results:</b><br>");

			foreach(string result in arrResults2)
			{
				//unpack result array
				int delimiter = result.IndexOf("||");
				string resultDefn = result.Substring(0, delimiter);				
				string resultValue = result.Substring(delimiter + 2);

				Response.Write(resultDefn);
				Response.Write(": ");
				Response.Write(resultValue);
				Response.Write("<br>");

			}
		}

		//----------------------------------------------------------------------
		protected void Click_Button_Ok(object sender, EventArgs e)
		{
			//Response.Write( _Button_Ok.Value + " was cklicked!<br>");
		}

		#endregion
		//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		#region Changed_Input_Name

		//----------------------------------------------------------------------
		protected void Changed_Input_Name(object sender, EventArgs e)
		{
			//Response.Write( _Input_Name.Value + " has changed!<br>");
		}

		#endregion
		//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		#region More...
		#endregion
		//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		#region Initialize Component

		protected override void OnInit(EventArgs e)
		{
			InitializeComponent();
			base.OnInit(e);
		}
		//----------------------------------------------------------------------
		private void InitializeComponent()
		{
			this.Load	+= new System.EventHandler(Page_Load);
			this.Init   += new System.EventHandler(PageInit);
			this.Unload += new System.EventHandler(PageExit);
			
			//_Button_Ok.ServerClick	 += new EventHandler(Click_Button_Ok);
			//_Input_Name.ServerChange += new EventHandler(Changed_Input_Name);
		}
		#endregion
		//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	}
}