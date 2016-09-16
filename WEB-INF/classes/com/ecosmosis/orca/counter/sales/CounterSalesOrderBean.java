// Decompiled by Yody
// File : CounterSalesOrderBean.class

package com.ecosmosis.orca.counter.sales;

import com.ecosmosis.mvc.bean.MvcBean;
import com.ecosmosis.orca.bean.AddressBean;
import com.ecosmosis.orca.member.MemberBean;
import com.ecosmosis.orca.outlet.OutletBean;
import com.ecosmosis.orca.outlet.store.OutletStoreBean;
import com.ecosmosis.orca.pricing.PriceCodeBean;
import com.ecosmosis.orca.salesman.SalesmanBean;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

// Referenced classes of package com.ecosmosis.orca.counter.sales:
//            CounterSalesComparator, CounterSalesItemBean, CounterSalesManager, CounterSalesFormBean, 
//            CounterSalesPaymentBean, DeliveryOrderBean

public class CounterSalesOrderBean extends MvcBean
{

    private Long salesID;
    private Date trxDate;
    private Date trxTime;
    private Date bonusDate;
    private String bonusPeriodID;
    private String trxDocCode;
    private String trxDocNo;
    private String trxDocType;
    private String trxDocName;
    private String trxType;
    private int trxGroup;
    private String adjstRefNo;
    private int adjstSalesID;
    private String adjstRemark;
    private String priceCode;
    private String localCurrency;
    private String localCurrencyName;
    private String localCurrencySymbol;
    private String baseCurrency;
    private String baseCurrencyName;
    private String baseCurrencySymbol;
    private double baseCurrencyRate;
    private double baseCurrencyRate2;
    private double baseCurrencyRate3;
        
    private int sellerSeq;
    private String sellerID;
    private String sellerType;
    private String sellerTypeStatus;
    private String sellerHomeBranchID;
    private int serviceAgentSeq;
    private String serviceAgentID;
    private String serviceAgentType;
    
    private int bonusEarnerSeq;
    private String bonusEarnerID;
    private String bonusEarnerType;
    private String bonusEarnerName;
    
    private int customerSeq;
    private String customerID;
    private int customerReg;
    private double customerLucky; 
    private String customerType;
    private String customerTypeStatus;
    private String customerName;
    private String customerIdentityNo;
    private String customerContact;
    private String customerRemark;
    private int shipOption;
    private String shipFromOutletID;
    private String shipFromStoreCode;
    private String shipByOutletID;
    private String shipByStoreCode;
    //2010-01-05
    private String shipExpedition;
    private String shipReceiver;
    private String shipContact;
    private String shipRemark;
    
    // cso_ship_address_line1, cso_ship_address_line2, cso_ship_zipcode, 
    // cso_ship_countryid, cso_ship_regionid, cso_ship_stateid, cso_ship_cityid     
    private String shipAddress1;
    private String shipAddress2;
    private String shipZipcode;
    
    private String shipCountry;
    private String shipRegion;
    private String shipState;
    private String shipCity;
    
    private double totalBv1;
    private double totalBv2;
    private double totalBv3;
    private double totalBv4;
    private double totalBv5;
    private double bvSalesAmount;
    private double nonBvSalesAmount;
    private double netSalesAmount;
    private double chiSalesAmount;
    private double corpSalesAmount;
    private double adjstPaymentAmount;
    private double discountRate;
    private double discountAmount;
    private double deliveryRate;
    private double deliveryAmount;
    private double mgmtRate;
    private double mgmtAmount;
    private double creditCardRate;
    private double creditCardAmount;
    private double bonusRate;
    private double bonusAmount;
    private double otherAmount1;
    private double otherAmount2;
    private double otherAmount3;
    private double otherAmount4;
    private double otherAmount5;
    private double paymentTender;
    private double paymentChange;
    private String paymentRemark;
    private String remark;
    private int processStatus;
    private int deliveryStatus;
    private int status;
    private String immediateDelivery;
    private String displayDelivery;
    private SortedSet itemSet;
    private Set formSet;
    private Set paymentSet;
    private CounterSalesItemBean itemArray[];
    private CounterSalesFormBean formArray[];
    private CounterSalesPaymentBean paymentArray[];
    private DeliveryOrderBean deliveryHistoryList[];
    private DeliveryOrderBean deliveryOrderBean;
    private AddressBean customerAddressBean;
    private AddressBean shippingAddressBean;
    private PriceCodeBean priceCodeBean;
    private OutletBean sellerBean;
    private OutletBean serviceAgentBean;
    private OutletBean shipFromOutletBean;
    private OutletStoreBean shipFromStoreBean;
    private OutletBean shipByOutletBean;
    private OutletStoreBean shipByStoreBean;
    
    /*
    private MemberBean bonusEarnerBean;
    */
    
    private MemberBean customerMemberBean;
    
    private SalesmanBean bonusEarnerBean;
    private SalesmanBean customerSalesmanBean;    
    
