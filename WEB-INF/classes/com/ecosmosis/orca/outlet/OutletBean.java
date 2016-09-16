// Decompiled by Yody
// File : OutletBean.class

package com.ecosmosis.orca.outlet;

import com.ecosmosis.mvc.bean.MvcBean;
import com.ecosmosis.orca.member.MemberBean;
import com.ecosmosis.orca.outlet.store.OutletStoreBean;
import com.ecosmosis.orca.pricing.PriceCodeBean;
import java.sql.ResultSet;
import java.sql.SQLException;

public class OutletBean extends MvcBean
{

    private int seqID;
    private String outletID;
    private String docCode;
    private String name;
    private String homeBranchID;
    private String controlLocationID;
    private String operationCountryID;
    private String reg_prefix;
    private String type;
    private String registrationInfo;
    private String address1;
    private String address2;
    private String zipcode;
    private String countryID;
    private String regionID;
    private String stateID;
    private String cityID;
    private String homeTel;
    private String officeTel;
    private String mobileTel;
    private String faxNo;
    private String remark;
    private String supervisor;
    private int pickup_private;
    private int pickup_public;
    private String email;
    private String status;
    private String warehouseStoreCode;
    private String salesStoreCode;
    private String writeoffStoreCode;
    private PriceCodeBean priceCodes[];
    private OutletStoreBean warehouseStore;
    private OutletStoreBean salesStore;
    private OutletStoreBean writeoffStore;
    private MemberBean memberBean;
    private boolean isStockist;

