// Decompiled by Yody
// File : StandardOptionsMap.class

package com.ecosmosis.util.http;

import com.ecosmosis.common.customlibs.FIFOMap;

public class StandardOptionsMap
{

    public StandardOptionsMap()
    {
    }

    public static FIFOMap getComparisonMap(boolean showDefault)
        throws Exception
    {
        FIFOMap maps = new FIFOMap();
        if(showDefault)
            maps.put("", "----");
        maps.put("=", "=");
        maps.put(">", ">");
        maps.put("<", "<");
        maps.put(">=", ">=");
        maps.put("<=", "<=");
        return maps;
    }

    public static FIFOMap getIntegerStatusMap(boolean showDefault, boolean showAll)
        throws Exception
    {
        FIFOMap maps = new FIFOMap();
        if(showDefault)
            maps.put("", "----");
        if(showAll)
            maps.put("0", "GENERAL_ALL");
        maps.put("1", "GENERAL_ACTIVE ");
        maps.put("2", "GENERAL_INACTIVE");
        return maps;
    }
    

    public static FIFOMap getActiveOrInativeMap(boolean showDefault, boolean showAll)
        throws Exception
    {
        FIFOMap maps = new FIFOMap();
        if(showDefault)
            maps.put("", "----");
        if(showAll)
            maps.put("", "GENERAL_ALL");
        maps.put("A", "GENERAL_ACTIVE");
        maps.put("I", "GENERAL_INACTIVE");
        return maps;
    }

    public static FIFOMap getActiveOrInativeMap2(boolean showDefault, boolean showAll)
        throws Exception
    {
        FIFOMap maps = new FIFOMap();
        if(showDefault)
            maps.put("", "----");
        maps.put("A", "GENERAL_ACTIVE");
        maps.put("I", "GENERAL_INACTIVE");
        if(showAll)
            maps.put("", "GENERAL_ALL");        
        return maps;
    }
    
    public static FIFOMap getYearMap(boolean showDefault, boolean showAll, int fromyear, int toyear)
        throws Exception
    {
        FIFOMap maps = new FIFOMap();
        if(showDefault)
            maps.put("", "----");
        if(showAll)
            maps.put("", "ALL");
        for(int i = fromyear; i <= toyear; i++)
            maps.put(Integer.toString(i), Integer.toString(i));

        return maps;
    }

    public static FIFOMap getMonthMap(boolean showDefault, boolean showAll)
        throws Exception
    {
        FIFOMap maps = new FIFOMap();
        if(showDefault)
            maps.put("", "----");
        if(showAll)
            maps.put("", "ALL");
        maps.put("1", "JAN");
        maps.put("2", "FEB");
        maps.put("3", "MAR");
        maps.put("4", "APR");
        maps.put("5", "MAY");
        maps.put("6", "JUN");
        maps.put("7", "JUL");
        maps.put("8", "AUG");
        maps.put("9", "SEP");
        maps.put("10", "OCT");
        maps.put("11", "NOV");
        maps.put("12", "DEC");
        return maps;
    }


}
