// Decompiled by Yody
// File : OutletBroker.class

package com.ecosmosis.orca.outlet;

import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionBroker;
import com.ecosmosis.orca.counter.sales.CounterSalesPaymentBean;
import com.ecosmosis.orca.outlet.paymentmode.OutletPaymentModeBean;
import com.ecosmosis.orca.pricing.PriceCodeBean;
import com.ecosmosis.util.log.Log;
import java.sql.*;
import java.util.ArrayList;

// Referenced classes of package com.ecosmosis.orca.outlet:
//            OutletBean

public class OutletBroker extends DBTransactionBroker
{

    private final String SQL_getRecord = " select * from outlet  left join locations on otl_control_locationid = loc_id   where otl_outletid = ? ";
    private final String SQL_getOutletPricecode = " select * from outlet_pricecode  left join price_code on opc_pricecodeid = pcd_pricecode  where opc_outletid = ? and opc_status = ?";
    private final String SQL_getOutletPaymentMode = " select * from outlet_payment_mode  left join payment_mode on opm_paymodecode = pmp_paymodecode  where opm_paymodecode = ? and opm_outletid = ?";
    private final String SQL_getOutletPaymentModeList = " select * from outlet_payment_mode  left join payment_mode on opm_paymodecode = pmp_paymodecode  where opm_outletid = ? order by opm_order_seq";

    protected OutletBroker(Connection con)
    {
        super(con);
    }

