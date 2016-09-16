// Decompiled by Yody
// File : DocumentInterface.class

package com.ecosmosis.orca.document;

import com.ecosmosis.mvc.exception.MvcException;
import java.sql.SQLException;

public interface DocumentInterface
{

    public abstract Object getDocumentNo()
        throws MvcException, SQLException;
    
    //Updated By Ferdi 2015-01-20
    public abstract Object getDocumentNo1()
        throws MvcException, SQLException;
    //

    public abstract String getId();
}
