/**
 * EPayService_PortType.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.mygateglobal.enterprise._5x0x0.epayservice_cfc;

public interface EPayService_PortType extends java.rmi.Remote {
    public java.lang.Object[] fProcess(java.lang.String gatewayID, java.lang.String merchantID, java.lang.String applicationID, java.lang.String action, java.lang.String transactionIndex, java.lang.String terminal, java.lang.String mode, java.lang.String merchantReference, java.lang.String amount, java.lang.String currency, java.lang.String cashBackAmount, java.lang.String cardType, java.lang.String accountType, java.lang.String cardNumber, java.lang.String cardHolder, java.lang.String CVVNumber, java.lang.String expiryMonth, java.lang.String expiryYear, java.lang.String budget, java.lang.String budgetPeriod, java.lang.String authorisationNumber, java.lang.String PIN, java.lang.String debugMode, java.lang.String eCommerceIndicator, java.lang.String verifiedByVisaXID, java.lang.String verifiedByVisaCAFF, java.lang.String secureCodeUCAF, java.lang.String UCI, java.lang.String IPAddress, java.lang.String shippingCountryCode, java.lang.String purchaseItemsID) throws java.rmi.RemoteException, coldfusion.xml.rpc.CFCInvocationException;
    public double isAlive(java.lang.String strRemoteAddress, java.lang.String strApplicationID) throws java.rmi.RemoteException, coldfusion.xml.rpc.CFCInvocationException;
}
