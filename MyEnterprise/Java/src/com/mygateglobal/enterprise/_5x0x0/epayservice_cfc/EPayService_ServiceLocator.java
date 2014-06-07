/**
 * EPayService_ServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.mygateglobal.enterprise._5x0x0.epayservice_cfc;

public class EPayService_ServiceLocator extends org.apache.axis.client.Service implements com.mygateglobal.enterprise._5x0x0.epayservice_cfc.EPayService_Service {

    public EPayService_ServiceLocator() {
    }


    public EPayService_ServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public EPayService_ServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for EpayserviceCfc
    private java.lang.String EpayserviceCfc_address = "https://enterprise.mygateglobal.com/5x0x0/epayservice.cfc";

    public java.lang.String getEpayserviceCfcAddress() {
        return EpayserviceCfc_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String EpayserviceCfcWSDDServiceName = "epayservice.cfc";

    public java.lang.String getEpayserviceCfcWSDDServiceName() {
        return EpayserviceCfcWSDDServiceName;
    }

    public void setEpayserviceCfcWSDDServiceName(java.lang.String name) {
        EpayserviceCfcWSDDServiceName = name;
    }

    public com.mygateglobal.enterprise._5x0x0.epayservice_cfc.EPayService_PortType getEpayserviceCfc() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(EpayserviceCfc_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getEpayserviceCfc(endpoint);
    }

    public com.mygateglobal.enterprise._5x0x0.epayservice_cfc.EPayService_PortType getEpayserviceCfc(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.mygateglobal.enterprise._5x0x0.epayservice_cfc.EpayserviceCfcSoapBindingStub _stub = new com.mygateglobal.enterprise._5x0x0.epayservice_cfc.EpayserviceCfcSoapBindingStub(portAddress, this);
            _stub.setPortName(getEpayserviceCfcWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setEpayserviceCfcEndpointAddress(java.lang.String address) {
        EpayserviceCfc_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (com.mygateglobal.enterprise._5x0x0.epayservice_cfc.EPayService_PortType.class.isAssignableFrom(serviceEndpointInterface)) {
                com.mygateglobal.enterprise._5x0x0.epayservice_cfc.EpayserviceCfcSoapBindingStub _stub = new com.mygateglobal.enterprise._5x0x0.epayservice_cfc.EpayserviceCfcSoapBindingStub(new java.net.URL(EpayserviceCfc_address), this);
                _stub.setPortName(getEpayserviceCfcWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("epayservice.cfc".equals(inputPortName)) {
            return getEpayserviceCfc();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("https://enterprise.mygateglobal.com/5x0x0/epayservice.cfc", "ePayService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("https://enterprise.mygateglobal.com/5x0x0/epayservice.cfc", "epayservice.cfc"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("EpayserviceCfc".equals(portName)) {
            setEpayserviceCfcEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
