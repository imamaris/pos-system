// Decompiled by Yody
// File : BvWalletManager.class

package com.ecosmosis.orca.bvwallet;

import com.ecosmosis.common.customlibs.FIFOMap;
import com.ecosmosis.mvc.accesscontrol.user.LoginUserBean;
import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionManager;
import com.ecosmosis.mvc.manager.MvcReturnBean;
import com.ecosmosis.mvc.manager.SQLConditionsBean;
import com.ecosmosis.mvc.sys.Sys;
import com.ecosmosis.orca.bonus.bonusperiod.BonusPeriodBean;
import com.ecosmosis.orca.bonus.bonusperiod.BonusPeriodManager;
import com.ecosmosis.orca.member.MemberManager;
import com.ecosmosis.util.http.RequestParser;
import com.ecosmosis.util.log.Log;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import javax.servlet.http.HttpServletRequest;

// Referenced classes of package com.ecosmosis.orca.bvwallet:
//            BvWalletBean, BvWalletBroker

public class BvWalletManager extends DBTransactionManager {
    
    public static final int STATUS_ACTIVE = 10;
    public static final int STATUS_INACTIVE = -10;
    public static final String SELLERTYPE_STATUS_OUTLET = "O";
    public static final String SELLERTYPE_STATUS_DISTRIBUTOR = "D";
    public static final String SELLERTYPE_STATUS_STOCKIST = "S";
    public static final String OWNERTYPE_DISTRIBUTOR = "D";
    public static final String OWNERTYPE_STOCKIST = "S";
    public static final String OWNERREG_DISTRIBUTOR = "A";
    public static final String OWNERREG_STOCKIST = "B";
    
    public static final String RETURN_STAFFLIST_CODE = "StaffList";
    
    public static final int BEANTYPE_TRANSACTION = 10;
    public static final int BEANTYPE_BALANCE = 20;
    public static final int BVWALLET_TYPE_BV = 1;
    public static final String TRXTYPE_SALES_IN = "ISAL";
    public static final String TRXTYPE_SALES_OUT = "OSAL";
    public static final String TRXTYPE_ADMIN_ADJ_IN = "IADM";
    public static final String TRXTYPE_ADMIN_ADJ_OUT = "OADM";
    public static final String TRXTYPE_TRANSFER_IN = "ITRF";
    public static final String TRXTYPE_TRANSFER_OUT = "OTRF";
    public static final int TASKID_BALANCEREPORT_BY_PERIOD = 0x1925b;
    public static final int TASKID_ADD_NEW_BVWALLET_DISTR_ITEM = 0x1925a;
    public static final int TASKID_VIEW_BVWALLET = 0x19259;
    public static final String TRXTYPES[] = {
        "IADM", "OADM"
    };
    public static final String TRXTYPES_STR[] = {
        "Voucher OUT", "Voucher IN"
    };
    public static final String TRXFROM[] = {
        "IND", "CHI"
    };
    public static final String TRXFROM_STR[] = {
        "Transaction From Indonesia", "Transaction From China"
    };
    private BvWalletBroker broker;
    
