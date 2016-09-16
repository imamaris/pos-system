/*
 * OutstandingTwBean.java
 *
 * Created on August 26, 2015, 2:34 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ecosmosis.orca.outstandingtw;

import com.ecosmosis.mvc.bean.MvcBean;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author ferdiansyah.dwiputra
 */
public class OutstandingTwBean extends MvcBean {
    
    private String DocNo;
    private String TrxType;
    private String ItemName;
    private String ItemCode;
    private String OutletFrom;
    private String OutletTo;
    private int QtyOut;
    private int QtyOrder;
    private int QtyStock;

    public String getDocNo() {
        return DocNo;
    }

    public void setDocNo(String DocNo) {
        this.DocNo = DocNo;
    }
    
    public String getTrxType() {
        return TrxType;
    }

    public void setTrxType(String TrxType) {
        this.TrxType = TrxType;
    }

    public String getItemName() {
        return ItemName;
    }

    public void setItemName(String ItemName) {
        this.ItemName = ItemName;
    }

    public String getItemCode() {
        return ItemCode;
    }

    public void setItemCode(String ItemCode) {
        this.ItemCode = ItemCode;
    }

    public String getOutletFrom() {
        return OutletFrom;
    }

    public void setOutletFrom(String OutletFrom) {
        this.OutletFrom = OutletFrom;
    }

    public String getOutletTo() {
        return OutletTo;
    }

    public void setOutletTo(String OutletTo) {
        this.OutletTo = OutletTo;
    }
    
    public int getQtyOut() {
        return QtyOut;
    }

    public void setQtyOut(int QtyOut) {
        this.QtyOut = QtyOut;
    }
    
    public int getQtyOrder() {
        return QtyOrder;
    }

    public void setQtyOrder(int QtyOrder) {
        this.QtyOrder = QtyOrder;
    }
    
    public int getQtyStock() {
        return QtyStock;
    }

    public void setQtyStock(int QtyStock) {
        this.QtyStock = QtyStock;
    }
    
    protected void parseBean(ResultSet rs)
        throws SQLException
    {
        parseBean(rs, "");
    }
    
    public void parseBean(ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        setDocNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("docno").toString()));
        setTrxType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("piv_trxtype").toString()));
        setItemName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("pmp_default_name").toString()));
        setItemCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("piv_skucode").toString()));
        setOutletFrom(rs.getString((new StringBuilder(String.valueOf(prefix))).append("piv_owner").toString()));
        setOutletTo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("target").toString()));
        setQtyOut(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("qty_out").toString()));
        setQtyOrder(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("qty_order").toString()));
        setQtyStock(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("qty_stock").toString()));
    }
}
