// Decompiled by Yody
// File : InventoryDocsViewTag.class

package com.ecosmosis.orca.common.customlibs.html.document;

import com.ecosmosis.mvc.sys.Sys;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.SimpleTagSupport;

public class InventoryDocsViewTag extends SimpleTagSupport
{

    private Object value;
    private Object value2;
    
    private String params;
    private String doc;
    private int type;
    private int width;
    private int height;

    public InventoryDocsViewTag()
    {
        value = null;
        params = null;
        doc = null;
        type = -1;
        width = 800;
        height = 450;
    }

    public void setType(int type)
    {
        this.type = type;
    }

    public void setValue(Object value)
    {
        this.value = value;
    }

    public void setValue2(Object value2)
    {
        this.value2 = value2;
    }
    
    public void setDoc(String doc)
    {
        this.doc = doc;
    }

    public void setW(int width)
    {
        this.width = width;
    }

    public void setH(int height)
    {
        this.height = height;
    }

    public void setParams(String params)
    {
        this.params = params;
    }

    public void doTag()
        throws JspException, IOException
    {
        StringBuffer displayText = new StringBuffer();
        String link = (new StringBuilder(String.valueOf(getLink()))).append(params == null ? "" : (new StringBuilder("&")).append(params).toString()).toString();
        if(link.length() > 0)
            displayText.append((new StringBuilder("<a href=\"")).append(link).append("\" ").toString());
        if(type > 0 && link.length() > 0)
            displayText.append(popUp(link));
        if(link.length() > 0)
            displayText.append(">");
        displayText.append(value.toString());
        if(link.length() > 0)
            displayText.append("</a>");
        getJspContext().getOut().write(displayText.toString());
    }

    private String getLink()
    {
        String link = "";
        HttpServletRequest request = (HttpServletRequest)((PageContext)getJspContext()).getRequest();
        if(doc.equalsIgnoreCase("SKBO"))
            link = (new StringBuilder(String.valueOf(Sys.getControllerURL(0x18e93, request)))).append("&RefNo=").append(value).toString();
        else
        if(doc.equalsIgnoreCase("SKCO"))
            link = (new StringBuilder(String.valueOf(Sys.getControllerURL(0x18e87, request)))).append("&RefNo=").append(value).toString();
        else
        if(doc.equalsIgnoreCase("SKDI") || doc.equalsIgnoreCase("SKDO"))
            link = (new StringBuilder(String.valueOf(Sys.getControllerURL(0x18e83, request)))).append("&RefNo=").append(value).toString();
        /*
        else        
        if(doc.equalsIgnoreCase("SKLO"))
            link = (new StringBuilder(String.valueOf(Sys.getControllerURL(0x18e8b, request)))).append("&RefNo=").append(value).toString();
        
        else
        if(doc.equalsIgnoreCase("SKLI"))
            link = (new StringBuilder(String.valueOf(Sys.getControllerURL(0x18e8f, request)))).append("&RefNo=").append(value).toString();
        */
        else
        if(doc.equalsIgnoreCase("SKPI"))
            link = (new StringBuilder(String.valueOf(Sys.getControllerURL(0x18e7b, request)))).append("&RefNo=").append(value).toString();
        else
        if(doc.equalsIgnoreCase("SKPO"))
            link = (new StringBuilder(String.valueOf(Sys.getControllerURL(0x18e7f, request)))).append("&RefNo=").append(value).toString();
        else
        if(doc.equalsIgnoreCase("STIO") || doc.equalsIgnoreCase("STII"))
            link = (new StringBuilder(String.valueOf(Sys.getControllerURL(0x18e97, request)))).append("&RefNo=").append(value).toString();
        else
        if(doc.equalsIgnoreCase("STEO") || doc.equalsIgnoreCase("STEI"))
            link = (new StringBuilder(String.valueOf(Sys.getControllerURL(0x18e9b, request)))).append("&RefNo=").append(value).toString();
        else
        // new TW    
        if(doc.equalsIgnoreCase("STAO"))
            link = (new StringBuilder(String.valueOf(Sys.getControllerURL(0x18e9f, request)))).append("&RefNo=").append(value2).toString();        
        else
        if(doc.equalsIgnoreCase("STAI"))
            link = (new StringBuilder(String.valueOf(Sys.getControllerURL(0x18ea0, request)))).append("&RefNo=").append(value2).toString();
        else
        if(doc.equalsIgnoreCase("TW"))
            link = (new StringBuilder(String.valueOf(Sys.getControllerURL(0x18ea1, request)))).append("&RefNo=").append(value2).toString();
        else
        if(doc.equalsIgnoreCase("VOID"))
            link = (new StringBuilder(String.valueOf(Sys.getControllerURL(0x18ea6, request)))).append("&RefNo=").append(value2).toString();        
        else
        if(doc.equalsIgnoreCase("IN"))
            link = (new StringBuilder(String.valueOf(Sys.getControllerURL(0x18ea2, request)))).append("&RefNo=").append(value2).toString();
        
        // new LOAN    
        else
        if(doc.equalsIgnoreCase("SKLO")) /* 102053 */
           link = (new StringBuilder(String.valueOf(Sys.getControllerURL(0x18ea9, request)))).append("&RefNo=").append(value2).toString();        
        else
        if(doc.equalsIgnoreCase("SKLI")) /* 102062 */
           link = (new StringBuilder(String.valueOf(Sys.getControllerURL(0x18eae, request)))).append("&RefNo=").append(value2).toString();        
        else
        if(doc.equalsIgnoreCase("LOAN")) /* 102058 */
            link = (new StringBuilder(String.valueOf(Sys.getControllerURL(0x18eaa, request)))).append("&RefNo=").append(value2).toString();
        else
        if(doc.equalsIgnoreCase("VOIDLOAN")) /* 102064 */
            link = (new StringBuilder(String.valueOf(Sys.getControllerURL(0x18eb0, request)))).append("&RefNo=").append(value2).toString();        
        else
        if(doc.equalsIgnoreCase("SLIN")) /* 102050 */
            link = (new StringBuilder(String.valueOf(Sys.getControllerURL(0x18ea2, request)))).append("&RefNo=").append(value2).toString();
        else
        if(doc.equalsIgnoreCase("GR")) /* 102024 */ //Updated By Ferdi 2015-09-02
           link = (new StringBuilder(String.valueOf(Sys.getControllerURL(0x18e88, request)))).append("&RefNo=").append(value2).toString();
        
        return link;
    }

    private String popUp(String link)
    {
        StringBuffer strBuff = new StringBuffer();
        strBuff.append("onClick=\"");
        strBuff.append((new StringBuilder("window.open(this.href,'MyPopup','menubr=no,resizable=yes,toolbar=no,scrollbars=yes,status=no,width=")).append(width).append(",height=").append(height).append(",").append("screenX=0,screenY=0');return false\"").append("\n").toString());
        return strBuff.toString();
    }
}
