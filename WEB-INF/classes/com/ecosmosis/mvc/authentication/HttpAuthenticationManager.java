// Decompiled by Yody
// File : HttpAuthenticationManager.class

package com.ecosmosis.mvc.authentication;

import com.ecosmosis.common.locations.LocationManager;
import com.ecosmosis.mvc.accesscontrol.menu.MenuBean;
import com.ecosmosis.mvc.accesscontrol.menu.ModuleManager;
import com.ecosmosis.mvc.accesscontrol.user.LoginUserBean;
import com.ecosmosis.mvc.authentication.accesscontrol.AccessControlList;
import com.ecosmosis.mvc.authentication.accesscontrol.AccessControlManager;
import com.ecosmosis.mvc.constant.SupportedLocale;
import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionManager;
import com.ecosmosis.mvc.manager.MvcReturnBean;
import com.ecosmosis.orca.member.*;
import com.ecosmosis.orca.outlet.OutletManager;
import com.ecosmosis.orca.stockist.*;
import com.ecosmosis.orca.users.AdminLoginUserBean;
import com.ecosmosis.orca.users.AdminManager;
import com.ecosmosis.util.crypto.DesEncrypt;
import com.ecosmosis.util.log.Log;
import java.sql.Connection;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class HttpAuthenticationManager extends DBTransactionManager
{

    public static final int ADMIN_LOGIN = 0x186a1;
    public static final int ADMIN_LOGOUT = 0x186a2;
    public static final int EXPIRED_PAGE = 0x186a3;
    public static final int ADMIN_MAIN_FRAME = 0x186aa;
    public static final int ADMIN_TOP_FRAME = 0x186ab;
    public static final int ADMIN_SIDE_MENU_FRAME = 0x186ac;
    public static final int ADMIN_MAIN_AREA = 0x186ad;
    public static final int ILLEGAL_DIRECT_JSP_ACCESS = 0x186a4;
    
    public static final int STOCKIST_LOGIN = 0x30d41;
    public static final int STOCKIST_LOGOUT = 0x30d42;
    public static final int STOCKIST_MAIN_FRAME = 0x30d4a;
    public static final int STOCKIST_TOP_FRAME = 0x30d4b;
    public static final int STOCKIST_SIDE_MENU_FRAME = 0x30d4c;
    public static final int STOCKIST_MAIN_AREA = 0x30d4d;
    
    public static final int MEMBER_LOGIN = 0x493e1;    
    public static final int MEMBER_LOGOUT = 0x493e2;
    public static final int MEMBER_EXPIRED_PAGE = 0x493e3;
    public static final int MEMBER_MAIN_FRAME = 0x493ea;
    
    public static final int MEMBER_CHECK_PIN = 0x493e5;
    
    public static final int MEMBER_TOP_FRAME = 0x493eb;
    public static final int MEMBER_BOTTOM_FRAME = 0x493ec;
    
    public static final int LOGIN_FAILED = -1;
    public static final int LOGIN_SUCCESS = 1;
    public static final int OVERWRITE_LOGININFO = 2;
    
    public static final String AUTH_KEY = "oooRCaaa";
    public static final String USERNAME = "Aid";
    public static final String PASSWORD = "Password";
    public static final int MAX_IDLED_INTERVAL = 1800;

    public HttpAuthenticationManager()
    {
    }

    protected boolean verifyAuthenticatedUserAccessControl(AccessControlList acl, int actionID)
        throws MvcException
    {
        return acl.verify(actionID);
    }

    public Locale parseLocale(String localeStr)
    {
        Locale locale = null;
        if(localeStr != null)
        {
            int index = localeStr.indexOf("_");
            if(index > 0)
            {
                String language = localeStr.substring(0, index);
                String country = localeStr.substring(index + 1);
                locale = new Locale(language, country);
            } else
            {
                locale = new Locale(localeStr);
            }
        } else
        {
            locale = SupportedLocale.DEFAULT_LOCALE;
        }
        return locale;
    }

    public boolean logout(HttpServletRequest request)
        throws MvcException
    {
        boolean logoutSuccessful = false;
        HttpSession session = request.getSession(false);
        if(session != null)
        {
            try
            {
                session.invalidate();
            }
            catch(Exception e)
            {
                Log.error(e.getMessage());
            }
            logoutSuccessful = true;
        }
        return logoutSuccessful;
    }

    public int isLoginUser(LoginUserBean loginUser)
        throws MvcException
    {
        int logintype = 0;
        if(loginUser != null)
            logintype = loginUser.getUserGroupType();
        return logintype;
    }

    public MvcReturnBean isAuthorizedAccess(LoginUserBean loginUser, int actionID)
        throws MvcException
    {
        MvcReturnBean returnBean = null;
        if(loginUser != null)
            try
            {
                boolean validAccess = verifyAuthenticatedUserAccessControl(loginUser.getAcl(), actionID);
                if(!validAccess)
                {
                    returnBean = new MvcReturnBean();
                    returnBean.fail();
                    returnBean.setTaskStatus(6);
                    returnBean.setSysError((new StringBuilder("ACL NOT FOUND - ")).append(actionID).toString());
                    returnBean.addError("ATH005", new Integer(actionID));
                }
            }
            catch(Throwable e)
            {
                Log.error(e);
            }
        return returnBean;
    }

    public static synchronized LoginUserBean getSessionLoginUserBean(HttpServletRequest request)
    {
        HttpSession session = request.getSession(false);
        if(session == null)
            return null;
        else
            return (LoginUserBean)session.getAttribute("oooRCaaa");
    }

    public MvcReturnBean performTask(int taskId, HttpServletRequest request, LoginUserBean loginuser)
    {
        setLoginUser(loginuser);
        MvcReturnBean returnBean = null;
        try
        {
            switch(taskId)
            {
            default:
                break;

            case 100001: 
            {
                int usertype = 80;
                if(usertype >= 80)
                    usertype = 80;
                returnBean = loginUser(usertype, request);
                break;
            }

            case 100002: 
            case 200002: 
            case 300002: 
            {
                logout(request);
                break;
            }

            case 100012: 
            case 200012: 
            {
                String catStr = request.getParameter("catid");
                int sysid = -1;
                if(taskId == 0x186ac)
                    sysid = 1;
                else
                if(taskId == 0x30d4c)
                    sysid = 2;
                int subsysid = -1;
                int catid = -1;
                ModuleManager mgr = new ModuleManager();
                try
                {
                    if(catStr != null)
                    {
                        int selectedcat = Integer.parseInt(catStr);
                        subsysid = mgr.getSubSystemID(selectedcat);
                        catid = mgr.getCategoryID(selectedcat);
                    }
                }
                catch(Exception exception) { }
                LoginUserBean loginUser = getSessionLoginUserBean(request);
                int accessgroup = loginUser.getUserGroupType();
                MenuBean ar[] = mgr.getFunctionsList(loginUser.getUserId(), accessgroup, loginUser.getLocale(), sysid, subsysid, catid);
                // System.out.println("Tiga : userid " + loginUser.getUserId() + "accessgroup " + accessgroup + "locale " + loginUser.getLocale() + "sysid " + sysid + "subsysid " + subsysid + "catid " + catid);         
                request.setAttribute("menu", ar);
                break;
            }

            case 100011: 
            case 200011: 
            {
                if(taskId != 0x186ab && taskId != 0x30d4b)
                    break;
                LoginUserBean loginUser = getSessionLoginUserBean(request);
                MenuBean subsystem[] = (MenuBean[])null;
                MenuBean category[] = (MenuBean[])null;
                ModuleManager mgr = new ModuleManager();
                int sysid = -1;
                if(taskId == 0x186ab)
                    sysid = 1;
                else
                if(taskId == 0x30d4b)
                    sysid = 2;
                subsystem = mgr.getSubSystemList(loginUser.getUserId(), loginUser.getUserGroupType(), loginUser.getLocale(), sysid);
                if(subsystem != null && subsystem.length > 0)
                {
                    int subsysid = -1;
                    String selectsubsys = request.getParameter("subsysid");
                    if(selectsubsys != null)
                        subsysid = mgr.getSubSystemID(Integer.parseInt(selectsubsys));
                    else
                        subsysid = mgr.getSubSystemID(subsystem[0].getFunctionID());
                    category = mgr.getCategoryList(loginUser.getUserId(), loginUser.getUserGroupType(), loginUser.getLocale(), sysid, subsysid);
                }
                request.setAttribute("subsystem", subsystem);
                request.setAttribute("category", category);
                break;
            }

            case 100013: 
            {
                if(loginuser.isChangePassword())
                {
                    returnBean = new MvcReturnBean();
                    returnBean.nextaction();
                }
                break;
            }

            case 100004: 
            {
                returnBean = new MvcReturnBean();
                returnBean.setTaskStatus(6);
                returnBean.setSysError("Illegal Direct JSP Access");
                returnBean.addError("ATH007");
                break;
            }

            case 100003: 
            {
                returnBean = new MvcReturnBean();
                returnBean.done();
                break;
            }

            case 200001: 
            {
                int usertype = 70;
                returnBean = loginUser(usertype, request);
                break;
            }

            case 300001: 
            {
                int usertype = 10;
                returnBean = loginUser(usertype, request);
                System.out.println("300001 MenuBean ar[5] ’" + returnBean + "’ ....");                                
                break;
            }

           
            case 300005: 
            {
                int usertype = 20;
                returnBean = checkPIN(usertype, request);
                System.out.println("300005 check PIN " + returnBean + "’ ....");                                
                break;
            }           
            
            case 300011: 
            {
                String catStr = request.getParameter("catid");
                int sysid = 3;
                int subsysid = 1;
                int catid = 1;
                ModuleManager mgr = new ModuleManager();
                LoginUserBean loginUser = getSessionLoginUserBean(request);
                int accessgroup = loginUser.getUserGroupType();
                MenuBean ar[] = mgr.getFunctionsList(loginUser.getUserId(), accessgroup, loginUser.getLocale(), sysid, subsysid, catid);                
                request.setAttribute("menu", ar);
                System.out.println("300011 MenuBean ar[5] ’" + ar[5] + "’ ....");                
                break;
            }

            case 300012: 
            {
                if(loginuser.isChangePassword())
                {
                    returnBean = new MvcReturnBean();
                    returnBean.nextaction();
                }
                System.out.println("300012 MenuBean ar[5] ’" + returnBean + "’ ....");                                
                break;
            }
            }
        }
        catch(Throwable e)
        {
            returnBean = new MvcReturnBean();
            returnBean.setTaskStatus(6);
            returnBean.setSysError((new StringBuilder("CTR003 <BR> ")).append(e.toString()).toString());
            returnBean.addError("CTR003");
        }
        return returnBean;
    }

    public MvcReturnBean loginUser(int usertype, HttpServletRequest request)
    {
        MvcReturnBean returnBean = null;
        String userName = request.getParameter("Aid");
        String passWord = request.getParameter("Password");
        StringBuffer buf = new StringBuffer();
        if(userName == null || userName.length() > 12 || userName.length() < 4)
            buf.append("<br>Invalid Login ID. Login ID length 4-10 chars.");
        if(passWord == null || passWord.length() > 12 || passWord.length() < 4)
            buf.append("<br>Invalid Password!");

        
        if(buf.length() > 0)
        {
            returnBean = new MvcReturnBean();
            returnBean.fail();
            returnBean.setSysMessage(buf.toString());
        } else
        {
            switch(usertype)
            {
            case 80: // 'P'
            case 100: // 'd'
                returnBean = loginAdminUser(userName, passWord, request);
                break;

            case 70: // 'F'
                returnBean = loginStockistUser(userName, passWord, request);
                break;

            case 10: // '\n'
                returnBean = loginMemberUser(userName, passWord, request);
                break;
                
            }
        }
        
        return returnBean;
    }
    
    public MvcReturnBean checkPIN(int usertype, HttpServletRequest request)
    {
        MvcReturnBean returnBean = null;
        StringBuffer buf = new StringBuffer();
        String idCRM  = request.getParameter("IdCRM");
        String pinCRM = request.getParameter("PinCRM");     
        
        if(idCRM == null || idCRM.length() > 10 || idCRM.length() < 4)
            buf.append("<br>Invalid Previllage Number. CRM ID length 10 chars.");
        if(pinCRM == null || pinCRM.length() > 12 || pinCRM.length() < 4)
            buf.append("<br>Invalid PIN!");
        
        if(buf.length() > 0)
        {
            returnBean = new MvcReturnBean();
            returnBean.fail();
            returnBean.setSysMessage(buf.toString());
        } else
        {
            returnBean = prosesCheckPIN(idCRM, pinCRM, request);
            // buf.append("<br>Valid PIN Number.");
            // returnBean.setSysMessage(buf.toString());            
         }
        
        return returnBean;
        }
 
    
    private MvcReturnBean loginAdminUser(String userName, String password, HttpServletRequest request)
    {
        MvcReturnBean returnBean = new MvcReturnBean();
        AdminManager adminmgr = new AdminManager();
        try
        {
            AdminLoginUserBean bean = adminmgr.getAdminUserBean(userName);
            DesEncrypt encryptor = new DesEncrypt();
            String decryptedpassword = bean == null ? "" : encryptor.decrypt(bean.getPassword());
            if(bean == null)
            {
                returnBean.fail();
                returnBean.setSysMessage("Invalid User!");
            } else
            if(!decryptedpassword.equals(password))
            {
                returnBean.fail();
                returnBean.setSysMessage("Invalid Username / Password!");
            } else
            if(!bean.getStatus().equalsIgnoreCase("A"))
            {
                returnBean.fail();
                returnBean.setSysMessage("Inactive Account, Pls check with System Administrator!");
            } else
            {
                OutletManager outletmgr = new OutletManager();
                bean.setOutletBean(outletmgr.getRecord(bean.getOutletID()));
                LocationManager locmgr = new LocationManager();
                bean.setManagementLocationBean(locmgr.getLocationBean(bean.getManagementLocationID()));
                bean.setOperationLocationBean(locmgr.getLocationBean(bean.getOperationLocationID()));
                AccessControlManager accessControlManager = new AccessControlManager();
                java.util.Map ACL = accessControlManager.getAccessControlList(bean.getUserId(), bean.getUserGroupType());
                AccessControlList acl = new AccessControlList();
                acl.setACL(ACL);
                bean.setAcl(acl);
                Locale locale = parseLocale(bean.getLanguage());
                bean.setLocale(locale);
                loginSession(request, bean);
                returnBean.done();
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

    private MvcReturnBean loginStockistUser(String userName, String password, HttpServletRequest request)
    {
        MvcReturnBean returnBean = new MvcReturnBean();
        StockistManager stockistManager = new StockistManager();
        try
        {
            StockistUserBean user = stockistManager.getStockistUser(userName);
            DesEncrypt encryptor = new DesEncrypt();
            String decryptedpassword = user == null ? "" : encryptor.decrypt(user.getPassword());
            if(user == null)
            {
                returnBean.fail();
                returnBean.setSysMessage("Invalid User!");                
                
            } else
            if(!decryptedpassword.equals(password))
            {
                returnBean.fail();
                returnBean.setSysMessage("Invalid Username / Password!");
            } else
            if(!user.getStatus().equalsIgnoreCase("Y"))
            {
                returnBean.fail();
                returnBean.setSysMessage("Inactive Account, Pls check with System Administrator!");
            } else
            {
                StockistLoginUserBean loginUser = new StockistLoginUserBean();
                AccessControlManager accessControlManager = new AccessControlManager();
                java.util.Map ACL = accessControlManager.getAccessControlList(user.getUserID(), user.getLevel());
                AccessControlList acl = new AccessControlList();
                acl.setACL(ACL);
                loginUser.setAcl(acl);
                loginUser.setUserId(user.getUserID());
                loginUser.setUserName(user.getName());
                loginUser.setOutletID(user.getStockistID());
                loginUser.setUserGroupType(user.getLevel());
                loginUser.setStockist(stockistManager.getStockist(null, user.getStockistID(), user.getUserID()));
                Locale locale = parseLocale(user.getLanguage());
                loginUser.setLocale(locale);
                loginSession(request, loginUser);
                returnBean.done();
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

    private MvcReturnBean loginMemberUser(String userName, String password, HttpServletRequest request)
    {
        MvcReturnBean returnBean = new MvcReturnBean();
        MemberManager memberMgr = new MemberManager();
        try
        {
            MemberBean member = memberMgr.getMemberByID(userName, false);
            DesEncrypt encryptor = new DesEncrypt();
            String decryptedpassword = member == null ? "" : encryptor.decrypt(member.getPassword());
            if(member == null)
            {
                returnBean.fail();
                returnBean.setSysMessage("Invalid User!");
            } else
            if(!decryptedpassword.equals(password))
            {
                returnBean.fail();
                returnBean.setSysMessage("Invalid Username / Password!");
            } else
            if(member.getStatus() != 10)
            {
                returnBean.fail();
                returnBean.setSysMessage("Inactive Account, Pls check with Company Administrator!");
            } else
            {
                MemberLoginUserBean loginUser = new MemberLoginUserBean();
                loginUser.setUserId(member.getMemberID());
                loginUser.setMemberBean(member);
                loginUser.setUserName(member.getName());
                loginUser.setOutletID(member.getHomeBranchID());
                loginUser.setChangePassword(member.isChangePassword());
                loginUser.setUserGroupType(10);
                Locale locale = parseLocale(member.getLocale());
                loginUser.setLocale(locale);
                loginSession(request, loginUser);
                returnBean.done();
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
    

    private MvcReturnBean prosesCheckPIN(String idCRM, String pinCRM, HttpServletRequest request)
    {
        MvcReturnBean returnBean = new MvcReturnBean();
        MemberManager memberMgr = new MemberManager();
        try
        {
            MemberBean member = memberMgr.getMemberByIdCRM(idCRM, false);
            // MemberBean member = memberMgr.getMemberByMobile(idCRM, false);
            String pin = member.getEpin();
            
            if(member == null || pin == null || pin.length() < 1)
            {
                returnBean.fail();
                returnBean.setSysMessage("Invalid ID Card !");
                // returnBean.setSysMessage("Invalid Mobile Number !");
                
            } else
            if(!pin.equals(pinCRM))
            {
                returnBean.fail();
                returnBean.setSysMessage("Invalid ID Card or PIN !");
                // returnBean.setSysMessage("Invalid Mobile Number or PIN !");
            } else
            if(member.getStatus() != 10)
            {
                returnBean.fail();
                returnBean.setSysMessage("Inactive Account Member, Pls check with Company Administrator!");
            }
            else
            {  
                // Insert ke table PIN
                System.out.println("Masuk Insert bro !! ");
                boolean insert;
                insert = false;
                insert = addMemberPIN(member);
                returnBean.setSysMessage("Valid PIN Number.");
                returnBean.done();
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
    
    private void loginSession(HttpServletRequest request, LoginUserBean userbean)
    {
        HttpSession session = request.getSession(false);
        if(session == null)
        {
            session = request.getSession(true);
            session.setMaxInactiveInterval(1800);
        }
        session.setAttribute("oooRCaaa", userbean);
    }

    private Hashtable createParamTable(HttpServletRequest request)
        throws Exception
    {
        Hashtable params = new Hashtable();
        String paramName;
        for(Enumeration e = request.getParameterNames(); e.hasMoreElements(); params.put(paramName, request.getParameter(paramName)))
            paramName = (String)e.nextElement();

        return params;
    }

    private String generateRandomPasswd()
    {
        String tmpPasswd = String.valueOf(Math.random());
        int index = tmpPasswd.indexOf(".");
        if(index != -1)
            tmpPasswd = tmpPasswd.substring(index + 1);
        if(tmpPasswd.length() < 6)
        {
            int balance = 6 - tmpPasswd.length();
            if(balance > 0)
            {
                StringBuffer sb = new StringBuffer(tmpPasswd);
                for(int i = 0; i < balance; i++)
                    sb.append("9");

                tmpPasswd = sb.toString();
            }
        } else
        {
            tmpPasswd = tmpPasswd.substring(0, 6);
        }
        return tmpPasswd;
    }


    private boolean addMemberPIN(MemberBean member)
        throws MvcException
    {
        boolean status;
        Connection conn;
        MemberManager memberMgr2 = new MemberManager();
        
        if(member == null)
            throw new IllegalArgumentException("No member specified");
        status = false;
        conn = null;
        try
        {
            conn = getConnection();
            // member.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
            status = memberMgr2.getBroker(conn).addMemberPIN(member);            
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
        releaseConnection(conn);
        return status;
        }
    }    

    
}
