// Decompiled by Yody
// File : CounterSalesReportManager.class

package com.ecosmosis.orca.counter.sales;

import com.ecosmosis.common.customlibs.FIFOMap;
import com.ecosmosis.mvc.accesscontrol.user.LoginUserBean;
import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionManager;
import com.ecosmosis.mvc.manager.MvcReturnBean;
import com.ecosmosis.mvc.manager.SQLConditionsBean;
import com.ecosmosis.mvc.sys.Sys;
import com.ecosmosis.orca.outlet.OutletBean;
import com.ecosmosis.orca.outlet.OutletManager;
import com.ecosmosis.orca.product.ProductManager;
import com.ecosmosis.orca.stockist.StockistManager;
import com.ecosmosis.util.http.StandardOptionsMap;
import com.ecosmosis.util.log.Log;
import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Locale;
import javax.servlet.http.HttpServletRequest;

// Referenced classes of package com.ecosmosis.orca.counter.sales:
//            CounterSalesReportBroker, CounterCollectionReportBean, SalesSummaryBean, ExportSalesGenerator, 
//            ProductSalesReportBean, ProductKivReportBean

public class CounterSalesReportManager extends DBTransactionManager
{

    public static final int TASKID_ADMIN_COLLECTION_RPT = 0x18da8;
    public static final int TASKID_OUTLET_COLLECTION_RPT = 0x18da9;
    public static final int TASKID_COMPANY_COLLECTION_RPT = 0x18daa;
    public static final int TASKID_ADMIN_COLLECTION_FILTER_RPT = 0x18dab;
    
    public static final int TASKID_ADMIN_DSR_FILTER_RPT = 0x18dad;
    // he
    public static final int TASKID_ADMIN_COLLECTION_FILTER_RPT_HE = 0x18dad;   
    public static final int TASKID_OUTLET_COLLECTION_FILTER_RPT = 0x18dac;
    public static final int TASKID_PRODUCT_KIV_RPT = 0x19192;
    
    public static final int TASKID_PRODUCT_KIV_RPT_LOAN = 0x19193;
    
    public static final int TASKID_TRX_PRODUCT_SALES_SUMMARY_RPT = 0x19e16;
    public static final int TASKID_BONUS_PRODUCT_SALES_SUMMARY_RPT = 0x19e1a;
    public static final int TASKID_ESTK_ADMIN_COLLECTION_RPT = 0x323e8;
    public static final int TASKID_ESTK_OUTLET_COLLECTION_RPT = 0x323e9;
    public static final int TASKID_EXPORT_SALES = 0x19a94;
    public static final int TASKID_EXPORT_SALES_SUBMIT = 0x19a95;
    public static final int TASKID_EXPORT_SALES_TYPEII = 0x19a96;
    public static final int TASKID_EXPORT_SALES_TYPEII_SUBMIT = 0x19a97;
    public static final int TASKID_EXPORT_SALES_TYPEIII = 0x19a98;
    public static final int TASKID_EXPORT_SALES_TYPEIII_SUBMIT = 0x19a99;
    private CounterSalesReportBroker broker;

    public CounterSalesReportManager()
    {
        broker = null;
    }

    public CounterSalesReportManager(Connection conn)
    {
        super(conn);
        broker = null;
    }

    private CounterSalesReportBroker getBroker(Connection conn)
    {
        if(broker == null)
            broker = new CounterSalesReportBroker(conn);
        else
            broker.setConnection(conn);
        return broker;
    }

    public String defineTaskTitle(int taskID)
    {
        String taskTitle = "";
        switch(taskID)
        {
        case 101800: 
        case 101803: 
        // case 101805:       
        case 205800: 
            taskTitle = "Admin Collection Report";
            break;
            
	case 101805:
            taskTitle = "DSR Report"; 
            break;            

        case 101801: 
        case 101804: 
        case 205801: 
            taskTitle = "Counter Collection Report";
            break;

        case 101802: 
            taskTitle = "Company Collection Report";
            break;
        }
        return taskTitle;
    }

