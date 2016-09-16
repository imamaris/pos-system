// Decompiled by Yody
// File : InventoryManager.class

package com.ecosmosis.orca.inventory;

import com.ecosmosis.common.customlibs.FIFOMap;
import com.ecosmosis.mvc.accesscontrol.user.LoginUserBean;
import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.mvc.manager.DBTransactionManager;
import com.ecosmosis.mvc.manager.MvcReturnBean;
import com.ecosmosis.mvc.sys.Sys;
import com.ecosmosis.orca.bonus.bonusperiod.BonusPeriodManager;
import com.ecosmosis.orca.document.DocumentFactory;
import com.ecosmosis.orca.document.DocumentInterface;
import com.ecosmosis.orca.member.MemberBean;
import com.ecosmosis.orca.member.MemberManager;
import com.ecosmosis.orca.outlet.OutletBean;
import com.ecosmosis.orca.outlet.OutletManager;
import com.ecosmosis.orca.outlet.store.OutletStoreBean;
import com.ecosmosis.orca.outlet.store.OutletStoreManager;
import com.ecosmosis.orca.product.ProductBean;
import com.ecosmosis.orca.product.ProductManager;
import com.ecosmosis.orca.product.category.ProductCategoryBean;
import com.ecosmosis.orca.stockist.StockistBean;
import com.ecosmosis.orca.stockist.StockistManager;
import com.ecosmosis.orca.supplier.SupplierBean;
import com.ecosmosis.orca.supplier.SupplierManager;
import com.ecosmosis.util.log.Log;
import java.sql.Connection;
import java.util.*;
import javax.servlet.http.HttpServletRequest;

// Referenced classes of package com.ecosmosis.orca.inventory:
//            InventoryBroker, InventoryBean

public class InventoryManager extends DBTransactionManager {
    
    public static final int TASKID_STOCK_PRE_PURCHASE = 0x18e79;
    public static final int TASKID_STOCK_PURCHASE = 0x18e7a;
    public static final int TASKID_STOCK_PURCHASE_INFO = 0x18e7b;
    public static final int TASKID_STOCK_PURCHASE_HISTORY = 0x18e7c;
    public static final int TASKID_STOCK_PRE_RETURN = 0x18e7d;
    public static final int TASKID_STOCK_RETURN = 0x18e7e;
    public static final int TASKID_STOCK_RETURN_INFO = 0x18e7f;
    public static final int TASKID_STOCK_RETURN_HISTORY = 0x18e80;
    public static final int TASKID_STOCK_PRE_DISCREPANCY = 0x18e81;
    public static final int TASKID_STOCK_DISCREPANCY = 0x18e82;
    public static final int TASKID_STOCK_DISCREPANCY_INFO = 0x18e83;
    public static final int TASKID_STOCK_DISCREPANCY_HISTORY = 0x18e84;
    public static final int TASKID_STOCK_PRE_COMPLIMENT = 0x18e85;
    public static final int TASKID_STOCK_COMPLIMENT = 0x18e86;
    public static final int TASKID_STOCK_COMPLIMENT_INFO = 0x18e87;
    public static final int TASKID_STOCK_COMPLIMENT_HISTORY = 0x18e88;
    public static final int TASKID_STOCK_PRE_LOANOUT = 0x18e89;
    public static final int TASKID_STOCK_LOANOUT = 0x18e8a;
    public static final int TASKID_STOCK_LOANOUT_INFO = 0x18e8b;
    public static final int TASKID_STOCK_LOANOUT_HISTORY = 0x18e8c;
    public static final int TASKID_STOCK_PRE_LOANRETURN = 0x18e8d;
    public static final int TASKID_STOCK_LOANRETURN = 0x18e8e;
    public static final int TASKID_STOCK_LOANRETURN_INFO = 0x18e8f;
    public static final int TASKID_STOCK_LOANRETURN_HISTORY = 0x18e90;
    public static final int TASKID_STOCK_PRE_ABOLISH = 0x18e91;
    public static final int TASKID_STOCK_ABOLISH = 0x18e92;
    public static final int TASKID_STOCK_ABOLISH_INFO = 0x18e93;
    public static final int TASKID_STOCK_ABOLISH_HISTORY = 0x18e94;
    
    public static final int TASKID_STOCK_PRE_TRANSFER_INTERNAL = 0x18e95;
    public static final int TASKID_STOCK_PRE_TRANSFER_INTERNAL_2 = 0x18e9c;
    
    public static final int TASKID_STOCK_TRANSFER_INTERNAL = 0x18e96;
    public static final int TASKID_STOCK_TRANSFER_INTERNAL_2 = 0x18e9d;
    
    public static final int TASKID_STOCK_TRANSFER_INTERNAL_INFO = 0x18e97;
    public static final int TASKID_STOCK_TRANSFER_INTERNAL_INFO_2 = 0x18e9e;
    
    public static final int TASKID_STOCK_TRANSFER_INTERNAL_HISTORY = 0x18e98;
    public static final int TASKID_STOCK_PRE_TRANSFER_EXTERNAL = 0x18e99;
    public static final int TASKID_STOCK_TRANSFER_EXTERNAL = 0x18e9a;
    public static final int TASKID_STOCK_TRANSFER_EXTERNAL_INFO = 0x18e9b;
    
    public static final int TASKID_STOCK_TRANSFER_EXTERNAL_TW = 0x18ea4;
    public static final int TASKID_STOCK_TRANSFER_EXTERNAL_TW_INFO = 0x18ea5;
    
    public static final int TASKID_STOCK_TRANSFER_EXTERNAL_INFO_TW = 0x18e9f;
    public static final int TASKID_STOCK_TRANSFER_EXTERNAL_INFO_TW_SUBMIT = 0x18ea1;
    public static final int TASKID_STOCK_TRANSFER_EXTERNAL_INFO_TW_IN_SUBMIT = 0x18ea2;
    
    public static final int TASKID_STOCK_PRE_TRANSFER_EXTERNAL_LOAN = 0x18ea7;
    public static final int TASKID_STOCK_TRANSFER_EXTERNAL_LOAN = 0x18ea8;
    public static final int TASKID_STOCK_TRANSFER_EXTERNAL_LOAN_INFO = 0x18ea9;     
    public static final int TASKID_STOCK_TRANSFER_EXTERNAL_INFO_LOAN_SUBMIT = 0x18eaa;
    
    public static final int TASKID_STOCK_PRE_TRANSFER_EXTERNAL_LOAN_IN = 0x18eac;
    public static final int TASKID_STOCK_TRANSFER_EXTERNAL_LOAN_IN = 0x18ead;
    public static final int TASKID_STOCK_TRANSFER_EXTERNAL_LOAN_IN_INFO = 0x18eae;     
    public static final int TASKID_STOCK_TRANSFER_EXTERNAL_INFO_LOAN_IN_SUBMIT = 0x18eaf;    
    
    public static final int TASKID_STOCK_TRANSFER_EXTERNAL_HISTORY = 0x18e9c;
    public static final int TASKID_STOCK_PRE_DISCREPANCY_INV = 0x191ae;
    public static final int TASKID_STOCK_DISCREPANCY_INV = 0x191af;
    public static final int TASKID_STOCK_DISCREPANCY_INFO_INV = 0x191b0;
    public static final int TASKID_STOCK_DISCREPANCY_HISTORY_INV = 0x191b1;
    public static final String TRXTYPE_STOCK_IN = "SKI";
    public static final String TRXTYPE_STOCK_OUT = "SKO";
    public static final String TRXTYPE_STOCKDISCREPANCY_IN = "SKDI";
    public static final String TRXTYPE_STOCKDISCREPANCY_OUT = "SKDO";
    public static final String TRXTYPE_STOCKPURC_IN = "SKPI";
    public static final String TRXTYPE_STOCKPURC_OUT = "SKPO";
    public static final String TRXTYPE_STOCKLOAN_IN = "SKLI";
    public static final String TRXTYPE_STOCKLOAN_OUT = "SKLO";
    public static final String TRXTYPE_STOCKABOLISH_OUT = "SKBO";
    public static final String TRXTYPE_STOCKCOMPL_OUT = "SKCO";
    public static final String TRXTYPE_STOCKTRANS_INT_OUT = "STIO";
    public static final String TRXTYPE_STOCKTRANS_INT_IN = "STII";
    public static final String TRXTYPE_STOCKTRANS_EXT_OUT = "STEO";
    public static final String TRXTYPE_STOCKTRANS_EXT_IN = "STEI";
    
    // Update for Alocate
    public static final String TRXTYPE_STOCKTRANS_ALLOCATION_OUT = "STAO";
    public static final String TRXTYPE_STOCKTRANS_ALLOCATION_IN = "STAI";
    
    public static final int STAT_NORMAL = 100;
    public static final int STAT_ALLOCATE = 90;
    
    public static final String RETURN_SELLERLIST_CODE = "SellerList";
    
    private InventoryBroker broker;
    
    public InventoryManager() {
        broker = null;
    }
    
    public InventoryManager(Connection _con) {
        super(_con);
        broker = null;
    }
    
    private InventoryBroker getBroker(Connection conn) {
        if(broker == null)
            broker = new InventoryBroker(conn);
        else
            broker.setConnection(conn);
        return broker;
    }
    