    private OutletBean customerStockistBean;
    private String trxDateStr;
    private String shipOptionStr;
    private boolean isTodayTrx;
    private boolean cancelBonus;
    private String importBatchCode;
    private double balanceFee;

    public CounterSalesOrderBean()
    {
        immediateDelivery = "N";
        displayDelivery = "N";
    }

    public Date getBonusDate()
    {
        return bonusDate;
    }

    public void setBonusDate(Date bonusDate)
    {
        this.bonusDate = bonusDate;
    }

    public double getAdjstPaymentAmount()
    {
        return adjstPaymentAmount;
    }

    public void setAdjstPaymentAmount(double adjstPaymentAmount)
    {
        this.adjstPaymentAmount = adjstPaymentAmount;
    }

    public String getAdjstRefNo()
    {
        return adjstRefNo;
    }

    public void setAdjstRefNo(String adjstRefNo)
    {
        this.adjstRefNo = adjstRefNo;
    }

    public int getAdjstSalesID()
    {
        return adjstSalesID;
    }

    public void setAdjstSalesID(int adjstSalesID)
    {
        this.adjstSalesID = adjstSalesID;
    }

    public String getAdjstRemark()
    {
        return adjstRemark;
    }

    public void setAdjstRemark(String adjstRemark)
    {
        this.adjstRemark = adjstRemark;
    }

    public String getBaseCurrency()
    {
        return baseCurrency;
    }

    public void setBaseCurrency(String baseCurrency)
    {
        this.baseCurrency = baseCurrency;
    }

    public String getBaseCurrencyName()
    {
        return baseCurrencyName;
    }

    public void setBaseCurrencyName(String baseCurrencyName)
    {
        this.baseCurrencyName = baseCurrencyName;
    }

    public double getBaseCurrencyRate()
    {
        return baseCurrencyRate;
    }

    public void setBaseCurrencyRate(double baseCurrencyRate)
    {
        this.baseCurrencyRate = baseCurrencyRate;
    }

    public String getBaseCurrencySymbol()
    {
        return baseCurrencySymbol;
    }

    public void setBaseCurrencySymbol(String baseCurrencySymbol)
    {
        this.baseCurrencySymbol = baseCurrencySymbol;
    }

    public double getBonusAmount()
    {
        return bonusAmount;
    }

    public void setBonusAmount(double bonusAmount)
    {
        this.bonusAmount = bonusAmount;
    }

    public String getBonusEarnerID()
    {
        return bonusEarnerID;
    }

    public void setBonusEarnerID(String bonusEarnerID)
    {
        this.bonusEarnerID = bonusEarnerID;
    }

    public String getBonusEarnerName()
    {
        return bonusEarnerName;
    }

    public void setBonusEarnerName(String bonusEarnerName)
    {
        this.bonusEarnerName = bonusEarnerName;
    }

    public int getBonusEarnerSeq()
    {
        return bonusEarnerSeq;
    }

    public void setBonusEarnerSeq(int bonusEarnerSeq)
    {
        this.bonusEarnerSeq = bonusEarnerSeq;
    }

    public String getBonusEarnerType()
    {
        return bonusEarnerType;
    }

    public void setBonusEarnerType(String bonusEarnerType)
    {
        this.bonusEarnerType = bonusEarnerType;
    }

    public String getBonusPeriodID()
    {
        return bonusPeriodID;
    }

    public void setBonusPeriodID(String bonusPeriodID)
    {
        this.bonusPeriodID = bonusPeriodID;
    }

    public double getBonusRate()
    {
        return bonusRate;
    }

    public void setBonusRate(double bonusRate)
    {
        this.bonusRate = bonusRate;
    }

    public double getBvSalesAmount()
    {
        return bvSalesAmount;
    }

    public void setBvSalesAmount(double bvSalesAmount)
    {
        this.bvSalesAmount = bvSalesAmount;
    }

    public double getCreditCardAmount()
    {
        return creditCardAmount;
    }

    public void setCreditCardAmount(double creditCardAmount)
    {
        this.creditCardAmount = creditCardAmount;
    }

    public double getCreditCardRate()
    {
        return creditCardRate;
    }

    public void setCreditCardRate(double creditCardRate)
    {
        this.creditCardRate = creditCardRate;
    }

    public String getCustomerContact()
    {
        return customerContact;
    }

    public void setCustomerContact(String customerContact)
    {
        this.customerContact = customerContact;
    }

    public String getCustomerID()
    {
        return customerID;
    }

    public void setCustomerID(String customerID)
    {
        this.customerID = customerID;
    }
   
    public int getCustomerReg()
    {
        return customerReg;
    }

    public void setCustomerReg(int customerReg)
    {
        this.customerReg = customerReg;
    }

    public double getCustomerLucky()
    {
        return customerLucky;
    }

    public void setCustomerLucky(double customerLucky)
    {
        this.customerLucky = customerLucky;
    }

    public String getCustomerIdentityNo()
    {
        return customerIdentityNo;
    }

    public void setCustomerIdentityNo(String customerIdentityNo)
    {
        this.customerIdentityNo = customerIdentityNo;
    }

