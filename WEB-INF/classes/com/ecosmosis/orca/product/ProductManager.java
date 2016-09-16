// Decompiled by Yody
// File : ProductManager.class

package com.ecosmosis.orca.product;

import com.ecosmosis.common.language.Language;
import com.ecosmosis.common.language.LanguageBean;
import com.ecosmosis.mvc.accesscontrol.user.LoginUserBean;
import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionManager;
import com.ecosmosis.mvc.manager.MvcReturnBean;
import com.ecosmosis.mvc.sys.Sys;
import com.ecosmosis.orca.pricing.product.ProductPricingManager;
import com.ecosmosis.orca.product.category.ProductCategoryBean;
import com.ecosmosis.util.log.Log;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.*;
import javax.servlet.http.HttpServletRequest;

// Referenced classes of package com.ecosmosis.orca.product:
//            ProductBean, ProductBroker

public class ProductManager extends DBTransactionManager
{

    public static final int TASKID_SINGLE_PRODUCT_ADD = 0x1a20c;
    public static final int TASKID_SINGLE_PRODUCT_LISTING = 0x1a20e;
    public static final int TASKID_SINGLE_PRODUCT_INFO = 0x1a294;
    public static final int TASKID_SINGLE_PRODUCT_EDIT = 0x1a296;
    public static final int TASKID_COMBO_PRODUCT_ADD = 0x1a20d;
    public static final int TASKID_COMBO_PRODUCT_LISTING = 0x1a20f;
    public static final int TASKID_COMBO_PRODUCT_INFO = 0x1a295;
    public static final int TASKID_COMBO_PRODUCT_EDIT = 0x1a297;
    public static final String PRODUCT_SINGLE = "S";
    public static final String PRODUCT_COMBO = "C";
    public static final String PRODUCT_ACTIVE = "A";
    public static final String PRODUCT_INACTIVE = "I";
    public static final int TYPE_SALESPRODUCT = 0;
    public static final int TYPE_FOCPRODUCT = 1;
    public static final ProductBean EMPTY_ARRAY_PRODUCT[] = new ProductBean[0];
    
    // for chek
    //    public ProductBean[] getProductItems()
    // {
    //    return (ProductBean[])items.values().toArray(ProductManager.EMPTY_ARRAY_PRODUCT);
    // }
    
    private ProductBroker broker;

    public ProductManager()
    {
        broker = null;
    }

    public ProductManager(Connection conn)
    {
        super(conn);
        broker = null;
    }

