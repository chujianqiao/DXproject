package com.trs.zhq.util;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class RequestUtil {
	public static HttpServletRequest getRequest() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		return request;
	}

	public static HttpSession getSession() {
		return getRequest().getSession();
	}

	public static String getSessionStrValues(String keys, String defaultValue) {
		return getSession().getAttribute(keys) == null ? defaultValue
				: getSession().getAttribute(keys).toString();
	}
}

/*
 * Location: C:\Users\UserHao\Desktop\通用框架\wms\WEB-INF\classes\
 * 
 * Qualified Name: com.wms.util.RequestUtil
 * 
 * JD-Core Version: 0.7.0.1
 */