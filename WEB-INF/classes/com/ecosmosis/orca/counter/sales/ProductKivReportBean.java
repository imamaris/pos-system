// Decompiled by Yody
// DeCompiled : ProductKivReportBean.class

package com.ecosmosis.orca.counter.sales;

import java.util.ArrayList;
import java.util.Hashtable;

// Referenced classes of package com.ecosmosis.orca.counter.sales:
//            CounterSalesOrderBean

public class ProductKivReportBean
{
    public class ProductKivBean
    {

        private String productID;
        private String productCode;
        private String skuCode;
        private String productName;
        private String productType;
        private int qtyKiv;
        private int qtyOnHand;
        final ProductKivReportBean this$0;

        public String getProductCode()
        {
            return productCode;
        }

        public void setProductCode(String productCode)
        {
            this.productCode = productCode;
        }

        public String getProductID()
        {
            return productID;
        }

        public void setProductID(String productID)
        {
            this.productID = productID;
        }

        public String getProductName()
        {
            return productName;
        }

        public void setProductName(String productName)
        {
            this.productName = productName;
        }

        public int getQtyKiv()
        {
            return qtyKiv;
        }

        public void setQtyKiv(int qtyKiv)
        {
            this.qtyKiv = qtyKiv;
        }

        public int getQtyOnHand()
        {
            return qtyOnHand;
        }

        public void setQtyOnHand(int qtyOnHand)
        {
            this.qtyOnHand = qtyOnHand;
        }

        public ProductKivBean()
        {
            super();
            this$0 = ProductKivReportBean.this;
            // super();
        }

        public String getSkuCode() {
            return skuCode;
        }

        public void setSkuCode(String skuCode) {
            this.skuCode = skuCode;
        }

        public String getProductType() {
            return productType;
        }

        public void setProductType(String productType) {
            this.productType = productType;
        }
    }

    public class BackOrderBean
    {

        private CounterSalesOrderBean counterSalesOrderBean;
        private int qtyKiv;
        final ProductKivReportBean this$0;

        public int getQtyKiv()
        {
            return qtyKiv;
        }

        public void setQtyKiv(int qtyKiv)
        {
            this.qtyKiv = qtyKiv;
        }

        public CounterSalesOrderBean getCounterSalesOrderBean()
        {
            return counterSalesOrderBean;
        }

        public void setCounterSalesOrderBean(CounterSalesOrderBean counterSalesOrderBean)
        {
            this.counterSalesOrderBean = counterSalesOrderBean;
        }

        public BackOrderBean()
        {
            super();
            this$0 = ProductKivReportBean.this;
            // super();
            
        }
    }


    private Hashtable backOrderByProduct;
    private ArrayList productKivList;

    public ProductKivReportBean()
    {
        backOrderByProduct = new Hashtable();
    }

    public ArrayList getProductKivList()
    {
        if(productKivList == null)
            return new ArrayList();
        else
            return productKivList;
    }

    public void setProductKivList(ArrayList productKivList)
    {
        this.productKivList = productKivList;
    }

    public void addProductKiv(ProductKivBean obj)
    {
        if(productKivList == null)
            productKivList = new ArrayList();
        productKivList.add(obj);
    }

    public ArrayList getBackOrderListByProduct(String productID)
    {
        ArrayList temp = (ArrayList)(ArrayList)backOrderByProduct.get(productID);
        if(temp == null)
            temp = new ArrayList();
        return temp;
    }

    public void addBackOrder(String productID, BackOrderBean obj)
    {
        ArrayList temp = (ArrayList)(ArrayList)backOrderByProduct.get(productID);
        if(temp == null)
        {
            temp = new ArrayList();
            backOrderByProduct.put(productID, temp);
        }
        temp.add(obj);
    }
}
