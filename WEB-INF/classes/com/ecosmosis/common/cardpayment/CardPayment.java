// Decompiled by Yody
// File : Currency.class

package com.ecosmosis.common.cardpayment;

import com.ecosmosis.mvc.exception.MvcException;
import com.ecosmosis.util.log.Log;
import java.util.Hashtable;

// Referenced classes of package com.ecosmosis.common.currency:
//            CurrencyManager, CurrencyBean

public class CardPayment
{

    private static CardPayment singleton = null;
    protected static Hashtable table = null;
    protected static Object fullall[] = null;

    private CardPayment()
    {
        initTables();
        load();
    }

    public static CardPayment getInstance()
    {
        if(singleton == null)
            singleton = new CardPayment();
        return singleton;
    }

    protected int load()
    {
        CardPaymentManager cmgr = new CardPaymentManager();
        try
        {
            fullall = cmgr.getAllCurency();
            for(int i = 0; i < fullall.length; i++)
            {
                CardPaymentBean bean = (CardPaymentBean)fullall[i];
                table.put(bean.getCode(), bean);
            }

        }
        catch(MvcException e)
        {
            Log.error((new StringBuilder("Error While Loading Currency - ")).append(e.toString()).toString());
        }
        return fullall.length;
    }

    protected synchronized void initTables()
    {
        table = new Hashtable();
    }

    protected boolean add(String key, Object value)
        throws MvcException
    {
        boolean exist = table.containsKey(key);
        if(exist)
        {
            throw new MvcException("Key already exists in the tableING !");
        } else
        {
            table.put(key, value);
            return true;
        }
    }

    protected boolean delete(String key)
    {
        Object a = table.remove(key);
        return a != null;
    }

    protected boolean update(String key, Object value)
        throws MvcException
    {
        Object a = table.remove(key);
        if(a != null)
            table.put(key, value);
        else
            throw new MvcException("Key not exist in the tableING");
        return true;
    }

    public static Object getObject(String key)
    {
        return table.get(key);
    }

    public static int getInt(String key)
    {
        return Integer.parseInt((String)table.get(key));
    }

    public static double getDouble(String key)
    {
        return Double.parseDouble((String)table.get(key));
    }

    public static String getString(String key)
    {
        return (String)table.get(key);
    }

    public static Object[] getAll()
    {
        return fullall;
    }

    public static void reset()
    {
        singleton = null;
        Object o = getInstance();
    }

}
