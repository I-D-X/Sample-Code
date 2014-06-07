#!/usr/bin/perl -w

use strict;
use warnings;

use CGI;
*CGI::br = sub { '<br />' };

my $q = CGI->new();

# Setting variables that get sent to MyGate
my $URL  = "https://virtual.mygateglobal.com/PaymentPage.cfm";
my $Mode = "0";     # 0 = Test Mode. 1 = Live Mode

# Be sure to populate these variables with the ones
# you generated in the MyGate Developer Center.
# Go there now by going to http://developer.mygateglobal.com
my $MerchantID    = "";
my $ApplicationID = "";

# Currency and price of transaction
my $Currency = "ZAR";
my $Amount   = "0.01";

# Redirect Details
my $RedirectSuccess = "http://localhost:8888/cgi-bin/RCCBVirtual/processResults.pl";
my $RedirectFailed  = "http://localhost:8888/cgi-bin/RCCBVirtual/processResults.pl";

# RCCB Variables
# The frequency determines when the transaction will go off.
my $Frequency = "M|1";
# This is the start date of the first reocurring transaction.
my $StartDate = "01-JUN-2012";
my $EndDate = "01-JUN-2013";

# The amount that is to go ff after the initial amount specified above
my $RecurringAmount = "0.01";

# Client details are used for reporting features in the MyGate web console
my $ClientName = "Mr J Soap";
my $ClientAccountNo = "Client12345";
my $ClientEmailAddress = 'joe.soap@gmail.com';
my $ClientMobileNumber = "0821234567";

# These flags indicate whether you want MyGate to notify the client of the upcoming transaction via SMS and/or email. 0 = No. 1 = Yes.
my $SMSClient = "0";
my $EmailClient = "0";

print $q->header(
    -type    => 'text/html',
    -charset => 'UTF-8',
  ),
  $q->start_html(
    -dtd   => [ '-//W3C//DTD XHTML 1.0 Transitional//EN', 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd' ],
    -title => 'Perl MyVirtual RCCB Example',
    -meta => { 'Copyright' => 'MyGate Communications (Pty) Ltd 2007', },
  ),
  $q->h1('MyVirtual RCCB Example'),    # perltidy hack
  $q->start_form(
    -name    => 'Virtual Post',
    -enctype => 'multipart/form-data',    # or 'application/x-www-form-urlencoded',
    -method  => 'POST',
    -action  => $URL,
  ),
  $q->hidden( -name => 'Mode',          -value => $Mode ),          $q->br(),
  $q->hidden( -name => 'MerchantID',    -value => $MerchantID ),    $q->br(),
  $q->hidden( -name => 'ApplicationID', -value => $ApplicationID ), $q->br(),
  'Amount: R', $q->textfield( -name => 'Amount', -value => $Amount ), $q->br(),
  $q->hidden( -name => 'Currency',              -value => $Currency ),        $q->br(),
  $q->hidden( -name => 'RedirectSuccessfulURL', -value => $RedirectSuccess ), $q->br(),
  $q->hidden( -name => 'RedirectFailedURL',     -value => $RedirectFailed ),  $q->br(),
  $q->hidden( -name => 'ACCB_Frequency',     -value => $Frequency ),  $q->br(),
  $q->hidden( -name => 'ACCB_StartDate',     -value => $StartDate ),  $q->br(),
  $q->hidden( -name => 'ACCB_EndDate',     -value => $EndDate ),  $q->br(),
  $q->hidden( -name => 'ACCB_Amount',     -value => $RecurringAmount ),  $q->br(),
  $q->hidden( -name => 'ACCB_ClientName',     -value => $ClientName ),  $q->br(),
  $q->hidden( -name => 'ACCB_ClientAccountNo',     -value => $ClientAccountNo ),  $q->br(),
  $q->hidden( -name => 'ACCB_ClientEmailAddress',     -value => $ClientEmailAddress ),  $q->br(),
  $q->hidden( -name => 'ACCB_ClientMobileNumber',     -value => $ClientMobileNumber ),  $q->br(),
  $q->hidden( -name => 'ACCB_ClientSendSMS',     -value => $SMSClient ),  $q->br(),
  $q->hidden( -name => 'ACCB_ClientSendEmail',     -value => $EmailClient ),  $q->br(),
  $q->submit( -name => 'submit', -value => 'Process Transaction' ), $q->br(),
  $q->end_form(),
  $q->end_html();

=head1 NAME
 
 sample.pl - MyGate Communications example
 
 =head1 LICENCE
 
 +---------------------------------------------------------------------------+
 | MyGate Communications - Perl Enterprise Auth and Settle Sample            |
 | Copyright (c) 2007 MyGate Communications (Pty) Ltd                  		 |
 | All rights reserved.                                                      |
 +---------------------------------------------------------------------------+
 | The initial developer of the original code is MyGate Global		         |
 +---------------------------------------------------------------------------+
 
 * "Perl MyVirtual Sample" payment page
 *
 * @category   Code Sample
 * @package    MyGate Communications (Pty) Ltd
 * @subpackage Virtual Transaction (Please contact MyGate to enable immediate settlement if your account requires it)
 * @author     MyGate Global
 * @copyright  Copyright (c) 2007 MyGate Communications (Pty) Ltd
 * @link       http://www.mygateglobal.com/
 * 
 * @Note	   This code serves as an example only. It is not recommended that you use this code for production purposes.
 
 
 =cut
