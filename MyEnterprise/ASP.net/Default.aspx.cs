/*
 * Created by SharpDevelop.
 * User: Administrator
 * Date: 6/13/2012
 * Time: 5:19 PM
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

namespace MyGate_Global_Enterprise
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
			 string MerchantUID = "592fee9e-c4fa-44da-8deb-bdd272291987";
			 string ApplicationUID = "73ddb801-dd2c-47f1-ba68-21ca7bde7711";
			
			//The GatewayID associated to your Application UID.
			 string GatewayID = "22";

			 string Terminal = "Terminal";
			
			//0 = Test Mode. 1 = Live Mode
			 string Mode = "0";
			
			//Currency and price of transaction
			 string Currency = "ZAR";
			 string Amount = "0.01";
			
			//Credit Card details
			 string CardHolder = "Mr J Soap";
			 string CardNumber = "4111111111111111";
			 string ExpiryMonth = "12";
			 string ExpiryYear = "2015";
			 string CVV = "123";
			 string CardType = "4";
			
			enterprise.mygateglobal.com.ePayService reference = new MyGate_Global_Enterprise.enterprise.mygateglobal.com.ePayService();
			
			object[] arrResults = reference.fProcess(
				GatewayID,									//GatewayID
				MerchantUID,  								//MerchantUID
				ApplicationUID, 							//ApplicationUID
				"1",										//Action
				"",											//TransactionIndex
				Terminal,									//Terminal
				Mode,										//Mode
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
				"00",										//eCommerceIndicator							
				"",											//verifiedByVisaXID
				"",											//verifiedByVisaCAFF
				"",											//secureCodeUCAF
				"",											//UCI
				"",											//IP Address
				"ZA",										//Shipping Country Code,
				""											//Purchase Items ID
				);
			
				#endregion
	
				#region Unpack results
				Response.Write("<b>Authorisation results:</b><br>");
	
				System.Boolean authorisationSuccessful = false; 
				string transactionIndex = "";
				foreach(string result in arrResults)
				{
					//unpack result array
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
				#endregion
				
				#region P U R C H A S E

			if (authorisationSuccessful)
			{
				reference = new enterprise.mygateglobal.com.ePayService();
				object[] arrResults2 = reference.fProcess(
					GatewayID,									//Gateway
					MerchantUID,  								//MerchantID
					ApplicationUID, 							//ApplicationID
					"3",										//Action
					transactionIndex,							//TransactionIndex
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
				#endregion
			}
		}
		
		//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		#region Click_Button_OK

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
			
			/*_Button_Ok.ServerClick	 += new EventHandler(Click_Button_Ok);
			_Input_Name.ServerChange += new EventHandler(Changed_Input_Name);*/
		}
		#endregion
		//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	}
}