    private ProductBroker getBroker(Connection conn)
    {
        if(broker == null)
            broker = new ProductBroker(conn);
        else
            broker.setConnection(conn);
        return broker;
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

            case 107020: 
                if(formSubmitted)
                    returnBean = addSingleProduct(request, taskId);
                else
                    returnBean = getProductCategoryList(request);
                break;

            case 107022: 
                if(formSubmitted)
                {
                    String type = request.getParameter("Type");
                    String status = request.getParameter("Status");
                    String catid = request.getParameter("CatID");
                    String inventory = request.getParameter("InventoryCtrl");
                    String priority = request.getParameter("PriorityLevel");
                    String safe = request.getParameter("SafeLevel");
                    returnBean = getProductList(request, type, status, catid, inventory, priority, safe, taskId);
                } else
                {
                    returnBean = getListingHeader(request);
                }
                break;

            case 107156: 
                String param = request.getParameter("productid");
                returnBean = getProductById(request, param);
                break;

            case 107158: 
                if(formSubmitted)
                {
                    returnBean = editProduct(request, taskId);
                } else
                {
                    String param1 = request.getParameter("productid");
                    returnBean = getProductById(request, param1);
                }
                break;

            case 107021: 
                if(formSubmitted)
                {
                    returnBean = addComboProduct(request, taskId);
                } else
                {
                    String type = "%S%";
                    String status = "%%";
                    String catid = "%%";
                    String inventory = "%%";
                    String priority = "%%";
                    String safe = "%%";
                    returnBean = getProductList(request, type, status, catid, inventory, priority, safe, taskId);
                }
                break;

            case 107159: 
                if(formSubmitted)
                {
                    returnBean = editComboProduct(request, taskId);
                } else
                {
                    String param2 = request.getParameter("productid");
                    returnBean = getComboProductById(request, param2);
                }
                break;

            case 107023: 
                String type = "C";
                String status = request.getParameter("Status");
                String catid = request.getParameter("CatID");
                String inventory = request.getParameter("InventoryCtrl");
                String priority = request.getParameter("PriorityLevel");
                String safe = request.getParameter("SafeLevel");
                returnBean = getProductList(request, type, status, catid, inventory, priority, safe, taskId);
                break;

            case 107157: 
                String productid = request.getParameter("productid");
                returnBean = getComboProductBySubId(request, productid);
                break;
            }
        }
        catch(Exception e)
        {
            returnBean = new MvcReturnBean();
            returnBean.setException(e);
        }
        return returnBean;
    }

    public MvcReturnBean getListingHeader(HttpServletRequest request)
        throws Exception
    {
        MvcReturnBean returnBean = new MvcReturnBean();
        Locale currentLocale = getLoginUser().getLocale();
        String LocaleStr = currentLocale.toString();
        returnBean.addReturnObject("CatList", getList(LocaleStr));
        return returnBean;
    }

    public MvcReturnBean getProductCategoryList(HttpServletRequest request)
        throws Exception
    {
        MvcReturnBean returnBean = new MvcReturnBean();
        Locale currentLocale = getLoginUser().getLocale();
        returnBean.setLocale(currentLocale);
        String LocaleStr = currentLocale.toString();
        LanguageBean supported_languages[] = (LanguageBean[])Language.getAll();
        returnBean.addReturnObject("supportedlocale", supported_languages);
        returnBean.addReturnObject("CatList", getList(LocaleStr));
        return returnBean;
    }

    public MvcReturnBean getProductList(HttpServletRequest request, String type, String status, String catid, String inventory, String priority, String safe, 
            int taskId)
        throws Exception
    {
        MvcReturnBean returnBean = new MvcReturnBean();
        Locale currentLocale = getLoginUser().getLocale();
        returnBean.setLocale(currentLocale);
        String LocaleStr = currentLocale.toString();
        returnBean.addReturnObject("CatList", getList(LocaleStr));
        LanguageBean supported_languages[] = (LanguageBean[])Language.getAll();
        returnBean.addReturnObject("supportedlocale", supported_languages);
        ProductBean product[] = getProductList(LocaleStr, type, status, catid, inventory, priority, safe, taskId);
        if(product != null)
            returnBean.addReturnObject("Product", product);
        return returnBean;
    }

    private MvcReturnBean getProductById(HttpServletRequest request, String productid)
        throws MvcException
    {
        if(productid == null)
            throw new IllegalArgumentException("No product specified");
        MvcReturnBean returnBean = new MvcReturnBean();
        Locale currentLocale = getLoginUser().getLocale();
        String LocaleStr = currentLocale.toString();
        returnBean.addReturnObject("CatList", getList(LocaleStr));
        LanguageBean supported_languages[] = (LanguageBean[])Language.getAll();
        returnBean.addReturnObject("supportedlocale", supported_languages);
        for(int i = 0; i < supported_languages.length; i++)
        {
            String locale = supported_languages[i].getLocaleStr();
            returnBean.addReturnObject(locale, getProductById(locale, productid));
        }

        return returnBean;
    }

    private MvcReturnBean getComboProductById(HttpServletRequest request, String productid)
        throws MvcException
    {
        if(productid == null)
            throw new IllegalArgumentException("No product specified");
        MvcReturnBean returnBean = new MvcReturnBean();
        Locale currentLocale = getLoginUser().getLocale();
        String LocaleStr = currentLocale.toString();
        returnBean.addReturnObject("CatList", getList(LocaleStr));
        LanguageBean supported_languages[] = (LanguageBean[])Language.getAll();
        returnBean.addReturnObject("supportedlocale", supported_languages);
        for(int i = 0; i < supported_languages.length; i++)
        {
            String locale = supported_languages[i].getLocaleStr();
            returnBean.addReturnObject(locale, getComboProductById(locale, productid));
        }

        return returnBean;
    }

    private MvcReturnBean getComboProductBySubId(HttpServletRequest request, String productid)
        throws MvcException
    {
        if(productid == null)
            throw new IllegalArgumentException("No product specified");
        MvcReturnBean returnBean = new MvcReturnBean();
        Locale currentLocale = getLoginUser().getLocale();
        String LocaleStr = currentLocale.toString();
        returnBean.addReturnObject("CatList", getList(LocaleStr));
        LanguageBean supported_languages[] = (LanguageBean[])Language.getAll();
        returnBean.addReturnObject("supportedlocale", supported_languages);
        for(int i = 0; i < supported_languages.length; i++)
        {
            String locale = supported_languages[i].getLocaleStr();
            returnBean.addReturnObject(locale, getProductById(locale, productid));
        }

        ProductBean product[] = getComboSubProductBySubId(LocaleStr, productid);
        if(product != null)
            returnBean.addReturnObject("Product", product);
        return returnBean;
    }

    public MvcReturnBean addSingleProduct(HttpServletRequest request, int taskId)
        throws Exception
    {        
        MvcReturnBean returnBean;
        Connection conn;
        returnBean = new MvcReturnBean();
        conn = null;
        // boolean succ = false;
        ProductBean bean;
        MvcReturnBean mvcreturnbean;
        bean = new ProductBean();
        parseProductBean(bean, request, taskId);
        if(checkInput(bean, returnBean))
            // break MISSING_BLOCK_LABEL_58;
            returnBean.fail();
            mvcreturnbean = returnBean;
            //releaseConnection(conn);
            //return mvcreturnbean;
        
        try
        {
            boolean succ = insert(bean);
            if(succ)
                returnBean.done();
            else
                returnBean.setSysMessage("Insert Failed ! ");
            if(returnBean.getTaskStatus() == 1)
            {
                returnBean.setTaskStatus(3);
                returnBean.setAlternateReturnMethod(2);
                returnBean.setAlternateReturnPath((new StringBuilder(String.valueOf(Sys.getControllerURL(0x1a294, request)))).append("&productid=").append(bean.getProductID()).toString());
            }
        }
        
        catch(Exception e)
        {
            returnBean = new MvcReturnBean();
            returnBean.setException(e);
        }
        /*    
        catch(SQLException e)
        {
            Log.error(e);
            returnBean.setException(e);
            if(e instanceof SQLException)
            {
                SQLException sqle = e;
                int i = e.getErrorCode();
            }
            // break MISSING_BLOCK_LABEL_200;
        }
         */
            
        /*
        break MISSING_BLOCK_LABEL_190;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        releaseConnection(conn);
        break MISSING_BLOCK_LABEL_207;
        */       
        releaseConnection(conn);
        return returnBean;
    }

    public MvcReturnBean editProduct(HttpServletRequest request, int taskId)
        throws Exception
    {
        MvcReturnBean returnBean;
        Connection conn;
        returnBean = new MvcReturnBean();
        conn = null;
        // boolean succ = false;
        ProductBean Bean;
        MvcReturnBean mvcreturnbean;
        Bean = new ProductBean();
        parseProductBean(Bean, request, taskId);
        if(checkInput(Bean, returnBean))
            // break MISSING_BLOCK_LABEL_58;
        returnBean.fail();
        mvcreturnbean = returnBean;
        // releaseConnection(conn);
        // return mvcreturnbean;
        try
        {
            boolean succ = update(Bean);
            if(succ)
                returnBean.done();
            else
                returnBean.setSysMessage("Edit Failed ! ");
            if(returnBean.getTaskStatus() == 1)
            {
                returnBean.setTaskStatus(3);
                returnBean.setAlternateReturnMethod(2);
                returnBean.setAlternateReturnPath((new StringBuilder(String.valueOf(Sys.getControllerURL(0x1a294, request)))).append("&productid=").append(Bean.getProductID()).toString());
            }
        }

        catch(Exception e)
        {
            returnBean = new MvcReturnBean();
            returnBean.setException(e);
        }
        
        /*
        catch(SQLException e)
        {
            Log.error(e);
            returnBean.setException(e);
            if(e instanceof SQLException)
            {
                SQLException sqle = e;
                int i = e.getErrorCode();
            }
            // break MISSING_BLOCK_LABEL_200;
        }
         */
        
        /*
        break MISSING_BLOCK_LABEL_190;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        releaseConnection(conn);
        break MISSING_BLOCK_LABEL_207;
        */
        releaseConnection(conn);
        return returnBean;
    }

    public MvcReturnBean editComboProduct(HttpServletRequest request, int taskId)
        throws Exception
    {
        MvcReturnBean returnBean;
        Connection conn;
        returnBean = new MvcReturnBean();
        conn = null;
        // boolean succ = false;
        ProductBean Bean;
        MvcReturnBean mvcreturnbean;
        Bean = new ProductBean();
        parseProductBean(Bean, request, taskId);
        if(checkComboInput(Bean, returnBean))
            // break MISSING_BLOCK_LABEL_58;
        returnBean.fail();
        mvcreturnbean = returnBean;
        // releaseConnection(conn);
        // return mvcreturnbean;
        try
        {
            boolean succ = updateCombo(Bean);
            if(succ)
                returnBean.done();
            else
                returnBean.setSysMessage("Edit Failed ! ");
            if(returnBean.getTaskStatus() == 1)
            {
                returnBean.setTaskStatus(3);
                returnBean.setAlternateReturnMethod(2);
                returnBean.setAlternateReturnPath((new StringBuilder(String.valueOf(Sys.getControllerURL(0x1a295, request)))).append("&productid=").append(Bean.getProductID()).toString());
            }
        }
        
        catch(Exception e)
        {
            returnBean = new MvcReturnBean();
            returnBean.setException(e);
        }
        
        /*
        catch(SQLException e)
        {
            Log.error(e);
            returnBean.setException(e);
            if(e instanceof SQLException)
            {
                SQLException sqle = e;
                int i = e.getErrorCode();
            }
            // break MISSING_BLOCK_LABEL_200;
        }
         */
        /*
        break MISSING_BLOCK_LABEL_190;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        releaseConnection(conn);
        break MISSING_BLOCK_LABEL_207;
        */
        releaseConnection(conn);
        return returnBean;
    }

    public MvcReturnBean addComboProduct(HttpServletRequest request, int taskId)
        throws Exception
    {
        MvcReturnBean returnBean;
        Connection conn;
        returnBean = new MvcReturnBean();
        conn = null;
        // boolean succ = false;
        ProductBean bean;
        MvcReturnBean mvcreturnbean;
        bean = new ProductBean();
        parseComboProductBean(bean, request, taskId);
        if(checkComboInput(bean, returnBean))
            // break MISSING_BLOCK_LABEL_58;
        returnBean.fail();
        mvcreturnbean = returnBean;
        // releaseConnection(conn);
        // return mvcreturnbean;
        try
        {
            boolean succ = insertCombo(bean);
            if(succ)
                returnBean.done();
            else
                returnBean.setSysMessage("Insert Failed ! ");
            if(returnBean.getTaskStatus() == 1)
            {
                returnBean.setTaskStatus(3);
                returnBean.setAlternateReturnMethod(2);
                returnBean.setAlternateReturnPath((new StringBuilder(String.valueOf(Sys.getControllerURL(0x1a295, request)))).append("&productid=").append(bean.getProductID()).toString());
            }
        }
        
        catch(Exception e)
        {
            returnBean = new MvcReturnBean();
            returnBean.setException(e);
        }
        /*
        catch(SQLException e)
        {
            Log.error(e);
            returnBean.setException(e);
            if(e instanceof SQLException)
            {
                SQLException sqle = e;
                int i = e.getErrorCode();
            }
            // break MISSING_BLOCK_LABEL_200;
        }
         */
        /*
        break MISSING_BLOCK_LABEL_190;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        releaseConnection(conn);
        break MISSING_BLOCK_LABEL_207;
        */
        releaseConnection(conn);
        return returnBean;
    }

    private boolean checkInput(ProductBean bean, MvcReturnBean ret)
    {
        if(bean.getProductCode() == null || bean.getProductCode() != null && bean.getProductCode().length() <= 0)
            ret.addError("No ProductCode specified");
        return !ret.hasErrorMessages();
    }

    private boolean checkComboInput(ProductBean bean, MvcReturnBean ret)
    {
        if(bean.getSkuCode() == null || bean.getSkuCode() != null && bean.getSkuCode().length() <= 0)
            ret.addError("No SkuCode specified");
        return !ret.hasErrorMessages();
    }

    private void parseProductBean(ProductBean bean, HttpServletRequest req, int taskId)
        throws Exception
    {
        Connection conn;
        String desc;
        String CatIdStr;
        String SafeStr;
        String PrioStr;
        conn = null;
        // int newID = 0;
        // int productId = 0;
        desc = "_desc";
        CatIdStr = req.getParameter("CatID");
        SafeStr = req.getParameter("SafeLevel");
        PrioStr = req.getParameter("PriorityLevel");
        try
        {
            conn = getConnection();
            switch(taskId)
            {
            default:
                break;

            case 107020: 
            {
                String BaseStr = req.getParameter("BaseValue");
                String QtySalesStr = req.getParameter("UnitSales");
                double BaseDou = 0.0D;
                try
                {
                    BaseDou = Double.parseDouble(BaseStr);
                }
                catch(NumberFormatException numberformatexception3) { }
                int QtySalesInt = 0;
                try
                {
                    QtySalesInt = Integer.parseInt(QtySalesStr);
                }
                catch(NumberFormatException numberformatexception5) { }
                int newID = getBroker(conn).GetCatId();
                bean.setProductID(newID);
                bean.setProductCode(req.getParameter("ProductCode"));
                bean.setSkuCode(req.getParameter("ProductCode"));
                bean.setBaseValue(BaseDou);
                bean.setQtySale(QtySalesInt);
                break;
            }

            case 107158: 
            {
                String BaseStr = req.getParameter("BaseValue");
                String QtySalesStr = req.getParameter("UnitSales");
                double BaseDou = 0.0D;
                try
                {
                    BaseDou = Double.parseDouble(BaseStr);
                }
                catch(NumberFormatException numberformatexception4) { }
                int QtySalesInt = 0;
                try
                {
                    QtySalesInt = Integer.parseInt(QtySalesStr);
                }
                catch(NumberFormatException numberformatexception6) { }
                String ProductIdStr = req.getParameter("ProductID");
                int productId = Integer.parseInt(ProductIdStr);
                bean.setProductID(productId);
                bean.setProductCode(req.getParameter("ProductCode"));
                bean.setSkuCode(req.getParameter("ProductCode"));
                bean.setBaseValue(BaseDou);
                bean.setQtySale(QtySalesInt);
                break;
            }

            case 107159: 
            {
                String ProductIdStr = req.getParameter("ProductID");
                int productId = Integer.parseInt(ProductIdStr);
                bean.setProductID(productId);
                bean.setSkuCode(req.getParameter("SkuCode"));
                break;
            }
            }
            int CatId = 0;
            int SafeInt = 0;
            int PrioInt = 0;
            try
            {
                CatId = Integer.parseInt(CatIdStr);
            }
            catch(NumberFormatException numberformatexception) { }
            try
            {
                SafeInt = Integer.parseInt(SafeStr);
            }
            catch(NumberFormatException numberformatexception1) { }
            try
            {
                PrioInt = Integer.parseInt(PrioStr);
            }
            catch(NumberFormatException numberformatexception2) { }
            bean.setCatID(CatId);
            bean.setSafeLevel(SafeInt);
            bean.setPriorityLevel(PrioInt);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_443;
        Exception exception;
        exception;
        releaseConnection(conn);
        */
        // throw exception;        
        releaseConnection(conn);
        bean.setDefaultName(req.getParameter("ProductName"));
        bean.setDefaultDesc(req.getParameter("Description"));
        bean.setStatus(req.getParameter("Status"));
        bean.setType(req.getParameter("Type"));
        bean.setUom(req.getParameter("Measurement"));
        bean.setInventory(req.getParameter("InventoryCtrl"));
        bean.setRegister(req.getParameter("Register"));
        LanguageBean supported_languages[] = (LanguageBean[])Language.getAll();
        for(int i = 0; i < supported_languages.length; i++)
        {
            String msg = req.getParameter(supported_languages[i].getLocaleStr());
            ProductBean lbean = new ProductBean();
            String localeDesc = (new StringBuilder(String.valueOf(supported_languages[i].getLocaleStr()))).append(desc).toString();
            lbean.setProductID(bean.getProductID());
            lbean.setLocale(supported_languages[i].getLocaleStr());
            lbean.setName(msg);
            lbean.setDescription(req.getParameter(localeDesc));
            bean.getProductDescList().add(lbean);
        }

        return;
    }

    private void parseComboProductBean(ProductBean bean, HttpServletRequest req, int taskId)
        throws Exception
    {
        Connection conn;
        String desc;
        String CatIdStr;
        String SafeStr;
        String PrioStr;
        conn = null;
        // int newID = 0;
        // int productId = 0;
        desc = "_desc";
        CatIdStr = req.getParameter("CatID");
        SafeStr = req.getParameter("SafeLevel");
        PrioStr = req.getParameter("PriorityLevel");
        try
        {
            conn = getConnection();
            if(taskId == 0x1a20d)
            {
                int newID = getBroker(conn).GetCatId();
                bean.setProductID(newID);
            } else
            {
                String ProductIdStr = req.getParameter("ProductID");
                int productId = Integer.parseInt(ProductIdStr);
                bean.setProductID(productId);
            }
            int CatId = 0;
            int SafeInt = 0;
            int PrioInt = 0;
            try
            {
                CatId = Integer.parseInt(CatIdStr);
            }
            catch(NumberFormatException numberformatexception) { }
            try
            {
                SafeInt = Integer.parseInt(SafeStr);
            }
            catch(NumberFormatException numberformatexception1) { }
            try
            {
                PrioInt = Integer.parseInt(PrioStr);
            }
            catch(NumberFormatException numberformatexception2) { }
            bean.setCatID(CatId);
            bean.setSafeLevel(SafeInt);
            bean.setPriorityLevel(PrioInt);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_195;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        bean.setDefaultName(req.getParameter("ProductName"));
        bean.setDefaultDesc(req.getParameter("Description"));
        bean.setSkuCode(req.getParameter("SkuCode"));
        bean.setStatus(req.getParameter("Status"));
        bean.setType(req.getParameter("Type"));
        bean.setUom(req.getParameter("Measurement"));
        bean.setInventory(req.getParameter("InventoryCtrl"));
        bean.setRegister(req.getParameter("Register"));
        LanguageBean supported_languages[] = (LanguageBean[])Language.getAll();
        for(int i = 0; i < supported_languages.length; i++)
        {
            String msg = req.getParameter(supported_languages[i].getLocaleStr());
            ProductBean lbean = new ProductBean();
            String localeDesc = (new StringBuilder(String.valueOf(supported_languages[i].getLocaleStr()))).append(desc).toString();
            lbean.setProductID(bean.getProductID());
            lbean.setLocale(supported_languages[i].getLocaleStr());
            lbean.setName(msg);
            lbean.setDescription(req.getParameter(localeDesc));
            bean.getProductDescList().add(lbean);
        }

        String product[] = req.getParameterValues("ProductID");
        if(product != null || product.equals(""))
        {
            int qty[] = new int[product.length];
            int seq[] = new int[product.length];
            int id[] = new int[product.length];
            for(int j = 0; j < product.length; j++)
            {
                ProductBean ibean = new ProductBean();
                seq[j] = Integer.parseInt(req.getParameter((new StringBuilder("OrderSeq_")).append(product[j]).toString()));
                qty[j] = Integer.parseInt(req.getParameter((new StringBuilder("UnitSales_")).append(product[j]).toString()));
                id[j] = Integer.parseInt(req.getParameter((new StringBuilder("ProductID_")).append(product[j]).toString()));
                ibean.setProductID(bean.getProductID());
                ibean.setSubProductID(id[j]);
                ibean.setOrderSeq(seq[j]);
                ibean.setQtySale(qty[j]);
                bean.getProductItemList().add(ibean);
            }

        }
        return;
    }

    protected ProductCategoryBean[] getList(String locale)
        throws MvcException
    {
        ProductCategoryBean clist[];
        Connection conn;
        clist = new ProductCategoryBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getProductCategoryList(locale);
            if(!list.isEmpty())
                clist = (ProductCategoryBean[])list.toArray(new ProductCategoryBean[0]);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_75;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return clist;
    }

    protected ProductBean[] getProductList(String locale, String type, String status, String catid, String inventory, String priority, String safe, 
            int taskId)
        throws MvcException
    {
        ProductBean clist[];
        Connection conn;
        clist = new ProductBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getProductList(locale, type, status, catid, inventory, priority, safe, taskId);
            if(!list.isEmpty())
                clist = (ProductBean[])list.toArray(new ProductBean[0]);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_93;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return clist;
    }

    protected ProductBean[] getProductById(String locale, String productid)
        throws MvcException
    {
        ProductBean clist[];
        Connection conn;
        clist = new ProductBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getProductById(locale, productid);
            if(!list.isEmpty())
                clist = (ProductBean[])list.toArray(new ProductBean[0]);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_80;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return clist;
    }

    protected ProductBean[] getComboProductById(String locale, String productid)
        throws MvcException
    {
        ProductBean clist[];
        Connection conn;
        clist = new ProductBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getComboProductById(locale, productid);
            if(!list.isEmpty())
                clist = (ProductBean[])list.toArray(new ProductBean[0]);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_80;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return clist;
    }

    protected ProductBean[] getComboSubProductBySubId(String locale, String productid)
        throws MvcException
    {
        ProductBean clist[];
        Connection conn;
        clist = new ProductBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getComboProduct(locale, productid);
            if(!list.isEmpty())
                clist = (ProductBean[])list.toArray(new ProductBean[0]);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_80;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return clist;
    }

    private boolean insert(ProductBean bean)
        throws MvcException
    {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try
        {
            conn = getConnection(false);
            status = getBroker(conn).InsertProduct(bean);
            commitTransaction();
        }
        catch(Exception e)
        {
            rollBackTransaction();
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_59;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return status;
    }

    private boolean insertCombo(ProductBean bean)
        throws MvcException
    {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try
        {
            conn = getConnection(false);
            status = getBroker(conn).InsertComboProduct(bean);
            commitTransaction();
        }
        catch(Exception e)
        {
            rollBackTransaction();
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_59;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return status;
    }

    private boolean update(ProductBean bean)
        throws MvcException
    {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try
        {
            conn = getConnection(false);
            status = getBroker(conn).UpdateProduct(bean);
            commitTransaction();
        }
        catch(Exception e)
        {
            rollBackTransaction();
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_59;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return status;
    }

    private boolean updateCombo(ProductBean bean)
        throws MvcException
    {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try
        {
            conn = getConnection(false);
            status = getBroker(conn).UpdateComboProduct(bean);
            commitTransaction();
        }
        catch(Exception e)
        {
            rollBackTransaction();
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_59;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return status;
    }

    public ProductBean getProduct(int productID)
        throws MvcException
    {
        ProductBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try
        {
            conn = getConnection();
            bean = getBroker(conn).getProduct(productID);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_50;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return bean;
    }

    public ProductBean getProduct(String skuCode)
        throws MvcException
    {
        ProductBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try
        {
            conn = getConnection();
            bean = getBroker(conn).getProduct(skuCode);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }

        releaseConnection(conn);
        return bean;
    }

    public ProductBean getProduct(int productID, String locale)
        throws MvcException
    {
        ProductBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try
        {
            conn = getConnection();
            bean = getBroker(conn).getProduct(productID, locale);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_55;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return bean;
    }

    public ProductBean[] getProductFullList(String locale)
        throws MvcException
    {
        ProductBean beans[];
        Connection conn;
        beans = new ProductBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getProductFullList(locale);
            // ArrayList list = getBroker(conn).getProductFullList(locale, brand, product);
            if(!list.isEmpty())
                beans = (ProductBean[])list.toArray(new ProductBean[0]);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_75;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return beans;
    }

    // public ProductBean[] getProductFullListUpdate(String locale, String brand, String product, String prodStatus)
    public ProductBean[] getProductFullListUpdate(String locale, String brand, String product, String productDesc, String productType, String prodStatus)
        throws MvcException
    {
        ProductBean beans[];
        Connection conn;
        beans = new ProductBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            // System.out.println(" 3. product "+ product+ " brand "+brand + " product Desc "+ productDesc + " Prod Status "+prodStatus);

            ArrayList list = getBroker(conn).getProductFullListUpdate(locale, brand, product, productDesc, productType, prodStatus);
            if(!list.isEmpty())
                beans = (ProductBean[])list.toArray(new ProductBean[0]);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return beans;
    }
    
    public ProductBean[] getProductFullListNew(String locale, String owner)
        throws MvcException
    {
        ProductBean beans[];
        Connection conn;
        beans = new ProductBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getProductFullListNew(locale, owner);
            if(!list.isEmpty())
                beans = (ProductBean[])list.toArray(new ProductBean[0]);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_75;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return beans;
    }

public ProductBean[] getProductFullList2(String locale, String catid)
        throws MvcException
    {
        ProductBean beans[];
        Connection conn;
        beans = new ProductBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            // ArrayList list = getBroker(conn).getProductFullList(locale);
            ArrayList list = getBroker(conn).getProductFullList2(locale, catid);
            if(!list.isEmpty())
                beans = (ProductBean[])list.toArray(new ProductBean[0]);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_75;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return beans;
    }

    public ProductBean[] getProductList(String productIDList[], String locale)
        throws MvcException
    {
        ProductBean beans[];
        Connection conn;
        beans = new ProductBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getProductList(productIDList, locale);
            if(!list.isEmpty())
                beans = (ProductBean[])list.toArray(new ProductBean[0]);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_80;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return beans;
    }

    public ProductBean[] getActiveProductList(String locale)
        throws MvcException
    {
        ProductBean beans[];
        Connection conn;
        beans = new ProductBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getActiveProductList(locale);
            if(!list.isEmpty())
                beans = (ProductBean[])list.toArray(new ProductBean[0]);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_75;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return beans;
    }

    public ProductBean getProductSet(int productID)
        throws MvcException
    {
        ProductBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try
        {
            conn = getConnection();
            bean = getBroker(conn).getProductSet(productID);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_50;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return bean;
    }

    public ProductBean getProductSet(int productID, String locale)
        throws MvcException
    {
        ProductBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try
        {
            conn = getConnection();
            bean = getBroker(conn).getProductSet(productID, locale);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_55;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return bean;
    }
    
    public ProductBean getProductSetBySkuCode(String skuCode, String locale)
        throws MvcException
    {
        ProductBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try
        {
            conn = getConnection();
            bean = getBroker(conn).getProductSetBySkuCode(skuCode, locale);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_55;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return bean;
    }

    public ProductBean[] getProductSetFullListUpdate(String locale, String brand, String product, String prodDesc, String prodType, String prodStatus)
        throws MvcException
    {
        ProductBean beans[];
        Connection conn;
        beans = new ProductBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            // ArrayList list = getBroker(conn).getProductSetFullList(locale);
            ArrayList list = getBroker(conn).getProductSetFullListUpdate(locale, brand, product, prodDesc, prodType, prodStatus);
            
            if(!list.isEmpty())
                beans = (ProductBean[])list.toArray(new ProductBean[0]);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_75;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return beans;
    }

    public ProductBean[] getProductSetFullList(String locale)
        throws MvcException
    {
        ProductBean beans[];
        Connection conn;
        beans = new ProductBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            // ArrayList list = getBroker(conn).getProductSetFullList(locale);
            ArrayList list = getBroker(conn).getProductSetFullList(locale);
            
            if(!list.isEmpty())
                beans = (ProductBean[])list.toArray(new ProductBean[0]);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_75;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return beans;
    }
    
    public ProductBean[] getActiveProductSetList(String locale)
        throws MvcException
    {
        ProductBean beans[];
        Connection conn;
        beans = new ProductBean[0];
        conn = null;
        try
        {
            conn = getConnection();
            ArrayList list = getBroker(conn).getActiveProductSetList(locale);
            if(!list.isEmpty())
                beans = (ProductBean[])list.toArray(new ProductBean[0]);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_75;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return beans;
    }

    public ProductBean[] getProductSetListForSales(String priceCodeID, Date effectiveDate, String locale)
        throws MvcException
    {
        Connection conn;
        ProductBean beans[];
        conn = null;
        beans = new ProductBean[0];
        try
        {
            conn = getConnection();
            ProductBean activeBeans[] = getActiveProductSetList(locale);
            ArrayList list = new ArrayList();
            ProductPricingManager mgr = new ProductPricingManager(conn);
            for(int i = 0; i < activeBeans.length; i++)
            {
                ProductBean bean = activeBeans[i];
                // com.ecosmosis.orca.pricing.product.ProductPricingBean curPrice = mgr.getCurrentPricing(bean.getProductID(), priceCodeID, effectiveDate);
                com.ecosmosis.orca.pricing.product.ProductPricingBean curPrice = mgr.getCurrentPricing(bean.getProductCode(), priceCodeID, effectiveDate);
                if(curPrice != null)
                {
                    bean.setCurrentPricing(curPrice);
                    list.add(bean);
                }
            }
            
            System.out.println("Trap 3a getProductSetListForSales " );
            
            if(!list.isEmpty())
                beans = (ProductBean[])list.toArray(new ProductBean[0]);
            
            
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_154;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return beans;
    }

    public ProductBean getProductSetPricingBySkuCode(String skuCode, String priceCodeID, Date effectiveDate, String locale)
        throws MvcException
    {
        Connection conn;
        ProductBean bean;
        conn = null;
        bean = new ProductBean();
        try
        {
            conn = getConnection();
            bean = getProductSetBySkuCode(skuCode, locale);
            ProductPricingManager mgr = new ProductPricingManager(conn);
            // com.ecosmosis.orca.pricing.product.ProductPricingBean curPrice = mgr.getCurrentPricing(bean.getProductID(), priceCodeID, effectiveDate);
            com.ecosmosis.orca.pricing.product.ProductPricingBean curPrice = mgr.getCurrentPricing(bean.getProductCode(), priceCodeID, effectiveDate);
            if(curPrice != null)
                bean.setCurrentPricing(curPrice);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        /*
        break MISSING_BLOCK_LABEL_96;
        Exception exception;
        exception;
        releaseConnection(conn);
        throw exception;
        */
        releaseConnection(conn);
        return bean;
    }

    public ProductBean getIdProduct(String productID)
        throws MvcException
    {
        ProductBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try
        {
            conn = getConnection();
            bean = getBroker(conn).getIdProduct(productID);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }

}
