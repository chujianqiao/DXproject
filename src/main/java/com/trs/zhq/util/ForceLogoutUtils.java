package com.trs.zhq.util;


import javax.servlet.http.HttpSession;
import java.util.Enumeration;

/**
 * Created by HuLuo on 2016/8/20.
 */
public class ForceLogoutUtils {
    public static void forceUserLogout(String username){
        if(SessionListener.sessionMap.get( username ) != null){
            HttpSession session = SessionListener.sessionMap.get( username );
 
            SessionListener.sessionMap.remove( username );
 
            Enumeration e = session.getAttributeNames();
 
            while(e.hasMoreElements()){
                String sessionName = (String) e.nextElement();
 
                session.removeAttribute( sessionName );
            }
 
            session.invalidate();
        }
    }
}