    public MvcReturnBean performTask(int taskId, HttpServletRequest request, LoginUserBean loginUser) {
        setLoginUser(loginUser);
        MvcReturnBean returnBean = null;
        try {
            switch(taskId) {
                default:
                    break;
                    
                case 103003:
                {
                    if(returnBean == null)
                        returnBean = new MvcReturnBean();
                                        
                   if(request.getParameter("periodid") != null) {
                     String periodid = request.getParameter("periodid");
                        String orderby = request.getParameter("orderby");
                        if(orderby != null && orderby.length() > 0)
                            orderby = (new StringBuilder("order by ")).append(orderby).toString();
                        
                    String fromdate = request.getParameter("fromdate");
                    String todate = request.getParameter("todate");
                    RequestParser parser = getRequestParser();
                    
                    java.util.Date from = null;
                    java.util.Date to = null;
                    
                    if(fromdate == null || fromdate.length() == 0)
                        from = getInfinityFromDate();
                    else
                        from = parser.parseDate(fromdate);
                    if(todate == null || todate.length() == 0)
                        to = getInfinityToDate();
                    else
                        to = parser.parseDate(todate);
                    
                    
                        //BonusPeriodManager periodmgr = new BonusPeriodManager();
                        //BonusPeriodBean period = periodmgr.getBonusPeriod(periodid);
                        // returnBean.addReturnObject("BonusPeriod", period);
                        // returnBean.addReturnObject("BvWalletList", getBonusPeriodBalanceReport(period.getStartDate(), period.getEndDate(), orderby));
                        returnBean.addReturnObject("BvWalletList", getBonusPeriodBalanceReport(from, to, orderby));
                    }
                    
                    BonusPeriodManager periodmgr = new BonusPeriodManager();
                    BonusPeriodBean pbeans[] = periodmgr.getAllOpenAndPastPeriod(0);
                    returnBean.addReturnObject("BonusPeriodList", periodmgr.getMap(pbeans, false));
                    break;
                }
                
                case 103002:
                {
                    System.out.println("masuk awal .... :");
                    // if(request.getParameter("trxtype") != null && request.getParameter("trxfrom") != null && request.getParameter("BonusDate") != null)
                    if(request.getParameter("trxtype") != null && request.getParameter("BonusDate") != null)
                        returnBean = addNewDistributorItem(request);
                    if(returnBean == null)
                        returnBean = new MvcReturnBean();
                    BonusPeriodManager periodmgr = new BonusPeriodManager();
                    BonusPeriodBean pbeans[] = periodmgr.getCompanyAllOpenPeriod();
                    returnBean.addReturnObject("BonusPeriodList", pbeans);
                    
                    // CRM Card
                    String custSegmentation = request.getParameter("CustomerSegmentation");
                    String custCRM = request.getParameter("CustomerCRM");
                    String custValid = request.getParameter("CustomerValid");
                    String custPin = request.getParameter("CustomerPin");                    
                    String custName = request.getParameter("CustomerName");
                   // String salesman = request.getParameter("Salesman");
                    
                    if(custName == null)
                        custName = "";
                    returnBean.addReturnObject("CustomerName", custName);
                    
                    if(custSegmentation == null)
                        custSegmentation = "";
                    returnBean.addReturnObject("CustomerSegmentation", custSegmentation);
                    
                    if(custCRM == null)
                        custCRM = "";
                    returnBean.addReturnObject("CustomerCRM", custCRM);
                    
                    if(custValid == null)
                        custValid = "";
                    returnBean.addReturnObject("CustomerValid", custValid);
                    
                    if(custPin == null)
                        custPin = "";
                    returnBean.addReturnObject("CustomerPin", custPin);     
                    
                    boolean showAny = false;
                    returnBean.addReturnObject("StaffList", getStaff(showAny, getLoginUser().getOutletID()));                    
                    
                    System.out.println("selesai ... :");
                    break;
                }
                
                case 103001:
                {
                    if(returnBean == null)
                        returnBean = new MvcReturnBean();
                    if(request.getParameter("memberid") == null)
                        break;
                    String memberid = request.getParameter("memberid");
                    String fromdate = request.getParameter("fromdate");
                    String todate = request.getParameter("todate");
                    RequestParser parser = getRequestParser();
                    java.util.Date from = null;
                    java.util.Date to = null;
                    
                    if(fromdate == null || fromdate.length() == 0)
                        from = getInfinityFromDate();
                    else
                        from = parser.parseDate(fromdate);
                    if(todate == null || todate.length() == 0)
                        to = getInfinityToDate();
                    else
                        to = parser.parseDate(todate);
                    
                    returnBean.addReturnObject("BvWalletList", getTrxList(memberid, "D", from, to));
                    break;
                }
            }
        } catch(Exception e) {
            if(returnBean == null)
                returnBean = new MvcReturnBean();
            returnBean.setException(e);
        }
        return returnBean;
    }
    