    private MvcReturnBean getCounterCollectionReport(HttpServletRequest request, int taskID)
        throws MvcException
    {
        MvcReturnBean returnBean = new MvcReturnBean();
        try
        {
            boolean formSubmitted = request.getParameter("SubmitData") != null;
            if(formSubmitted)
            {
                java.util.Date trxDtFrom = null;
                java.util.Date trxDtTo = null;
                String conditions = "";
                SQLConditionsBean cond = new SQLConditionsBean();
                cond.setOrderby(" order by cso_trxdate, cso_trxgroup asc");
                String sellerID = getLoginUser().getOutletID();
                if(taskID == 0x18daa)
                    sellerID = request.getParameter("SellerID");
                if(sellerID != null && sellerID.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(conditions.length() != 0 ? " and " : " where ").append(" cso_sellerid = '").append(sellerID.trim()).append("' ").toString();
                //sementara dibuka semua ..10 Mei 2012
                /*
                String userID = getLoginUser().getUserId();
                if(taskID != 0x18da8 && taskID != 0x18dab && taskID != 0x323e8)
                    userID = request.getParameter("UserID");
                if(userID != null && userID.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(conditions.length() != 0 ? " and " : " where ").append(" std_createby = '").append(userID.trim()).append("' ").toString();
                */
                String status = request.getParameter("Status");
                String trxDtFromStr = request.getParameter("TrxDateFrom");
                String trxDtToStr = request.getParameter("TrxDateTo");
                if(status != null && status.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(conditions.length() != 0 ? " and " : " where ").append(" ((cso_trxgroup = '").append(10).append("' AND (cso_status = '").append(status).append("' OR cso_status = '").append(60).append("')) OR").append(" (cso_trxgroup = '").append(40).append("')) ").toString();
                try
                {
                    trxDtFrom = Sys.parseDate(trxDtFromStr);
                }
                catch(Exception exception) { }
                try
                {
                    trxDtTo = Sys.parseDate(trxDtToStr);
                }
                catch(Exception exception1) { }
                if(trxDtFrom != null)
                {
                    Date sqlDtFrom = new Date(trxDtFrom.getTime());
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(conditions.length() != 0 ? " and " : " where ").append(" cso_trxdate >= '").append(sqlDtFrom).append("'").toString();
                }
                if(trxDtTo != null)
                {
                    Date sqlDtTo = new Date(trxDtTo.getTime());
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(conditions.length() != 0 ? " and " : " where ").append(" cso_trxdate <= '").append(sqlDtTo).append("'").toString();
                }
                cond.setConditions(conditions);
                returnBean.addReturnObject("CollectionReport", getCounterCollectionReport(sellerID, cond));
            }
            returnBean.addReturnObject("TaskID", String.valueOf(taskID));
            returnBean.addReturnObject("TaskTitle", defineTaskTitle(taskID));
            returnBean.addReturnObject("TrnxStatus", getMapForTrnxStatus());
        }
        catch(Exception ex)
        {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }

    protected CounterCollectionReportBean getCounterCollectionReport(String outletID, SQLConditionsBean conditions)
        throws MvcException
    {
        CounterSalesOrderBean orderBean;
        CounterCollectionReportBean rptBean;
        Connection conn;
        rptBean = null;
        conn = null;
        try
        {
            conn = getConnection();
            if(outletID != null && outletID.length() > 0)
            {
                rptBean = getBroker(conn).getCounterCollectionReport(outletID, conditions);
                
                if(rptBean != null)
                {
                    boolean isStockist = (new StockistManager(conn)).isStockist(outletID);
                    String refID = outletID;
                    if(isStockist)
                        refID = (new OutletManager(conn)).getRecord(outletID).getHomeBranchID();
                    String documentList[] = getBroker(conn).getCounterDocumentList(outletID);                    
                    com.ecosmosis.orca.outlet.paymentmode.OutletPaymentModeBean paymentModeList[] = (new OutletManager(conn)).getPaymentModeList(refID);
                    // com.ecosmosis.orca.counter.sales.CounterSalesPaymentBean paymentModeList2[] = (new CounterSalesManager(conn)).getPaymentModeList2();                    
                    rptBean.setOutletID(outletID);
                    rptBean.setDocumentList(documentList);
                    rptBean.setPaymentModeList(paymentModeList);
                    // rptBean.setPaymentModeList2(paymentModeList2);
                }
                
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return rptBean;
    }

    private MvcReturnBean getTrxProductSales(HttpServletRequest request)
        throws MvcException
    {
        MvcReturnBean returnBean = new MvcReturnBean();
        try
        {
            boolean formSubmitted = request.getParameter("SubmitData") != null;
            if(formSubmitted)
            {
                java.util.Date trxDtFrom = null;
                java.util.Date trxDtTo = null;
                String conditions = "";
                SQLConditionsBean cond = new SQLConditionsBean();
                conditions = (new StringBuilder(String.valueOf(conditions))).append(" where cso_seller_typestatus = 'O' ").toString();
                String trxDtFromStr = request.getParameter("TrxDateFrom");
                String trxDtToStr = request.getParameter("TrxDateTo");
                try
                {
                    trxDtFrom = Sys.parseDate(trxDtFromStr);
                }
                catch(Exception exception) { }
                try
                {
                    trxDtTo = Sys.parseDate(trxDtToStr);
                }
                catch(Exception exception1) { }
                if(trxDtFrom != null)
                {
                    Date sqlDtFrom = new Date(trxDtFrom.getTime());
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_trxdate >= '").append(sqlDtFrom).append("'").toString();
                }
                if(trxDtTo != null)
                {
                    Date sqlDtTo = new Date(trxDtTo.getTime());
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" and cso_trxdate <= '").append(sqlDtTo).append("'").toString();
                }
                String productIDList[] = request.getParameterValues("ProductIDList");
                if(productIDList != null && productIDList.length > 0)
                {
                    String inParams = null;
                    if(!productIDList[0].equals("ALL"))
                        inParams = getSQLInParamsAsInteger(productIDList);
                    if(inParams != null && inParams.length() > 0)
                        conditions = (new StringBuilder(String.valueOf(conditions))).append(" and csi_productid in ").append(inParams).toString();
                }
                cond.setConditions(conditions);
                returnBean.addReturnObject("SelProductIDList", productIDList);
                returnBean.addReturnObject("ProductSalesReport", getTrxProductSales(cond, getLoginUser().getLocale().toString()));
            }
            prepareProductList(returnBean);
        }
        catch(Exception ex)
        {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }

    protected ProductSalesReportBean getTrxProductSales(SQLConditionsBean conditions, String locale)
        throws MvcException
    {
        ProductSalesReportBean rptBean;
        Connection conn;
        rptBean = null;
        conn = null;
        try
        {
            conn = getConnection();
            rptBean = getBroker(conn).getTrxProductSales(conditions, locale);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return rptBean;
    }

    private MvcReturnBean getBonusProductSales(HttpServletRequest request)
        throws MvcException
    {
        MvcReturnBean returnBean = new MvcReturnBean();
        try
        {
            boolean formSubmitted = request.getParameter("SubmitData") != null;
            if(formSubmitted)
            {
                String conditions = "";
                SQLConditionsBean cond = new SQLConditionsBean();
                conditions = (new StringBuilder(String.valueOf(conditions))).append(" where pou_status = 30 ").toString();
                String bonusPeriod = request.getParameter("BonusPeriodID");
                if(bonusPeriod != null && bonusPeriod.length() > 0)
                    conditions = (new StringBuilder(String.valueOf(conditions))).append(" where pou_bonusperiodid = '").append(bonusPeriod.trim()).append("' ").toString();
                String productIDList[] = request.getParameterValues("ProductIDList");
                if(productIDList != null && productIDList.length > 0)
                {
                    String inParams = null;
                    if(!productIDList[0].equals("ALL"))
                        inParams = getSQLInParamsAsInteger(productIDList);
                    if(inParams != null && inParams.length() > 0)
                        conditions = (new StringBuilder(String.valueOf(conditions))).append(" and piu_productid in ").append(inParams).toString();
                }
                cond.setConditions(conditions);
                returnBean.addReturnObject("SelProductIDList", productIDList);
                returnBean.addReturnObject("ProductSalesReport", getBonusProductSales(cond, getLoginUser().getLocale().toString()));
            }
            prepareProductList(returnBean);
        }
        catch(Exception ex)
        {
            Log.error(ex);
            returnBean.addError(ex.getMessage());
            returnBean.fail();
        }
        return returnBean;
    }

    protected ProductSalesReportBean getBonusProductSales(SQLConditionsBean conditions, String locale)
        throws MvcException
    {
        ProductSalesReportBean rptBean;
        Connection conn;
        rptBean = null;
        conn = null;
        try
        {
            conn = getConnection();
            rptBean = getBroker(conn).getBonusProductSales(conditions, locale);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return rptBean;
    }

    protected ProductKivReportBean getProductKivList(String shipByOutleID, String locale)
        throws MvcException
    {
        ProductKivReportBean rptBean;
        Connection conn;
        rptBean = null;
        conn = null;
        try
        {
            conn = getConnection();
            rptBean = getBroker(conn).getProductKivList(shipByOutleID, locale);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return rptBean;
    }

    protected ProductKivReportBean getProductKivListLoan(String shipByOutleID, String locale)
        throws MvcException
    {
        ProductKivReportBean rptBean;
        Connection conn;
        rptBean = null;
        conn = null;
        try
        {
            conn = getConnection();
            rptBean = getBroker(conn).getProductKivListLoan(shipByOutleID, locale);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return rptBean;
    }

    
    protected void prepareProductList(MvcReturnBean returnBean)
    {
        Connection conn = null;
        try
        {
            conn = getConnection();
            ProductManager mgr = new ProductManager(conn);
            returnBean.addReturnObject("ProductFullList", mgr.getProductFullList(getLoginUser().getLocale().toString()));
        }
        catch(Exception e)
        {
            Log.error(e);
            returnBean.setException(e);
        }
        releaseConnection(conn);
    }

    public SalesSummaryBean[] getMonthlyMemberProductSalesSummary(String month, String year, int salesType)
        throws MvcException
    {
        SalesSummaryBean beans[];
        Connection conn;
        beans = new SalesSummaryBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            java.util.Date trxDate = getLastDayAtMonth(Integer.parseInt(month), Integer.parseInt(year));
            ArrayList list = getBroker(conn).getMemberProductSalesList(month, year, trxDate, salesType);
            if(!list.isEmpty())
                beans = (SalesSummaryBean[])list.toArray(beans);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return beans;
    }

    public SalesSummaryBean[] getMonthlyNonMemberProductSalesSummary(String month, String year, int salesType)
        throws MvcException
    {
        SalesSummaryBean beans[];
        Connection conn;
        beans = new SalesSummaryBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            java.util.Date trxDate = getLastDayAtMonth(Integer.parseInt(month), Integer.parseInt(year));
            ArrayList list = getBroker(conn).getNonMemberProductSalesList(month, year, trxDate, salesType);
            if(!list.isEmpty())
                beans = (SalesSummaryBean[])list.toArray(beans);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return beans;
    }

    public int getTotalMemberProductSales(String month, String year, int salesType)
        throws MvcException
    {
        int result;
        Connection conn;
        result = 0;
        conn = null;
        try
        {
            conn = getConnection();
            result = getBroker(conn).getTotalMemberProductSales(month, year, salesType);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return result;
    }

    public int getTotalNonMemberProductSales(String month, String year, int salesType)
        throws MvcException
    {
        int result;
        Connection conn;
        result = 0;
        conn = null;
        try
        {
            conn = getConnection();
            result = getBroker(conn).getTotalNonMemberProductSales(month, year, salesType);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return result;
    }

    public static java.util.Date getLastDayAtMonth(int month, int year)
    {
        if(month == 12)
        {
            month = 0;
            year++;
        }
        Calendar cal = Calendar.getInstance();
        cal.clear();
        cal.set(5, 1);
        cal.set(2, month);
        cal.set(1, year);
        cal.add(5, -1);
        return cal.getTime();
    }

    protected String getSQLInParamsAsInteger(String values[])
    {
        StringBuffer sb = new StringBuffer(" (");
        for(int i = 0; i < values.length; i++)
            sb.append(values[i]).append(",");

        sb.deleteCharAt(sb.length() - 1);
        sb.append(") ");
        return sb.toString();
    }

    private FIFOMap getMapForTrnxStatus()
        throws Exception
    {
        FIFOMap map = new FIFOMap();
        map.put("", "ALL");
        map.put(String.valueOf(30), "Active");
        return map;
    }

    public MvcReturnBean performTask(int taskId, HttpServletRequest request, LoginUserBean loginUser)
    {
        setLoginUser(loginUser);
        MvcReturnBean returnBean = null;
        boolean formSubmitted = request.getParameter("SubmitData") != null;
        try
        {
            switch(taskId)
            {
            default:
                break;

            case 101800: 
            case 101801: 
            case 101802: 
            case 101803: 
            case 101805:     
            case 101804: 
            case 205800: 
            case 205801: 
            {
                returnBean = getCounterCollectionReport(request, taskId);
                break;
            }

            case 102802: 
            {
                ProductKivReportBean rptBean = getProductKivList(getLoginUser().getOutletID(), getLoginUser().getLocale().toString());
                if(returnBean == null)
                    returnBean = new MvcReturnBean();
                returnBean.addReturnObject("ProductKivList", rptBean);
                break;
            }

            case 102803: 
            {
                ProductKivReportBean rptBean = getProductKivListLoan(getLoginUser().getOutletID(), getLoginUser().getLocale().toString());
                if(returnBean == null)
                    returnBean = new MvcReturnBean();
                returnBean.addReturnObject("ProductKivListLoan", rptBean);
                break;
            }            
            
            case 106006: 
            {
                returnBean = getTrxProductSales(request);
                break;
            }

            case 106010: 
            {
                returnBean = getBonusProductSales(request);
                break;
            }

            case 105108: 
            case 105110: 
            case 105112: 
            {
                returnBean = new MvcReturnBean();
                String month = request.getParameter("month");
                String year = request.getParameter("year");
                int salesType = 1;
                if(taskId == 0x19a96)
                {
                    returnBean.addReturnObject("ReportTitle", "Export Sales CN");
                    returnBean.addReturnObject("TaskExportID", String.valueOf(0x19a97));
                    salesType = 2;
                } else
                if(taskId == 0x19a98)
                {
                    returnBean.addReturnObject("ReportTitle", "Export Sales KC");
                    returnBean.addReturnObject("TaskExportID", String.valueOf(0x19a99));
                    salesType = 3;
                } else
                {
                    returnBean.addReturnObject("ReportTitle", "Export Sales");
                    returnBean.addReturnObject("TaskExportID", String.valueOf(0x19a95));
                }
                returnBean.addReturnObject("TaskID", String.valueOf(taskId));
                StandardOptionsMap optionMap = new StandardOptionsMap();
                returnBean.addReturnObject("MonthList", StandardOptionsMap.getMonthMap(true, false));
                returnBean.addReturnObject("YearList", StandardOptionsMap.getYearMap(true, false, 2006, 2020));
                if(!formSubmitted)
                    break;
                if(month.length() > 0 && year.length() > 0)
                {
                    SalesSummaryBean salesBeans1[] = getMonthlyMemberProductSalesSummary(month, year, salesType);
                    SalesSummaryBean salesBeans2[] = getMonthlyNonMemberProductSalesSummary(month, year, salesType);
                    returnBean.addReturnObject("SalesList1", salesBeans1);
                    returnBean.addReturnObject("SalesList2", salesBeans2);
                    returnBean.addReturnObject("TotalSalesRecord", Integer.valueOf(getTotalMemberProductSales(month, year, salesType) + getTotalNonMemberProductSales(month, year, salesType)));
                } else
                {
                    returnBean.addError("Please Select Month and Year to proceed");
                    returnBean.fail();
                }
                break;
            }

            case 105109: 
            case 105111: 
            case 105113: 
            {
                returnBean = new MvcReturnBean();
                String month = request.getParameter("month");
                String year = request.getParameter("year");
                int salesType = 1;
                if(taskId == 0x19a97)
                {
                    salesType = 2;
                    returnBean.addReturnObject("ReportTitle", "Export Sales Data CN");
                } else
                if(taskId == 0x19a99)
                {
                    returnBean.addReturnObject("ReportTitle", "Export Sales Data KC");
                    salesType = 3;
                } else
                {
                    returnBean.addReturnObject("ReportTitle", "Export Sales Data");
                }
                if(month.length() > 0 && year.length() > 0)
                {
                    SalesSummaryBean salesBeans1[] = getMonthlyMemberProductSalesSummary(month, year, salesType);
                    SalesSummaryBean salesBeans2[] = getMonthlyNonMemberProductSalesSummary(month, year, salesType);
                    ExportSalesGenerator writer = new ExportSalesGenerator();
                    writer.setMemberSales(salesBeans1);
                    writer.setNonMemberSales(salesBeans2);
                    returnBean.addReturnObject("TotalSalesRecord", Integer.valueOf(getTotalMemberProductSales(month, year, salesType) + getTotalNonMemberProductSales(month, year, salesType)));
                    returnBean.addReturnObject("Filename", writer.generate(salesType));
                } else
                {
                    returnBean.addError("Please Select Month and Year to proceed");
                    returnBean.fail();
                }
                break;
            }
            }
        }
        catch(Exception e)
        {
            if(returnBean == null)
                returnBean = new MvcReturnBean();
            returnBean.setException(e);
        }
        return returnBean;
    }
}
