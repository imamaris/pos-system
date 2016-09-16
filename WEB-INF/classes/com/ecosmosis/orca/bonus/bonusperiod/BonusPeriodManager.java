// Decompiled by Yody
// File : BonusPeriodManager.class

package com.ecosmosis.orca.bonus.bonusperiod;

import com.ecosmosis.common.customlibs.FIFOMap;
import com.ecosmosis.mvc.accesscontrol.user.LoginUserBean;
import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionManager;
import com.ecosmosis.mvc.manager.MvcReturnBean;
import com.ecosmosis.mvc.manager.SQLConditionsBean;
import com.ecosmosis.mvc.sys.SystemConstant;
import com.ecosmosis.util.http.RequestParser;
import com.ecosmosis.util.http.StandardOptionsMap;
import com.ecosmosis.util.log.Log;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.sql.Date;
// import java.util.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.TreeMap;
import javax.servlet.http.HttpServletRequest;

// Referenced classes of package com.ecosmosis.orca.bonus.bonusperiod:
//            BonusPeriodBean, BonusPeriodBroker

public class BonusPeriodManager extends DBTransactionManager
{

    public static final int TASKID_BONUSPERID_LISTING = 0x19267;
    public static final int TASKID_ADD_NEW_BONUSPERID = 0x19266;
    public static final int TASKID_ADD_NEW_BONUSPERID_2 = 0x1928a;
    public static final int TASKID_UPDATE_NEW_BONUSPERID = 0x1928c;
    
    public static final int TASKID_UPDATE_BONUSPERID = 0x19276;
    public static final int TASKID_UPDATE_BONUSPERID_SUBMIT = 0x1927a;
    
    public static final int TASKID_UPDATE_BONUS_WEEKLY = 0x19277;
    public static final int TASKID_UPDATE_BONUS_WEEKLY_SUBMIT = 0x1928a;
    
    public static final int BONUSPERIOD_TYPE_ALL = 0;
    public static final int BONUSPERIOD_TYPE_DAILY = 6;
    
    public static final int BONUSPERIOD_TYPE_WEEKLY = 1;
    public static final int BONUSPERIOD_TYPE_MONTHLY = 2;
    public static final int BONUSPERIOD_TYPE_HALFYEARLY = 3;
    public static final int BONUSPERIOD_TYPE_ANNUALLY = 4;
    public static final int BONUSPERIOD_TYPE_SPECIAL = 5;
    public static final String STATUSLIST[] = {
        "10", "20", "30", "40", "50", "60", "70", "90", "100", "110", 
        "200", "-10"
    };
    public static final String STATUSLIST_STR[] = {
        "PENDING", "OPEN", "CURRENT", "CLOSED STOCKIST", "CLOSED ALL", "TOP UP", "CALCULATED", "CONFIRMED", "TAXED", "RELEASED", 
        "PAID", "CANCEL"
    };
    private BonusPeriodBroker broker;

    public static String definePeriodType(int t)
    {
        String type = "N/A";
        switch(t)
        {
        case 1: // '\001'
            type = "WEEKLY";
            break;

        case 2: // '\002'
            type = "MONTHLY";
            break;

        case 3: // '\003'
            type = "HALFYEARLY";
            break;

        case 4: // '\004'
            type = "ANNUALLY";
            break;

        case 5: // '\005'
            type = "SPECIAL";
            break;
            
        case 6: // '\005'
            type = "DAILY";
            break;            
            
        }
        
        return type;
    }

    public BonusPeriodManager(Connection con)
    {
        super(con);
        broker = null;
    }

    public BonusPeriodManager()
    {
        broker = null;
    }