    public String getCustomerName()
    {
        return customerName;
    }

    public void setCustomerName(String customerName)
    {
        this.customerName = customerName;
    }

    public String getCustomerRemark()
    {
        return customerRemark;
    }

    public void setCustomerRemark(String customerRemark)
    {
        this.customerRemark = customerRemark;
    }

    public int getCustomerSeq()
    {
        return customerSeq;
    }

    public void setCustomerSeq(int customerSeq)
    {
        this.customerSeq = customerSeq;
    }

    public String getCustomerType()
    {
        return customerType;
    }

    public void setCustomerType(String customerType)
    {
        this.customerType = customerType;
    }

    public String getCustomerTypeStatus()
    {
        return customerTypeStatus;
    }

    public void setCustomerTypeStatus(String customerTypeStatus)
    {
        this.customerTypeStatus = customerTypeStatus;
    }

    public double getDeliveryAmount()
    {
        return deliveryAmount;
    }

    public void setDeliveryAmount(double deliveryAmount)
    {
        this.deliveryAmount = deliveryAmount;
    }

    public double getDeliveryRate()
    {
        return deliveryRate;
    }

    public void setDeliveryRate(double deliveryRate)
    {
        this.deliveryRate = deliveryRate;
    }

    public int getDeliveryStatus()
    {
        return deliveryStatus;
    }

    public void setDeliveryStatus(int deliveryStatus)
    {
        this.deliveryStatus = deliveryStatus;
    }

    public double getDiscountAmount()
    {
        return discountAmount;
    }

    public void setDiscountAmount(double discountAmount)
    {
        this.discountAmount = discountAmount;
    }

    public double getDiscountRate()
    {
        return discountRate;
    }

    public void setDiscountRate(double discountRate)
    {
        this.discountRate = discountRate;
    }

    public double getNonBvSalesAmount()
    {
        return nonBvSalesAmount;
    }

    public void setNonBvSalesAmount(double nonBvSalesAmount)
    {
        this.nonBvSalesAmount = nonBvSalesAmount;
    }

    public String getLocalCurrency()
    {
        return localCurrency;
    }

    public void setLocalCurrency(String localCurrency)
    {
        this.localCurrency = localCurrency;
    }

    public String getLocalCurrencyName()
    {
        return localCurrencyName;
    }

    public void setLocalCurrencyName(String localCurrencyName)
    {
        this.localCurrencyName = localCurrencyName;
    }

    public String getLocalCurrencySymbol()
    {
        return localCurrencySymbol;
    }

    public void setLocalCurrencySymbol(String localCurrencySymbol)
    {
        this.localCurrencySymbol = localCurrencySymbol;
    }

    public double getMgmtAmount()
    {
        return mgmtAmount;
    }

    public void setMgmtAmount(double mgmtAmount)
    {
        this.mgmtAmount = mgmtAmount;
    }

    public double getMgmtRate()
    {
        return mgmtRate;
    }

    public void setMgmtRate(double mgmtRate)
    {
        this.mgmtRate = mgmtRate;
    }

    public double getNetSalesAmount()
    {
        return netSalesAmount;
    }

    public void setNetSalesAmount(double netSalesAmount)
    {
        this.netSalesAmount = netSalesAmount;
    }

    public double getBalanceFee()
    {
        return balanceFee;
    }

    public void setBalanceFee(double balanceFee)
    {
        this.balanceFee = balanceFee;
    }
    
    public double getOtherAmount1()
    {
        return otherAmount1;
    }

    public void setOtherAmount1(double otherAmount1)
    {
        this.otherAmount1 = otherAmount1;
    }

    public double getOtherAmount2()
    {
        return otherAmount2;
    }

    public void setOtherAmount2(double otherAmount2)
    {
        this.otherAmount2 = otherAmount2;
    }

    public double getOtherAmount3()
    {
        return otherAmount3;
    }

    public void setOtherAmount3(double otherAmount3)
    {
        this.otherAmount3 = otherAmount3;
    }

    public double getOtherAmount4()
    {
        return otherAmount4;
    }

    public void setOtherAmount4(double otherAmount4)
    {
        this.otherAmount4 = otherAmount4;
    }

    public double getOtherAmount5()
    {
        return otherAmount5;
    }

    public void setOtherAmount5(double otherAmount5)
    {
        this.otherAmount5 = otherAmount5;
    }

    public double getPaymentChange()
    {
        return paymentChange;
    }

    public void setPaymentChange(double paymentChange)
    {
        this.paymentChange = paymentChange;
    }

    public double getPaymentTender()
    {
        return paymentTender;
    }

    public void setPaymentTender(double paymentTender)
    {
        this.paymentTender = paymentTender;
    }

    public String getPaymentRemark()
    {
        return paymentRemark;
    }

    public void setPaymentRemark(String paymentRemark)
    {
        this.paymentRemark = paymentRemark;
    }

    public String getPriceCode()
    {
        return priceCode;
    }