    public OutletBean()
    {
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getEmail()
    {
        return email;
    }

    public void setEmail(String email)
    {
        this.email = email;
    }

    public String getAddress1()
    {
        return address1;
    }

    public void setAddress1(String address1)
    {
        this.address1 = address1;
    }

    public String getAddress2()
    {
        return address2;
    }

    public void setAddress2(String address2)
    {
        this.address2 = address2;
    }

    public String getCityID()
    {
        return cityID;
    }

    public void setCityID(String cityID)
    {
        this.cityID = cityID;
    }

    public String getControlLocationID()
    {
        return controlLocationID;
    }

    public void setControlLocationID(String controlLocationID)
    {
        this.controlLocationID = controlLocationID;
    }

    public String getCountryID()
    {
        return countryID;
    }

    public void setCountryID(String countryID)
    {
        this.countryID = countryID;
    }

    public String getDocCode()
    {
        return docCode;
    }

    public void setDocCode(String docCode)
    {
        this.docCode = docCode;
    }

    public String getFaxNo()
    {
        return faxNo;
    }

    public void setFaxNo(String faxNo)
    {
        this.faxNo = faxNo;
    }

    public String getMobileTel()
    {
        return mobileTel;
    }

    public void setMobileTel(String mobileTel)
    {
        this.mobileTel = mobileTel;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getOfficeTel()
    {
        return officeTel;
    }

    public void setOfficeTel(String officeTel)
    {
        this.officeTel = officeTel;
    }

    public String getOperationCountryID()
    {
        return operationCountryID;
    }

    public void setOperationCountryID(String operationCountryID)
    {
        this.operationCountryID = operationCountryID;
    }

    public String getOutletID()
    {
        return outletID;
    }

    public void setOutletID(String outletID)
    {
        this.outletID = outletID;
    }

    public int getPickup_private()
    {
        return pickup_private;
    }

    public void setPickup_private(int pickup_private)
    {
        this.pickup_private = pickup_private;
    }

    public int getPickup_public()
    {
        return pickup_public;
    }

    public void setPickup_public(int pickup_public)
    {
        this.pickup_public = pickup_public;
    }

    public String getReg_prefix()
    {
        return reg_prefix;
    }

    public void setReg_prefix(String reg_prefix)
    {
        this.reg_prefix = reg_prefix;
    }

    public String getRegionID()
    {
        return regionID;
    }

    public void setRegionID(String regionID)
    {
        this.regionID = regionID;
    }

    public String getRegistrationInfo()
    {
        return registrationInfo;
    }

    public void setRegistrationInfo(String registrationInfo)
    {
        this.registrationInfo = registrationInfo;
    }

    public String getRemark()
    {
        return remark;
    }

    public void setRemark(String remark)
    {
        this.remark = remark;
    }

    public int getSeqID()
    {
        return seqID;
    }

    public void setSeqID(int seqID)
    {
        this.seqID = seqID;
    }

    public String getStateID()
    {
        return stateID;
    }

    public void setStateID(String stateID)
    {
        this.stateID = stateID;
    }

    public String getSupervisor()
    {
        return supervisor;
    }

    public void setSupervisor(String supervisor)
    {
        this.supervisor = supervisor;
    }

    public String getType()
    {
        return type;
    }

    public void setType(String type)
    {
        this.type = type;
    }

    public String getZipcode()
    {
        return zipcode;
    }

    public void setZipcode(String zipcode)
    {
        this.zipcode = zipcode;
    }

    public String getSalesStoreCode()
    {
        return salesStoreCode;
    }

    public void setSalesStoreCode(String salesStoreCode)
    {
        this.salesStoreCode = salesStoreCode;
    }

    public String getWarehouseStoreCode()
    {
        return warehouseStoreCode;
    }

    public void setWarehouseStoreCode(String warehouseStoreCode)
    {
        this.warehouseStoreCode = warehouseStoreCode;
    }

    public String getWriteoffStoreCode()
    {
        return writeoffStoreCode;
    }

    public void setWriteoffStoreCode(String writeoffStoreCode)
    {
        this.writeoffStoreCode = writeoffStoreCode;
    }

    public void parseBean(OutletBean bean, ResultSet rs, String prefix)
        throws SQLException
    {
        bean.setSeqID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("otl_seq").toString()));
        bean.setOutletID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_outletid").toString()));
        bean.setDocCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_doccode").toString()));
        bean.setName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_name").toString()));
        bean.setHomeBranchID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_home_branchid").toString()));
        bean.setControlLocationID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_control_locationid").toString()));
        bean.setOperationCountryID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_operation_countryid").toString()));
        bean.setReg_prefix(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_register_prefix").toString()));
        bean.setType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_type").toString()));
        bean.setRegistrationInfo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_company_registerno").toString()));
        bean.setAddress1(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_address_line1").toString()));
        bean.setAddress2(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_address_line2").toString()));
        bean.setZipcode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_zipcode").toString()));
        bean.setCountryID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_countryid").toString()));
        bean.setRegionID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_regioinid").toString()));
        bean.setStateID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_stateid").toString()));
        bean.setCityID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_cityid").toString()));
        bean.setOfficeTel(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_officeno").toString()));
        bean.setFaxNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_faxno").toString()));
        bean.setMobileTel(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_mobileno").toString()));
        bean.setEmail(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_email").toString()));
        bean.setSupervisor(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_supervisor_name").toString()));
        bean.setPickup_private(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("otl_pickup_private").toString()));
        bean.setPickup_public(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("otl_pickup_public").toString()));
        bean.setRemark(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_remark").toString()));
        bean.setStatus(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_status").toString()));
        bean.setWarehouseStoreCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_warehouse_storecode").toString()));
        bean.setSalesStoreCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_sales_storecode").toString()));
        bean.setWriteoffStoreCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_writeoff_storecode").toString()));
    }

    public void parseBean(ResultSet rs)
        throws SQLException
    {
        parseBean(rs, "");
    }

    public void parseBean(ResultSet rs, String prefix)
        throws SQLException
    {
        setSeqID(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("otl_seq").toString()));
        setOutletID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_outletid").toString()));
        setDocCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_doccode").toString()));
        setName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_name").toString()));
        setHomeBranchID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_home_branchid").toString()));
        setControlLocationID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_control_locationid").toString()));
        setOperationCountryID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_operation_countryid").toString()));
        setReg_prefix(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_register_prefix").toString()));
        setType(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_type").toString()));
        setRegistrationInfo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_company_registerno").toString()));
        setAddress1(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_address_line1").toString()));
        setAddress2(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_address_line2").toString()));
        setZipcode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_zipcode").toString()));
        setCountryID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_countryid").toString()));
        setRegionID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_regioinid").toString()));
        setStateID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_stateid").toString()));
        setCityID(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_cityid").toString()));
        setOfficeTel(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_officeno").toString()));
        setFaxNo(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_faxno").toString()));
        setMobileTel(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_mobileno").toString()));
        setEmail(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_email").toString()));
        setSupervisor(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_supervisor_name").toString()));
        setPickup_private(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("otl_pickup_private").toString()));
        setPickup_public(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("otl_pickup_public").toString()));
        setWarehouseStoreCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_warehouse_storecode").toString()));
        setSalesStoreCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_sales_storecode").toString()));
        setWriteoffStoreCode(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_writeoff_storecode").toString()));
        setRemark(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_remark").toString()));
        setStatus(rs.getString((new StringBuilder(String.valueOf(prefix))).append("otl_status").toString()));
        parseInfo(rs, prefix);
    }

    public PriceCodeBean[] getPriceCodes()
    {
        return priceCodes;
    }

    public void setPriceCodes(PriceCodeBean priceCodes[])
    {
        this.priceCodes = priceCodes;
    }

    public OutletStoreBean getSalesStore()
    {
        return salesStore;
    }

    public void setSalesStore(OutletStoreBean salesStore)
    {
        this.salesStore = salesStore;
    }

    public OutletStoreBean getWarehouseStore()
    {
        return warehouseStore;
    }

    public void setWarehouseStore(OutletStoreBean warehouseStore)
    {
        this.warehouseStore = warehouseStore;
    }

    public OutletStoreBean getWriteoffStore()
    {
        return writeoffStore;
    }

    public void setWriteoffStore(OutletStoreBean writeoffStore)
    {
        this.writeoffStore = writeoffStore;
    }

    public String getHomeTel()
    {
        return homeTel;
    }

    public void setHomeTel(String homeTel)
    {
        this.homeTel = homeTel;
    }

    public String getHomeBranchID()
    {
        return homeBranchID;
    }

    public void setHomeBranchID(String homeBranchID)
    {
        this.homeBranchID = homeBranchID;
    }

    public boolean isStockist()
    {
        return isStockist;
    }

    public void setStockist(boolean isStockist)
    {
        this.isStockist = isStockist;
    }

    public MemberBean getMemberBean()
    {
        return memberBean;
    }

    public void setMemberBean(MemberBean memberBean)
    {
        this.memberBean = memberBean;
    }
}