    public MvcReturnBean performTask(int taskId, HttpServletRequest request, LoginUserBean loginuser) {     
        
        MvcReturnBean returnBean;
        setLoginUser(loginuser);
        returnBean = null;
        
        try {
            switch(taskId) {
                
                default:
                    break;
                    
                case 102009:
                case 102013:
                case 102017:
                case 102021:
                case 102025:
                case 102029:
                case 102033:
                case 102037:
                case 102830:
                case 102044:
                {
                    String id = null;
                    String docno = null;
                    returnBean = new MvcReturnBean();
                    OutletStoreBean storeBeans[] = (OutletStoreBean[])null;
                    
                    if(taskId != 0x191ae) {
                        if(request.getParameter("id") != null && request.getParameter("id").length() > 0)
                            id = request.getParameter("id");
                        else
                            id = getLoginUser().getOutletID();
                    } else {
                        String stockistID = request.getParameter("StockistID");
                        if(stockistID != null && stockistID.length() > 0) {
                            StockistManager stockistManager = new StockistManager();
                            stockistID = stockistManager.filterStockistID(stockistID);
                            StockistBean stockist = stockistManager.getStockist(null, stockistID, null);
                            if(stockist != null && (stockist.getType().equalsIgnoreCase("F") || stockist.getType().equalsIgnoreCase("S")))
                                id = stockistID;
                        }
                    }
                    
                    if(id != null) {
                        
                        // tambahan
                        
                        InventoryBean inventoryBean = null;
                        inventoryBean = new InventoryBean();
                        
                        InventoryBean inventoryBeans[] = (InventoryBean[])null;
                        
                        OutletManager outletManager = new OutletManager();
                        OutletStoreManager storeManager = new OutletStoreManager();
                        OutletStoreBean storeBean = null;
                        OutletStoreBean _storeBeans[] = (OutletStoreBean[])null;
                        OutletBean outletBean = outletManager.getRecord(id);
                        if(outletBean != null)
                            if(taskId == 0x18e79 || taskId == 0x18e9c)
                                id = outletBean.getWarehouseStoreCode();
                            else
                                if(taskId == 0x18e7d || taskId == 0x18e91)
                                    id = outletBean.getWriteoffStoreCode();
                                else
                                    // if(taskId == 0x18e81 || taskId == 0x18e95 || taskId == 0x18e9c ||taskId == 0x18e99)
                                    if(taskId == 0x18e81 || taskId == 0x18e95 ||taskId == 0x18e99) {
                            _storeBeans = storeManager.getStoreListByOutlet(outletBean.getOutletID());
                            if(_storeBeans != null && _storeBeans.length > 0)
                                id = _storeBeans[0].getStoreID();
                                    } else
                                        if(taskId == 0x18e85)
                                            id = outletBean.getSalesStoreCode();
                                        else
                                            if(taskId == 0x18e89 || taskId == 0x18e8d)
                                                id = outletBean.getWarehouseStoreCode();
                                            else
                                                id = outletBean.getWarehouseStoreCode();
                        OutletStoreBean _storeBean = storeManager.getOutletStore(id);
                        
                        if(_storeBean != null) {
                            storeBean = new OutletStoreBean();
                            storeBean = _storeBean;
                            if(outletBean == null)
                                outletBean = outletManager.getRecord(_storeBean.getOutletID());
                            if(taskId == 0x18e79 || taskId == 0x18e7d || taskId == 0x18e91) {
                                storeBeans = new OutletStoreBean[1];
                                storeBeans[0] = storeBean;
                            } else
                                if(taskId == 0x18e81 || taskId == 0x18e95 || taskId == 0x18e99 || taskId == 0x18e9c || taskId == 0x191ae)
                                    // if(taskId == 0x18e81 || taskId == 0x18e95 || taskId == 0x18e99 || taskId == 0x191ae)
                                    storeBeans = storeManager.getStoreListByOutlet(outletBean.getOutletID());
                                else
                                    if(taskId == 0x18e85 || taskId == 0x18e89 || taskId == 0x18e8d)
                                        storeBeans = storeManager.getStoreListByOutletStoreType(outletBean.getOutletID(), new String[] {
                                            "w", "s"
                                        });
                        }
                        
                        if(taskId == 0x18e9c) {
                            
                            inventoryBeans = new InventoryBean[1];
                            inventoryBeans[0] = inventoryBean;
                            
                            InventoryManager inventoryManager = new InventoryManager();
                            inventoryBeans = inventoryManager.getInventoryListByDoc(outletBean.getWarehouseStoreCode());
                            InventoryBean invenBean = inventoryManager.getRecordsByDocNum(id);
                            
                            System.out.println("Chek docno 0 " + docno);
                            
                            if(request.getParameter("docno") != null && request.getParameter("docno").length() > 0)
                                docno = request.getParameter("docno");
                            else
                                docno = invenBean.getTrnxDocNo();
                            
                            System.out.println("Chek docno 1 " + docno);
                        }
                        
                        
                        if(storeBean != null && taskId != 0x18e9c) {
                            InventoryBean beans[] = getStoreInventory(getLoginUser().getLocale(), id);
                            SupplierBean supplierBeans[] = (new SupplierManager()).getSupplierListForGeneral();
                            
                            if(beans == null)
                                returnBean.fail();
                            else
                                
                                returnBean.done();
                            returnBean.addReturnObject("ID", id);
                            returnBean.addReturnObject("Store", storeBean);
                            returnBean.addReturnObject("Stores", getStoreCodeOnlyList(storeBeans, false));
                            returnBean.addReturnObject("StoresTo", getStoreCodeOnlyList(storeBeans, storeBean, false));
                            returnBean.addReturnObject("Outlet", outletBean);
                            returnBean.addReturnObject("InventoryBeans", beans);
                            if(taskId == 0x18e79 || taskId == 0x18e7d)
                                returnBean.addReturnObject("Suppliers", getSupplierNameOnlyList(supplierBeans, true));
                        } else
                            
                            if(storeBean != null && taskId == 0x18e9c) {
                            System.out.println("Chek docno 2" + docno);
                            InventoryBean beans[] = getStoreInventory2(getLoginUser().getLocale(), id, docno);
                            
                            SupplierBean supplierBeans[] = (new SupplierManager()).getSupplierListForGeneral();
                            
                            if(beans == null)
                                returnBean.fail();
                            else
                                
                            returnBean.done();
                            returnBean.addReturnObject("ID", id);
                            returnBean.addReturnObject("DOCNO", docno);
                            
                            System.out.println("Chek docno 4 " + docno);
                            
                            returnBean.addReturnObject("Store", storeBean);
                            returnBean.addReturnObject("Stores", getStoreCodeOnlyList(storeBeans, false));
                            
                            returnBean.addReturnObject("Inventory", inventoryBean);
                            returnBean.addReturnObject("Inventorys", getInventoryCodeOnlyList(inventoryBeans, false));
                            
                            System.out.println("Chek docno 5 " + inventoryBean);
                            System.out.println("Chek docno 6 " + getInventoryCodeOnlyList(inventoryBeans, false));
                            
                            returnBean.addReturnObject("StoresTo", getStoreCodeOnlyList(storeBeans, storeBean, false));
                            returnBean.addReturnObject("Outlet", outletBean);
                            returnBean.addReturnObject("InventoryBeans", beans);
                            
                            } else
                                
                            {
                            returnBean.fail();
                            }
                    } else {
                        returnBean.fail();
                    }
                    returnBean.addReturnObject("TaskID", Integer.valueOf(taskId));
                    break;
                }
                
                case 102010:
                {
                    String storeCode;
                    String supplierCode;
                    String remark;
                    String productIDs[];
                    String ins[] = null;
                    ArrayList list;
                    OutletBean outletBean = null;
                    int i;
                    returnBean = new MvcReturnBean();
                    storeCode = request.getParameter("storeCode");
                    storeCode = storeCode == null || storeCode.length() != 0 ? storeCode : null;
                    supplierCode = request.getParameter("supplierCode");
                    remark = request.getParameter("Remark");
                    productIDs = request.getParameterValues("product_id");
                    ins = request.getParameterValues("qty_in");
                    list = new ArrayList();
                    OutletStoreBean _storeBean = (new OutletStoreManager()).getOutletStore(storeCode);
                    outletBean = (new OutletManager()).getRecord(_storeBean.getOutletID());
                    
                    for(i = 0; i < productIDs.length; i++) {
                        int qty_in = 0;
                        if(ins[i].length() > 0) {
                            // if(ins[i].length() > 0)
                            qty_in = Integer.parseInt(ins[i]);
                            if(qty_in > 0) {
                                InventoryBean inventoryBean = new InventoryBean();
                                inventoryBean.setTrnxType("SKPI");
                                inventoryBean.setTotalIn(qty_in);
                                inventoryBean.setOwnerType(outletBean.getType());
                                inventoryBean.setOwnerID(outletBean.getOutletID());
                                inventoryBean.setStoreCode(storeCode);
                                inventoryBean.setTarget(supplierCode);
                                inventoryBean.setProductID(Integer.parseInt(productIDs[i]));
                                inventoryBean.setProductType(0);
                                inventoryBean.setRemark(remark);
                                inventoryBean.setStatus(100);
                                inventoryBean.setTrnxDate(new Date());
                                inventoryBean.setTrnxTime(new Date());
                                inventoryBean.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                                list.add(inventoryBean);
                            }
                            
                        }
                    }
                    
                    String refNo = addRecord(list, "SPN");
                    if(refNo != null) {
                        returnBean.addReturnObject("RefNo", refNo);
                        returnBean.addReturnObject("Outlet", outletBean);
                        returnBean.done();
                    } else {
                        returnBean.fail();
                    }
                    break;
                }
                
                case 102011:
                case 102015:
                case 102019:
                case 102023:
                case 102027:
                case 102031:
                case 102035:
                case 102039:
                case 102043:
                    
                case 102053:
                    
                    // TW
                case 102047:
                case 102048:
                    
                case 102832:
                case 102046:
                {
                    returnBean = new MvcReturnBean();
                    MvcReturnBean _returnBean = (MvcReturnBean)request.getAttribute("MvcReturnBean");
                    String refNo = null;
                    OutletBean outletBean1 = null;
                    OutletBean outletToBean = null;
                    if(_returnBean != null) {
                        refNo = (String)_returnBean.getReturnObject("RefNo");
                        outletBean1 = (OutletBean)_returnBean.getReturnObject("Outlet");
                        outletToBean = (OutletBean)_returnBean.getReturnObject("OutletTo");
                    } else {
                        refNo = request.getParameter("RefNo");
                    }
                    
                    String docType = null;
                    if(taskId == 0x18e97 || taskId == 0x18e9e)
                        docType = "STIO";
                    
                    else if(taskId == 0x18e9b)
                        docType = "STEO";
                    
                    else if(taskId == 0x18ea5)
                        docType = "STAO";
                    
                    else if(taskId == 0x18e8b)
                        docType = "SKLO";
                    
                    else if(taskId == 0x18e9f) // 102047
                        docType = "STAO";
                    else
                        docType = "STAI";
                    
                    System.out.println("Check docType :"+docType);
                    
                    InventoryBean inventoryBeans[] = getRecordsByDocNum(refNo, docType, null, getLoginUser().getLocale().toString());
                    
                    InventoryBean bean = inventoryBeans[0];
                    if(outletBean1 == null)
                        outletBean1 = (new OutletManager()).getRecord(bean.getOwnerID());
                    if(outletToBean == null) {
                        OutletStoreBean _bean = (new OutletStoreManager()).getOutletStore(bean.getTarget());
                        if(_bean != null)
                            outletToBean = (new OutletManager()).getRecord(_bean.getOutletID());
                    }
                    if(taskId == 0x18e7b || taskId == 0x18e7f) {
                        SupplierBean supplier = (new SupplierManager()).getSupplier(bean.getTarget());
                        returnBean.addReturnObject("Supplier", supplier);
                    } else
                        if(taskId == 0x18e97 || taskId == 0x18e9e || taskId == 0x18e9b || taskId == 0x18e9f  || taskId == 0x18e8b )
                            returnBean.addReturnObject("Target", bean.getTarget());
                    returnBean.addReturnObject("Outlet", outletBean1);
                    if(outletToBean != null)
                        returnBean.addReturnObject("OutletTo", outletToBean);
                    returnBean.addReturnObject("InventoryBean", bean);
                    returnBean.addReturnObject("InventoryBeans", inventoryBeans);
                    returnBean.done();
                    break;
                }

                case 102057: 
                case 102062:     
                {
                    returnBean = new MvcReturnBean();
                    MvcReturnBean _returnBean = (MvcReturnBean)request.getAttribute("MvcReturnBean");
                    String refNo = null;
                    OutletBean outletBean1 = null;
                    OutletBean outletToBean = null;
                    if(_returnBean != null) {
                        refNo = (String)_returnBean.getReturnObject("RefNo");
                        outletBean1 = (OutletBean)_returnBean.getReturnObject("Outlet");
                        outletToBean = (OutletBean)_returnBean.getReturnObject("OutletTo");
                    } else {
                        refNo = request.getParameter("RefNo");
                    }
                    
                    String docType = null;
                    if(taskId == 0x18ea9)
                       docType = "SKLO";

                    if(taskId == 0x18eae)
                       docType = "SKLI";
                    
                    System.out.println("Check docType :"+docType);
                    
                    InventoryBean inventoryBeans[] = getRecordsByDocNum(refNo, docType, null, getLoginUser().getLocale().toString());
                    
                    InventoryBean bean = inventoryBeans[0];
                    if(outletBean1 == null)
                        outletBean1 = (new OutletManager()).getRecord(bean.getOwnerID());
                    if(outletToBean == null) {
                        OutletStoreBean _bean = (new OutletStoreManager()).getOutletStore(bean.getTarget());
                        if(_bean != null)
                            outletToBean = (new OutletManager()).getRecord(_bean.getOutletID());
                    }
                    
                    returnBean.addReturnObject("Outlet", outletBean1);
                    if(outletToBean != null)
                        returnBean.addReturnObject("OutletTo", outletToBean);
                    returnBean.addReturnObject("InventoryBean", bean);
                    returnBean.addReturnObject("InventoryBeans", inventoryBeans);
                    returnBean.done();
                    break;
                }
                
                /*
                case 102043:
                {
                    returnBean = new MvcReturnBean();
                    MvcReturnBean _returnBean = (MvcReturnBean)request.getAttribute("MvcReturnBean");
                    String refNo = null;
                    OutletBean outletBean1 = null;
                    OutletBean outletToBean = null;
                    if(_returnBean != null) {
                        refNo = (String)_returnBean.getReturnObject("RefNo");
                        outletBean1 = (OutletBean)_returnBean.getReturnObject("Outlet");
                        outletToBean = (OutletBean)_returnBean.getReturnObject("OutletTo");
                    } else {
                        refNo = request.getParameter("RefNo");
                    }
                 
                    String docType1 = null;
                    String docType2 = null;
                 
                    if(taskId == 0x18e9b)
                    {
                        docType1 = "STEO";
                        docType2 = "STEI";
                    }
                 
                    InventoryBean inventoryBeans[] = getRecordsByDocNumTW(refNo, docType1, docType2, null, getLoginUser().getLocale().toString());
                 
                    InventoryBean bean = inventoryBeans[0];
                    if(outletBean1 == null)
                        outletBean1 = (new OutletManager()).getRecord(bean.getOwnerID());
                    if(outletToBean == null) {
                        OutletStoreBean _bean = (new OutletStoreManager()).getOutletStore(bean.getTarget());
                        if(_bean != null)
                            outletToBean = (new OutletManager()).getRecord(_bean.getOutletID());
                    }
                    if(taskId == 0x18e7b || taskId == 0x18e7f) {
                        SupplierBean supplier = (new SupplierManager()).getSupplier(bean.getTarget());
                        returnBean.addReturnObject("Supplier", supplier);
                    } else
                        if(taskId == 0x18e97 || taskId == 0x18e9e || taskId == 0x18e9b || taskId == 0x18e9f  )
                            returnBean.addReturnObject("Target", bean.getTarget());
                    returnBean.addReturnObject("Outlet", outletBean1);
                    if(outletToBean != null)
                        returnBean.addReturnObject("OutletTo", outletToBean);
                    returnBean.addReturnObject("InventoryBean", bean);
                    returnBean.addReturnObject("InventoryBeans", inventoryBeans);
                    returnBean.done();
                    break;
                }
                 */
                
                
                /*
                case 102048:
                {
                    returnBean = new MvcReturnBean();
                    MvcReturnBean _returnBean = (MvcReturnBean)request.getAttribute("MvcReturnBean");
                    String refNo = null;
                    Object bean2 = null;
                    // InventoryBean inventoryBeans2 = null;
                    String inventoryBeans2[] = null;
                 
                    OutletBean outletBean1 = null;
                    OutletBean outletToBean = null;
                    if(_returnBean != null) {
                        refNo = (String)_returnBean.getReturnObject("RefNo");
                        outletBean1 = (OutletBean)_returnBean.getReturnObject("Outlet");
                        outletToBean = (OutletBean)_returnBean.getReturnObject("OutletTo");
                    } else {
                        refNo = request.getParameter("RefNo");
                    }
                 
                    String docType = null;
                    docType = "STAI";
                 
                    System.out.println("Check docType :"+docType);
                 
                    InventoryBean inventoryBeans[] = getRecordsByDocNum(refNo, docType, null, getLoginUser().getLocale().toString());
                    InventoryBean bean = inventoryBeans[0];
                 
                    if(bean == null)
                    {
                        docType = "STEI";
                        inventoryBeans2[] = getRecordsByDocNum(refNo, docType, null, getLoginUser().getLocale().toString() );
                        bean2 = inventoryBeans2[0];
                    }
                 
                    if(outletBean1 == null)
                        outletBean1 = (new OutletManager()).getRecord(bean.getOwnerID());
                    if(outletToBean == null) {
                        OutletStoreBean _bean = (new OutletStoreManager()).getOutletStore(bean.getTarget());
                        if(_bean != null)
                            outletToBean = (new OutletManager()).getRecord(_bean.getOutletID());
                    }
                    if(taskId == 0x18e7b || taskId == 0x18e7f) {
                        SupplierBean supplier = (new SupplierManager()).getSupplier(bean.getTarget());
                        returnBean.addReturnObject("Supplier", supplier);
                    } else
                        if(taskId == 0x18e97 || taskId == 0x18e9e || taskId == 0x18e9b || taskId == 0x18e9f  )
                            returnBean.addReturnObject("Target", bean.getTarget());
                    returnBean.addReturnObject("Outlet", outletBean1);
                    if(outletToBean != null)
                        returnBean.addReturnObject("OutletTo", outletToBean);
                    returnBean.addReturnObject("InventoryBean", (bean == null ? bean2 : bean ));
                    returnBean.addReturnObject("InventoryBeans",(inventoryBeans == null ? inventoryBeans2 : inventoryBeans));
                    returnBean.done();
                    break;
                }
                 */
                
                
                // AWAL TW, 18EA1, 18EA2
                /*
                case 102049:
                case 102050:
                {
                    returnBean = new MvcReturnBean();
                    MvcReturnBean _returnBean = (MvcReturnBean)request.getAttribute("MvcReturnBean");                    
                    String refNo = null;
                    String docType = null;
                    
                    boolean status;
                    ProductManager productMgr = new ProductManager();
                    OutletBean outletBean1 = null;
                    OutletBean outletToBean = null;
                    if(_returnBean != null) {
                        refNo = (String)_returnBean.getReturnObject("RefNo");
                        outletBean1 = (OutletBean)_returnBean.getReturnObject("Outlet");
                        outletToBean = (OutletBean)_returnBean.getReturnObject("OutletTo");
                    } else {
                        refNo = request.getParameter("RefNo");
                    }
                    
                    if(taskId == 0x18ea1)
                        docType = "STAO";
                    else
                        docType = "STAI";
                    
                    InventoryBean inventoryBeans[] = getRecordsByDocNum(refNo, docType, null, getLoginUser().getLocale().toString());
                    InventoryBean bean = inventoryBeans[0];
                    
                    // pengecekan Qty ketika Verify OUT
                    if(bean.getTrnxType().equalsIgnoreCase("STAO") && bean.getStatus()==90) {
                        
                        for(int i = 0; i < inventoryBeans.length; i++) {
                            int balance = getProductBalance(inventoryBeans[i].getProductID(), null, inventoryBeans[i].getStoreCode());
                            if(inventoryBeans[i].getTotalOut() > balance) {
                                returnBean.fail();
                                returnBean.setSysError("Selected product  not enough quantity in the inventory, please checked it on Inventory Report. Failed to procceed. Serial Number : "+productMgr.getProduct(inventoryBeans[i].getProductID()).getSkuCode()+ " Stock Balance :"+balance);
                                return returnBean;
                            }
                        }
                        
                    }
                    
                    status = updateTW(bean.getTrnxDocNo(), bean.getStatus(), bean.getTrnxType(), loginuser.getUserId());
                    
                    
                    if(bean.getTrnxType().equalsIgnoreCase("STAO") && bean.getStatus()==90) {
                        docType = "STAO";
                    }
                    
                    if(bean.getTrnxType().equalsIgnoreCase("STAI") && bean.getStatus()==100) {
                        docType = "STEI";
                    }
                    
                    
                    InventoryBean inventoryBeans2[] = getRecordsByDocNum(refNo, docType, null, getLoginUser().getLocale().toString());
                    InventoryBean bean2 = inventoryBeans2[0];
                    
                    if(outletBean1 == null)
                        outletBean1 = (new OutletManager()).getRecord(bean.getOwnerID());
                    if(outletToBean == null) {
                        OutletStoreBean _bean = (new OutletStoreManager()).getOutletStore(bean.getTarget());
                        if(_bean != null)
                            outletToBean = (new OutletManager()).getRecord(_bean.getOutletID());
                    }
                    if(taskId == 0x18e7b || taskId == 0x18e7f) {
                        SupplierBean supplier = (new SupplierManager()).getSupplier(bean.getTarget());
                        returnBean.addReturnObject("Supplier", supplier);
                    } else
                        if(taskId == 0x18e97 || taskId == 0x18e9e || taskId == 0x18e9b || taskId == 0x18e9f  )
                            returnBean.addReturnObject("Target", bean.getTarget());
                    returnBean.addReturnObject("Outlet", outletBean1);
                    if(outletToBean != null)
                        returnBean.addReturnObject("OutletTo", outletToBean);
                    returnBean.addReturnObject("InventoryBean", bean2);
                    returnBean.addReturnObject("InventoryBeans", inventoryBeans2);
                    returnBean.done();
                    break;  
                    
                }
                */
                   
                // verify OUT, 18EA1
                case 102049:
                {
                    returnBean = new MvcReturnBean();
                    MvcReturnBean _returnBean = (MvcReturnBean)request.getAttribute("MvcReturnBean");                    
                    String refNo = null;
                    String docType = null;
                    
                    boolean status;
                    ProductManager productMgr = new ProductManager();
                    OutletBean outletBean1 = null;
                    OutletBean outletToBean = null;
                    if(_returnBean != null) {
                        refNo = (String)_returnBean.getReturnObject("RefNo");
                        outletBean1 = (OutletBean)_returnBean.getReturnObject("Outlet");
                        outletToBean = (OutletBean)_returnBean.getReturnObject("OutletTo");
                    } else {
                        refNo = request.getParameter("RefNo");
                    }
                    
                    docType = "STAO";
                    
                    InventoryBean inventoryBeans[] = getRecordsByDocNum(refNo, docType, null, getLoginUser().getLocale().toString());
                    InventoryBean bean = inventoryBeans[0];
                    
                    // pengecekan Qty ketika Verify OUT
                    if(bean.getTrnxType().equalsIgnoreCase("STAO") && bean.getStatus()==90) {
                        
                        for(int i = 0; i < inventoryBeans.length; i++) {
                            int balance = getProductBalance(inventoryBeans[i].getProductID(), null, inventoryBeans[i].getStoreCode());
                            if(inventoryBeans[i].getTotalOut() > balance) {
                                returnBean.fail();
                                returnBean.setSysError("Selected product  not enough quantity in the inventory, please checked it on Inventory Report. Failed to procceed. Serial Number : "+productMgr.getProduct(inventoryBeans[i].getProductID()).getSkuCode()+ " Stock Balance :"+balance);
                                return returnBean;
                            }
                        }
                        
                    }
                    
                    status = updateTW(bean.getTrnxDocNo(), bean.getStatus(), bean.getTrnxType(), loginuser.getUserId());
                    
                    
                    if(bean.getTrnxType().equalsIgnoreCase("STAO") && bean.getStatus()==90) {
                        docType = "STAO";
                    }
                    
                    if(bean.getTrnxType().equalsIgnoreCase("STAI") && bean.getStatus()==100) {
                        docType = "STEI";
                    }
                    
                    
                    InventoryBean inventoryBeans2[] = getRecordsByDocNum(refNo, docType, null, getLoginUser().getLocale().toString());
                    InventoryBean bean2 = inventoryBeans2[0];
                    
                    if(outletBean1 == null)
                        outletBean1 = (new OutletManager()).getRecord(bean.getOwnerID());
                    if(outletToBean == null) {
                        OutletStoreBean _bean = (new OutletStoreManager()).getOutletStore(bean.getTarget());
                        if(_bean != null)
                            outletToBean = (new OutletManager()).getRecord(_bean.getOutletID());
                    }
                    if(taskId == 0x18e7b || taskId == 0x18e7f) {
                        SupplierBean supplier = (new SupplierManager()).getSupplier(bean.getTarget());
                        returnBean.addReturnObject("Supplier", supplier);
                    } else
                        if(taskId == 0x18e97 || taskId == 0x18e9e || taskId == 0x18e9b || taskId == 0x18e9f  )
                            returnBean.addReturnObject("Target", bean.getTarget());
                    returnBean.addReturnObject("Outlet", outletBean1);
                    if(outletToBean != null)
                        returnBean.addReturnObject("OutletTo", outletToBean);
                    returnBean.addReturnObject("InventoryBean", bean2);
                    returnBean.addReturnObject("InventoryBeans", inventoryBeans2);
                    returnBean.done();
                    break;   
                }

                // verify LOAN OUT, 18eaa
                case 102058:
                {
                    returnBean = new MvcReturnBean();
                    MvcReturnBean _returnBean = (MvcReturnBean)request.getAttribute("MvcReturnBean");                    
                    String refNo = null;
                    String docType = null;
                    
                    boolean status;
                    ProductManager productMgr = new ProductManager();
                    OutletBean outletBean1 = null;
                    OutletBean outletToBean = null;
                    if(_returnBean != null) {
                        refNo = (String)_returnBean.getReturnObject("RefNo");
                        outletBean1 = (OutletBean)_returnBean.getReturnObject("Outlet");
                        outletToBean = (OutletBean)_returnBean.getReturnObject("OutletTo");
                    } else {
                        refNo = request.getParameter("RefNo");
                    }
                    
                    docType = "SKLO";
                    
                    InventoryBean inventoryBeans[] = getRecordsByDocNum(refNo, docType, null, getLoginUser().getLocale().toString());
                    InventoryBean bean = inventoryBeans[0];
                    
                    // pengecekan Qty ketika Verify OUT
                    if(bean.getTrnxType().equalsIgnoreCase("SKLO") && bean.getStatus()==90) {
                        
                        for(int i = 0; i < inventoryBeans.length; i++) {
                            int balance = getProductBalance(inventoryBeans[i].getProductID(), null, inventoryBeans[i].getStoreCode());
                            if(inventoryBeans[i].getTotalOut() > balance) {
                                returnBean.fail();
                                returnBean.setSysError("Selected product  not enough quantity in the inventory, please checked it on Inventory Report. Failed to procceed. Serial Number : "+productMgr.getProduct(inventoryBeans[i].getProductID()).getSkuCode()+ " Stock Balance :"+balance);
                                return returnBean;
                            }
                        }
                        
                    }
                    
                    status = updateLOAN(bean.getTrnxDocNo(), bean.getStatus(), bean.getTrnxType(), loginuser.getUserId());
                    
                    
                    if(bean.getTrnxType().equalsIgnoreCase("SKLO"))
                        docType = "SKLO";
                    
                    InventoryBean inventoryBeans2[] = getRecordsByDocNum(refNo, docType, null, getLoginUser().getLocale().toString());
                    InventoryBean bean2 = inventoryBeans2[0];
                    
                    if(outletBean1 == null)
                        outletBean1 = (new OutletManager()).getRecord(bean.getOwnerID());
                    if(outletToBean == null) {
                        OutletStoreBean _bean = (new OutletStoreManager()).getOutletStore(bean.getTarget());
                        if(_bean != null)
                            outletToBean = (new OutletManager()).getRecord(_bean.getOutletID());
                    }
                    if(taskId == 0x18e7b || taskId == 0x18e7f) {
                        SupplierBean supplier = (new SupplierManager()).getSupplier(bean.getTarget());
                        returnBean.addReturnObject("Supplier", supplier);
                    } else
                        if(taskId == 0x18e97 || taskId == 0x18e9e || taskId == 0x18e9b || taskId == 0x18e9f  || taskId == 0x18e8b )
                            returnBean.addReturnObject("Target", bean.getTarget());
                    returnBean.addReturnObject("Outlet", outletBean1);
                    if(outletToBean != null)
                        returnBean.addReturnObject("OutletTo", outletToBean);
                    returnBean.addReturnObject("InventoryBean", bean2);
                    returnBean.addReturnObject("InventoryBeans", inventoryBeans2);
                    returnBean.done();
                    break;   
                }
                
                // verify IN, NOT 18EA1
                case 102050:
                {
                    returnBean = new MvcReturnBean();
                    MvcReturnBean _returnBean = (MvcReturnBean)request.getAttribute("MvcReturnBean");                    
                    String refNo = null;
                    String docType = null;
                    
                    boolean status;
                    ProductManager productMgr = new ProductManager();
                    OutletBean outletBean1 = null;
                    OutletBean outletToBean = null;
                    if(_returnBean != null) {
                        refNo = (String)_returnBean.getReturnObject("RefNo");
                        outletBean1 = (OutletBean)_returnBean.getReturnObject("Outlet");
                        outletToBean = (OutletBean)_returnBean.getReturnObject("OutletTo");
                    } else {
                        refNo = request.getParameter("RefNo");
                    }
                    
                    docType = "STAI";
                    
                    InventoryBean inventoryBeans[] = getRecordsByDocNum(refNo, docType, null, getLoginUser().getLocale().toString());
                    InventoryBean bean = inventoryBeans[0];                    
                    
                    status = updateTW(bean.getTrnxDocNo(), bean.getStatus(), bean.getTrnxType(), loginuser.getUserId());
                    
                    
                    if(bean.getTrnxType().equalsIgnoreCase("STAO") && bean.getStatus()==90) {
                        docType = "STAO";
                    }
                    
                    if(bean.getTrnxType().equalsIgnoreCase("STAI") && bean.getStatus()==100) {
                        docType = "STEI";             
                        
                        /*** Updated By Mila 2016-02-29 */
                        int balance = 0;
                        InventoryBean inventoryBean, inventoryBean2;
                        for(int i = 0; i < inventoryBeans.length; i++) {
                            balance = getBalanceByProductID(bean.getOwnerID(), bean.getTrnxDate(), bean.getProductID());
                            System.out.println("Balance VIN Adjusment :" + balance);
                            if(balance <= 0){
                                inventoryBean = new InventoryBean();
                                inventoryBean2 = new InventoryBean();
                                inventoryBean.setOwnerType(inventoryBeans[i].getOwnerType());
                                inventoryBean2.setOwnerType(inventoryBeans[i].getOwnerType());
                                inventoryBean.setOwnerID(inventoryBeans[i].getOwnerID());
                                inventoryBean2.setOwnerID(inventoryBeans[i].getTarget().split("-")[0]);
                                inventoryBean.setStoreCode(inventoryBeans[i].getStoreCode());
                                inventoryBean2.setStoreCode(inventoryBeans[i].getTarget() + "-001");
                                inventoryBean.setProductID(inventoryBeans[i].getProductID());
                                inventoryBean2.setProductID(inventoryBeans[i].getProductID());
                                inventoryBean.setProductType(0);
                                inventoryBean2.setProductType(0);
                                inventoryBean.setTrnxDocNo("***********");
                                inventoryBean2.setTrnxDocNo("***********");
                                inventoryBean.setTrnxDocType("SDN");
                                inventoryBean2.setTrnxDocType("SDN");
                                inventoryBean.setTrnxType("SKDI");
                                inventoryBean2.setTrnxType("SKDI");
                                inventoryBean.setTotalIn(inventoryBeans[i].getTotalIn());
                                inventoryBean2.setTotalIn(inventoryBeans[i].getTotalIn());
                                inventoryBean.setTrnxType("SKDI");
                                inventoryBean2.setTrnxType("SKDI");
                                inventoryBean.setTotalIn(inventoryBeans[i].getTotalIn());
                                inventoryBean2.setTotalIn(inventoryBeans[i].getTotalIn());
                                inventoryBean.setTarget(inventoryBeans[i].getTarget());
                                inventoryBean2.setTarget(inventoryBeans[i].getOwnerID() + "-001");
                                inventoryBean.setRemark("Plus Adjustment - Synch VIN");
                                inventoryBean2.setRemark("Plus Adjustment - Synch VIN");
                                inventoryBean.setStatus(100);
                                inventoryBean2.setStatus(100);
                                inventoryBean.setProductCode(inventoryBeans[i].getProductCode());
                                inventoryBean2.setProductCode(inventoryBeans[i].getProductCode());
                                inventoryBean.setProductSerial(inventoryBeans[i].getProductSerial());
                                inventoryBean2.setProductSerial(inventoryBeans[i].getProductSerial());
                                inventoryBean.setTrnxDate(new Date());
                                inventoryBean2.setTrnxDate(new Date());
                                inventoryBean.setTrnxTime(new Date());
                                inventoryBean2.setTrnxTime(new Date());
                                inventoryBean.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                                inventoryBean2.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());

                                boolean ref2 = addRecord(inventoryBean);
                                ref2 = addRecord(inventoryBean2);
                                if(ref2) {
                                    returnBean.done();
                                } else {
                                    returnBean.fail();
                                }
                            }
                            /** END Updated **/
                        }
                    }
                    
                    
                    InventoryBean inventoryBeans2[] = getRecordsByDocNum(refNo, docType, null, getLoginUser().getLocale().toString());
                    InventoryBean bean2 = inventoryBeans2[0];
                    
                    if(outletBean1 == null)
                        outletBean1 = (new OutletManager()).getRecord(bean.getOwnerID());
                    if(outletToBean == null) {
                        OutletStoreBean _bean = (new OutletStoreManager()).getOutletStore(bean.getTarget());
                        if(_bean != null)
                            outletToBean = (new OutletManager()).getRecord(_bean.getOutletID());
                    }
                    if(taskId == 0x18e7b || taskId == 0x18e7f) {
                        SupplierBean supplier = (new SupplierManager()).getSupplier(bean.getTarget());
                        returnBean.addReturnObject("Supplier", supplier);
                    } else
                        if(taskId == 0x18e97 || taskId == 0x18e9e || taskId == 0x18e9b || taskId == 0x18e9f  )
                            returnBean.addReturnObject("Target", bean.getTarget());
                    returnBean.addReturnObject("Outlet", outletBean1);
                    if(outletToBean != null)
                        returnBean.addReturnObject("OutletTo", outletToBean);
                    returnBean.addReturnObject("InventoryBean", bean2);
                    returnBean.addReturnObject("InventoryBeans", inventoryBeans2);
                    returnBean.done();
                    break;   
                }
                
                // VOID                
                case 102054:
                case 102064:
                {
                    returnBean = new MvcReturnBean();
                    MvcReturnBean _returnBean = (MvcReturnBean)request.getAttribute("MvcReturnBean");
                    String refNo = null;
                    String docType = null;
                    String remark = request.getParameter("TargetRemark");
                    
                    if(remark == null)
                        remark = "Document has been VOIDED";
                    
                    boolean status;
                    ProductManager productMgr = new ProductManager();
                    OutletBean outletBean1 = null;
                    OutletBean outletToBean = null;
                    if(_returnBean != null) {
                        refNo = (String)_returnBean.getReturnObject("RefNo");
                        outletBean1 = (OutletBean)_returnBean.getReturnObject("Outlet");
                        outletToBean = (OutletBean)_returnBean.getReturnObject("OutletTo");
                    } else {
                        refNo = request.getParameter("RefNo");
                    }
                    
                    if(taskId == 0x18ea6)
                        docType = "STAO";
                    
                    if(taskId == 0x18eb0)
                        docType = "SKLO";
                    
                    InventoryBean inventoryBeans[] = getRecordsByDocNum(refNo, docType, null, getLoginUser().getLocale().toString());
                    InventoryBean bean = inventoryBeans[0];
                    
                    int encript = refNo.concat("8483").hashCode();
                    
                    System.out.println("Encript nomor : " + encript);
                    // System.out.println("Deccript nomor : " + encript);
                    // pengecekan Qty ketika VOID
                    
                    if(bean.getTrnxType().equalsIgnoreCase("STAI") && bean.getStatus()==100) {
                        returnBean.fail();
                        returnBean.setSysError("The document has been Verified OUT, needs to be Verified IN by Your Boutique");
                        return returnBean;
                    }
                    
                    if(taskId == 0x18ea6)
                    {    
                     status = voidTW(bean.getTrnxDocNo(), bean.getStatus(), bean.getTrnxType(), loginuser.getUserId());
                    } else
                    {
                     status = voidLoan(bean.getTrnxDocNo(), bean.getStatus(), bean.getTrnxType(), loginuser.getUserId());   
                    }  
                    
                    if(bean.getTrnxType().equalsIgnoreCase("STAO") && (bean.getStatus()==50 || bean.getStatus()==40) ) {
                        docType = "STAO";
                    }else if(bean.getTrnxType().equalsIgnoreCase("SKLO") && (bean.getStatus()==50 || bean.getStatus()==40) ) {
                        docType = "SKLO";
                    }
                    
                    InventoryBean inventoryBeans2[] = getRecordsByDocNum(refNo, docType, null, getLoginUser().getLocale().toString());
                    InventoryBean bean2 = inventoryBeans2[0];
                    
                    if(outletBean1 == null)
                        outletBean1 = (new OutletManager()).getRecord(bean.getOwnerID());
                    if(outletToBean == null) {
                        OutletStoreBean _bean = (new OutletStoreManager()).getOutletStore(bean.getTarget());
                        if(_bean != null)
                            outletToBean = (new OutletManager()).getRecord(_bean.getOutletID());
                    }
                    if(taskId == 0x18e7b || taskId == 0x18e7f) {
                        SupplierBean supplier = (new SupplierManager()).getSupplier(bean.getTarget());
                        returnBean.addReturnObject("Supplier", supplier);
                    } else
                        if(taskId == 0x18e97 || taskId == 0x18e9e || taskId == 0x18e9b || taskId == 0x18e9f || taskId == 0x18ea6 || taskId == 0x18eb0)
                            returnBean.addReturnObject("Target", bean.getTarget());
                    returnBean.addReturnObject("Outlet", outletBean1);
                    if(outletToBean != null)
                        returnBean.addReturnObject("OutletTo", outletToBean);
                    returnBean.addReturnObject("InventoryBean", bean2);
                    returnBean.addReturnObject("InventoryBeans", inventoryBeans2);
                    returnBean.done();
                    break;
                }
                
                case 102014:
                {
                    String storeCode;
                    String refNo = null;
                    String remark;
                    String productIDs[];
                    String ins[] = null;
                    ArrayList list;
                    OutletBean outletBean = null;
                    int i;
                    
                    returnBean = new MvcReturnBean();
                    storeCode = request.getParameter("storeCode");
                    storeCode = storeCode == null || storeCode.length() != 0 ? storeCode : null;
                    refNo = request.getParameter("supplierCode");
                    remark = request.getParameter("Remark");
                    productIDs = request.getParameterValues("product_id");
                    ins = request.getParameterValues("qty_out");
                    list = new ArrayList();
                    OutletStoreBean _storeBean2 = (new OutletStoreManager()).getOutletStore(storeCode);
                    outletBean = (new OutletManager()).getRecord(_storeBean2.getOutletID());
                    
                    for(i = 0; i < productIDs.length; i++) {
                        int qty_out = 0;
                        if(ins[i].length() > 0) {
                            // if(ins[i].length() > 0)
                            qty_out = Integer.parseInt(ins[i]);
                            if(qty_out <= getProductBalance(Integer.parseInt(productIDs[i]), null, storeCode))
                                // if(qty_out > 0)
                            {
                                InventoryBean inventoryBean = new InventoryBean();
                                inventoryBean.setTrnxType("SKPO");
                                inventoryBean.setTotalOut(qty_out);
                                inventoryBean.setOwnerType(outletBean.getType());
                                inventoryBean.setOwnerID(outletBean.getOutletID());
                                inventoryBean.setStoreCode(storeCode);
                                inventoryBean.setTarget(refNo);
                                inventoryBean.setProductID(Integer.parseInt(productIDs[i]));
                                inventoryBean.setProductType(0);
                                inventoryBean.setRemark(remark);
                                inventoryBean.setStatus(100);
                                inventoryBean.setTrnxDate(new Date());
                                inventoryBean.setTrnxTime(new Date());
                                inventoryBean.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                                list.add(inventoryBean);
                            } else {
                                returnBean.fail();
                                returnBean.setSysError(" Selected product  not enough quantity in the inventory. Failed to procceed.");
                                return returnBean;
                            }
                        }
                    }
                    
                    String refNo2 = addRecord(list, "SRN");
                    if(refNo2 != null) {
                        returnBean.addReturnObject("RefNo", refNo2);
                        returnBean.addReturnObject("Outlet", outletBean);
                        returnBean.done();
                    } else {
                        returnBean.fail();
                    }
                    
                    break;
                }
                
                case 102018:
                case 102831:
                {
                    String storeCode;
                    String refNo = null;
                    String remark;
                    String productIDs[];
                    String ins[] = null;
                    ArrayList list;
                    OutletBean outletBean = null;
                    int i;
                    returnBean = new MvcReturnBean();
                    storeCode = request.getParameter("id");
                    storeCode = storeCode == null || storeCode.length() != 0 ? storeCode : null;
                    remark = request.getParameter("Remark");
                    productIDs = request.getParameterValues("product_id");
                    ins = request.getParameterValues("qty");
                    list = new ArrayList();
                    refNo = null;
                    OutletStoreBean _storeBean3 = (new OutletStoreManager()).getOutletStore(storeCode);
                    outletBean = (new OutletManager()).getRecord(_storeBean3.getOutletID());
                    for(i = 0; i < productIDs.length; i++) {
                        int qty = 0;
                        if(ins[i].length() > 0) {
                            // if(ins[i].length() > 0)
                            qty = Integer.parseInt(ins[i]);
                            if(qty != 0) {
                                InventoryBean inventoryBean = new InventoryBean();
                                if(qty > 0) {
                                    inventoryBean.setTotalIn(qty);
                                    inventoryBean.setTrnxType("SKDI");
                                } else
                                    if(qty < 0) {
                                    inventoryBean.setTotalOut(-qty);
                                    inventoryBean.setTrnxType("SKDO");
                                    }
                                inventoryBean.setOwnerType(outletBean.getType());
                                inventoryBean.setOwnerID(outletBean.getOutletID());
                                inventoryBean.setStoreCode(storeCode);
                                inventoryBean.setTarget(refNo);
                                inventoryBean.setProductID(Integer.parseInt(productIDs[i]));
                                inventoryBean.setProductType(0);
                                inventoryBean.setRemark(remark);
                                inventoryBean.setStatus(100);
                                inventoryBean.setTrnxDate(new Date());
                                inventoryBean.setTrnxTime(new Date());
                                inventoryBean.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                                list.add(inventoryBean);
                            }
                        }
                    }
                    
                    String refNo3 = addRecord(list, "SDN");
                    if(refNo3 != null) {
                        returnBean.addReturnObject("RefNo", refNo3);
                        returnBean.addReturnObject("Outlet", outletBean);
                        returnBean.done();
                    } else {
                        returnBean.fail();
                    }
                    break;
                }
                
                case 102041:
                {
                    String target;
                    // String id = null;
                    String id = getLoginUser().getOutletID();
                    target = null;
                    // String id = request.getParameter("id");
                    // String target = request.getParameter("storeTo");
                    
                    boolean isSubmit = false;
                    returnBean = new MvcReturnBean();
                    OutletStoreBean storeBeans[] = (OutletStoreBean[])null;
                    OutletStoreBean storeBeans2[] = (OutletStoreBean[])null;
                    OutletStoreBean fromStore = null;
                    OutletStoreBean toStore = null;
                    
                    if(request.getParameter("id") != null && request.getParameter("id").length() > 0) {
                        id = request.getParameter("id");
                        target = request.getParameter("storeTo");
                        System.out.println("from "+id+" to target : "+target);
                        
                        isSubmit = true;
                    }
                    
        /*
        else
        {
            id = getLoginUser().getOutletID();
        }
         */
                    
                    if(id != null) {
                        OutletManager outletManager = new OutletManager();
                        OutletStoreManager storeManager = new OutletStoreManager();
                        OutletStoreBean _storeBean1 = null;
                        boolean isFromValid = false;
                        OutletBean outletBean11 = outletManager.getRecord(id);
                        if(outletBean11 != null) {
                            isFromValid = true;
                        } else {
                            _storeBean1 = storeManager.getOutletStore(id);
                            if(_storeBean1 != null) {
                                fromStore = _storeBean1;
                                isFromValid = true;
                                outletBean11 = outletManager.getRecord(_storeBean1.getOutletID());
                            }
                        }
                        boolean isToValid = false;
                        OutletBean outletBean2 = outletManager.getRecord(target);
                        OutletStoreBean _storeBean22 = null;
                        if(outletBean2 != null) {
                            isToValid = true;
                        } else {
                            _storeBean22 = storeManager.getOutletStore(target);
                            if(_storeBean22 != null) {
                                toStore = _storeBean22;
                                isToValid = true;
                                outletBean2 = outletManager.getRecord(_storeBean22.getOutletID());
                            }
                        }
                        
                        System.out.println("store from "+fromStore+" to target : "+toStore);
                        
                        if(isSubmit)
                            if(!isFromValid)
                                returnBean.setSysMessage("ID (From) not valid.");
                            else
                                if(!isToValid)
                                    returnBean.setSysMessage("ID (To) not valid.");
                                else
                                    if(isToValid && isFromValid && outletBean11.getOutletID().equalsIgnoreCase(outletBean2.getOutletID()))
                                        returnBean.setSysMessage("IDs cannot be in the same outlet.");
                        if(returnBean.getSysMessage() == null && isSubmit) {
                            storeBeans = storeManager.getStoreListByOutlet(outletBean11.getOutletID());
                            storeBeans2 = storeManager.getStoreListByOutlet(outletBean2.getOutletID());
                            if(fromStore == null)
                                fromStore = storeBeans[0];
                            if(toStore == null)
                                toStore = storeBeans2[0];
                            InventoryBean beans[] = getStoreInventory(getLoginUser().getLocale(), fromStore.getStoreID());
                            returnBean.done();
                            returnBean.addReturnObject("FromStore", fromStore);
                            returnBean.addReturnObject("ToStore", toStore);
                            returnBean.addReturnObject("Stores", getStoreCodeOnlyList(storeBeans, false));
                            returnBean.addReturnObject("StoresTo", getStoreCodeOnlyList(storeBeans2, false));
                            returnBean.addReturnObject("OutletFrom", outletBean11);
                            returnBean.addReturnObject("OutletTo", outletBean2);
                            returnBean.addReturnObject("InventoryBeans", beans);
                            // returnBean.addReturnObject("SellerList", getMapForSalesOutletList());
                            
                        } else {
                            returnBean.fail();
                        }
                        returnBean.addReturnObject("ID", id);
                        if(target != null)
                            returnBean.addReturnObject("Target", target);
                    }
                    returnBean.addReturnObject("TaskID", Integer.valueOf(taskId));
                    
                    returnBean.addReturnObject("SellerList", getMapForSalesOutletList());
                    
                    break;
                }
                
                case 102051:
                {
                    String target;
                    String id = getLoginUser().getOutletID();
                    target = null;
                    
                    Locale currentLocale = getLoginUser().getLocale();
                    String LocaleStr = currentLocale.toString();
                    
                    boolean isSubmit = false;
                    returnBean = new MvcReturnBean();
                    OutletStoreBean storeBeans[] = (OutletStoreBean[])null;
                    OutletStoreBean storeBeans2[] = (OutletStoreBean[])null;
                    OutletStoreBean fromStore = null;
                    OutletStoreBean toStore = null;
                    
                    if(request.getParameter("id") != null && request.getParameter("id").length() > 0) {
                        id = request.getParameter("id");
                        target = request.getParameter("storeTo");
                        System.out.println("from "+id+" to target : "+target);
                        isSubmit = true;
                    }
                                                            
                    if(id != null) {
                        OutletManager outletManager = new OutletManager();
                        OutletStoreManager storeManager = new OutletStoreManager();
                        OutletStoreBean _storeBean1 = null;
                        boolean isFromValid = false;
                        OutletBean outletBean11 = outletManager.getRecord(id);
                        if(outletBean11 != null) {
                            isFromValid = true;
                        } else {
                            _storeBean1 = storeManager.getOutletStore(id);
                            if(_storeBean1 != null) {
                                fromStore = _storeBean1;
                                isFromValid = true;
                                outletBean11 = outletManager.getRecord(_storeBean1.getOutletID());
                            }
                        }
                        boolean isToValid = false;
                        OutletBean outletBean2 = outletManager.getRecord(target);
                        OutletStoreBean _storeBean22 = null;
                        if(outletBean2 != null) {
                            isToValid = true;
                        } else {
                            _storeBean22 = storeManager.getOutletStore(target);
                            if(_storeBean22 != null) {
                                toStore = _storeBean22;
                                isToValid = true;
                                outletBean2 = outletManager.getRecord(_storeBean22.getOutletID());
                            }
                        }
                        
                        String chek = request.getParameter("BonusDate");
                        if(chek == null)
                            chek = Sys.getDateFormater().format(new Date());                                                
                        
                        BonusPeriodManager bonusPeriodManager = new BonusPeriodManager();
                        boolean isBonusDateActive = false;
                        try {
                            Date bonusDate = Sys.parseDate(chek);
                            isBonusDateActive = bonusPeriodManager.isBonusPeriodActive(new java.sql.Date(bonusDate.getTime()), 50);
                            if(isBonusDateActive) {
                                System.out.println("Period Bonus has Active "+ bonusDate);
                            } else {
                                returnBean.setSysMessage("Initial Date is closed for TW");
                            }
                        } catch(Exception e) {
                            returnBean.setSysMessage("Invalid Initial Date Format");
                        }                        
                        
                        String brand = request.getParameter("brand");
                        // if(brand == null || brand.length() < 1)
                            // returnBean.setSysMessage("Please, pilih brand yah ...");

                        System.out.println("store from "+fromStore+" to target : "+toStore+ "  check : "+chek+ " brand :"+brand);
                        
                        if(isSubmit)
                            if(!isFromValid)
                                returnBean.setSysMessage("ID (From) not valid.");
                            else
                                if(!isToValid)
                                    returnBean.setSysMessage("ID (To) not valid.");
                                else                                    
                                    if(isToValid && isFromValid && outletBean11.getOutletID().equalsIgnoreCase(outletBean2.getOutletID()))
                                        returnBean.setSysMessage("IDs cannot be in the same outlet.");

                                    else                                    
                                    if(brand == null || brand.length() < 1)
                                        returnBean.setSysMessage("please select product brand. ");
                        
                        

                        if(returnBean.getSysMessage() == null && isSubmit) {
                            storeBeans = storeManager.getStoreListByOutlet(outletBean11.getOutletID());
                            storeBeans2 = storeManager.getStoreListByOutlet(outletBean2.getOutletID());
                            if(fromStore == null)
                                fromStore = storeBeans[0];
                            if(toStore == null)
                                toStore = storeBeans2[0];
                            // InventoryBean beans[] = getStoreInventory(getLoginUser().getLocale(), fromStore.getStoreID());
                            returnBean.done();
                            returnBean.addReturnObject("FromStore", fromStore);
                            returnBean.addReturnObject("ToStore", toStore);
                            returnBean.addReturnObject("Stores", getStoreCodeOnlyList(storeBeans, false));
                            returnBean.addReturnObject("StoresTo", getStoreCodeOnlyList(storeBeans2, false));
                            returnBean.addReturnObject("OutletFrom", outletBean11);
                            returnBean.addReturnObject("OutletTo", outletBean2);
                            
                            returnBean.addReturnObject("Category", brand);
                            
                            System.out.println(" chek lagi Category : "+ brand);
                            // returnBean.addReturnObject("SellerList", getMapForSalesOutletList());
                             
                        } else {
                            returnBean.fail();
                        }
                        returnBean.addReturnObject("ID", id);
                        
                        if(target != null)
                            returnBean.addReturnObject("Target", target);
                        
                    }
                    returnBean.addReturnObject("TaskID", Integer.valueOf(taskId));
                    
                    returnBean.addReturnObject("SellerList", getMapForSalesOutletList());
                    returnBean.addReturnObject("CatList", getList(LocaleStr));  
                    
                    break;
                }
                
                case 102055:
                case 102060:    
                {
                    // String target = "33620";
                    String target = request.getParameter("CustomerID");                           
                    String id = getLoginUser().getOutletID();
                    
                    Locale currentLocale = getLoginUser().getLocale();
                    String LocaleStr = currentLocale.toString();
                    
                    boolean isSubmit = false;
                    returnBean = new MvcReturnBean();
                    OutletStoreBean storeBeans[] = (OutletStoreBean[])null;
                    OutletStoreBean storeBeans2[] = (OutletStoreBean[])null;
                    OutletStoreBean fromStore = null;
                    MemberBean toStore = null;
                    
                    if(request.getParameter("id") != null && request.getParameter("id").length() > 0) {
                        id = request.getParameter("id");
                        target = request.getParameter("storeTo");
                        
                        if (target.length() < 1 || target == null)
                            target = "test";
                        
                        System.out.println("from "+id+" to target : "+target);
                        isSubmit = true;
                    }
                                                            
                    if(id != null) {
                        OutletManager outletManager = new OutletManager();
                        OutletStoreManager storeManager = new OutletStoreManager();
                        MemberManager memberManager = new MemberManager();
                        
                        OutletStoreBean _storeBean1 = null;
                        boolean isFromValid = false;
                        OutletBean outletBean11 = outletManager.getRecord(id);
                        if(outletBean11 != null) {
                            isFromValid = true;
                        } else {
                            _storeBean1 = storeManager.getOutletStore(id);
                            if(_storeBean1 != null) {
                                fromStore = _storeBean1;
                                isFromValid = true;
                                outletBean11 = outletManager.getRecord(_storeBean1.getOutletID());
                            }
                        }
                                           
                        
                        boolean isToValid = false;
                        if(target == null)
                           target = "33620";
                        
                        MemberBean outletBean2 = getMember(target, false);
                        
                        if (outletBean2 != null)
                           System.out.println(" chek nilai member "+outletBean2.getMemberID());
                        
                        OutletStoreBean _storeBean22 = null;
                        if(outletBean2 != null) {
                            isToValid = true;
                        } 
                        
                        String chek = request.getParameter("BonusDate");
                        if(chek == null)
                            chek = Sys.getDateFormater().format(new Date());                                                
                        
                        BonusPeriodManager bonusPeriodManager = new BonusPeriodManager();
                        boolean isBonusDateActive = false;
                        try {
                            Date bonusDate = Sys.parseDate(chek);
                            isBonusDateActive = bonusPeriodManager.isBonusPeriodActive(new java.sql.Date(bonusDate.getTime()), 50);
                            if(isBonusDateActive) {
                                System.out.println("Period Bonus has Active "+ bonusDate);
                            } else {
                                returnBean.setSysMessage("Initial Date is closed for Loan");
                            }
                        } catch(Exception e) {
                            returnBean.setSysMessage("Invalid Initial Date Format");
                        }                        
                        
                        String brand = request.getParameter("brand");
                        System.out.println("store from "+fromStore+" to target : "+toStore+ "  check : "+chek+ " brand :"+brand);
                                                
                            returnBean.addReturnObject("CustomerID", outletBean2.getMemberID());
                            returnBean.addReturnObject("CustomerName", outletBean2.getName());                            
                            
                            
                        if(isSubmit)
                            if(!isFromValid)
                                returnBean.setSysMessage("ID (From) not valid.");
                            else
                                if(!isToValid)
                                    returnBean.setSysMessage("Customer ID not valid.");
                                
                                else                                    
                                    if(isToValid && isFromValid && outletBean11.getOutletID().equalsIgnoreCase(outletBean2.getMemberID()))   
                                    returnBean.setSysMessage("Customer ID cannot be in the same outlet.");

                        if(returnBean.getSysMessage() == null && isSubmit) {
                            storeBeans = storeManager.getStoreListByOutlet(outletBean11.getOutletID());
                            
                            if(fromStore == null)
                                fromStore = storeBeans[0];

                            returnBean.done();
                            returnBean.addReturnObject("FromStore", fromStore);
                            returnBean.addReturnObject("ToStore", toStore);
                            returnBean.addReturnObject("Stores", getStoreCodeOnlyList(storeBeans, false));
                            returnBean.addReturnObject("StoresTo", outletBean2.getName());
                            returnBean.addReturnObject("OutletFrom", outletBean11);
                            returnBean.addReturnObject("OutletTo", outletBean2.getMemberID());
                            returnBean.addReturnObject("Category", brand);
                            returnBean.addReturnObject("CustomerID", outletBean2.getMemberID());
                            returnBean.addReturnObject("CustomerName", outletBean2.getName());                            
                            System.out.println(" chek lagi Category : "+ brand);
                             
                        } else {
                            returnBean.fail();
                        }
                        returnBean.addReturnObject("ID", id);
                        
                        if(target != null)
                            returnBean.addReturnObject("Target", target);
                        
                    }
                    returnBean.addReturnObject("TaskID", Integer.valueOf(taskId));
                    
                    returnBean.addReturnObject("SellerList", getMapForSalesOutletList());
                    returnBean.addReturnObject("CatList", getList(LocaleStr));  
                    
                    break;
                }
                
                case 102022:
                {
                    String targetRemark;
                    String remark1;
                    String productIDs1[];
                    String ins1[];
                    ArrayList list1;
                    
                    String storeCode;
                    String refNo = null;
                    OutletBean outletBean = null;
                    int i;
                    
                    returnBean = new MvcReturnBean();
                    storeCode = request.getParameter("id");
                    storeCode = storeCode == null || storeCode.length() != 0 ? storeCode : null;
                    refNo = null;
                    targetRemark = request.getParameter("TargetRemark");
                    targetRemark = targetRemark == null || targetRemark.length() <= 0 ? null : targetRemark;
                    remark1 = request.getParameter("Remark");
                    productIDs1 = request.getParameterValues("product_id");
                    ins1 = request.getParameterValues("qty_out");
                    list1 = new ArrayList();
                    OutletStoreBean _storeBean1 = (new OutletStoreManager()).getOutletStore(storeCode);
                    outletBean = (new OutletManager()).getRecord(_storeBean1.getOutletID());
                    for(i = 0; i < productIDs1.length; i++) {
                        int qty_out = 0;
                        if(ins1[i].length() > 0) {
                            // if(ins1[i].length() > 0)
                            qty_out = Integer.parseInt(ins1[i]);
                            if(qty_out > 0) {
                                if(qty_out <= getProductBalance(Integer.parseInt(productIDs1[i]), null, storeCode)) {
                                    InventoryBean inventoryBean = new InventoryBean();
                                    inventoryBean.setTrnxType("SKCO");
                                    inventoryBean.setTotalOut(qty_out);
                                    inventoryBean.setOwnerType(outletBean.getType());
                                    inventoryBean.setOwnerID(outletBean.getOutletID());
                                    inventoryBean.setStoreCode(storeCode);
                                    inventoryBean.setTarget(refNo);
                                    inventoryBean.setTargetRemark(targetRemark);
                                    inventoryBean.setProductID(Integer.parseInt(productIDs1[i]));
                                    inventoryBean.setProductType(0);
                                    inventoryBean.setRemark(remark1);
                                    inventoryBean.setStatus(100);
                                    inventoryBean.setTrnxDate(new Date());
                                    inventoryBean.setTrnxTime(new Date());
                                    inventoryBean.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                                    list1.add(inventoryBean);
                                } else {
                                    returnBean.fail();
                                    returnBean.setSysError(" Selected product  not enough quantity in the inventory. Failed to procceed.");
                                    return returnBean;
                                }
                                
                            }
                        }
                    }
                    
                    String refNo1 = addRecord(list1, "SCN");
                    if(refNo1 != null) {
                        returnBean.addReturnObject("RefNo", refNo1);
                        returnBean.addReturnObject("Outlet", outletBean);
                        returnBean.done();
                    } else {
                        returnBean.fail();
                    }
                    
                    break;
                }
                
                case 102026:
                {
                    String storeCode;
                    String refNo = null;
                    String remark1;
                    String targetRemark;
                    String productIDs1[];
                    String ins1[] = null;
                    ArrayList list1;
                    OutletBean outletBean = null;
                    int i;
                    
                    returnBean = new MvcReturnBean();
                    storeCode = request.getParameter("id");
                    storeCode = storeCode == null || storeCode.length() != 0 ? storeCode : null;
                    refNo = null;
                    targetRemark = request.getParameter("TargetRemark");
                    targetRemark = targetRemark == null || targetRemark.length() <= 0 ? null : targetRemark;
                    remark1 = request.getParameter("Remark");
                    productIDs1 = request.getParameterValues("product_id");
                    ins1 = request.getParameterValues("qty_out");
                    list1 = new ArrayList();
                    OutletStoreBean _storeBean4 = (new OutletStoreManager()).getOutletStore(storeCode);
                    outletBean = (new OutletManager()).getRecord(_storeBean4.getOutletID());
                    for(i = 0; i < productIDs1.length; i++) {
                        int qty_out = 0;
                        if(ins1[i].length() > 0) {
                            //  if(ins1[i].length() > 0)
                            qty_out = Integer.parseInt(ins1[i]);
                            if(qty_out > 0) {
                                if(qty_out <= getProductBalance(Integer.parseInt(productIDs1[i]), null, storeCode)) {
                                    InventoryBean inventoryBean = new InventoryBean();
                                    inventoryBean.setTrnxType("SKLO");
                                    inventoryBean.setTotalOut(qty_out);
                                    inventoryBean.setOwnerType(outletBean.getType());
                                    inventoryBean.setOwnerID(outletBean.getOutletID());
                                    inventoryBean.setStoreCode(storeCode);
                                    inventoryBean.setTarget(refNo);
                                    inventoryBean.setTargetRemark(targetRemark);
                                    inventoryBean.setProductID(Integer.parseInt(productIDs1[i]));
                                    inventoryBean.setProductType(0);
                                    inventoryBean.setRemark(remark1);
                                    inventoryBean.setStatus(100);
                                    inventoryBean.setTrnxDate(new Date());
                                    inventoryBean.setTrnxTime(new Date());
                                    inventoryBean.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                                    list1.add(inventoryBean);
                                } else {
                                    returnBean.fail();
                                    returnBean.setSysError(" Selected product  not enough quantity in the inventory. Failed to procceed.");
                                    return returnBean;
                                }
                                
                            }
                        }
                    }
                    
                    String refNo1 = addRecord(list1, "SLNO");
                    if(refNo1 != null) {
                        returnBean.addReturnObject("RefNo", refNo1);
                        returnBean.addReturnObject("Outlet", outletBean);
                        returnBean.done();
                    } else {
                        returnBean.fail();
                    }
                    
                    break;
                }
                
                case 102030:
                {
                    String storeCode;
                    String refNo = null;
                    String remark;
                    String targetRemark;
                    String productIDs[];
                    String ins[] = null;
                    ArrayList list;
                    OutletBean outletBean = null;
                    int i;
                    
                    returnBean = new MvcReturnBean();
                    storeCode = request.getParameter("id");
                    storeCode = storeCode == null || storeCode.length() != 0 ? storeCode : null;
                    refNo = null;
                    targetRemark = request.getParameter("TargetRemark");
                    targetRemark = targetRemark == null || targetRemark.length() <= 0 ? null : targetRemark;
                    remark = request.getParameter("Remark");
                    productIDs = request.getParameterValues("product_id");
                    ins = request.getParameterValues("qty_in");
                    list = new ArrayList();
                    OutletStoreBean _storeBean5 = (new OutletStoreManager()).getOutletStore(storeCode);
                    outletBean = (new OutletManager()).getRecord(_storeBean5.getOutletID());
                    
                    for(i = 0; i < productIDs.length; i++) {
                        int qty_in = 0;
                        if(ins[i].length() > 0) {
                            // if(ins[i].length() > 0)
                            qty_in = Integer.parseInt(ins[i]);
                            if(qty_in > 0) {
                                InventoryBean inventoryBean = new InventoryBean();
                                inventoryBean.setTrnxType("SKLI");
                                inventoryBean.setTotalIn(qty_in);
                                inventoryBean.setOwnerType(outletBean.getType());
                                inventoryBean.setOwnerID(outletBean.getOutletID());
                                inventoryBean.setStoreCode(storeCode);
                                inventoryBean.setTarget(refNo);
                                inventoryBean.setTargetRemark(targetRemark);
                                inventoryBean.setProductID(Integer.parseInt(productIDs[i]));
                                inventoryBean.setProductType(0);
                                inventoryBean.setRemark(remark);
                                inventoryBean.setStatus(100);
                                inventoryBean.setTrnxDate(new Date());
                                inventoryBean.setTrnxTime(new Date());
                                inventoryBean.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                                list.add(inventoryBean);
                            }
                        }
                    }
                    
                    String refNo1 = addRecord(list, "SLNI");
                    if(refNo1 != null) {
                        returnBean.addReturnObject("RefNo", refNo1);
                        returnBean.addReturnObject("Outlet", outletBean);
                        returnBean.done();
                    } else {
                        returnBean.fail();
                    }
                    break;
                }
                
                case 102034:
                {
                    String storeCode;
                    String refNo = null;
                    String remark1;
                    String targetRemark;
                    String productIDs1[];
                    String ins1[] = null;
                    ArrayList list1;
                    OutletBean outletBean = null;
                    int i;
                    
                    returnBean = new MvcReturnBean();
                    storeCode = request.getParameter("id");
                    storeCode = storeCode == null || storeCode.length() != 0 ? storeCode : null;
                    refNo = null;
                    targetRemark = request.getParameter("TargetRemark");
                    targetRemark = targetRemark == null || targetRemark.length() <= 0 ? null : targetRemark;
                    remark1 = request.getParameter("Remark");
                    productIDs1 = request.getParameterValues("product_id");
                    ins1 = request.getParameterValues("qty_out");
                    list1 = new ArrayList();
                    OutletStoreBean _storeBean6 = (new OutletStoreManager()).getOutletStore(storeCode);
                    outletBean = (new OutletManager()).getRecord(_storeBean6.getOutletID());
                    for(i = 0; i < productIDs1.length; i++) {
                        int qty_in = 0;
                        if(ins1[i].length() > 0) {
                            // if(ins1[i].length() > 0)
                            qty_in = Integer.parseInt(ins1[i]);
                            if(qty_in > 0) {
                                if(qty_in <= getProductBalance(Integer.parseInt(productIDs1[i]), null, storeCode)) {
                                    InventoryBean inventoryBean = new InventoryBean();
                                    inventoryBean.setTrnxType("SKBO");
                                    inventoryBean.setTotalOut(qty_in);
                                    inventoryBean.setOwnerType(outletBean.getType());
                                    inventoryBean.setOwnerID(outletBean.getOutletID());
                                    inventoryBean.setStoreCode(storeCode);
                                    inventoryBean.setTarget(refNo);
                                    inventoryBean.setTargetRemark(targetRemark);
                                    inventoryBean.setProductID(Integer.parseInt(productIDs1[i]));
                                    inventoryBean.setProductType(0);
                                    inventoryBean.setRemark(remark1);
                                    inventoryBean.setStatus(100);
                                    inventoryBean.setTrnxDate(new Date());
                                    inventoryBean.setTrnxTime(new Date());
                                    inventoryBean.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                                    list1.add(inventoryBean);
                                } else {
                                    returnBean.fail();
                                    returnBean.setSysError(" Selected product  not enough quantity in the inventory. Failed to procceed.");
                                    return returnBean;
                                }
                            }
                        }
                    }
                    
                    
                    String refNo4 = addRecord(list1, "SBO");
                    if(refNo4 != null) {
                        returnBean.addReturnObject("RefNo", refNo4);
                        returnBean.addReturnObject("Outlet", outletBean);
                        returnBean.done();
                    } else {
                        returnBean.fail();
                    }
                    break;
                }
                
                case 102038:
                case 102042:
                {
                    String storeCode;
                    String refNo = null;
                    String remark1;
                    String targetRemark;
                    String remarkPro[];
                    String productIDs[];
                    ArrayList list;
                    OutletBean outletBean = null;
                    int i;
                    
                    OutletBean fromOutletBean;
                    OutletBean toOutletBean;
                    
                    returnBean = new MvcReturnBean();
                    storeCode = request.getParameter("id");
                    storeCode = storeCode == null || storeCode.length() != 0 ? storeCode : null;
                    refNo = request.getParameter("storeTo");
                    targetRemark = request.getParameter("Remark");
                    remarkPro = request.getParameterValues("product_id");
                    productIDs = request.getParameterValues("qty");
                    list = new ArrayList();
                    OutletStoreBean fromStoreBean = (new OutletStoreManager()).getOutletStore(storeCode);
                    fromOutletBean = (new OutletManager()).getRecord(fromStoreBean.getOutletID());
                    OutletStoreBean toStoreBean = (new OutletStoreManager()).getOutletStore(refNo);
                    toOutletBean = (new OutletManager()).getRecord(toStoreBean.getOutletID());
                    i = 0;
                    
                    for(i = 0; i < remarkPro.length; i++) {
                        int qty = 0;
                        if(productIDs[i].length() > 0) {
                            // if(productIDs[i].length() > 0)
                            qty = Integer.parseInt(productIDs[i]);
                            if(qty > 0) {
                                if(qty <= getProductBalance(Integer.parseInt(remarkPro[i]), null, storeCode)) {
                                    InventoryBean inventoryBean = new InventoryBean();
                                    // inventoryBean.setTrnxType((taskId != 0x18e96) ? "STEO" : "STIO");
                                    // Update Allocate
                                    inventoryBean.setTrnxType((taskId != 0x18e96) ? "STAO" : "STIO");
                                    inventoryBean.setTotalOut(qty);
                                    inventoryBean.setOwnerType(fromOutletBean.getType());
                                    inventoryBean.setOwnerID(fromOutletBean.getOutletID());
                                    inventoryBean.setStoreCode(storeCode);
                                    inventoryBean.setTarget(refNo);
                                    inventoryBean.setProductID(Integer.parseInt(remarkPro[i]));
                                    inventoryBean.setProductType(0);
                                    inventoryBean.setRemark(targetRemark);
                                    // inventoryBean.setStatus(100);
                                    inventoryBean.setStatus((taskId == 0x18e9a) ? 90 : 100);
                                    inventoryBean.setTrnxDate(new Date());
                                    inventoryBean.setTrnxTime(new Date());
                                    inventoryBean.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                                    list.add(inventoryBean);
                                    
                                    InventoryBean _inventoryBean = new InventoryBean();
                                    // _inventoryBean.setTrnxType((taskId != 0x18e96) ? "STEI" : "STII");
                                    // Update Allocate
                                    _inventoryBean.setTrnxType((taskId != 0x18e96) ? "STAI" : "STII");
                                    _inventoryBean.setTotalIn(qty);
                                    _inventoryBean.setOwnerType(toOutletBean.getType());
                                    _inventoryBean.setOwnerID(toOutletBean.getOutletID());
                                    _inventoryBean.setStoreCode(refNo);
                                    _inventoryBean.setTarget(storeCode);
                                    _inventoryBean.setProductID(Integer.parseInt(remarkPro[i]));
                                    _inventoryBean.setProductType(0);
                                    _inventoryBean.setRemark(targetRemark);
                                    // _inventoryBean.setStatus(100);
                                    _inventoryBean.setStatus((taskId == 0x18e9a) ? 90 : 100);
                                    _inventoryBean.setTrnxDate(new Date());
                                    _inventoryBean.setTrnxTime(new Date());
                                    _inventoryBean.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                                    list.add(_inventoryBean);
                                } else {
                                    returnBean.fail();
                                    returnBean.setSysError(" Selected product  not enough quantity in the inventory. Failed to procceed.");
                                    return returnBean;
                                }
                                
                                String refNo4 = addRecord(list, "STN");
                                if(refNo4 != null) {
                                    returnBean.addReturnObject("RefNo", refNo4);
                                    returnBean.addReturnObject("OutletTo", toOutletBean);
                                    returnBean.addReturnObject("Outlet", fromOutletBean);
                                    returnBean.done();
                                } else {
                                    returnBean.fail();
                                }
                                
                            }
                        }
                    }
                    
                    break;
                }
                
                case 102052:
                {
                    String storeCode;
                    String refNo = null;
                    String remark1;
                    String targetRemark;
                    String remarkPro[];
                    String productIDs[];
                    ArrayList list;
                    OutletBean outletBean = null;
                    
                    OutletBean fromOutletBean;
                    OutletBean toOutletBean;
                    ProductManager productMgr = new ProductManager();
                    
                    returnBean = new MvcReturnBean();
                    storeCode = request.getParameter("id");
                    storeCode = storeCode == null || storeCode.length() != 0 ? storeCode : null;
                    refNo = request.getParameter("storeTo");
                    targetRemark = request.getParameter("Remark");
                    // remarkPro = request.getParameterValues("product_id");
                    
                    remarkPro = request.getParameterValues("icode_");
                    productIDs = request.getParameterValues("qty");
                    
                    list = new ArrayList();
                    OutletStoreBean fromStoreBean = (new OutletStoreManager()).getOutletStore(storeCode);
                    fromOutletBean = (new OutletManager()).getRecord(fromStoreBean.getOutletID());
                    OutletStoreBean toStoreBean = (new OutletStoreManager()).getOutletStore(refNo);
                    toOutletBean = (new OutletManager()).getRecord(toStoreBean.getOutletID());
                    
                    String ulang = request.getParameter("ulangi_kit2");
                    int ulangi = Integer.parseInt(request.getParameter("ulangi_kit2"));
                    boolean status = false;
                    
                    for(int i=1;i<ulangi ;i++) {
                        String productSerial = "";
                        String productCode = "";
                        String quantity = request.getParameter("qty_" + i);
                        productSerial = request.getParameter("icode_" + i);
                        // productCode = request.getParameter("iserial_" + i);
                        String quantity1 = "0";
                        
                        /*
                        if(i>5) {
                            if (quantity.isEmpty() || quantity == null || quantity.equalsIgnoreCase("0"))
                                quantity = "1";
                            else
                                quantity1 = quantity;
                         
                        } else {
                            if (quantity.isEmpty() || quantity == null)
                                quantity = "";
                        }
                         */
                        
                        if (productSerial.isEmpty() || productSerial == null)
                            productSerial = "";
                        
                        if (productCode.isEmpty() || productCode == null)
                            productCode = "";
                        
                        System.out.println("2. Item Serial "+productSerial+ " Item Product "+productCode+ "  Qty " + quantity);
                        
                        if(quantity != null && quantity.length() > 0 && productSerial != null && productSerial.length() > 0) {
                            int Qty = Integer.parseInt(quantity);
                            //if(Qty > 0) { //Updated By Ferdi 2015-08-26
                                
                                int idproduct = productMgr.getIdProduct(productSerial).getProductID();
                                productCode = productMgr.getIdProduct(productSerial).getProductCode();
                                
                                if(Qty <= getProductBalance(idproduct, null, storeCode)) {
                                    InventoryBean inventoryBean = new InventoryBean();
                                    inventoryBean.setTrnxType("STAO");
                                    inventoryBean.setTotalOut(Qty);
                                    inventoryBean.setOwnerType(fromOutletBean.getType());
                                    inventoryBean.setOwnerID(fromOutletBean.getOutletID());
                                    inventoryBean.setStoreCode(storeCode);
                                    inventoryBean.setTarget(refNo);
                                    inventoryBean.setProductID(idproduct);
                                    inventoryBean.setProductType(0);
                                    
                                    inventoryBean.setProductCode(productCode);
                                    inventoryBean.setProductSerial(productSerial);
                                    
                                    // tambahan tuk KIT
                                    /*
                                    if(quantity1.equalsIgnoreCase("0"))
                                      inventoryBean.setProcessStatus(10);
                                    else
                                      inventoryBean.setProcessStatus(20);
                                     */
                                    
                                    inventoryBean.setRemark(targetRemark);
                                    inventoryBean.setStatus(90);
                                    inventoryBean.setTrnxDate(new Date());
                                    inventoryBean.setTrnxTime(new Date());
                                    inventoryBean.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                                    list.add(inventoryBean);
                                    
                                    InventoryBean _inventoryBean = new InventoryBean();
                                    _inventoryBean.setTrnxType("STAI");
                                    _inventoryBean.setTotalIn(Qty);
                                    _inventoryBean.setOwnerType(toOutletBean.getType());
                                    _inventoryBean.setOwnerID(toOutletBean.getOutletID());
                                    _inventoryBean.setStoreCode(refNo);
                                    _inventoryBean.setTarget(storeCode);
                                    _inventoryBean.setProductID(idproduct);
                                    
                                    _inventoryBean.setProductCode(productCode);
                                    _inventoryBean.setProductSerial(productSerial);
                                    
                                    _inventoryBean.setProductType(0);
                                    _inventoryBean.setRemark(targetRemark);
                                    _inventoryBean.setStatus(90);
                                    _inventoryBean.setTrnxDate(new Date());
                                    _inventoryBean.setTrnxTime(new Date());
                                    _inventoryBean.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                                    list.add(_inventoryBean);
                                } else {
                                    returnBean.fail();
                                    returnBean.setSysError(" Selected product  not enough quantity in the inventory. Failed to procceed.");
                                    return returnBean;
                                }
                                
                            //} //Updated By Ferdi 2015-08-26
                        }
                    }
                    
                    String refNo4 = addRecord(list, "STN");
                    System.out.println("refNo4 "+refNo4);
                    
                    if(refNo4 != null) {
                        returnBean.addReturnObject("RefNo", refNo4);
                        returnBean.addReturnObject("OutletTo", toOutletBean);
                        returnBean.addReturnObject("Outlet", fromOutletBean);
                        returnBean.done();
                    } else {
                        returnBean.fail();
                    }
                    
                    break;
                }
                
                case 102056:
                {
                    String storeCode;
                    String refNo = null;
                    String custID = null;
                    String Remark;
                    String targetRemark;
                    String remarkPro[];
                    String productIDs[];
                    ArrayList list;
                    OutletBean outletBean = null;
                    
                    OutletBean fromOutletBean;
                    
                    ProductManager productMgr = new ProductManager();
                    
                    returnBean = new MvcReturnBean();
                    storeCode = request.getParameter("id");
                    storeCode = storeCode == null || storeCode.length() != 0 ? storeCode : null;
                    refNo = request.getParameter("storeTo");
                    custID = request.getParameter("custID");                    
                    targetRemark = request.getParameter("custName");
                    Remark = request.getParameter("Remark");
                    
                    remarkPro = request.getParameterValues("icode_");
                    productIDs = request.getParameterValues("qty");
                    
                    list = new ArrayList();
                    OutletStoreBean fromStoreBean = (new OutletStoreManager()).getOutletStore(storeCode);
                    fromOutletBean = (new OutletManager()).getRecord(fromStoreBean.getOutletID());
                    
                    MemberBean toStoreBean = getMember(custID, false);
                    MemberBean toOutletBean = getMember(custID, false);
                    
                    String ulang = request.getParameter("ulangi_kit2");
                    int ulangi = Integer.parseInt(request.getParameter("ulangi_kit2"));
                    boolean status = false;
                    
                    for(int i=1;i<ulangi ;i++) {
                        String productSerial = "";
                        String productCode = "";
                        String quantity = request.getParameter("qty_" + i);
                        productSerial = request.getParameter("icode_" + i);
                        String quantity1 = "0";
                        
                        if (productSerial.isEmpty() || productSerial == null)
                            productSerial = "";
                        
                        if (productCode.isEmpty() || productCode == null)
                            productCode = "";
                        
                        System.out.println("2. Item Serial "+productSerial+ " Item Product "+productCode+ "  Qty " + quantity);
                        
                        if(quantity != null && quantity.length() > 0 && productSerial != null && productSerial.length() > 0) {
                            int Qty = Integer.parseInt(quantity);
                            if(Qty > 0) {
                                
                                int idproduct = productMgr.getIdProduct(productSerial).getProductID();
                                productCode = productMgr.getIdProduct(productSerial).getProductCode();
                                
                                
                                if(Qty <= getProductBalance(idproduct, null, storeCode)) {
                                    InventoryBean inventoryBean = new InventoryBean();
                                    inventoryBean.setTrnxType("SKLO");
                                    inventoryBean.setTotalOut(Qty);
                                    inventoryBean.setOwnerType(fromOutletBean.getType());
                                    inventoryBean.setOwnerID(fromOutletBean.getOutletID());
                                    inventoryBean.setStoreCode(storeCode);
                                    // inventoryBean.setTarget(refNo);
                                    inventoryBean.setTarget(custID);
                                    inventoryBean.setTargetRemark(targetRemark);
                                    inventoryBean.setProductID(idproduct);
                                    inventoryBean.setProductType(0);
                                    
                                    inventoryBean.setProductCode(productCode);
                                    inventoryBean.setProductSerial(productSerial);
                                    
                                    inventoryBean.setRemark(Remark);
                                    inventoryBean.setStatus(90);
                                    inventoryBean.setTrnxDate(new Date());
                                    inventoryBean.setTrnxTime(new Date());
                                    inventoryBean.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                                    list.add(inventoryBean);
                                    
                                } else {
                                    returnBean.fail();
                                    returnBean.setSysError(" Selected product  not enough quantity in the inventory. Failed to procceed.");
                                    return returnBean;
                                }
                                
                                
                                
                            }
                        }
                    }
                    
                    String refNo4 = addRecord(list, "SLNO");
                    System.out.println("refNo4 "+refNo4);
                    
                    if(refNo4 != null) {
                        returnBean.addReturnObject("RefNo", refNo4);
                        // returnBean.addReturnObject("OutletTo", toOutletBean);
                        returnBean.addReturnObject("Outlet", fromOutletBean);
                        returnBean.done();
                    } else {
                        returnBean.fail();
                    }
                    
                    break;
                }
                
                case 102061:    
                {
                    String storeCode;
                    String refNo = null;
                    String custID = null;
                    String Remark;
                    String targetRemark;
                    String remarkPro[];
                    String productIDs[];
                    ArrayList list;
                    OutletBean outletBean = null;
                    
                    OutletBean fromOutletBean;
                    
                    ProductManager productMgr = new ProductManager();
                    
                    returnBean = new MvcReturnBean();
                    storeCode = request.getParameter("id");
                    storeCode = storeCode == null || storeCode.length() != 0 ? storeCode : null;
                    refNo = request.getParameter("storeTo");
                    custID = request.getParameter("custID");                    
                    targetRemark = request.getParameter("custName");
                    Remark = request.getParameter("Remark");
                    
                    remarkPro = request.getParameterValues("icode_");
                    productIDs = request.getParameterValues("qty");
                    
                    list = new ArrayList();
                    OutletStoreBean fromStoreBean = (new OutletStoreManager()).getOutletStore(storeCode);
                    fromOutletBean = (new OutletManager()).getRecord(fromStoreBean.getOutletID());
                    
                    MemberBean toStoreBean = getMember(custID, false);
                    MemberBean toOutletBean = getMember(custID, false);
                    
                    String ulang = request.getParameter("ulangi_kit2");
                    int ulangi = Integer.parseInt(request.getParameter("ulangi_kit2"));
                    boolean status = false;
                    
                    for(int i=1;i<ulangi ;i++) {
                        String productSerial = "";
                        String productCode = "";
                        String quantity = request.getParameter("qty_" + i);
                        productSerial = request.getParameter("icode_" + i);
                        String quantity1 = "0";
                        
                        if (productSerial.isEmpty() || productSerial == null)
                            productSerial = "";
                        
                        if (productCode.isEmpty() || productCode == null)
                            productCode = "";
                        
                        System.out.println("2. Item Serial "+productSerial+ " Item Product "+productCode+ "  Qty " + quantity);
                        
                        if(quantity != null && quantity.length() > 0 && productSerial != null && productSerial.length() > 0) {
                            int Qty = Integer.parseInt(quantity);
                            if(Qty > 0) {
                                
                                int idproduct = productMgr.getIdProduct(productSerial).getProductID();
                                productCode = productMgr.getIdProduct(productSerial).getProductCode();
                                
                                
                                //if(Qty <= getProductBalance(idproduct, null, storeCode)) {
                                    InventoryBean inventoryBean = new InventoryBean();
                                    inventoryBean.setTrnxType("SKLI");
                                    inventoryBean.setTotalIn(Qty);
                                    inventoryBean.setOwnerType(fromOutletBean.getType());
                                    inventoryBean.setOwnerID(fromOutletBean.getOutletID());
                                    inventoryBean.setStoreCode(storeCode);
                                    // inventoryBean.setTarget(refNo);
                                    inventoryBean.setTarget(custID);
                                    inventoryBean.setTargetRemark(targetRemark);
                                    inventoryBean.setProductID(idproduct);
                                    inventoryBean.setProductType(0);
                                    
                                    inventoryBean.setProductCode(productCode);
                                    inventoryBean.setProductSerial(productSerial);
                                    
                                    inventoryBean.setRemark(Remark);
                                    inventoryBean.setStatus(100);
                                    inventoryBean.setTrnxDate(new Date());
                                    inventoryBean.setTrnxTime(new Date());
                                    inventoryBean.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                                    list.add(inventoryBean);
                                    
                                //} else {
                                //    returnBean.fail();
                                //   returnBean.setSysError(" Selected product  not enough quantity in the inventory. Failed to procceed.");
                                //     return returnBean;
                                //}
                                
                                
                                
                            }
                        }
                    }
                    
                    String refNo4 = addRecord(list, "SLNI");
                    System.out.println("refNo4 "+refNo4);
                    
                    if(refNo4 != null) {
                        returnBean.addReturnObject("RefNo", refNo4);
                        // returnBean.addReturnObject("OutletTo", toOutletBean);
                        returnBean.addReturnObject("Outlet", fromOutletBean);
                        returnBean.done();
                    } else {
                        returnBean.fail();
                    }
                    
                    break;
                }

                
                case 102045:
                {
                    String storeCode;
                    String refNo = null;
                    String remark1;
                    String targetRemark;
                    String remarkPro[];
                    String productIDs[];
                    ArrayList list;
                    OutletBean outletBean = null;
                    int i;
                    
                    OutletBean fromOutletBean;
                    OutletBean toOutletBean;
                    
                    returnBean = new MvcReturnBean();
                    storeCode = request.getParameter("id");
                    storeCode = storeCode == null || storeCode.length() != 0 ? storeCode : null;
                    refNo = request.getParameter("storeTo");
                    targetRemark = request.getParameter("Remark");
                    remarkPro = request.getParameterValues("product_id");
                    productIDs = request.getParameterValues("qty");
                    list = new ArrayList();
                    OutletStoreBean fromStoreBean = (new OutletStoreManager()).getOutletStore(storeCode);
                    fromOutletBean = (new OutletManager()).getRecord(fromStoreBean.getOutletID());
                    OutletStoreBean toStoreBean = (new OutletStoreManager()).getOutletStore(refNo);
                    toOutletBean = (new OutletManager()).getRecord(toStoreBean.getOutletID());
                    i = 0;
                    
                    for(i = 0; i < remarkPro.length; i++) {
                        int qty = 0;
                        if(productIDs[i].length() > 0) {
                            // if(productIDs[i].length() > 0)
                            qty = Integer.parseInt(productIDs[i]);
                            if(qty > 0) {
                                if(qty <= getProductBalance(Integer.parseInt(remarkPro[i]), null, storeCode)) {
                                    InventoryBean inventoryBean = new InventoryBean();
                                    inventoryBean.setTrnxType("STIO");
                                    inventoryBean.setTotalOut(qty);
                                    inventoryBean.setOwnerType(fromOutletBean.getType());
                                    inventoryBean.setOwnerID(fromOutletBean.getOutletID());
                                    inventoryBean.setStoreCode(storeCode);
                                    inventoryBean.setTarget(refNo);
                                    inventoryBean.setProductID(Integer.parseInt(remarkPro[i]));
                                    inventoryBean.setProductType(0);
                                    inventoryBean.setRemark(targetRemark);
                                    inventoryBean.setStatus(100);
                                    inventoryBean.setTrnxDate(new Date());
                                    inventoryBean.setTrnxTime(new Date());
                                    inventoryBean.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                                    list.add(inventoryBean);
                                    
                                    InventoryBean _inventoryBean = new InventoryBean();
                                    _inventoryBean.setTrnxType("STII");
                                    _inventoryBean.setTotalIn(qty);
                                    _inventoryBean.setOwnerType(toOutletBean.getType());
                                    _inventoryBean.setOwnerID(toOutletBean.getOutletID());
                                    _inventoryBean.setStoreCode(refNo);
                                    _inventoryBean.setTarget(storeCode);
                                    _inventoryBean.setProductID(Integer.parseInt(remarkPro[i]));
                                    _inventoryBean.setProductType(0);
                                    _inventoryBean.setRemark(targetRemark);
                                    _inventoryBean.setStatus(100);
                                    _inventoryBean.setTrnxDate(new Date());
                                    _inventoryBean.setTrnxTime(new Date());
                                    _inventoryBean.parseCreationInfo(getLoginUser().getOutletID(), getLoginUser().getUserId());
                                    list.add(_inventoryBean);
                                } else {
                                    returnBean.fail();
                                    returnBean.setSysError(" Selected product  not enough quantity in the inventory. Failed to procceed.");
                                    return returnBean;
                                }
                                
                                String refNo4 = addRecord(list, "STN");
                                if(refNo4 != null) {
                                    returnBean.addReturnObject("RefNo", refNo4);
                                    returnBean.addReturnObject("OutletTo", toOutletBean);
                                    returnBean.addReturnObject("Outlet", fromOutletBean);
                                    returnBean.done();
                                } else {
                                    returnBean.fail();
                                }
                                
                            }
                        }
                    }
                    
                    break;
                }
                
            }  /* end Switch */
            
        }  /* end Try */
        