    public void setPriceCode(String priceCode)
    {
        this.priceCode = priceCode;
    }

    public int getProcessStatus()
    {
        return processStatus;
    }

    public void setProcessStatus(int processStatus)
    {
        this.processStatus = processStatus;
    }

    public String getRemark()
    {
        return remark;
    }

    public void setRemark(String remark)
    {
        this.remark = remark;
    }

    public Long getSalesID()
    {
        return salesID;
    }

    public void setSalesID(Long salesID)
    {
        this.salesID = salesID;
    }

    public String getSellerID()
    {
        return sellerID;
    }

    public void setSellerID(String sellerID)
    {
        this.sellerID = sellerID;
    }

    public int getSellerSeq()
    {
        return sellerSeq;
    }

    public void setSellerSeq(int sellerSeq)
    {
        this.sellerSeq = sellerSeq;
    }

    public String getSellerType()
    {
        return sellerType;
    }

    public void setSellerType(String sellerType)
    {
        this.sellerType = sellerType;
    }

    public String getSellerTypeStatus()
    {
        return sellerTypeStatus;
    }

    public void setSellerTypeStatus(String sellerTypeStatus)
    {
        this.sellerTypeStatus = sellerTypeStatus;
    }

    public String getSellerHomeBranchID()
    {
        return sellerHomeBranchID;
    }

    public void setSellerHomeBranchID(String sellerHomeBranchID)
    {
        this.sellerHomeBranchID = sellerHomeBranchID;
    }

    public String getServiceAgentID()
    {
        return serviceAgentID;
    }

    public void setServiceAgentID(String serviceAgentID)
    {
        this.serviceAgentID = serviceAgentID;
    }

    public int getServiceAgentSeq()
    {
        return serviceAgentSeq;
    }

    public void setServiceAgentSeq(int serviceAgentSeq)
    {
        this.serviceAgentSeq = serviceAgentSeq;
    }

    public String getServiceAgentType()
    {
        return serviceAgentType;
    }

    public void setServiceAgentType(String serviceAgentType)
    {
        this.serviceAgentType = serviceAgentType;
    }

    public String getShipByOutletID()
    {
        return shipByOutletID;
    }

    public void setShipByOutletID(String shipByOutletID)
    {
        this.shipByOutletID = shipByOutletID;
    }

    public String getShipByStoreCode()
    {
        return shipByStoreCode;
    }

    public void setShipByStoreCode(String shipByStoreCode)
    {
        this.shipByStoreCode = shipByStoreCode;
    }

    public String getShipContact()
    {
        return shipContact;
    }

    public void setShipContact(String shipContact)
    {
        this.shipContact = shipContact;
    }

    public String getShipFromOutletID()
    {
        return shipFromOutletID;
    }

    public void setShipFromOutletID(String shipFromOutletID)
    {
        this.shipFromOutletID = shipFromOutletID;
    }

    public String getShipFromStoreCode()
    {
        return shipFromStoreCode;
    }

    public void setShipFromStoreCode(String shipFromStoreCode)
    {
        this.shipFromStoreCode = shipFromStoreCode;
    }

    public int getShipOption()
    {
        return shipOption;
    }

    public void setShipOption(int shipOption)
    {
        this.shipOption = shipOption;
    }

    public String getShipReceiver()
    {
        return shipReceiver;
    }

    public void setShipReceiver(String shipReceiver)
    {
        this.shipReceiver = shipReceiver;
    }

    //2010-01-05
    public String getShipExpedition()
    {
        return shipExpedition;
    }

    public void setShipExpedition(String shipExpedition)
    {
        this.shipExpedition = shipExpedition;
    }
    
    public String getShipRemark()
    {
        return shipRemark;
    }

    public void setShipRemark(String shipRemark)
    {
        this.shipRemark = shipRemark;
    }

    public int getStatus()
    {
        return status;
    }

    public void setStatus(int status)
    {
        this.status = status;
    }

    public boolean isDisplayDelivery()
    {
        return displayDelivery.equalsIgnoreCase("Y");
    }

    public String getDisplayDelivery()
    {
        return displayDelivery;
    }

    public void setDisplayDelivery(String displayDelivery)
    {
        this.displayDelivery = displayDelivery;
    }

    public boolean isImmediateDelivery()
    {
        return immediateDelivery.equalsIgnoreCase("Y");
    }

    public String getImmediateDelivery()
    {
        return immediateDelivery;
    }

    public void setImmediateDelivery(String immediateDelivery)
    {
        this.immediateDelivery = immediateDelivery;
    }

    public double getTotalBv1()
    {
        return totalBv1;
    }

    public void setTotalBv1(double totalBv1)
    {
        this.totalBv1 = totalBv1;
    }

    public double getTotalBv2()
    {
        return totalBv2;
    }

    public void setTotalBv2(double totalBv2)
    {
        this.totalBv2 = totalBv2;
    }

    public double getTotalBv3()
    {
        return totalBv3;
    }

    public void setTotalBv3(double totalBv3)
    {
        this.totalBv3 = totalBv3;
    }

