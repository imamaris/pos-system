// Decompiled by Yody
// File : StockMovementRptBean.class

package com.ecosmosis.orca.inventory;

import com.ecosmosis.orca.product.ProductBean;
import com.ecosmosis.orca.product.ProductManager;
import java.util.*;

public class StockMovementRptBean
// public abstract class StockMovementRptBean
// public class CounterSalesOrderBean extends MvcBean 
// public abstract class Type         
{
    public class ProductDoc
    {

        private String trxId;
        private String trxType;
        private String docNo;
        private String docType;
        private Date trxnDate;
        final StockMovementRptBean this$0;

        public String getDocNo()
        {
            return docNo;
        }

        public void setDocNo(String docNo)
        {
            this.docNo = docNo;
        }

        public String getTrxId()
        {
            return trxId;
        }

        public void setTrxId(String trxId)
        {
            this.trxId = trxId;
        }

        public String getTrxType()
        {
            return trxType;
        }

        public void setTrxType(String docType)
        {
            trxType = docType;
        }

        public String getDocType()
        {
            return docType;
        }

        public void setDocType(String docType)
        {
            this.docType = docType;
        }

        public Date getTrxnDate()
        {
            return trxnDate;
        }

        public void setTrxnDate(Date trxnDate)
        {
            this.trxnDate = trxnDate;
        }

        public ProductDoc()
        {
            super();
            this$0 = StockMovementRptBean.this;
            // super();
        }
    }

    public class ProductDocDetail
    {

        private int in;
        private int out;
        private String productName;
        private String productId;
        private String productCode;
        final StockMovementRptBean this$0;

        public int getIn()
        {
            return in;
        }

        public void setIn(int in)
        {
            this.in = in;
        }

        public int getOut()
        {
            return out;
        }

        public void setOut(int out)
        {
            this.out = out;
        }

        public String getProductName()
        {
            return productName;
        }

        public void setProductName(String productName)
        {
            this.productName = productName;
        }

        public String getProductId()
        {
            return productId;
        }

        public void setProductId(String productId)
        {
            this.productId = productId;
        }

        public String getProductCode()
        {
            return productCode;
        }

        public void setProductCode(String productCode)
        {
            this.productCode = productCode;
        }

        public ProductDocDetail()
        {
            super();
            this$0 = StockMovementRptBean.this;
            // super();
            in = 0;
            out = 0;
        }
    }

    public class StockInfo
    // public class StockInfo extends StockMovementRptBean
    {

        private String itemId;
        private int purchaseIn;
        private int purchaseOut;
        private int disposeIn;
        private int disposeOut;
        private int transferIn;
        private int transferOut;
        
        // Allocate
        private int allocateIn;
        private int allocateOut;
        
        private int salesIn;
        private int salesOut;
        private int adjustmentIn;
        private int adjustmentOut;
        private int loanIn;
        private int loanOut;
        private int freeIn;
        private int freeOut;
        private int returnOut;
        private int discrOut;
        private int discrIn;
        private int bringForwardBalance;
        final StockMovementRptBean this$0;

        public int getReturnOut()
        {
            return returnOut;
        }

        public void setReturnOut(int returnOut)
        {
            this.returnOut = returnOut;
        }

        public int getDiscrOut()
        {
            return discrOut;
        }

        public void setDiscrOut(int discrOut)
        {
            this.discrOut = discrOut;
        }

        public int getDiscrIn()
        {
            return discrIn;
        }

        public void setDiscrIn(int discrIn)
        {
            this.discrIn = discrIn;
        }

        public int getAdjustmentIn()
        {
            return adjustmentIn;
        }

        public void setAdjustmentIn(int adjustmentIn)
        {
            this.adjustmentIn = adjustmentIn;
        }

        public int getAdjustmentOut()
        {
            return adjustmentOut;
        }

        public void setAdjustmentOut(int adjustmentOut)
        {
            this.adjustmentOut = adjustmentOut;
        }

        public int getDisposeIn()
        {
            return disposeIn;
        }

        public void setDisposeIn(int disposeIn)
        {
            this.disposeIn = disposeIn;
        }

        public int getDisposeOut()
        {
            return disposeOut;
        }

        public void setDisposeOut(int disposeOut)
        {
            this.disposeOut = disposeOut;
        }

        public int getLoanIn()
        {
            return loanIn;
        }

        public void setLoanIn(int loanIn)
        {
            this.loanIn = loanIn;
        }

        public int getLoanOut()
        {
            return loanOut;
        }

        public void setLoanOut(int loanOut)
        {
            this.loanOut = loanOut;
        }

        public String getItemId()
        {
            return itemId;
        }

        public int getSalesIn()
        {
            return salesIn;
        }

        public void setSalesIn(int salesIn)
        {
            this.salesIn = salesIn;
        }

        public int getSalesOut()
        {
            return salesOut;
        }

        public void setSalesOut(int salesOut)
        {
            this.salesOut = salesOut;
        }

        public int getTransferIn()
        {
            return transferIn;
        }

        public void setTransferIn(int transferIn)
        {
            this.transferIn = transferIn;
        }

        public int getTransferOut()
        {
            return transferOut;
        }

        public void setTransferOut(int transferOut)
        {
            this.transferOut = transferOut;
        }

        public void setProduct(ProductBean productBean)
        {
            String productId = String.valueOf(productBean.getProductID());
            // String productId = String.valueOf(productBean.getProductCode());
            itemId = productId;
            if(!items.contains(productId))
                items.put(productId, productBean);
        }

        public int getBringForwardBalance()
        {
            return bringForwardBalance;
        }

        public Hashtable getItems()
        {
            return items;
        }

        public void setBringForwardBalance(int bal)
        {
            bringForwardBalance = bal;
        }

        public int getBalance()
        {
            // int bal = (bringForwardBalance + purchaseIn + disposeIn + transferIn + salesIn + adjustmentIn + loanIn + discrIn + freeIn) - (purchaseOut + disposeOut + transferOut + salesOut + discrOut + returnOut + adjustmentOut + loanOut + freeOut);
            // Allocate
            int bal = (bringForwardBalance + purchaseIn + disposeIn + transferIn + allocateIn + salesIn + adjustmentIn + loanIn + discrIn + freeIn) - (purchaseOut + disposeOut + transferOut + allocateOut + salesOut + discrOut + returnOut + adjustmentOut + loanOut + freeOut);
            return bal;
        }

        public int getPurchaseIn()
        {
            return purchaseIn;
        }

        public int getPurchaseOut()
        {
            return purchaseOut;
        }

        public void setPurchaseIn(int i)
        {
            purchaseIn = i;
        }

        public void setPurchaseOut(int i)
        {
            purchaseOut = i;
        }

        public int getFreeIn()
        {
            return freeIn;
        }

        public int getFreeOut()
        {
            return freeOut;
        }

        public void setFreeIn(int i)
        {
            freeIn = i;
        }

        public void setFreeOut(int i)
        {
            freeOut = i;
        }

        public StockInfo()
        {
            super();
            this$0 = StockMovementRptBean.this;
            // super();
        }

        public int getAllocateIn() {
            return allocateIn;
        }

        public void setAllocateIn(int allocateIn) {
            this.allocateIn = allocateIn;
        }

        public int getAllocateOut() {
            return allocateOut;
        }

        public void setAllocateOut(int allocateOut) {
            this.allocateOut = allocateOut;
        }
    }


    private Hashtable items;
    private TreeMap stocks;
    private Hashtable doc;
    private Hashtable docDetail;

    // public class Inner extends Outer
    public StockMovementRptBean()
    // public abstract class StockMovementRptBean()    
    {
        items = new Hashtable();
        stocks = new TreeMap();
        doc = new Hashtable();
        docDetail = new Hashtable();
    }

    public Date[] getTotalDate()
    {
        return (Date[])stocks.keySet().toArray(new Date[0]);
    }

    public ProductBean[] getProductItems()
    {
        return (ProductBean[])items.values().toArray(ProductManager.EMPTY_ARRAY_PRODUCT);
    }

    public StockInfo getStockInfo(String item)
    {
        StockInfo stock = (StockInfo)stocks.get(item);
        if(stock == null)
            return null;
        else
            return stock;
    }

    public void addStock(String item, StockInfo stockinfo)
    {
        stocks.put(stockinfo.getItemId(), stockinfo);
    }

    public void addProductDocDetail(String docNum, Collection productDocDetail)
    {
        docDetail.put(docNum, productDocDetail);
    }

    public Collection getProductDocDetail(String docNum)
    {
        Collection productDocDetail = (Collection)docDetail.get(docNum);
        if(productDocDetail == null)
            return null;
        else
            return productDocDetail;
    }

    public void addProductDoc(String docType, Collection productDoc)
    {
        doc.put(docType, productDoc);
    }

    public Collection getProductDoc(String docType)
    {
        Collection productDocList = (Collection)doc.get(docType);
        if(productDocList == null)
            return null;
        else
            return productDocList;
    }

    public ProductDoc[] getProductDocList()
    {
        return (ProductDoc[])doc.values().toArray(new ProductDoc[0]);
    }

    public String[] getTrxTypeList()
    {
        return (String[])doc.keySet().toArray(new String[0]);
    }

}