        catch(Exception e) {
            if(returnBean == null)
                returnBean = new MvcReturnBean();
            returnBean.setException(e);
        }
        
        return returnBean;
        
    }
    
    private FIFOMap getInventoryCodeOnlyList(InventoryBean docnos[], boolean showDefault)
    throws Exception {
        FIFOMap maps = new FIFOMap();
        if(showDefault)
            maps.put("", "----");
        for(int i = 0; i < docnos.length; i++)
            maps.put(docnos[i].getTrnxDocNo(), docnos[i].getTrnxDocNo());
        
        return maps;
    }
    
    private FIFOMap getStoreCodeOnlyList(OutletStoreBean stores[], boolean showDefault)
    throws Exception {
        FIFOMap maps = new FIFOMap();
        if(showDefault)
            maps.put("", "----");
        for(int i = 0; i < stores.length; i++)
            maps.put(stores[i].getStoreID(), stores[i].getStoreID());
        
        return maps;
    }
    
    private FIFOMap getStoreCodeOnlyList(OutletStoreBean stores[], OutletStoreBean storeBean, boolean showDefault)
    throws Exception {
        FIFOMap maps = new FIFOMap();
        if(showDefault)
            maps.put("", "----");
        for(int i = 0; i < stores.length; i++)
            if(storeBean == null || !storeBean.getStoreID().equalsIgnoreCase(stores[i].getStoreID()))
                maps.put(stores[i].getStoreID(), stores[i].getStoreID());
        
        return maps;
    }
    
    private FIFOMap getSupplierNameOnlyList(SupplierBean suppliers[], boolean showDefault)
    throws Exception {
        FIFOMap maps = new FIFOMap();
        if(showDefault)
            maps.put("", "");
        for(int i = 0; i < suppliers.length; i++)
            maps.put(suppliers[i].getSupplierCode(), (new StringBuilder(String.valueOf(suppliers[i].getName()))).append(" (").append(suppliers[i].getSupplierCode()).append(")").toString());
        
        return maps;
    }
    
    private InventoryBean[] getStoreInventory(Locale locale, String storeCode)
    throws Exception {
        InventoryBean beans[];
        ProductBean productBeans[];
        Connection conn;
        ArrayList list = null;
        String brand = "";
        String product = "";
        String prodStatus = "";
        String prodDesc = "";
        String prodType = "";
        
        beans = (InventoryBean[])null;
        // productBeans = (new ProductManager()).getProductFullList(locale.toString());
        productBeans = (new ProductManager()).getProductFullListUpdate(locale.toString(), brand, product, prodDesc, prodType, prodStatus);
        
        conn = null;
        // if(productBeans == null || productBeans.length <= 0)
        // if(productBeans != null || productBeans.length > 0)
        // break MISSING_BLOCK_LABEL_199;
        list = new ArrayList();
        
        try {
            conn = getConnection();
            
            for(int i = 0; i < productBeans.length; i++) {
                InventoryBean inventoryBean = getBroker(conn).viewStoreInventory(productBeans[i].getProductID(), null, storeCode);
                if(productBeans[i].getInventory().equalsIgnoreCase("Y") && productBeans[i].getType().equalsIgnoreCase("S")) {
                    inventoryBean.setProductBean(productBeans[i]);
                    list.add(inventoryBean);
                }
            }
            
            if(!list.isEmpty())
                beans = (InventoryBean[])list.toArray(new InventoryBean[0]);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return beans;
    }
    
    
    private InventoryBean[] getStoreInventory2(Locale locale, String storeCode, String docno)
    throws Exception {
        InventoryBean beans[];
        ProductBean productBeans[];
        Connection conn;
        ArrayList list = null;
        beans = (InventoryBean[])null;
        productBeans = (new ProductManager()).getProductFullList(locale.toString());
        conn = null;
        list = new ArrayList();
        
        System.out.println("Chek docno 3" + docno);
        
        try {
            conn = getConnection();
            // String docno = "PT-STN00001695";
            
            for(int i = 0; i < productBeans.length; i++) {
                InventoryBean inventoryBean = getBroker(conn).viewStoreInventory2(docno,productBeans[i].getProductID(), null, storeCode);
                if(productBeans[i].getInventory().equalsIgnoreCase("Y") && productBeans[i].getType().equalsIgnoreCase("S")) {
                    inventoryBean.setProductBean(productBeans[i]);
                    list.add(inventoryBean);
                }
            }
            
            if(!list.isEmpty())
                beans = (InventoryBean[])list.toArray(new InventoryBean[0]);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return beans;
    }
    
    public boolean addRecord(InventoryBean inventoryBean)
    throws Exception {
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try {
            conn = getConnection();
            status = getBroker(conn).addRecord(inventoryBean);
        } catch(Exception e) {
            status = false;
            Log.error(e);
        }
        releaseConnection(conn);
        return status;
    }
    
    public String addRecordAwal(ArrayList list, String docType)
    throws Exception {
        String refNo;
        Connection conn;
        boolean status;
        refNo = null;
        conn = null;
        status = false;
        
        try {
            conn = getConnection(false);
            String ownerid = null;
            String docCode = null;
            
            if(list != null && list.size() > 0) {
                for(int i = 0; i < list.size(); i++) {
                    InventoryBean inventoryBean = (InventoryBean)list.get(i);
                    status = getBroker(conn).addRecord(inventoryBean);
                    // System.out.println("Cek i "+i);
                    if(ownerid == null)
                        ownerid = inventoryBean.getOwnerID();
                }
                
                OutletBean outlet = (new OutletManager(conn)).getRecord(ownerid);
                docCode = outlet.getDocCode();
                
                if(status) {
                    DocumentInterface docInterface = DocumentFactory.getDocumentMgr(docCode, docType, "Sequence Basis");
                    refNo = (String)docInterface.getDocumentNo1(); //Updated By Ferdi 2015-01-22
                    
                    for(int j = 0; j < list.size(); j++) {
                        InventoryBean inventoryBean = (InventoryBean)list.get(j);
                        // inventoryBean.setTrnxDocNo((docType.equalsIgnoreCase("STN")) ? refNo2 : refNo);
                        inventoryBean.setTrnxDocNo(refNo);
                        inventoryBean.setTrnxDocType(docType);
                        status = getBroker(conn).updateDocRecord(inventoryBean);
                        status = getBroker(conn).updateDocRecordTW2(refNo, docType, outlet);
                        // System.out.println("Cek j "+j);
                    }
                    
                }
            }
        } catch(Exception e) {
            status = false;
            Log.error(e);
        }
        commitTransaction();
        releaseConnection(conn);
        return refNo;
    }
    
    
    public String addRecord(ArrayList list, String docType)
    throws Exception {
        String refNo;
        Connection conn;
        boolean status;
        refNo = null;
        conn = null;
        status = false;
        String kode = null;
        int panjang = 0;
        
        try {
            conn = getConnection(false);
            String ownerid = null;
            String docCode = null;
            
            if(list != null && list.size() > 0) {
                for(int i = 0; i < list.size(); i++) {
                    InventoryBean inventoryBean = (InventoryBean)list.get(i);
                    status = getBroker(conn).addRecord(inventoryBean);
                    // System.out.println("Cek i "+i);
                    if(ownerid == null)
                        ownerid = inventoryBean.getOwnerID();
                }
                
                OutletBean outlet = (new OutletManager(conn)).getRecord(ownerid);
                docCode = outlet.getDocCode();
                
                kode = Integer.toString(outlet.getSeqID());
                panjang = kode.length();
                
                if(panjang==1)
                    kode = "0".concat(kode);
                
                if(status) {
                    
                    if(docType.equalsIgnoreCase("STN")) {
                        DocumentInterface docInterface = DocumentFactory.getDocumentMgr(kode, "TW", "Sequence Basis");
                        refNo = (String)docInterface.getDocumentNo1(); //Updated By Ferdi 2015-01-22
                    } else if (docType.equalsIgnoreCase("SLNO") || docType.equalsIgnoreCase("SLNI")) {
                        DocumentInterface docInterface = DocumentFactory.getDocumentMgr(kode, "SLN", "Sequence Basis");
                        refNo = (String)docInterface.getDocumentNo1(); //Updated By Ferdi 2015-01-22
                    }
                    
                    else {
                        DocumentInterface docInterface = DocumentFactory.getDocumentMgr(docCode, docType, "Sequence Basis");
                        refNo = (String)docInterface.getDocumentNo1(); //Updated By Ferdi 2015-01-22
                    }
                    
                    for(int j = 0; j < list.size(); j++) {
                        InventoryBean inventoryBean = (InventoryBean)list.get(j);
                        inventoryBean.setTrnxDocNo(refNo);
                        inventoryBean.setTrnxDocType(docType);
                        status = getBroker(conn).updateDocRecord(inventoryBean);
                        // status = getBroker(conn).updateDocRecordTW2(refNo, docType, outlet);
                    }
                    
                }
            }
        } catch(Exception e) {
            status = false;
            Log.error(e);
        }
        commitTransaction();
        releaseConnection(conn);
        return refNo;
    }
    
    
    public InventoryBean[] getRecordsByDocNumTW(String refNo, String docType1, String docType2, String ownerid, String locale) {
        InventoryBean inventoryBeans[];
        Connection conn;
        inventoryBeans = new InventoryBean[0];
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getRecordsByDocNumTW(refNo, docType1, docType2, ownerid, locale);
            inventoryBeans = (InventoryBean[])list.toArray(inventoryBeans);
        } catch(Exception e) {
            Log.error(e);
        }
        releaseConnection(conn);
        return inventoryBeans;
    }
    
    public InventoryBean[] getRecordsByDocNum(String refNo, String docType, String ownerid, String locale) {
        InventoryBean inventoryBeans[];
        Connection conn;
        inventoryBeans = new InventoryBean[0];
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getRecordsByDocNum(refNo, docType, ownerid, locale);
            inventoryBeans = (InventoryBean[])list.toArray(inventoryBeans);
        } catch(Exception e) {
            Log.error(e);
        }
        releaseConnection(conn);
        return inventoryBeans;
    }
    
    private void checkBonusPeriodInfoHE(MvcReturnBean returnBean, HttpServletRequest request) {
        BonusPeriodManager bonusPeriodManager = new BonusPeriodManager();
        boolean isBonusDateActive = false;
        try {
            Date bonusDate = Sys.parseDate(request.getParameter("BonusDate"));
            isBonusDateActive = bonusPeriodManager.isBonusPeriodActive(new java.sql.Date(bonusDate.getTime()), 50);
            if(isBonusDateActive) {
                System.out.println("Period Bonus has Active "+ bonusDate);
            } else {
                returnBean.addError("Initial Date is closed for sales");
            }
        } catch(Exception e) {
            returnBean.addError("Invalid Initial Date Format");
        }
    }
    
    public int getProductBalance(int productId, String outletId, String storeCode) {
        int qty;
        Connection conn;
        qty = 0;
        conn = null;
        try {
            conn = getConnection();
            InventoryBean bean = getBroker(conn).viewStoreInventory(productId, outletId, storeCode);
            if(bean != null)
                qty = bean.getTotal();
        } catch(Exception e) {
            Log.error(e);
        }
        releaseConnection(conn);
        return qty;
    }
    
    private InventoryBean[] getInventoryListByDoc(String outletid)
    throws Exception {
        InventoryBean beans[] = getStoreListingByDoc(outletid);
        return beans;
    }
    
    private InventoryBean[] getStoreListingByDoc(String param)
    throws MvcException {
        InventoryBean clist[];
        Connection conn;
        clist = new InventoryBean[0];
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getInventoryListingByDoc(param);
            if(!list.isEmpty())
                clist = (InventoryBean[])list.toArray(new InventoryBean[0]);
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return clist;
    }
    
    private InventoryBean getRecordsByDocNum(String id)
    throws Exception {
        InventoryBean bean;
        Connection conn;
        bean = null;
        conn = null;
        try {
            conn = getConnection();
            bean = getBroker(conn).getRecord(id);
            if(bean != null) {
                // PriceCodeBean list[] = getPriceCode(docno);
                // bean.setPriceCodes(list);
            }
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        releaseConnection(conn);
        return bean;
    }
    
    private FIFOMap getMapForSalesOutletList()
    throws Exception {
        FIFOMap map;
        Connection conn;
        map = new FIFOMap();
        conn = null;
        try {
            conn = getConnection();
            ArrayList list = getBroker(conn).getSalesOutletList();
            // map.put("", "Any");
            map.put("", "");
            for(int i = 0; i < list.size(); i++)
                map.put(list.get(i), list.get(i));
            
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return map;
    }
    
    
    private boolean updateTW(String DocNo, int statusDoc, String trxType, String user) {
        boolean status;
        status = false;
        Connection conn;
        conn = null;
        try {
            conn = getConnection();
            status = getBroker(conn).updateTW(DocNo, statusDoc, trxType, user);
        } catch(Exception e) {
            Log.error(e);
        }
        releaseConnection(conn);
        return status;
    }
    
    private boolean updateLOAN(String DocNo, int statusDoc, String trxType, String user) {
        boolean status;
        status = false;
        Connection conn;
        conn = null;
        try {
            conn = getConnection();
            status = getBroker(conn).updateLOAN(DocNo, statusDoc, trxType, user);
        } catch(Exception e) {
            Log.error(e);
        }
        releaseConnection(conn);
        return status;
    }
    
    private boolean voidTW(String DocNo, int statusDoc, String trxType, String user) {
        boolean status;
        status = false;
        Connection conn;
        conn = null;
        try {
            conn = getConnection();
            status = getBroker(conn).voidTW(DocNo, statusDoc, trxType, user);
        } catch(Exception e) {
            Log.error(e);
        }
        releaseConnection(conn);
        return status;
    }

    private boolean voidLoan(String DocNo, int statusDoc, String trxType, String user) {
        boolean status;
        status = false;
        Connection conn;
        conn = null;
        try {
            conn = getConnection();
            status = getBroker(conn).voidLoan(DocNo, statusDoc, trxType, user);
        } catch(Exception e) {
            Log.error(e);
        }
        releaseConnection(conn);
        return status;
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
        releaseConnection(conn);
        return clist;
       }

    private MemberBean getMember(String customerID, boolean bonusEarner)
    throws Exception {
        MemberBean buyer;
        Connection conn;
        String entity;
        buyer = null;
        conn = null;
        entity = bonusEarner ? "Bonus Earner" : "Member";
        try {
            conn = getConnection();
            buyer = (new MemberManager(conn)).getMemberByID(customerID, false);
            
            /*
            if(buyer == null)
                throw new Exception((new StringBuilder("No ")).append(entity).append(" found -> ").append(customerID).toString());
            if(buyer.getStatus() != 10)
                throw new Exception((new StringBuilder(String.valueOf(entity))).append(" status is INACTIVE -> ").append(customerID).toString());
            if(buyer.isHidden())
                throw new Exception((new StringBuilder(String.valueOf(entity))).append(" account is not valid for sales -> ").append(customerID).toString());
            */
            
        } catch(Exception e) {
            Log.error(e);
            throw new MvcException(e);
        }
        
        releaseConnection(conn);
        return buyer;
    }
    
     public boolean getValidateSerialNoTW(String sku_kode, String lokasi)
     throws MvcException{
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try
        {
            conn = getConnection();
            status = getBroker(conn).getValidateVerifyInAndVoidApprove(sku_kode, lokasi);
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
    public boolean getValidateVerifyOutSerialNoTW(String sku_kode, String lokasi)
     throws MvcException{
        boolean status;
        Connection conn;
        status = false;
        conn = null;
        try
        {
            conn = getConnection();
            status = getBroker(conn).getValidateVerifyOut(sku_kode, lokasi);
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

    private int getBalanceByProductID(String ownerID, Date trxDate, int productID) 
     throws MvcException{
        int balance = 0;
        Connection conn;
        conn = null;
        try
        {
            conn = getConnection();
            balance = getBroker(conn).getBalanceByProductID(ownerID, trxDate, productID);
        }
        catch(Exception e)
        {
            Log.error(e);
            throw new MvcException(e);
        }
        finally
        {
            releaseConnection(conn);
            return balance;
        }
     }    
    
    public boolean getValidateLoanOut(String sku_kode, String lokasi)
    throws MvcException
    {
        boolean status = false;
    
        Connection conn = null;
        try
        {
          conn = getConnection();
          status = getBroker(conn).cekOutstandingLO(sku_kode, lokasi);
        }
        catch (Exception e)
        {
          Log.error(e);
          throw new MvcException(e);
        }
        finally
        {
          releaseConnection(conn);
        }
        return status;
  }
  
  public String getValidateLoanIn(String sku_kode, String lokasi, String target)
  throws MvcException
  {
        String balance = "";

        Connection conn = null;
        try
        {
          conn = getConnection();
          balance = getBroker(conn).getAvailableLoanOut(sku_kode, lokasi, target);
        }
        catch (Exception e)
        {
          Log.error(e);
          throw new MvcException(e);
        }
        finally
        {
          releaseConnection(conn);
        }
        return balance;
      }
}
