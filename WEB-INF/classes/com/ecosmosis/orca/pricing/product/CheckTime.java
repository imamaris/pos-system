/*
 * CheckTime.java
 *
 * Created on May 22, 2012, 2:48 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package com.ecosmosis.orca.pricing.product;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author dodi.iswarman
 */
public class CheckTime {
    
  public static void main(String[] argv) {
 

       Date dNow = new Date( );
       SimpleDateFormat ft = 
       new SimpleDateFormat ("E yyyy.MM.dd 'at' hh:mm:ss a zzz");
     
       System.out.println("Current Date: " + ft.format(dNow));
 
  }
    
}