    public MvcReturnBean performTask(int taskId, HttpServletRequest request, LoginUserBean loginUser)
    {
        setLoginUser(loginUser);
        MvcReturnBean returnBean = null;
        try
        {
            switch(taskId)
            {
            default:
                break;

            case 103015: 
            {
                if(returnBean == null)
                    returnBean = new MvcReturnBean();
                if(request.getParameter("periodtype") != null)
                {
                    int type = Integer.parseInt(request.getParameter("periodtype"));
                    String recordstatus = request.getParameter("recordstatus");
                    BonusPeriodBean pbeans[] = getAllBonusPeriod(type, recordstatus);
                    returnBean.addReturnObject("BonusPeriodList", pbeans);
                }
                returnBean.addReturnObject("PeriodTypeList", getMapForBonusPeriodType(true));
                returnBean.addReturnObject("StatusList", StandardOptionsMap.getActiveOrInativeMap(false, true));
                break;
            }

            case 103014: 
            {
                if(request.getParameter("periodid") != null)
                    returnBean = addNew(request);
                if(returnBean == null)
                    returnBean = new MvcReturnBean();
                returnBean.addReturnObject("PeriodTypeList", getMapForBonusPeriodType(false));
                returnBean.addReturnObject("MonthMaps", StandardOptionsMap.getMonthMap(false, false));
                returnBean.addReturnObject("YearMaps", StandardOptionsMap.getYearMap(false, false, 2006, 2020));
                break;
            }
            
            case 103050: 
            {
                if(request.getParameter("periodid") != null)
                {
                    String tanggal = request.getParameter("Check");
                    System.out.println("Nilai Chek 0 : " + tanggal);    
                    returnBean = addNew2(request, tanggal);
                }
                
                if(returnBean == null)
                    returnBean = new MvcReturnBean();
        
                returnBean.addReturnObject("PeriodTypeList", getMapForBonusPeriodType2(false));
                break;
            }            

            case 103052: 
            {
                BonusPeriodBean bean = null;
                
                String periodid = request.getParameter("periodid");
                // String periodid = request.getParameter("periodid");
                
                if(request.getParameter("periodid") != null)
                {  
                    bean = getBonusPeriod(periodid);
                    returnBean = update2(periodid, request);
                    // bean = getBonusPeriod(periodid);
                }
                
                if(returnBean == null)
                    returnBean = new MvcReturnBean();
        
                returnBean.addReturnObject("PeriodTypeList", getMapForBonusPeriodType2(false));
                break;
            }

            case 103030: 
            {
                BonusPeriodBean bean = null;
                if(request.getParameter("periodid") != null)
                    bean = getBonusPeriod(request.getParameter("periodid"));
                if(bean == null)
                    bean = new BonusPeriodBean();
                if(returnBean == null)
                    returnBean = new MvcReturnBean();
                
                returnBean.addReturnObject("BonusPeriodBean", bean);
                returnBean.addReturnObject("StatusList", StandardOptionsMap.getActiveOrInativeMap2(false, false));
                returnBean.addReturnObject("PeriodTypeList", getMapForBonusPeriodType(true));
                returnBean.addReturnObject("BonusStatusList", getMapForBonusPeriodStatus());
                returnBean.addReturnObject("MonthMaps", StandardOptionsMap.getMonthMap(false, false));
                returnBean.addReturnObject("YearMaps", StandardOptionsMap.getYearMap(false, false, 2006, 2020));
                break;
            }

            case 103034: 
            // Masuk Task Update BonusPeriod
            {
                // nilai null u/ BonusPeriodBean bean
                BonusPeriodBean bean = null;
                
                // ambil string periodid dari JSP
                String periodid = request.getParameter("periodid");
                
                // jika periodid tdk sama dng null
                if(periodid != null)
                {
                    // jalankan procedure update dng parameter periodid
                    returnBean = update(periodid, request);
                    
                    // isi nilai bean dgn procedure getBonusPeriod dng parameter periodid
                    bean = getBonusPeriod(periodid);
                }
                
                // jika periodid sama dng null : sepertinya tidak terjadi krn di JSP nya periodid dibuat Locked
                if(bean == null)
                    bean = new BonusPeriodBean();
                if(returnBean == null)
                    returnBean = new MvcReturnBean();
                returnBean.addReturnObject("BonusPeriodBean", bean);
                returnBean.addReturnObject("StatusList", StandardOptionsMap.getActiveOrInativeMap(false, false));
                returnBean.addReturnObject("PeriodTypeList", getMapForBonusPeriodType(true));
                returnBean.addReturnObject("BonusStatusList", getMapForBonusPeriodStatus());
                returnBean.addReturnObject("MonthMaps", StandardOptionsMap.getMonthMap(false, false));
                returnBean.addReturnObject("YearMaps", StandardOptionsMap.getYearMap(false, false, 2006, 2020));
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

    
    public MvcReturnBean addNew(HttpServletRequest request)
    {
        // berikan nilai u objek MvcReturnBean & Connection
        MvcReturnBean ret;
        Connection con;
        ret = new MvcReturnBean();
        con = null;
        
        try
        {
            // berikan nilai bean dgn BonusPeriodBean()
            BonusPeriodBean bean = new BonusPeriodBean();
            
            // buat nilai String chkMsg dari objek bean dengan proc parseBean  (u/ cek input )
            String chkMsg = parseBean(bean, request);
        
            String tanggal = request.getParameter("Check");
            System.out.println("Nilai Chek : " + tanggal);    
            
            if(chkMsg == null)
            {
                con = getConnection();
                bean.setPeriodstatus(10);
                // boolean succ = getBroker(con).insert(bean);
                boolean succ = getBroker(con).insert(bean, tanggal);
                if(succ)
                {
                    ret.done();
                    ret.addMessage("MDL006");
                } else
                {
                    ret.addError("MSG_INSERT_FAIL");
                }
            } else
            {
                ret.fail();
                ret.setSysMessage(chkMsg);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            ret.setSysError(e.getMessage());
            // break MISSING_BLOCK_LABEL_137;
        }
        finally
        {
        releaseConnection(con);
        releaseConnection(con);
        return ret;
        }
    }

    public MvcReturnBean addNew2(HttpServletRequest request, String tanggal)
    {
        // berikan nilai u objek MvcReturnBean & Connection
        MvcReturnBean ret;
        Connection con;
        ret = new MvcReturnBean();
        con = null;
        
        //String tanggal = request.getParameter("Check");
        System.out.println("Nilai Chek 1 : " + tanggal);    
        
        try
        {
            // berikan nilai bean dgn BonusPeriodBean()
            BonusPeriodBean bean = new BonusPeriodBean();
            
            // buat nilai String chkMsg dari objek bean dengan proc parseBean  (u/ cek input )
            String chkMsg = parseBean2(bean, request);
            
            if(chkMsg == null)
            {
                con = getConnection();
                bean.setPeriodstatus(20);
                boolean succ = getBroker(con).insert(bean, tanggal);
                if(succ)
                {
                    ret.done();
                    ret.addMessage("MDL006");
                } else
                {
                    //ret.addError("MSG_INSERT_FAIL");
                    ret.addError(" Initial Date is Already Inputed ");
                }
            } else
            {
                ret.fail();
                ret.setSysMessage(chkMsg);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            ret.setSysError(e.getMessage());
            // break MISSING_BLOCK_LABEL_137;
        }
        finally
        {
        releaseConnection(con);
        return ret;
        }
    }
    
/*
    public MvcReturnBean addNew3(HttpServletRequest request)
    {
        // berikan nilai u objek MvcReturnBean & Connection
        MvcReturnBean ret;
        Connection con;
        ret = new MvcReturnBean();
        con = null;
        
        try
        {
            // berikan nilai bean dgn BonusPeriodBean()
            BonusPeriodBean bean = new BonusPeriodBean();
            
            // buat nilai String chkMsg dari objek bean dengan proc parseBean  (u/ cek input )
            String chkMsg = parseBean2(bean, request);
            
            if(chkMsg == null)
            {
                con = getConnection();
                bean.setPeriodstatus(50);
                boolean succ = getBroker(con).insert(bean);
                if(succ)
                {
                    ret.done();
                    ret.addMessage("MDL006");
                } else
                {
                    ret.addError("MSG_INSERT_FAIL");
                }
            } else
            {
                ret.fail();
                ret.setSysMessage(chkMsg);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            ret.setSysError(e.getMessage());
            // break MISSING_BLOCK_LABEL_137;
        }
        finally
        {
        releaseConnection(con);
        return ret;
        }
    }
*/     
    
    public MvcReturnBean update(String periodid, HttpServletRequest request)
    {
        // berikan nilai awal u/ objek MvcReturnBean & Connection
        MvcReturnBean ret;
        Connection con;
        ret = new MvcReturnBean();
        con = null;
        try
        {
            // berikan nilai bean dgn proc getBonusPeriod, parameter periodid            
            BonusPeriodBean bean = getBonusPeriod(periodid);

            // buat nilai String chkMsg dari objek bean dengan proc parseBean  (u/ cek input )
            String chkMsg = parseBean(bean, request);
            
            // jika tidak ada pesan error
            if(chkMsg == null)
            {
                // berikan nilai con dari proc getConnection()
                con = getConnection();
                
                // berikan nilai boolean u/succ jika proc getBroker(con).updateBonusPeriodStatus(bean) nilainya 1
                boolean succ = getBroker(con).updateBonusPeriodStatus(bean) == 1;
                
                if(succ)
                {
                    ret.done();
                    ret.addMessage("MDL008");
                } else
                {
                    // ret.addError("MSG_UPDATE_FAIL");
                    ret.addError(" You cannot input any transaction anymore ");
                }
            } else
            {
                ret.fail();
                ret.setSysMessage(chkMsg);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            ret.setSysError(e.getMessage());
          //  break MISSING_BLOCK_LABEL_143;
        }
        finally
        {
        releaseConnection(con);
        // throw exception;
        releaseConnection(con);
        return ret;
        }
    }

    public MvcReturnBean update2(String periodid, HttpServletRequest request)
    {
        // berikan nilai awal u/ objek MvcReturnBean & Connection
        MvcReturnBean ret;
        Connection con;
        ret = new MvcReturnBean();
        con = null;
        try
        {
            // berikan nilai bean dgn proc getBonusPeriod, parameter periodid            
            BonusPeriodBean bean = getBonusPeriod(periodid);

            // buat nilai String chkMsg dari objek bean dengan proc parseBean  (u/ cek input )
            String chkMsg = parseBean2(bean, request);
            
            // jika tidak ada pesan error
            if(chkMsg == null)
            {
                // berikan nilai con dari proc getConnection()
                
                con = getConnection();
                bean.setPeriodstatus(50);
                
                // berikan nilai boolean u/succ jika proc getBroker(con).updateBonusPeriodStatus(bean) nilainya 1
                boolean succ = getBroker(con).updateBonusPeriodStatus2(bean) == 1;
                
                if(succ)
                {
                    ret.done();
                    ret.addMessage("MDL008");
                } else
                {
                    ret.addError("Record Updated Successfully !");
                }
            } else
            {
                ret.fail();
                ret.setSysMessage(chkMsg);
            }
        }
        catch(Exception e)
        {
            Log.error(e);
            ret.setSysError(e.getMessage());
          //  break MISSING_BLOCK_LABEL_143;
        }
        
        finally
        {
        releaseConnection(con);
        return ret;
        }
    }
   
    
    private String parseBean(BonusPeriodBean bean, HttpServletRequest req)
        throws Exception
    {
        String res = null;
        StringBuffer buf = new StringBuffer();
        String periodid = req.getParameter("periodid");
        if(periodid == null || periodid.length() < 2)
            buf.append("<br>Invalid ID");
        bean.setPeriodID(periodid);
        String startdate_str = req.getParameter("startdate");
        if(startdate_str == null || startdate_str.length() < 1)
            buf.append("<br>Invalid Start Date");
        
        String enddate_str = req.getParameter("enddate");
        if(enddate_str == null || enddate_str.length() < 1)
            buf.append("<br>Invalid End Date");
        if(buf.length() <= 0)
            try
            {
                RequestParser parser = getRequestParser();
                java.util.Date sdate = parser.parseDate(startdate_str);
                java.util.Date edate = parser.parseDate(enddate_str);
                
                
                bean.setStartDate(new Date(sdate.getTime()));
                bean.setEndDate(new Date(edate.getTime()));
                String bmonth = req.getParameter("bonusmonth");
                String byear = req.getParameter("bonusyear");
                if(bmonth != null && bmonth.length() > 0)
                {
                    int bonusmonth = parser.parseIntegerValue(bmonth);
                    int bonusyear = parser.parseIntegerValue(byear);
                    bean.setBonusMonth(bonusmonth);
                    bean.setBonusYear(bonusyear);
                } else
                {
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(sdate);
                    bean.setBonusMonth(cal.get(2));
                    bean.setBonusYear(cal.get(1));
                }
            }
            catch(Exception e)
            {
                buf.append("<br>Invalid Date Format. Format is YYYY-MM-DD.");
            }
        String status = req.getParameter("status");
        if(status != null && status.length() > 0)
            try
            {
                int stat = Integer.parseInt(status);
                bean.setPeriodstatus(stat);
            }
            catch(Exception e)
            {
                buf.append("<br>Invalid Status");
            }
        String type = req.getParameter("periodtype");
        if(type != null && type.length() > 0)
            try
            {
                int ptype = Integer.parseInt(type);
                bean.setType(ptype);
            }
            catch(Exception e)
            {
                buf.append("<br>Invalid Type");
            }
        String recordstatus = req.getParameter("recordstatus");
        if(recordstatus != null)
            bean.setStatus(recordstatus);
        if(buf.length() > 0)
            res = buf.toString();
        return res;
    }

    private String parseBean2(BonusPeriodBean bean, HttpServletRequest req)
        throws Exception
    {
        String res = null;
        StringBuffer buf = new StringBuffer();
        String periodid = req.getParameter("periodid");
        if(periodid == null || periodid.length() < 2)
            buf.append("<br>Invalid ID");
        bean.setPeriodID(periodid);
        
        String startdate_str = req.getParameter("periodid");  
        String enddate_str = req.getParameter("periodid");
            
        
        if(buf.length() <= 0)
            try
            {
                RequestParser parser = getRequestParser();
                java.util.Date sdate = parser.parseDate(startdate_str);
                java.util.Date edate = parser.parseDate(enddate_str);
                
                
                bean.setStartDate(new Date(sdate.getTime()));
                bean.setEndDate(new Date(edate.getTime()));                
        
        String bmonth = periodid.substring(5, 7).toString();
        String byear = periodid.substring(0, 4).toString();                   
                
                // String bmonth = req.getParameter("bonusmonth");
                // String byear = req.getParameter("bonusyear");
                if(bmonth != null && bmonth.length() > 0)
                {
                    int bonusmonth = parser.parseIntegerValue(bmonth);
                    int bonusyear = parser.parseIntegerValue(byear);
                    bean.setBonusMonth(bonusmonth);
                    bean.setBonusYear(bonusyear);
                } else
                {
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(sdate);
                    bean.setBonusMonth(cal.get(2));
                    bean.setBonusYear(cal.get(1));
                }
            }
            catch(Exception e)
            {
                buf.append("<br>Invalid Date Format. Format is YYYY-MM-DD.");
            }
        
        String status = req.getParameter("status");
        if(status != null && status.length() > 0)
            try
            {
                int stat = Integer.parseInt(status);
                bean.setPeriodstatus(stat);
            }
            catch(Exception e)
            {
                buf.append("<br>Invalid Status");
            }
        String type = "6";
        if(type != null && type.length() > 0)
            try
            {
                int ptype = Integer.parseInt(type);
                bean.setType(ptype);
            }
            catch(Exception e)
            {
                buf.append("<br>Invalid Type");
            }
        String recordstatus = req.getParameter("recordstatus");
        if(recordstatus != null)
            bean.setStatus(recordstatus);
        if(buf.length() > 0)
            res = buf.toString();
        return res;
    }

   
    
    public BonusPeriodBean[] getCompanyAllOpenPeriod()
        throws MvcException
    {
        return getBonusPeriodList(20, 40, "A", 0);
    }

    public BonusPeriodBean[] getStockistAllOpenPeriod()
        throws MvcException
    {
        return getBonusPeriodList(20, 30, "A", 0);
    }

    public BonusPeriodBean[] getAllBonusPeriod(int type, String recordstatus)
        throws MvcException
    {
        return getBonusPeriodList(10, 200, recordstatus, type);
    }

    public BonusPeriodBean[] getAllOpenAndPastPeriod()
        throws MvcException
    {
        return getAllOpenAndPastPeriod(2);
    }

    public BonusPeriodBean[] getBonusPeriodsByStatus(int periodstatus, int type)
        throws MvcException
    {
        return getBonusPeriodList(periodstatus, periodstatus, "A", type);
    }

    public BonusPeriodBean[] getBonusPeriodsByStatus(int fromstatus, int tostatus, int type)
        throws MvcException
    {
        return getBonusPeriodList(fromstatus, tostatus, "A", type);
    }

    public BonusPeriodBean[] getAllOpenAndPastPeriod(int type)
        throws MvcException
    {
        return getBonusPeriodList(20, 200, "A", type);
    }

    public BonusPeriodBean[] getAllOpenedPeriods(int type)
        throws MvcException
    {
        return getBonusPeriodList(20, 20, "A", type);
    }

    public BonusPeriodBean[] getAllOpenToRunPeriods(int type)
        throws MvcException
    {
        return getBonusPeriodList(20, 70, "A", type);
    }

    public BonusPeriodBean[] getAllConfirmedPeriod(int type)
        throws MvcException
    {
        return getBonusPeriodList(90, 200, "A", type);
    }

    public BonusPeriodBean[] getAllConfirmedPeriod()
        throws MvcException
    {
        return getBonusPeriodList(90, 200, "A", 1);
    }

    public BonusPeriodBean[] getAllRunablePeriods(int type)
        throws MvcException
    {
        return getBonusPeriodList(20, 90, "A", type);
    }

    public BonusPeriodBean[] getBonusPeriodListForBonus()
        throws MvcException
    {
        return getBonusPeriodList(">=", 70);
    }

    public BonusPeriodBean[] getWeeklyBonusPeriodListForBonus()
        throws MvcException
    {
        return getWeeklyBonusPeriodList(">=", 70);
    }

    public BonusPeriodBean[] getTopUpPeriodListForBonus()
        throws MvcException
    {
        return getBonusPeriodList(">=", 60);
    }

    public boolean isBonusPeriodActive(Date date, int periodStatus)
        throws MvcException
    {
        boolean status = false;
        BonusPeriodBean beans[] = getBonusPeriodsbyDate(date, periodStatus);
        if(beans != null && beans.length > 0)
            status = true;
        return status;
    }

    public BonusPeriodBean[] getBonusPeriodList(int status1, int status2, String recordstatus, int type)
        throws MvcException
    {
        SQLConditionsBean cond = new SQLConditionsBean();
        StringBuffer buf = new StringBuffer();
        buf.append((new StringBuilder(" and bpm_periodstatus >= ")).append(status1).append(" and bpm_periodstatus <= ").append(status2).toString());
        if(recordstatus != null && recordstatus.length() > 0)
            buf.append((new StringBuilder(" and bpm_status = '")).append(recordstatus).append("' ").toString());
        if(type > 0)
            buf.append((new StringBuilder(" and bpm_type = ")).append(type).toString());
        cond.setConditions(buf.toString());
        cond.setOrderby(" order by bpm_type, bpm_startdate desc ");
        return getList(cond);
    }

    public BonusPeriodBean[] getActiveBonusPeriodList(String fromPeriodID, String toPeriodID, int bonusStatus)
        throws MvcException
    {
        SQLConditionsBean cond = new SQLConditionsBean();
        StringBuffer buf = new StringBuffer();
        BonusPeriodBean startbean = getBonusPeriod(fromPeriodID);
        BonusPeriodBean endbean = getBonusPeriod(toPeriodID);
        buf.append((new StringBuilder(" and bpm_startdate >= ")).append(startbean.getStartDate()).toString());
        buf.append((new StringBuilder(" and bpm_enddate <= ")).append(endbean.getEndDate()).toString());
        buf.append((new StringBuilder(" and bpm_periodstatus >= ")).append(bonusStatus).toString());
        buf.append(" and bpm_status = 'A' ");
        cond.setConditions(buf.toString());
        cond.setOrderby(" order by bpm_periodid asc ");
        System.out.println("Condisi dari period Manager " + cond + "..."); 
        
        return getList(cond);
    }

    public BonusPeriodBean[] getActiveWeeklyBonusPeriodList(int bonusmonth, int bonusyear)
        throws MvcException
    {
        SQLConditionsBean cond = new SQLConditionsBean();
        StringBuffer buf = new StringBuffer();
        buf.append((new StringBuilder(" and bpm_bonusmonth = ")).append(bonusmonth).toString());
        buf.append((new StringBuilder(" and bpm_bonusyear = ")).append(bonusyear).toString());
        buf.append(" and bpm_status = 'A' ");
        cond.setConditions(buf.toString());
        cond.setOrderby(" order by bpm_startdate asc ");
        return getList(cond);
    }

    private BonusPeriodBean[] getBonusPeriodsbyDate(Date checkdate, int periodStatus)
        throws MvcException
    {
        SQLConditionsBean cond = new SQLConditionsBean();
        StringBuffer buf = new StringBuffer();
        buf.append((new StringBuilder(" and bpm_startdate <= '")).append(checkdate).append("' ").toString());
        buf.append((new StringBuilder(" and bpm_enddate >= '")).append(checkdate).append("' ").toString());
        buf.append((new StringBuilder(" and bpm_periodstatus < '")).append(periodStatus).append("' ").toString());
        buf.append(" and bpm_status = 'A' ");
        cond.setConditions(buf.toString());
        cond.setOrderby(" order by bpm_startdate asc ");
        return getList(cond);
    }

    public BonusPeriodBean[] getList(SQLConditionsBean cond)
        throws MvcException
    {
        BonusPeriodBean plist[];
        Connection conn;
        plist = new BonusPeriodBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getList(cond);
            if(!list.isEmpty())
                plist = (BonusPeriodBean[])list.toArray(new BonusPeriodBean[0]);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        releaseConnection(conn);
        // throw exception;
        releaseConnection(conn);
        return plist;
        }
    }

    public BonusPeriodBean[] getBonusPeriodList(String compare, int status)
        throws MvcException
    {
        BonusPeriodBean plist[];
        Connection conn;
        plist = new BonusPeriodBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getBonusPeriodListForBonus(compare, status);
            if(!list.isEmpty())
                plist = (BonusPeriodBean[])list.toArray(new BonusPeriodBean[0]);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        releaseConnection(conn);
        // throw exception;
        releaseConnection(conn);
        return plist;
        }
    }

    public BonusPeriodBean[] getWeeklyBonusPeriodList(String compare, int status)
        throws MvcException
    {
        BonusPeriodBean plist[];
        Connection conn;
        plist = new BonusPeriodBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getWeeklyBonusPeriodListForBonus(compare, status);
            if(!list.isEmpty())
                plist = (BonusPeriodBean[])list.toArray(new BonusPeriodBean[0]);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        releaseConnection(conn);
        // throw exception;
        releaseConnection(conn);
        return plist;
        }
    }

    public BonusPeriodBean getBonusPeriod(String periodid)
        throws MvcException
    {
        BonusPeriodBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try
        {
            conn = getConnection();
            bean = getBroker(conn).getBonusPeriod(periodid);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        releaseConnection(conn);
        // throw exception;
        releaseConnection(conn);
        return bean;
        }
    }

    public BonusPeriodBean getBonusPeriod(int seqid)
        throws MvcException
    {
        BonusPeriodBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try
        {
            conn = getConnection();
            bean = getBroker(conn).getBonusPeriod(seqid);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        releaseConnection(conn);
        // throw exception;
        releaseConnection(conn);
        return bean;
        }
    }

    public int updateBonusPeriodInfo(BonusPeriodBean bonusperiod)
        throws MvcException
    {
        int count;
        Connection conn;
        count = 0;
        conn = null;
        try
        {
            conn = getConnection();
            count = getBroker(conn).updateBonusPeriodInfo(bonusperiod);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        releaseConnection(conn);
        //  exception;
        releaseConnection(conn);
        return count;
        }
    }

    public int cleanUpBonusPeriodInfo(String id)
        throws MvcException
    {
        BonusPeriodBean bonusperiod = getBonusPeriod(id);
        bonusperiod.setTotalMembers(0);
        bonusperiod.setTotalActiveMembers(0);
        bonusperiod.setTotalSales(0.0D);
        bonusperiod.setTotalBvSales(0.0D);
        bonusperiod.setTotalBv(0.0D);
        bonusperiod.setTotalBv1(0.0D);
        bonusperiod.setTotalBv2(0.0D);
        bonusperiod.setTotalBv3(0.0D);
        bonusperiod.setTotalBv4(0.0D);
        bonusperiod.setTotalBonus(0.0D);
        bonusperiod.setTotalCarryForwardBonus1(0.0D);
        bonusperiod.setTotalCarryForwardBonus2(0.0D);
        bonusperiod.setTotalMonthlyBonus(0.0D);
        bonusperiod.setTotalPeriodicalBonus(0.0D);
        bonusperiod.setTotalAdminFees(0.0D);
        bonusperiod.setTotalOthersFee(0.0D);
        bonusperiod.setTotalAdjustment(0.0D);
        bonusperiod.setTotalTax(0.0D);
        bonusperiod.setTotalStockistBonus(0.0D);
        int res = updateBonusPeriodInfo(bonusperiod);
        return res;
    }

    public int updateBonusPeriodStatus(BonusPeriodBean bonusperiod)
        throws MvcException
    {
        int count;
        Connection conn;
        count = 0;
        conn = null;
        try
        {
            conn = getConnection();
            count = getBroker(conn).updateBonusPeriodStatus(bonusperiod);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        releaseConnection(conn);
        // throw exception;
        releaseConnection(conn);
        return count;
        }
    }

    public static String defineStatus(int status)
    {
        String msg = "Unknown";
        switch(status)
        {
        case 10: // '\n'
            msg = "NEW";
            break;

        case 20: // '\024'
            msg = "OPENED";
            break;

        case 30: // '\036'
            msg = "CURRENT";
            break;

        case 40: // '('
            msg = "CLOSED STOCKIST";
            break;

        case 50: // '2'
            msg = "CLOSED";
            break;

        case 60: // '<'
            msg = "TOP UP";
            break;

        case 70: // 'F'
            msg = "CALCULATED";
            break;

        case 90: // 'Z'
            msg = "CONFIRMED";
            break;

        case 100: // 'd'
            msg = "TAXED";
            break;

        case 200: 
            msg = "PAID";
            break;

        case -10: 
            msg = "CANCEL";
            break;

        case 110: // 'n'
            msg = "RELEASED";
            break;
        }
        return msg;
    }

    public TreeMap getMap(BonusPeriodBean beans[], boolean showDefault)
        throws Exception
    {
        FIFOMap maps = new FIFOMap();
        if(showDefault)
            maps.put("", "----");
        for(int i = 0; i < beans.length; i++)
            maps.put(beans[i].getPeriodID(), (new StringBuilder(String.valueOf(beans[i].getPeriodID()))).toString());

        return maps;
    }

    public TreeMap getMapForBonusPeriodTypeAsal(boolean showAll)
    {
        FIFOMap maps = new FIFOMap();
        if(showAll)
            maps.put("0", getLangDisplay("GENERAL_ALL"));
        if(SystemConstant.BONUSPERIOD_TYPE_DAILY)            
            maps.put("6", "Daily");        
        if(SystemConstant.BONUSPERIOD_TYPE_WEEKLY)
            maps.put("1", "Weekly");
        if(SystemConstant.BONUSPERIOD_TYPE_MONTHLY)
            maps.put("2", "Monthly");
        return maps;
    }

    public TreeMap getMapForBonusPeriodType(boolean showAll)
    {
        FIFOMap maps = new FIFOMap();
        if(SystemConstant.BONUSPERIOD_TYPE_DAILY)            
            maps.put("6", "Daily");        
        return maps;
    }
    
    
        public TreeMap getMapForBonusPeriodType2(boolean showAll)
    {
        FIFOMap maps = new FIFOMap();
        if(SystemConstant.BONUSPERIOD_TYPE_DAILY)            
            maps.put("6", "Daily");        
        return maps;
    }
    

    public TreeMap getMapForBonusPeriodStatus()
    {
        FIFOMap maps = new FIFOMap();
        maps.put(Integer.toString(10), getLangDisplay("BONUS_PERIOD_NEW"));
        maps.put(Integer.toString(20), getLangDisplay("BONUS_PERIOD_OPEN"));
        maps.put(Integer.toString(50), getLangDisplay("BONUS_PERIOD_CLOSE"));
        return maps;
    }
    
    public TreeMap getMapForBonusPeriodStatusAsal()
    {
        FIFOMap maps = new FIFOMap();
        maps.put(Integer.toString(10), getLangDisplay("BONUS_PERIOD_NEW"));
        maps.put(Integer.toString(20), getLangDisplay("BONUS_PERIOD_OPEN"));
        maps.put(Integer.toString(50), getLangDisplay("BONUS_PERIOD_CLOSE"));
        maps.put(Integer.toString(90), getLangDisplay("BONUS_PERIOD_PUBLISH"));
        maps.put(Integer.toString(200), getLangDisplay("BONUS_PERIOD_PAID"));
        return maps;
    }    

    public TreeMap getMapForWeeklyPeriod(BonusPeriodBean beans[], boolean showDefault)
        throws Exception
    {
        FIFOMap maps = new FIFOMap();
        if(showDefault)
            maps.put("", "----");
        for(int i = 0; i < beans.length; i++)
            maps.put(beans[i].getPeriodID(), (new StringBuilder(String.valueOf(beans[i].getPeriodID()))).append(" (").append(beans[i].getStartDate()).append(" - ").append(beans[i].getEndDate()).append(")").toString());

        return maps;
    }

    private BonusPeriodBroker getBroker(Connection conn)
    {
        if(broker == null)
            broker = new BonusPeriodBroker(conn);
        else
            broker.setConnection(conn);
        return broker;
    }

    public static void main(String args[])
        throws Exception
    {
        BonusPeriodManager mgr = new BonusPeriodManager();
        BonusPeriodBean list[] = mgr.getCompanyAllOpenPeriod();
        System.exit(0);
    }

    public boolean checkNewBonusPeriodValidity(BonusPeriodBean bean)
    {
        boolean res;
        Connection conn;
        res = false;
        conn = null;
        try
        {
            conn = getConnection();
            SQLConditionsBean cond = new SQLConditionsBean();
            Date sdate = new Date(bean.getStartDate().getTime());
            Date edate = new Date(bean.getEndDate().getTime());
            StringBuffer buf = new StringBuffer();
            buf.append((new StringBuilder(" and ((bpm_startdate <= '")).append(sdate).append("' and bpm_enddate >= '").append(sdate).append("')").toString());
            buf.append((new StringBuilder(" or (bpm_startdate <= '")).append(edate).append("' and bpm_enddate >= '").append(edate).append("'))").toString());
            cond.setConditions(buf.toString());
            ArrayList list = getBroker(conn).getList(cond);
            if(list == null || list.size() == 0)
                res = true;
        }
        catch(Exception e)
        {
            Log.error(e);
        //    break MISSING_BLOCK_LABEL_211;
        }
        finally
        {
        releaseConnection(conn);
        // throw exception;
        releaseConnection(conn);
        return res;
        }
    }

}
