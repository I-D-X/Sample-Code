'''
+-----------------------------------------------------------------------------+
| MyGate Communications - Python Virtual Auth and Settle Sample               |
| Copyright (c) 2007 MyGate Communications (Pty) Ltd                  		  |
| All rights reserved.                                                        |
+-----------------------------------------------------------------------------+
| The initial developer of the original code is MyGate Global		          |
+-----------------------------------------------------------------------------+

* "Python MyVirtual RCCB Sample" payment page
*
* @category   Code Sample
* @package    MyGate Communications (Pty) Ltd
* @subpackage Virtual Transaction (Please contact MyGate to enable immediate settlement if your account requires it)
* @author     MyGate Global - support@mygateglobal.com
* @copyright  Copyright (c) 2007 MyGate Communications (Pty) Ltd
* @link       http://www.mygateglobal.com/
* 
* @Note	   This code serves as an example only. It is not recommended that you use this code for production purposes.
'''

from flask import Flask
from flask import render_template
from flask import request

app = Flask(__name__)

@app.route('/')
def helloworld():
    return 'Welcome'

@app.route('/RCCBVirtual/')

# Setting variables that get sent to MyGate

def sample():
    data = {}
    data['URL'] = "https://virtual.mygateglobal.com/PaymentPage.cfm"
    
    #0 = Test Mode. 1 = Live Mode
    data['Mode'] = 0
    
    #Be sure to populate these variables with the ones you generated in the MyGate Developer Center. Go there now by going to http://developer.mygateglobal.com
    data['MerchantID'] = ""
    data['ApplicationID'] = ""
    
    #The authorisation and settlement currency
    data['Currency'] = 'ZAR'
    
    #The amount to be processed
    data['Amount'] = 0.01
    
    #The result pages (Where MyGate returns the card holder to after the transaction)
    data['RedirectSuccess'] = "http://127.0.0.1:5000/processResults/"
    data['RedirectFailed'] = "http://127.0.0.1:5000/processResults/"
    
    #RCCB Variables
    #The frequency determines when the transaction will go off.
    data['Frequency'] = "M|1"
    #This is the start date of the first reocurring transaction.
    data['StartDate'] = "01-JUN-2012"
    data['EndDate'] = "01-JUN-2013"

    #The amount that is to go ff after the initial amount specified above
    data['RecurringAmount'] = 0.01

    #Client details are used for reporting features in the MyGate web console
    data['ClientName'] = "Mr J Soap"
    data['ClientAccountNo'] = "Client12345"
    data['ClientEmailAddress'] = "joe.soap@gmail.com"
    data['ClientMobileNumber'] = "0821234567"
    
    #These flags indicate whether you want MyGate to notify the client of the upcoming transaction via SMS and/or email. 0 = No. 1 = Yes.
    data['SMSClient'] = 0;
    data['EmailClient'] = 0;
    
    return render_template('sample.html', data = data)


@app.route('/processResults/', methods=['POST'])
def process_results():
    if request.method == 'POST':
        
        #Populate Python variables with the POST back variables MyGate sends
        try:
            result = int(request.form['_RESULT'].strip())
        except KeyError:
            pass
        
        try:
            errorCode = request.form['_ERROR_CODE'].strip()
        except KeyError:
            pass
        
        try:
            errorSource = request.form['_ERROR_SOURCE'].strip()
        except KeyError:
            pass
        
        try:
            errorMessage = request.form['_ERROR_MESSAGE'].strip()
        except KeyError:
            pass
        
        try:
            errorDetail = request.form['_ERROR_DETAIL'].strip()
        except KeyError:
            pass
        
        try:
            variable1 = request.form['VARIABLE1'].strip()
        except KeyError:
            variable1 = ''
        
        try:
            bankErrorCode = request.form['_BANK_ERROR_CODE'].strip()
        except KeyError:
            pass
        
        try:
            bankErrorMessage = request.form['_BANK_ERROR_MESSAGE'].strip()
        except KeyError:
            pass
        
        try:
            cardCountry = request.form['_CARDCOUNTRY'].strip()
        except KeyError:
            pass
        
        try:
            price = request.form['TXTPRICE'].strip()
        except KeyError:
            pass
        
        try:
            threedsecure = request.form['_3DSTATUS'].strip()
        except KeyError:
            pass
        
        # All the variables are passed as python dictionary to processResults.html template
        # which uses jinja2 template language to process the results and display as html.

        #The POST._RESULT element of the form post is the transaction result. 0=Successful, 1=Warning (A result of 1 is returned either when the fraud module is providing a flag or if unnecessary parameters were sent to the API in the request message). Note: A result code of 1 is still a successful transaction.
        if result >= 0:
            return render_template('processResults.html',
                                   data = {'success' : True,
                                           'result': 'Successfull Transaction',
                                           'cardCountry' : cardCountry,
                                           'price' : price,
                                           'threedsecure': threedsecure,
                                           'variable1': variable1}
                                   )
        else:
            #In the event of a failed transaction, most merchants will only display the bank error message to the client as this will often give the most descriptive message relevant to the client. E.g. Insufficient funds, Blocked Card, etc.
            return render_template('processResults.html',
                                   data = {'success': False,
                                           'result': 'Failed Transaction',
                                           'errorCode': errorCode,
                                           'errorMessage': errorMessage,
                                           'errorDetail': errorDetail,
                                           'variable1': variable1,
                                           'bankErrorCode': bankErrorCode,
                                           'bankErrorMessage': bankErrorMessage}
                                   )
    else:
        return "Only Post method allowed"


if __name__ == '__main__':
    app.run()