    public long insertDistributorBvItem(BvWalletBean bean)
    throws MvcException {
        long seqID;
        Connection conn;
        seqID = -1L;
        conn = null;
        try {
            conn = getConnection();
            bean.setOwnerType("D");
            bean.setWalletType(1);
            bean.setTrxDate(Calendar.getInstance().getTime());
            bean.setTrxTime(new Time(Calendar.getInstance().getTimeInMillis()));
            seqID = getBroker(conn).insert(bean);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return seqID;
    }
    
    public BvWalletBean[] getTrxList(String ownerid, String ownertype, java.util.Date from, java.util.Date to)
    throws MvcException {
        BvWalletBean blist[];
        Connection conn;
        blist = new BvWalletBean[0];
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getList(ownerid, ownertype, new Date(from.getTime()), new Date(to.getTime()));
            if(!list.isEmpty())
                blist = (BvWalletBean[])list.toArray(new BvWalletBean[0]);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return blist;
    }
    
    public BvWalletBean[] getDistributorBonusPeriodBalanceReport(String periodid, String orderby)
    throws MvcException {
        BvWalletBean blist[];
        Connection conn;
        blist = new BvWalletBean[0];
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getBalanceReport(10, periodid, "D", orderby);
            if(!list.isEmpty())
                blist = (BvWalletBean[])list.toArray(new BvWalletBean[0]);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return blist;
    }
    
    // java.util.Date from, java.util.Date to

    public BvWalletBean[] getBonusPeriodBalanceReport(java.util.Date from, java.util.Date to, String orderby)
    throws MvcException {
        SQLConditionsBean cond = new SQLConditionsBean();
        StringBuffer buf = new StringBuffer();
        buf.append(" and bvw_status = 10");
        buf.append((new StringBuilder(" and bvw_trxdate between '")).append(new Date(from.getTime())).append("' and '").append(new Date(to.getTime())).append("' ").toString());
        cond.setConditions(buf.toString());
        cond.setGroupby(" group by bvw_ownerid,bvw_ownertype ");
        cond.setOrderby(orderby);
        return getBalanceReport(cond);
    }
    
    public BvWalletBean[] getBonusPeriodBalanceReportAwal(Date from, Date to, String orderby)
    throws MvcException {
        SQLConditionsBean cond = new SQLConditionsBean();
        StringBuffer buf = new StringBuffer();
        buf.append(" and bvw_status = 10");
        buf.append((new StringBuilder(" and bvw_bonusdate between '")).append(from).append("' and '").append(to).append("' ").toString());
        cond.setConditions(buf.toString());
        cond.setGroupby(" group by bvw_ownerid,bvw_ownertype ");
        cond.setOrderby(orderby);
        return getBalanceReport(cond);
    }
    
    
    
    public BvWalletBean[] getDistributorBonusPeriodBalanceReport(Date from, Date to)
    throws MvcException {
        BvWalletBean blist[];
        Connection conn;
        blist = new BvWalletBean[0];
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getBalanceReport(10, from, to, "D");
            if(!list.isEmpty())
                blist = (BvWalletBean[])list.toArray(new BvWalletBean[0]);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return blist;
    }
    
    public BvWalletBean getDistributorBalance(String ownerid, Date from, Date to)
    throws MvcException {
        BvWalletBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            bean = getBroker(conn).getBalanceBetweenDates(10, ownerid, "D", from, to);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return bean;
    }
    
    public BvWalletBean getDistributorBalance(String ownerid)
    throws MvcException {
        BvWalletBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            bean = getBroker(conn).getBalance(10, ownerid, "D");
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return bean;
    }
    
    public BvWalletBean getDistributorBonusdate(String ownerid)
    throws MvcException {
        BvWalletBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            bean = getBroker(conn).getDistributorBonusDate(10, ownerid, "D");
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return bean;
    }
    
    public boolean deactivateTrx(long seqID, String remark)
    throws MvcException {
        boolean res;
        Connection conn;
        res = false;
        conn = null;
        try {
            conn = getConnection();
            res = getBroker(conn).updateStatus(seqID, -10, remark);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return res;
    }
    
    public boolean deactivateTrx(String refno, String reftype, String remark)
    throws MvcException {
        boolean res;
        Connection conn;
        res = false;
        conn = null;
        try {
            conn = getConnection();
            res = getBroker(conn).updateStatus(refno, reftype, -10, remark);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return res;
    }
    
    public boolean deactivateTrx2(String noid, String period, String remark)
    throws MvcException {
        boolean res;
        Connection conn;
        res = false;
        conn = null;
        try {
            conn = getConnection();
            res = getBroker(conn).updateStatus(noid, period, -10, remark);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return res;
    }
    
    public MvcReturnBean addNewDistributorItem(HttpServletRequest request) {
        MvcReturnBean ret;
        boolean status;
        Connection con;
        ret = new MvcReturnBean();
        con = null;
        status = false;
        try {
            BvWalletBean bean = new BvWalletBean();
            String chkMsg = parseBean(bean, request);
            String memberid = request.getParameter("custID");
            boolean isBonusActive = checkBonusPeriodInfo(bean, ret, request);
            bean.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
            System.out.println("masuk sini addNewDistributorItem ...");
            if(chkMsg == null && isBonusActive) {
                con = getConnection();
                long seqid = insertDistributorBvItem(bean);
                status = deletePIN(memberid);
                
                if(seqid > 0L) {
                    ret.done();
                    ret.addMessage("MDL006");
                } else {
                    ret.fail();
                    ret.addError("MDL007");
                }
            } else {
                ret.fail();
                ret.setSysMessage(chkMsg);
            }
        } catch(Exception e) {
            Log.error(e);
            ret.setSysError(e.getMessage());
            // break MISSING_BLOCK_LABEL_167;
        }
        
        releaseConnection(con);
        return ret;
    }
    
    private String parseBean(BvWalletBean bean, HttpServletRequest req)
    throws Exception {
        String res = null;
        StringBuffer buf = new StringBuffer();
        String memberid = req.getParameter("custID");
        if(memberid == null || memberid.length() < 4) {
            buf.append("<br>Invalid Member ID");
        } else {
            MemberManager memmgr = new MemberManager();
            if(!memmgr.isActiveMember(memberid))
                buf.append("<br>Invalid Member ID or Wrong ID");
        }
        String trxtype = req.getParameter("trxtype");
        String trxfrom = req.getParameter("trxfrom");
        String periodid = req.getParameter("periodid");
        String voucher = req.getParameter("voucher");
        String salesman = req.getParameter("Salesman");
 
        if(voucher == null || voucher.length() < 4) {
            buf.append("<br>Invalid Voucher Number");
        } else {
            // chek keberadaan voucher
            // VoucherManager voucherMgr = new VoucherManager();
            // if(!voucherMgr.isActiveMember(voucher))
            //    buf.append("<br>No Voucher Number");
        }
        
        
        bean.setOwnerID(memberid);
        bean.setTrxType(trxtype);
        bean.setFromType(trxfrom);
        bean.setPeriodID(periodid);
        
        bean.setReferenceNo(voucher);
        // bean.setRemark(req.getParameter("remark"));
        bean.setRemark(salesman.concat(" : ").concat(req.getParameter("remark")));
        
        String bv_str = req.getParameter("bv");
        String bv1_str = req.getParameter("bv1");
        String bv2_str = req.getParameter("bv2");
        String bv3_str = req.getParameter("bv3");
        String bv4_str = req.getParameter("bv4");
        
        // Koneksi BV Internasional
        String bvamount_str = req.getParameter("bvamount");
        String bvfullamount_str = req.getParameter("bvfullamount");
        
        double bv = 0.0D;
        double bv1 = 0.0D;
        double bv2 = 0.0D;
        double bv3 = 0.0D;
        double bv4 = 0.0D;
        
        double bvamount = 0.0D;
        double bvfullamount = 0.0D;
        
        if(bv_str != null && bv_str.length() > 0)
            try {
                bv = Double.parseDouble(bv_str);
            } catch(Exception e) {
                buf.append("<br>Invalid BV Value");
            }
        
        if(bv1_str != null && bv1_str.length() > 0)
            try {
                bv1 = Double.parseDouble(bv1_str);
            } catch(Exception e) {
                buf.append("<br>Invalid BV 1 Value");
            }
        
        if(bv2_str != null && bv2_str.length() > 0)
            try {
                bv2 = Double.parseDouble(bv2_str);
            } catch(Exception e) {
                buf.append("<br>Invalid BV 2 Value");
            }
        if(bv3_str != null && bv3_str.length() > 0)
            try {
                bv3 = Double.parseDouble(bv3_str);
            } catch(Exception e) {
                buf.append("<br>Invalid BV 3 Value");
            }
        if(bv4_str != null && bv4_str.length() > 0)
            try {
                bv4 = Double.parseDouble(bv4_str);
            } catch(Exception e) {
                buf.append("<br>Invalid BV 4 Value");
            }
        
        if(bvamount_str != null && bvamount_str.length() > 0)
            try {
                bvamount = Double.parseDouble(bvamount_str);
            } catch(Exception e) {
                buf.append("<br>Invalid BV Amount Value");
            }
        
        if(bvfullamount_str != null && bvfullamount_str.length() > 0)
            try {
                bvfullamount = Double.parseDouble(bvfullamount_str);
            } catch(Exception e) {
                buf.append("<br>Invalid BV Full Amount Value");
            }
        
        if(bean.isTrxIN()) {
            bean.setBvIn(bv);
            bean.setBvIn1(bv1);
            bean.setBvIn2(bv2);
            bean.setBvIn3(bv3);
            bean.setBvIn4(bv4);
            
            bean.setBvAmountIn(bvamount);
            bean.setFullAmountIn(bvfullamount);
            
        } else {
            bean.setBvOut(bv);
            bean.setBvOut1(bv1);
            bean.setBvOut2(bv2);
            bean.setBvOut3(bv3);
            bean.setBvOut4(bv4);
            
        }
        if(bv <= 0.0D && bv1 <= 0.0D && bv2 <= 0.0D && bv3 <= 0.0D && bv4 <= 0.0D && bvamount <= 0.0D && bvfullamount <= 0.0D )
            buf.append("BV Value Not FOUND !!!");
        if(buf.length() > 0)
            res = buf.toString();
        return res;
    }
    
    public BvWalletManager() {
        broker = null;
    }
    
    public BvWalletManager(Connection conn) {
        super(conn);
        broker = null;
    }
    
    private BvWalletBroker getBroker(Connection conn) {
        if(broker == null)
            broker = new BvWalletBroker(conn);
        else
            broker.setConnection(conn);
        return broker;
    }
    
    private boolean checkBonusPeriodInfo(BvWalletBean bean, MvcReturnBean returnBean, HttpServletRequest request) {
        BonusPeriodManager bonusPeriodManager = new BonusPeriodManager();
        boolean isBonusDateActive = false;
        try {
            java.util.Date bonusDate = Sys.parseDate(request.getParameter("BonusDate"));
            isBonusDateActive = bonusPeriodManager.isBonusPeriodActive(new Date(bonusDate.getTime()), 50);
            if(isBonusDateActive) {
                bean.setBonusDate(bonusDate);
                bean.setPeriodID(Sys.getDateFormater().format(bonusDate));
            } else {
                returnBean.addError("Bonus Date is closed !!");
            }
        } catch(Exception e) {
            returnBean.addError("Invalid Bonus Date Format !!");
        }
        return !returnBean.hasErrorMessages();
    }
    
    private FIFOMap getStaff(boolean showAny, String branch)
    throws Exception {
        FIFOMap map;
        Connection conn;
        map = new FIFOMap();
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getStaffList(branch);
            if(showAny)
                map.put("", "Any");
            for(int i = 0; i < list.size(); i++)
                map.put(list.get(i), list.get(i));
            
            System.out.println("Size " + list.size());
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        
        releaseConnection(conn);
        return map;
    }    
    
    public BvWalletBean[] getBalanceReport(SQLConditionsBean cond)
    throws MvcException {
        BvWalletBean blist[];
        Connection conn;
        blist = new BvWalletBean[0];
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getBalanceReport(cond);
            if(!list.isEmpty())
                blist = (BvWalletBean[])list.toArray(new BvWalletBean[0]);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return blist;
    }

    private boolean deletePIN(String customerNo)
    throws MvcException {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection();
            status = getBroker(conn).deletePIN(customerNo);
        } catch(Exception ex) {
            Log.error(ex);
            throw new MvcException(ex);
        }
        releaseConnection(conn);
        return status;
    }
    
}