    public double getTotalBv4()
    {
        return totalBv4;
    }

    public void setTotalBv4(double totalBv4)
    {
        this.totalBv4 = totalBv4;
    }

    public double getTotalBv5()
    {
        return totalBv5;
    }

    public void setTotalBv5(double totalBv5)
    {
        this.totalBv5 = totalBv5;
    }

    public Date getTrxDate()
    {
        return trxDate;
    }

    public void setTrxDate(Date trxDate)
    {
        this.trxDate = trxDate;
    }

    public String getTrxDocCode()
    {
        return trxDocCode;
    }

    public void setTrxDocCode(String trxDocCode)
    {
        this.trxDocCode = trxDocCode;
    }

    public String getTrxDocNo()
    {
        return trxDocNo;
    }

    public void setTrxDocNo(String trxDocNo)
    {
        this.trxDocNo = trxDocNo;
    }

    public String getTrxDocType()
    {
        return trxDocType;
    }

    public void setTrxDocType(String trxDocType)
    {
        this.trxDocType = trxDocType;
    }

    public String getTrxDocName()
    {
        return trxDocName;
    }

    public void setTrxDocName(String trxDocName)
    {
        this.trxDocName = trxDocName;
    }

    public int getTrxGroup()
    {
        return trxGroup;
    }

    public void setTrxGroup(int trxGroup)
    {
        this.trxGroup = trxGroup;
    }

    public Date getTrxTime()
    {
        return trxTime;
    }

    public void setTrxTime(Date trxTime)
    {
        this.trxTime = trxTime;
    }

    public String getTrxType()
    {
        return trxType;
    }

    public void setTrxType(String trxType)
    {
        this.trxType = trxType;
    }

    public double getTotalOtherAmount()
    {
        return otherAmount1 + otherAmount2 + otherAmount3 + otherAmount4 + otherAmount5;
    }

    public double getMiscAmount()
    {
        double miscAmt = 0.0D;
        miscAmt = adjstPaymentAmount + discountAmount + deliveryAmount + mgmtAmount + creditCardAmount + bonusAmount + getTotalOtherAmount();
        return miscAmt;
    }

   
   
    public SalesmanBean getBonusEarnerBean()
    {
        return bonusEarnerBean;
    }

    public void setBonusEarnerBean(SalesmanBean bonusEarnerBean)
    {
        this.bonusEarnerBean = bonusEarnerBean;
    }
    
    
    
    

    public AddressBean getCustomerAddressBean()
    {
        return customerAddressBean;
    }

    public void setCustomerAddressBean(AddressBean customerAddressBean)
    {
        this.customerAddressBean = customerAddressBean;
    }

   
    public SalesmanBean getCustomerSalesmanBean()
    {
        return customerSalesmanBean;
    }

    public void setCustomerSalesmanBean(SalesmanBean customerSalesmanBean)
    {
        this.customerSalesmanBean = customerSalesmanBean;
    }
   

    public MemberBean getCustomerMemberBean()
    {
        return customerMemberBean;
    }

    public void setCustomerMemberBean(MemberBean customerMemberBean)
    {
        this.customerMemberBean = customerMemberBean;
    }
       
    
    public OutletBean getCustomerStockistBean()
    {
        return customerStockistBean;
    }

    public void setCustomerStockistBean(OutletBean customerStockistBean)
    {
        this.customerStockistBean = customerStockistBean;
    }

    public OutletBean getSellerBean()
    {
        return sellerBean;
    }

    public void setSellerBean(OutletBean sellerBean)
    {
        this.sellerBean = sellerBean;
    }

    public OutletBean getServiceAgentBean()
    {
        return serviceAgentBean;
    }

    public void setServiceAgentBean(OutletBean serviceAgentBean)
    {
        this.serviceAgentBean = serviceAgentBean;
    }

    public OutletBean getShipByOutletBean()
    {
        return shipByOutletBean;
    }

    public void setShipByOutletBean(OutletBean shipByOutletBean)
    {
        this.shipByOutletBean = shipByOutletBean;
    }

    public OutletStoreBean getShipByStoreBean()
    {
        return shipByStoreBean;
    }

    public void setShipByStoreBean(OutletStoreBean shipByStoreBean)
    {
        this.shipByStoreBean = shipByStoreBean;
    }

    public OutletBean getShipFromOutletBean()
    {
        return shipFromOutletBean;
    }

    public void setShipFromOutletBean(OutletBean shipFromOutletBean)
    {
        this.shipFromOutletBean = shipFromOutletBean;
    }

    public OutletStoreBean getShipFromStoreBean()
    {
        return shipFromStoreBean;
    }

    public void setShipFromStoreBean(OutletStoreBean shipFromStoreBean)
    {
        this.shipFromStoreBean = shipFromStoreBean;
    }

    public AddressBean getShippingAddressBean()
    {
        return shippingAddressBean;
    }

    public void setShippingAddressBean(AddressBean shippingAddressBean)
    {
        this.shippingAddressBean = shippingAddressBean;
    }

