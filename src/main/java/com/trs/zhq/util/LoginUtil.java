package com.trs.zhq.util;

import com.trs.zhq.entity.Users;
import org.springframework.util.StringUtils;

import java.util.HashMap;
import java.util.Map;

public class LoginUtil {
	public static String getLoginUserCard() {
		Object userinfos_card = RequestUtil.getSession().getAttribute(
				"USERSINFOS_CARD");
		Object userinfos_tel = RequestUtil.getSession().getAttribute(
				"USERSINFOS_TEL");
		if ((StringUtils.isEmpty(userinfos_card))
				|| (StringUtils.isEmpty(userinfos_tel))) {
			return null;
		}
		return userinfos_card.toString();
	}

	public static String getConsoleLoginUserName() {
		Object userinfoObj = RequestUtil.getSession().getAttribute(
				"CONSOLEUSER");
		Object userinfos_username = RequestUtil.getSession().getAttribute(
				"CONSOLEUSERNAME");
		if ((StringUtils.isEmpty(userinfoObj))
				|| (StringUtils.isEmpty(userinfoObj))) {
			return null;
		}
		return userinfos_username.toString();
	}

	public static Users getConsoleLoginUser() {
		Object userinfoObj = RequestUtil.getSession().getAttribute(
				"CONSOLEUSER");
		Object userinfos_username = RequestUtil.getSession().getAttribute(
				"CONSOLEUSERNAME");
		if ((StringUtils.isEmpty(userinfoObj))
				|| (StringUtils.isEmpty(userinfoObj))) {
			return null;
		}
		return (Users) userinfoObj;
	}

	public static void setAuth_map(Map<String, String> auth_map_login) {
		RequestUtil.getSession().setAttribute("auth_map_login", auth_map_login);
	}

	public static Map<String, String> getAuth_map() {
		Object obj = RequestUtil.getSession().getAttribute("auth_map_login");
		if (obj != null) {
			return (Map) obj;
		}
		return new HashMap();
	}
	
}
