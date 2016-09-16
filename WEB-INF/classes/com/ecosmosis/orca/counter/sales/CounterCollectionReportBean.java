// Decompiled by Yody
// File : CounterCollectionReportBean.class

package com.ecosmosis.orca.counter.sales;

import com.ecosmosis.orca.outlet.paymentmode.OutletPaymentModeBean;
import com.ecosmosis.orca.counter.sales.CounterSalesPaymentBean;
import java.util.*;

// Referenced classes of package com.ecosmosis.orca.counter.sales:
//            CounterSalesOrderBean

public class CounterCollectionReportBean
{
    
    String outletID;
    String documentList[];
    OutletPaymentModeBean paymentModeList[];
    CounterSalesPaymentBean paymentModeList2[];
    
    private Hashtable trxCollection;
    
    public class SalesTrxBean
    {

        private Date date;
        private Hashtable docGrp;
        private Hashtable payGrp;
        private Hashtable payGrp2;
         
        private double totalChangeDue;
        final CounterCollectionReportBean this$0;

        public ArrayList getDocGrpDetail(String docType)
        {
            if(docGrp.containsKey(docType))
                return (ArrayList)(ArrayList)docGrp.get(docType);
            else
                return new ArrayList();
        }

        public void addDocGrpDetail(String docType, CounterSalesOrderBean bean)
        {
            ArrayList temp = (ArrayList)(ArrayList)docGrp.get(docType);
            if(temp == null)
            {
                temp = new ArrayList();
                docGrp.put(docType, temp);
            }
            if(bean != null && bean.getPaymentChange() > 0.0D && bean.getStatus() == 30)
                totalChangeDue += bean.getPaymentChange();
            temp.add(bean);
        }

        public PaymentOrderBean getPayGrpDetail(String paycode)
        {
            PaymentOrderBean bean = null;
            System.out.println("chek getPayGrpDetail : " + paycode) ;
            
            if(payGrp.containsKey(paycode))
                bean = (PaymentOrderBean)payGrp.get(paycode);
            return bean;
            
            
        }
        
        public PaymentOrderBean getPayGrpDetail2(String paycode)
        {
            PaymentOrderBean bean = null;
            System.out.println("chek getPayGrpDetail2 : " + paycode) ;
            
            if(payGrp.containsKey(paycode))
                bean = (PaymentOrderBean)payGrp.get(paycode);
            return bean;
        
        }        

        public void addPayGrpDetail(String payCode, PaymentOrderBean bean)
        {
            payGrp.put(payCode, bean);
        }

        public void addPayGrpDetail2(String payCode, PaymentOrderBean bean)
        {
            // payGrp2.put(payCode.concat(edc).concat(time).toString(), bean);
            payGrp2.put(payCode, bean);
        }
        
                        
        public int getTotalDocGrp()
        {
            return docGrp.size();
        }

        public int getTotalPayGrp()
        {
            return payGrp.size();
        }

        public int getTotalPayGrp2()
        {
            return payGrp2.size();
        }
        
        
        public double getTotalChangeDue()
        {
            return totalChangeDue;
        }

        public void setTotalChangeDue(double totalChangeDue)
        {
            this.totalChangeDue = totalChangeDue;
        }

        public Date getDate()
        {
            return date;
        }

        public void setDate(Date date)
        {
            this.date = date;
        }


        public SalesTrxBean()
        {
            super();
            this$0 = CounterCollectionReportBean.this;
            // super();
            docGrp = new Hashtable();
            payGrp = new Hashtable();
            payGrp2 = new Hashtable();
            totalChangeDue = 0.0D;
        }
    }

    public class PaymentOrderBean            
    {
        private Date date;
        private String paymentCode;
        private String paymentDesc;
        private String paymentEdc;
        private String paymentTime;
        private String gabung;
        private String paymentCurrency;
        
        private double paymentRate;
        private double paymentIn;
        private double paymentOut;
        private int payCount;
        private int currCount;
        final CounterCollectionReportBean this$0;

        public int getPayCount()
        {
            return payCount;
        }

        public void setPayCount(int payCount)
        {
            this.payCount = payCount;
        }

        public String getPaymentCode()
        {
            return paymentCode;
        }

        public void setPaymentCode(String paymentCode)
        {
            this.paymentCode = paymentCode;
        }

        public String getGabung()
        {
            return gabung;
        }

        public void setGabung(String gabung)
        {
            this.gabung = gabung;
        }
        
        public String getPaymentDesc()
        {
            return paymentDesc;
        }

        public void setPaymentDesc(String paymentDesc)
        {
            this.paymentDesc = paymentDesc;
        }

