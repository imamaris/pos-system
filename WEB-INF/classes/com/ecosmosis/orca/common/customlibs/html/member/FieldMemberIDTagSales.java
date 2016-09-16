// Decompiled by Yody
// File : FieldMemberIDTag.class

package com.ecosmosis.orca.common.customlibs.html.member;

import com.ecosmosis.mvc.sys.Sys;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.SimpleTagSupport;

public class FieldMemberIDTagSales extends SimpleTagSupport
{

    private Object value;
    private String name;
    private String id;
    private String onkeyup;
    private int size;
    private int maxlength;
    private int height;
    private int width;
    private int taskid;
    private String form;
    private String status;
    private String pstatus;
    

    public FieldMemberIDTagSales()
    {
        value = null;
        name = null;
        size = 15;
        maxlength = 15;
        width = 800;
        height = 450;
        // taskid = 0x1964b; 19666
        taskid = 0x19666;
        form = null;
        status = null;
        pstatus = null;
    }

    public void setTaskid(int taskid)
    {
        this.taskid = taskid;
    }

    public void setValue(Object value)
    {
        this.value = value;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public void setSize(int size)
    {
        this.size = size;
    }

    public void setForm(String form)
    {
        this.form = form;
    }

    public void setMaxlength(int maxlength)
    {
        this.maxlength = maxlength;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public void setPstatus(String pstatus)
    {
        this.pstatus = pstatus;
    }

    public void doTag()
        throws JspException, IOException
    {
        StringBuffer displayText = new StringBuffer();
        status = status == null ? "" : status;
        pstatus = pstatus == null ? "" : pstatus;
        String size_txt = size < 0 ? "" : (new StringBuilder("size=")).append(size).append(" ").toString();
        String maxlength_txt = maxlength < 0 ? "" : (new StringBuilder("maxlength=")).append(maxlength).append(" ").toString();
        HttpServletRequest request = (HttpServletRequest)((PageContext)getJspContext()).getRequest();
        String value_txt = request.getParameter(name);
        if((value == null || value.toString().length() <= 0) && value_txt != null && value_txt.length() > 0)
            value = replaceCodes(value_txt);
        displayText.append((new StringBuilder("<input type=text  name=\"")).append(name == null ? "MemberID" : name).append("\" ").append(size_txt).append(maxlength_txt).append(" value=\"").append(value == null ? "" : value).append("\" ").append(status).append(" >").toString());
        if(form != null && form.length() > 0)
        {
            String link = (new StringBuilder(String.valueOf(Sys.getControllerURL(taskid, request)))).append("&FormName=").append(form).append("&ObjName=").append(name == null ? "MemberID" : name).append("&").append(pstatus).toString();
            displayText.append(popUp(link));
        }
        getJspContext().getOut().write(displayText.toString());
    }

    private String popUp(String link)
    {
        StringBuffer strBuff = new StringBuffer();
        strBuff.append((new StringBuilder("<a href=\"")).append(link).append("\" onClick=\"").toString());
        strBuff.append((new StringBuilder("window.open(this.href,'MyPopup','menubr=no,resizable=yes,toolbar=no,scrollbars=yes,status=no,width=")).append(width).append(",height=").append(height).append(",").append("screenX=0,screenY=0');return false;\"").append(">").append("&nbsp;").append("<img border=0 alt='Search Customer' src=\"").append(Sys.getWebapp()).append("/img/lookup.gif\"/>").append("</a>").append("\n").toString());
        return strBuff.toString();
    }

    private String replaceCodes(String _value)
    {
        String text = "";
        if(_value != null && _value.length() > 0)
        {
            text = _value.replaceAll("\"", "&quot;");
            text = text.replaceAll("'", "&#39;");
        }
        return text;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOnkeyup() {
        return onkeyup;
    }

    public void setOnkeyup(String onkeyup) {
        this.onkeyup = onkeyup;
    }
}