    public ArrayList getList(String locationTracekey)
        throws MvcException, SQLException
    {
        ArrayList list;
        String SQL1;
        String SQL2;
        String SQL3;
        PreparedStatement stmt;
        ResultSet rs;
        list = new ArrayList();
        SQL1 = " select * from outlet  left join locations on otl_control_locationid = loc_id  ";
        SQL2 = " where loc_tracekey like ? ";
        SQL3 = " order by loc_tracekey ";
        stmt = null;
        rs = null;
        try
        {
            if(locationTracekey == null)
            {
                stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL1))).append(SQL3).toString());
            } else
            {
                stmt = getConnection().prepareStatement((new StringBuilder(String.valueOf(SQL1))).append(SQL2).append(SQL3).toString());
                stmt.setString(1, (new StringBuilder(String.valueOf(locationTracekey))).append("%").toString());
            }
            rs = stmt.executeQuery();
            int count = 0;
            OutletBean bean;
            for(; rs.next(); list.add(bean))
            {
                count++;
                bean = new OutletBean();
                bean.parseBean(bean, rs, "");
            }

        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Outlet Info --> ")).append(sqlex).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_243;
        Exception exception;
        exception;
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        throw exception;
        */
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }

    public OutletBean getRecord(String id)
        throws MvcException, SQLException
    {
        OutletBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        bean = null;
        stmt = null;
        rs = null;
        try
        {
            stmt = getConnection().prepareStatement(" select * from outlet  left join locations on otl_control_locationid = loc_id   where otl_outletid = ? ");
            stmt.setString(1, id);
            rs = stmt.executeQuery();
            int count = 0;
            if(rs.next())
            {
                count++;
                bean = new OutletBean();
                bean.parseBean(bean, rs, "");
            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Outlet Record --> ")).append(sqlex).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_130;
        Exception exception;
        exception;
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        throw exception;
        */
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
    }

    public ArrayList getPriceCode(String id)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        list = new ArrayList();
        stmt = null;
        rs = null;
        try
        {
            stmt = getConnection().prepareStatement(" select * from outlet_pricecode  left join price_code on opc_pricecodeid = pcd_pricecode  where opc_outletid = ? and opc_status = ?");
            stmt.setString(1, id);
            stmt.setString(2, "A");
            rs = stmt.executeQuery();
            int count = 0;
            PriceCodeBean bean;
            for(; rs.next(); list.add(bean))
            {
                count++;
                bean = new PriceCodeBean();
                bean.parseBean(bean, rs, "");
            }

        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Outlet Price Code Info  --> ")).append(sqlex).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_158;
        Exception exception;
        exception;
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        throw exception;
        */
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }

    public OutletPaymentModeBean getPaymentMode(String paymodeCode, String outletID)
        throws MvcException, SQLException
    {
        OutletPaymentModeBean bean;
        PreparedStatement stmt;
        ResultSet rs;
        bean = null;
        stmt = null;
        rs = null;
        try
        {
            stmt = getConnection().prepareStatement(" select * from outlet_payment_mode  left join payment_mode on opm_paymodecode = pmp_paymodecode  where opm_paymodecode = ? and opm_outletid = ?");
            stmt.setString(1, paymodeCode);
            stmt.setString(2, outletID);
            rs = stmt.executeQuery();
            if(rs.next())
            {
                bean = new OutletPaymentModeBean();
                bean.parseBean(rs);
            }
        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Outlet Payment Mode Info  --> ")).append(sqlex).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_136;
        Exception exception;
        exception;
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        throw exception;
        */
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return bean;
    }

    public ArrayList getPaymentModeList(String outletID)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        list = new ArrayList();
        stmt = null;
        rs = null;
        try
        {
            // stmt = getConnection().prepareStatement(" select * from outlet_payment_mode  left join payment_mode on opm_paymodecode = pmp_paymodecode  where opm_outletid = ? order by opm_paymodecode, opm_edc, opm_time");       
            stmt = getConnection().prepareStatement(" select * from outlet_payment_mode  where opm_outletid = ? order by opm_paymodecode, opm_edc, opm_time");
            
            stmt.setString(1, outletID);
            rs = stmt.executeQuery();
            int count = 0;
            OutletPaymentModeBean bean;
            for(; rs.next(); list.add(bean))
            {
                count++;
                bean = new OutletPaymentModeBean();
                bean.parseBean(rs);
            }

        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading Outlet Payment Mode Info  --> ")).append(sqlex).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_145;
        Exception exception;
        exception;
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();        
        throw exception;
        */
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }

    public ArrayList getPaymentModeList2(String outletID)
        throws MvcException, SQLException
    {
        ArrayList list;
        PreparedStatement stmt;
        ResultSet rs;
        list = new ArrayList();
        stmt = null;
        rs = null;
        try
        {
            // stmt = getConnection().prepareStatement(" select * from outlet_payment_mode  left join payment_mode on opm_paymodecode = pmp_paymodecode  where opm_outletid = ? order by opm_paymodecode, opm_edc, opm_time");       
            //stmt = getConnection().prepareStatement(" select * from outlet_payment_mode  where opm_outletid = ? order by opm_paymodecode, opm_edc, opm_time");
            stmt = getConnection().prepareStatement(" SELECT counter_sales_payment.csm_seq,counter_sales_payment.csm_salesid,counter_sales_payment.csm_paymodecode,counter_sales_payment.csm_paymodedesc,counter_sales_payment.csm_paymodeedc,counter_sales_payment.csm_paymodetime,counter_sales_payment.csm_paymodegroup,counter_sales_payment.csm_refno,counter_sales_payment.csm_expired,counter_sales_payment.csm_owner,counter_sales_payment.csm_amt,counter_sales_payment.XCHGRATE,counter_sales_payment.csm_status FROM counter_sales_order Left Join counter_sales_payment ON counter_sales_order.cso_salesid = counter_sales_payment.csm_salesid where cso_sellerid = ?  and counter_sales_payment.csm_paymodecode is not null order by counter_sales_payment.csm_paymodedesc, counter_sales_payment.csm_paymodeedc, counter_sales_payment.csm_paymodetime ");            
            
            stmt.setString(1, outletID);
            rs = stmt.executeQuery();
            int count = 0;
            CounterSalesPaymentBean bean;
            for(; rs.next(); list.add(bean))
            {
                count++;
                bean = new CounterSalesPaymentBean();                
                bean.parseBean(rs);
            }

        }
        catch(SQLException sqlex)
        {
            Log.error(sqlex);
            throw new MvcException((new StringBuilder("Error while Loading CounterSalesPaymentBean New Info  --> ")).append(sqlex).toString());
        }
        /*
        break MISSING_BLOCK_LABEL_145;
        Exception exception;
        exception;
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();        
        throw exception;
        */
        if(stmt != null)
            stmt.close();
        if(rs != null)
            rs.close();
        return list;
    }
    
    public boolean insert(OutletBean bean)
        throws SQLException
    {
        boolean status;
        PreparedStatement stmt1;
        String sql1;
        status = false;
        stmt1 = null;
        String fields = "(otl_outletid,otl_doccode,otl_name,otl_control_locationid,otl_operation_countryid,otl_register_prefix,  otl_type,otl_company_registerno,otl_address_line1,otl_address_line2,otl_zipcode,otl_countryid,otl_regioinid,  otl_stateid,otl_cityid,otl_officeno,otl_faxno,otl_mobileno,otl_email,otl_supervisor_name,otl_pickup_private,  otl_pickup_public, otl_warehouse_storecode, otl_sales_storecode, otl_writeoff_storecode, otl_remark) ";
        sql1 = (new StringBuilder(" insert into outlet ")).append(fields).append(" values ").append(getSQLInsertParams(fields)).toString();
        stmt1 = getConnection().prepareStatement(sql1);
        int cnt = 0;
        stmt1.setString(++cnt, bean.getOutletID());
        stmt1.setString(++cnt, bean.getDocCode());
        stmt1.setString(++cnt, bean.getName());
        stmt1.setString(++cnt, bean.getControlLocationID());
        stmt1.setString(++cnt, bean.getOperationCountryID());
        stmt1.setString(++cnt, bean.getReg_prefix());
        stmt1.setString(++cnt, bean.getType());
        stmt1.setString(++cnt, bean.getRegistrationInfo());
        stmt1.setString(++cnt, bean.getAddress1());
        stmt1.setString(++cnt, bean.getAddress2());
        stmt1.setString(++cnt, bean.getZipcode());
        stmt1.setString(++cnt, bean.getCountryID());
        stmt1.setString(++cnt, bean.getRegionID());
        stmt1.setString(++cnt, bean.getStateID());
        stmt1.setString(++cnt, bean.getCityID());
        stmt1.setString(++cnt, bean.getOfficeTel());
        stmt1.setString(++cnt, bean.getFaxNo());
        stmt1.setString(++cnt, bean.getMobileTel());
        stmt1.setString(++cnt, bean.getEmail());
        stmt1.setString(++cnt, bean.getSupervisor());
        stmt1.setInt(++cnt, bean.getPickup_private());
        stmt1.setInt(++cnt, bean.getPickup_public());
        stmt1.setString(++cnt, bean.getWarehouseStoreCode());
        stmt1.setString(++cnt, bean.getSalesStoreCode());
        stmt1.setString(++cnt, bean.getWriteoffStoreCode());
        stmt1.setString(++cnt, bean.getRemark());
        status = stmt1.executeUpdate() == 1;
        stmt1.close();
        String sql_pay = (new StringBuilder(" insert into  outlet_payment_mode  (opm_paymodecode, opm_outletid)  select opm_paymodecode, '")).append(bean.getOutletID()).append("' from ").append(" outlet_payment_mode where opm_outletid = 'PT' ").toString();
        stmt1 = getConnection().prepareStatement(sql_pay);
        stmt1.executeUpdate();
        stmt1.close();
        String sql_price = (new StringBuilder(" insert into  outlet_pricecode  (opc_outletid, opc_pricecodeid)  select '")).append(bean.getOutletID()).append("', opc_pricecodeid from ").append(" outlet_pricecode where opc_outletid = 'PT' ").toString();
        stmt1 = getConnection().prepareStatement(sql_price);
        stmt1.executeUpdate();
        stmt1.close();
        /* 
        break MISSING_BLOCK_LABEL_609;
        Exception exception;
        exception;
        try
        {
            if(stmt1 != null)
                stmt1.close();
        }
        catch(SQLException sqlexception) { }
        throw exception;
        */
        try
        {
            if(stmt1 != null)
                stmt1.close();
        }
        catch(SQLException sqlexception1) { }
        return status;
    }

}