    public PriceCodeBean getPriceCodeBean()
    {
        return priceCodeBean;
    }

    public void setPriceCodeBean(PriceCodeBean priceCodeBean)
    {
        this.priceCodeBean = priceCodeBean;
    }

    public SortedSet getItemSet()
    {
        return itemSet;
    }

    public void addItem(CounterSalesItemBean item)
    {
        if(itemSet == null)
            itemSet = Collections.synchronizedSortedSet(new TreeSet(new CounterSalesComparator()));
        itemSet.add(item);
        item.setMaster(this);
    }

    public CounterSalesItemBean[] getItemArray()
    {
        if(itemArray == null)
            itemArray = CounterSalesManager.EMPTY_SALES_ITEM_ARRAY;
        if(itemSet != null && !itemSet.isEmpty())
            itemArray = (CounterSalesItemBean[])itemSet.toArray(CounterSalesManager.EMPTY_SALES_ITEM_ARRAY);
        return itemArray;
    }

    public void setItemArray(CounterSalesItemBean itemArray[])
    {
        this.itemArray = itemArray;
    }

    public Set getFormSet()
    {
        return formSet;
    }

    public void addForm(CounterSalesFormBean beans[])
    {
        if(formSet == null)
            formSet = new HashSet();
        for(int i = 0; i < beans.length; i++)
        {
            CounterSalesFormBean bean = beans[i];
            if(bean.getFormNo() != null && (bean.getFormNo() == null || bean.getFormNo().length() > 0))
            {
                bean.setMaster(this);
                formSet.add(bean);
            }
        }

    }

    public CounterSalesFormBean[] getFormArray()
    {
        if(formArray == null)
            formArray = CounterSalesManager.EMPTY_SALES_FORM_ARRAY;
        if(formSet != null && !formSet.isEmpty())
            formArray = (CounterSalesFormBean[])formSet.toArray(CounterSalesManager.EMPTY_SALES_FORM_ARRAY);
        return formArray;
    }

    public void setFormArray(CounterSalesFormBean formArray[])
    {
        this.formArray = formArray;
    }

    public Set getPaymentSet()
    {
        return paymentSet;
    }

    public void addPayment(CounterSalesPaymentBean beans[])
    {
        if(paymentSet == null)
            paymentSet = new HashSet();
        for(int i = 0; i < beans.length; i++)
        {
            CounterSalesPaymentBean bean = beans[i];
            if(bean.getAmount() != 0.0D)
            {
                bean.setMaster(this);
                paymentSet.add(bean);
            }
        }

    }

    public CounterSalesPaymentBean[] getPaymentArray()
    {
        if(paymentArray == null)
            paymentArray = CounterSalesManager.EMPTY_SALES_PAYMENT_ARRAY;
        if(paymentSet != null && !paymentSet.isEmpty())
            paymentArray = (CounterSalesPaymentBean[])paymentSet.toArray(CounterSalesManager.EMPTY_SALES_PAYMENT_ARRAY);
        return paymentArray;
    }

    public void setPaymentArray(CounterSalesPaymentBean paymentArray[])
    {
        this.paymentArray = paymentArray;
    }

    public void setFormSet(Set formSet)
    {
        this.formSet = formSet;
    }

    public void setItemSet(SortedSet itemSet)
    {
        this.itemSet = itemSet;
    }

    public void setPaymentSet(Set paymentSet)
    {
        this.paymentSet = paymentSet;
    }

    public DeliveryOrderBean[] getDeliveryHistoryList()
    {
        return deliveryHistoryList;
    }

    public void setDeliveryHistoryList(DeliveryOrderBean deliveryHistoryList[])
    {
        this.deliveryHistoryList = deliveryHistoryList;
    }

    public DeliveryOrderBean getDeliveryOrderBean()
    {
        return deliveryOrderBean;
    }

    public void setDeliveryOrderBean(DeliveryOrderBean deliveryOrderBean)
    {
        this.deliveryOrderBean = deliveryOrderBean;
    }

    public String getTrxDateStr()
    {
        return trxDateStr;
    }

    public void setTrxDateStr(String trxDateStr)
    {
        this.trxDateStr = trxDateStr;
    }

    public String getShipOptionStr()
    {
        return shipOptionStr;
    }

    public void setShipOptionStr(String shipOptionStr)
    {
        this.shipOptionStr = shipOptionStr;
    }

    public boolean isTodayTrx()
    {
        return isTodayTrx;
    }

    public void setTodayTrx(boolean isTodayTrx)
    {
        this.isTodayTrx = isTodayTrx;
    }

    public boolean isCancelBonus()
    {
        return cancelBonus;
    }

    public void setCancelBonus(boolean cancelBonus)
    {
        this.cancelBonus = cancelBonus;
    }

    public void parseBean(ResultSet rs)
        throws SQLException
    {
        parseBean(rs, "");
    }

