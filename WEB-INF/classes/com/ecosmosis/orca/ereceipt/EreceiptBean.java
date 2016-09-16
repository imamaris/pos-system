/*
 * EreceiptBean.java
 *
 * Created on July 22, 2015, 3:02 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ecosmosis.orca.ereceipt;

import com.ecosmosis.mvc.bean.MvcBean;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author ferdiansyah.dwiputra
 */
public class EreceiptBean extends MvcBean {
    
    private String ercptEmail;
    private String ercptPassword;
    private String ercptHost;
    private int ercptPort;
    private String ercptName;
    private String ercptSubject;
    private String ercptMsg;
    private String ercptEmailReply;
    private int ercptStatus;
    private String ercptGroup;
    private String ercptCc;
    private String ercptBcc;      

    public String getErcptEmail() {
        return ercptEmail;
    }

    public void setErcptEmail(String ercptEmail) {
        this.ercptEmail = ercptEmail;
    }

    public String getErcptPassword() {
        return ercptPassword;
    }

    public void setErcptPassword(String ercptPassword) {
        this.ercptPassword = ercptPassword;
    }

    public String getErcptHost() {
        return ercptHost;
    }

    public void setErcptHost(String ercptHost) {
        this.ercptHost = ercptHost;
    }
    
    public int getErcptPort() {
        return ercptPort;
    }

    public void setErcptPort(int ercptPort) {
        this.ercptPort = ercptPort;
    }
    
    public String getErcptName() {
        return ercptName;
    }

    public void setErcptName(String ercptName) {
        this.ercptName = ercptName;
    }

    public String getErcptSubject() {
        return ercptSubject;
    }

    public void setErcptSubject(String ercptSubject) {
        this.ercptSubject = ercptSubject;
    }

    public String getErcptMsg() {
        return ercptMsg;
    }

    public void setErcptMsg(String ercptMsg) {
        this.ercptMsg = ercptMsg;
    }

    public String getErcptEmailReply() {
        return ercptEmailReply;
    }

    public void setErcptEmailReply(String ercptEmailReply) {
        this.ercptEmailReply = ercptEmailReply;
    }
    
    public int getErcptStatus() {
        return ercptStatus;
    }

    public void setErcptStatus(int ercptStatus) {
        this.ercptStatus = ercptStatus;
    }
    
    
    public String getErcptGroup() {
        return ercptGroup;
    }

    public void setErcptGroup(String ercptGroup) {
        this.ercptGroup = ercptGroup;
    }
    
    protected void parseBean(ResultSet rs)
        throws SQLException
    {
        parseBean(rs, "");
    }
    
    public void parseBean(ResultSet rs, String prefix)
        throws SQLException
    {
        if(prefix == null)
            prefix = "";
        setErcptEmail(rs.getString((new StringBuilder(String.valueOf(prefix))).append("ercpt_email").toString()));
        setErcptPassword(rs.getString((new StringBuilder(String.valueOf(prefix))).append("ercpt_password").toString()));
        setErcptHost(rs.getString((new StringBuilder(String.valueOf(prefix))).append("ercpt_host").toString()));
        setErcptPort(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("ercpt_port").toString()));
        setErcptName(rs.getString((new StringBuilder(String.valueOf(prefix))).append("ercpt_name").toString()));
        setErcptSubject(rs.getString((new StringBuilder(String.valueOf(prefix))).append("ercpt_subject").toString()));
        setErcptMsg(rs.getString((new StringBuilder(String.valueOf(prefix))).append("ercpt_msg").toString()));
        setErcptEmailReply(rs.getString((new StringBuilder(String.valueOf(prefix))).append("ercpt_email_reply").toString()));
        setErcptStatus(rs.getInt((new StringBuilder(String.valueOf(prefix))).append("ercpt_status").toString()));
        setErcptGroup(rs.getString((new StringBuilder(String.valueOf(prefix))).append("ercpt_group").toString()));
        setErcptCc(rs.getString((new StringBuilder(String.valueOf(prefix))).append("ercpt_cc").toString()));
        setErcptBcc(rs.getString((new StringBuilder(String.valueOf(prefix))).append("ercpt_bcc").toString()));
    }

    public String getErcptCc() {
        return ercptCc;
    }

    public void setErcptCc(String ercptCc) {
        this.ercptCc = ercptCc;
    }

    public String getErcptBcc() {
        return ercptBcc;
    }

    public void setErcptBcc(String ercptBcc) {
        this.ercptBcc = ercptBcc;
    }

}