        public double getPaymentIn()
        {
            return paymentIn;
        }

        public void setPaymentIn(double paymentIn)
        {
            this.paymentIn = paymentIn;
        }

        public double getPaymentOut()
        {
            return paymentOut;
        }

        public void setPaymentOut(double paymentOut)
        {
            this.paymentOut = paymentOut;
        }

        public Date getDate()
        {
            return date;
        }

        public void setDate(Date date)
        {
            this.date = date;
        }

       public PaymentOrderBean()
      {
           // pindah krn error admin collection 
           super();
            this$0 = CounterCollectionReportBean.this;
            // super();
       }

        public String getPaymentEdc() {
            return paymentEdc;
        }

        public void setPaymentEdc(String paymentEdc) {
            this.paymentEdc = paymentEdc;
        }

        public String getPaymentTime() {
            return paymentTime;
        }

        public void setPaymentTime(String paymentTime) {
            this.paymentTime = paymentTime;
        }

        public String getPaymentCurrency() {
            return paymentCurrency;
        }

        public void setPaymentCurrency(String paymentCurrency) {
            this.paymentCurrency = paymentCurrency;
        }

        public double getPaymentRate()
        {
            return paymentRate;
        }

        public void setPaymentRate(double paymentRate)
        {
            this.paymentRate = paymentRate;
        }

        public int getCurrCount()
        {
            return currCount;
        }

        public void setCurrCount(int currCount)
        {
            this.currCount = currCount;
        }
        
    }


/*    String outletID;
    String documentList[];
    OutletPaymentModeBean paymentModeList[];
    private Hashtable trxCollection;
*/
   public CounterCollectionReportBean()
   {
       trxCollection = new Hashtable();
    }

    public Date[] getTrxColletionDateList()
    {
        Date list[] = new Date[0];
        if(trxCollection.size() > 0)
        {
            Vector v = new Vector((Collection)trxCollection.keySet());
            Collections.sort(v);
            list = (Date[])v.toArray(new Date[0]);
        }
        return list;
    }

    public SalesTrxBean getTrxCollection(Date date)
    {
        SalesTrxBean bean = null;
        if(trxCollection.containsKey(date))
            bean = (SalesTrxBean)trxCollection.get(date);
        return bean;
    }

    public void addTrxCollection(Date date, CounterSalesOrderBean bean)
    {
        SalesTrxBean temp = (SalesTrxBean)trxCollection.get(date);
        if(temp == null)
        {
            temp = new SalesTrxBean();
            temp.setDate(date);
            trxCollection.put(date, temp);
        }
        temp.addDocGrpDetail(bean.getTrxDocType(), bean);
    }

    public void addPaymentCollection(Date date, PaymentOrderBean bean)
    {
        SalesTrxBean temp = (SalesTrxBean)trxCollection.get(date);
        if(temp == null)
        {
            temp = new SalesTrxBean();
            temp.setDate(date);
            trxCollection.put(date, temp);
        }
        temp.addPayGrpDetail(bean.getPaymentCode(), bean);
        // temp.addPayGrpDetail(bean.getPaymentTime(), bean);
        // temp.addPayGrpDetail(bean.getPaymentCode().concat(bean.getPaymentEdc()).concat(bean.getPaymentTime()).concat(bean.getPaymentCurrency()), bean);
    }

    public void addPaymentCollection2(Date date, PaymentOrderBean bean)
    {
        SalesTrxBean temp = (SalesTrxBean)trxCollection.get(date);
        if(temp == null)
        {
            temp = new SalesTrxBean();
            temp.setDate(date);
            trxCollection.put(date, temp);
        }
        temp.addPayGrpDetail2(bean.getPaymentCode().concat(bean.getPaymentEdc()).concat(bean.getPaymentTime()), bean);
    }
    
    public String getOutletID()
    {
        return outletID;
    }

    public void setOutletID(String outletID)
    {
        this.outletID = outletID;
    }

    public String[] getDocumentList()
    {
        return documentList;
    }

    public void setDocumentList(String documentList[])
    {
        this.documentList = documentList;
    }

    public OutletPaymentModeBean[] getPaymentModeList()
    {
        return paymentModeList;
    }

    public void setPaymentModeList(OutletPaymentModeBean paymentModeList[])
    {
        this.paymentModeList = paymentModeList;
    }

    public CounterSalesPaymentBean[] getPaymentModeList2()
    {
        return paymentModeList2;
    }
    
    
    public void setPaymentModeList2(CounterSalesPaymentBean paymentModeList2[]) {
         this.paymentModeList2 = paymentModeList2;
    }
}