    public void parseBean(ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        setSalesID(Long.valueOf(rs.getLong((new StringBuilder(String.valueOf(prefix))).append("cso_salesid").toString())));
        setTrxDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("cso_trxdate").toString()));
        setTrxTime(rs.getTime((new StringBuilder(String.valueOf(prefix))).append("cso_trxtime").toString()));
        setBonusDate(rs.getDate((new StringBuilder(String.valueOf(prefix))).append("cso_bonusdate").toString()));
        setBonusPeriodID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_bonusperiodid").toString()));
        setTrxDocCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_trxdoccode").toString()));
        setTrxDocNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_trxdocno").toString()));
        setTrxDocType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_trxdoctype").toString()));
        setTrxDocName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_trxdocname").toString()));
        setTrxType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_trxtype").toString()));
        setTrxGroup(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("cso_trxgroup").toString()));
        setAdjstRefNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_adj_refno").toString()));
        setAdjstSalesID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("cso_adj_salesid").toString()));
        setAdjstRemark(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_adj_remark").toString()));
        setPriceCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_pricecode").toString()));
        setLocalCurrency(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_local_currency").toString()));
        setLocalCurrencyName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_local_currency_name").toString()));
        setLocalCurrencySymbol(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_local_currency_symbol").toString()));
        setBaseCurrency(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_base_currency").toString()));
        setBaseCurrencyName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_base_currency_name").toString()));
        setBaseCurrencySymbol(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_base_currency_symbol").toString()));
        setBaseCurrencyRate(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_base_currency_rate").toString()));
        setBaseCurrencyRate2(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_base_currency_rate2").toString()));
        setBaseCurrencyRate3(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_base_currency_rate3").toString()));
        
        setSellerSeq(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("cso_sellerseq").toString()));
        setSellerID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_sellerid").toString()));
        setSellerType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_sellertype").toString()));
        setSellerTypeStatus(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_seller_typestatus").toString()));
        setSellerHomeBranchID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_seller_home_branchid").toString()));
        setServiceAgentSeq(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("cso_service_agentseq").toString()));
        setServiceAgentID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_service_agentid").toString()));
        setServiceAgentType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_service_agenttype").toString()));
        
        setBonusEarnerSeq(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("cso_bonus_earnerseq").toString()));
        setBonusEarnerID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_bonus_earnerid").toString()));
        setBonusEarnerType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_bonus_earnertype").toString()));
        setBonusEarnerName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_bonus_earnername").toString()));
        
        setCustomerSeq(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("cso_custseq").toString()));
        setCustomerID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_custid").toString()));
        setCustomerReg(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("cso_custreg").toString()));
        setCustomerLucky(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_custlucky").toString()));
        setCustomerType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_custtype").toString()));
        setCustomerTypeStatus(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_cust_typestatus").toString()));
        setCustomerName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_cust_name").toString()));
        setCustomerIdentityNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_cust_identityno").toString()));
        setCustomerContact(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_cust_contact").toString()));                
        
        setCustomerRemark(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_cust_remark").toString()));
        setShipOption(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("cso_ship_option").toString()));
        setShipFromOutletID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_ship_from_outletid").toString()));
        setShipFromStoreCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_ship_from_storecode").toString()));
        setShipByOutletID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_ship_by_outletid").toString()));
        
        setShipByStoreCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_ship_by_storecode").toString()));

        setShipAddress1(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_ship_address_line1").toString()));
        setShipAddress2(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_ship_address_line2").toString()));
        setShipZipcode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_ship_zipcode").toString()));
        
        // cso_ship_countryid, cso_ship_regionid, cso_ship_stateid, cso_ship_cityid    
        setShipCountry(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_ship_countryid").toString()));
        setShipRegion(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_ship_regionid").toString()));
        setShipState(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_ship_stateid").toString()));
        setShipCity(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_ship_cityid").toString()));
        
      //2010-01-05
        setShipExpedition(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_ship_by_expedition").toString()));
        setShipReceiver(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_ship_receiver").toString()));
        setShipContact(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_ship_contact").toString()));
        setShipRemark(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_ship_remark").toString()));
        setTotalBv1(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_total_bv1").toString()));
        setTotalBv2(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_total_bv2").toString()));
        setTotalBv3(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_total_bv3").toString()));
        setTotalBv4(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_total_bv4").toString()));
        setTotalBv5(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_total_bv5").toString()));
        setBvSalesAmount(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_bvsales_amt").toString()));
        setNonBvSalesAmount(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_nonbvsales_amt").toString()));
        setNetSalesAmount(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_netsales_amt").toString()));
        setChiSalesAmount(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_sales_chi_amt").toString()));
        setCorpSalesAmount(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_sales_corp_amt").toString()));
        setAdjstPaymentAmount(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_adjust_payment_amt").toString()));
        setDiscountRate(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_discount_rate").toString()));
        setDiscountAmount(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_discount_amt").toString()));
        setDeliveryRate(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_delivery_rate").toString()));
        setDeliveryAmount(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_delivery_amt").toString()));
        setMgmtRate(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_mgmt_rate").toString()));
        setMgmtAmount(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_mgmt_amt").toString()));
        setCreditCardRate(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_creditcard_rate").toString()));
        setCreditCardAmount(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_creditcard_amt").toString()));
        setBonusRate(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_bonus_rate").toString()));
        setBonusAmount(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_bonus_amt").toString()));
        setOtherAmount1(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_oth_amt1").toString()));
        setOtherAmount2(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_oth_amt2").toString()));
        setOtherAmount3(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_oth_amt3").toString()));
        setOtherAmount4(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_oth_amt4").toString()));
        setOtherAmount5(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_oth_amt5").toString()));
        setPaymentTender(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_payment_tender").toString()));
        setPaymentChange(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_payment_change").toString()));
        setPaymentRemark(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_payment_remark").toString()));
        setRemark(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_remark").toString()));
        setImmediateDelivery(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_immediate_delivery").toString()));
        setDisplayDelivery(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_display_delivery").toString()));
        setProcessStatus(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("cso_process_status").toString()));
        setDeliveryStatus(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("cso_delivery_status").toString()));
        setStatus(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("cso_status").toString()));
        setBalanceFee(rs.getDouble((new StringBuilder(String.valueOf(prefix))).append("cso_balance_fee").toString()));
                
        parseCustomerAddressBean(rs, prefix);
        parseShippingAddressBean(rs, prefix);
        parseInfo(rs, prefix);
        parseTodayTrx();
    }

    private void parseCustomerAddressBean(ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        AddressBean address = new AddressBean();
        address.setMailAddressLine1(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_cust_address_line1").toString()));
        address.setMailAddressLine2(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_cust_address_line2").toString()));
        address.setMailZipCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_cust_zipcode").toString()));
        address.setMailCountryID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_cust_countryid").toString()));
        address.setMailRegionID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_cust_regionid").toString()));
        address.setMailStateID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_cust_stateid").toString()));
        address.setMailCityID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_cust_cityid").toString()));
        setCustomerAddressBean(address);
    }

    private void parseShippingAddressBean(ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        AddressBean address = new AddressBean();
        address.setMailAddressLine1(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_ship_address_line1").toString()));
        address.setMailAddressLine2(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_ship_address_line2").toString()));
        address.setMailZipCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_ship_zipcode").toString()));
        address.setMailCountryID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_ship_countryid").toString()));
        address.setMailRegionID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_ship_regionid").toString()));
        address.setMailStateID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_ship_stateid").toString()));
        address.setMailCityID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("cso_ship_cityid").toString()));
        setShippingAddressBean(address);
    }

    protected void parseTodayTrx()
    {
        Calendar today = Calendar.getInstance();
        today.set(11, 0);
        today.set(12, 0);
        today.set(13, 0);
        today.set(14, 0);
        if(getTrxDate().equals(today.getTime()))
            setTodayTrx(true);
    }

    public String getImportBatchCode()
    {
        return importBatchCode;
    }

    public void setImportBatchCode(String importBatchCode)
    {
        this.importBatchCode = importBatchCode;
    }

    public double getChiSalesAmount()
    {
        return chiSalesAmount;
    }

    public void setChiSalesAmount(double chiSalesAmount)
    {
        this.chiSalesAmount = chiSalesAmount;
    }

    public double getCorpSalesAmount()
    {
        return corpSalesAmount;
    }

    public void setCorpSalesAmount(double corpSalesAmount)
    {
        this.corpSalesAmount = corpSalesAmount;
    }

    public String getShipAddress1() {
        return shipAddress1;
    }

    public void setShipAddress1(String shipAddress1) {
        this.shipAddress1 = shipAddress1;
    }

    public String getShipAddress2() {
        return shipAddress2;
    }

    public void setShipAddress2(String shipAddress2) {
        this.shipAddress2 = shipAddress2;
    }

    public String getShipZipcode() {
        return shipZipcode;
    }

    public void setShipZipcode(String shipZipcode) {
        this.shipZipcode = shipZipcode;
    }

    public String getShipCountry() {
        return shipCountry;
    }

    public void setShipCountry(String shipCountry) {
        this.shipCountry = shipCountry;
    }

    public String getShipRegion() {
        return shipRegion;
    }

    public void setShipRegion(String shipRegion) {
        this.shipRegion = shipRegion;
    }

    public void setShipState(String shipState) {
        this.shipState = shipState;
    }

    public String getShipState() {
        return shipState;
    }    
    
    public String getShipCity() {
        return shipCity;
    }

    public void setShipCity(String shipCity) {
        this.shipCity = shipCity;
    }

    public double getBaseCurrencyRate2() {
        return baseCurrencyRate2;
    }

    public void setBaseCurrencyRate2(double baseCurrencyRate2) {
        this.baseCurrencyRate2 = baseCurrencyRate2;
    }

    public double getBaseCurrencyRate3() {
        return baseCurrencyRate3;
    }

    public void setBaseCurrencyRate3(double baseCurrencyRate3) {
        this.baseCurrencyRate3 = baseCurrencyRate3;
    }

}
