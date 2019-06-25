package com.trs.zhq.util;

import java.util.HashMap;
import java.util.Map;

public class CodesUtil {
	public static String NORMAL_USER_STATUS = "1";
	public static short DEL_USER_STATUS = -1;
	public static short FORBIDDN_USER_STATUS = -2;
	public static String EXIT_TEL = "-2";
	public static String EXIT_USERNAME = "-3";
	public static String EXIT_EMAIL = "-1";
	public static String OK = "0";
	public static String Del_OK = "Del_OK";
	public static String Del_ERROR = "Del_ERROR";
	public static String ERROR = "ERROR";
	public static String PASS_NOT_SAME = "-4";
	public static Integer NORMAL_STATUS = Integer.valueOf(1);
	public static Integer DEL_STATUS = Integer.valueOf(-1);
	public static Integer FORBIDDEN_STATUS = Integer.valueOf(-2);
	public static String EXIT_ROLENAME = "-5";
	public static String ERROR_VALIDECODE = "VALCODE_ERROR";
	public static String ERROR_STATUS = "ERROT_STATUS";
	public static String UPPASSWORD_OK = "UPPASSWORD_OK";
	public static Map<String, String> codes_map;
	public static short NEW_APPLY = 0;
	public static short RECIEVE_APPLY = 1;
	public static short YFB_APPLY = 2;
	public static short YYQ_APPLY = 4;
	public static short YBJ_APPLY = 6;
	public static short YCX_APPLY = -2;
	public static short FINISHED_APPLY = 8;
	public static short BACK_APPLY = -1;
	public static short STATUS_BACK = -10;
	public static Integer APPLY_TYPEFLAG_W = Integer.valueOf(0);
	public static Integer APPLY_TYPEFLAG_H = Integer.valueOf(1);
	public static Integer APPLY_TYPEFLAG_D = Integer.valueOf(2);
	public static Integer APPLY_PAYTYPE_DF = Integer.valueOf(0);
	public static Integer APPLY_PAYTYPE_XF = Integer.valueOf(1);

	public static String getCodesMap(String key) {
		if (codes_map == null) {
			setCodesMap();
		}
		return (String) codes_map.get(key);
	}

	public static void setCodesMap() {
		if (codes_map == null) {
			codes_map = new HashMap();
		}
		codes_map.put(EXIT_TEL, "手机号已存在！");
		codes_map.put(EXIT_USERNAME, "用户名已存在！");
		codes_map.put(EXIT_EMAIL, "邮箱已存在！");
		codes_map.put(OK, "操作成功");
		codes_map.put(ERROR, "操作失败！请联系管理员。");
		codes_map.put(PASS_NOT_SAME, "确认旧密码输入是否正确！");
		codes_map.put(EXIT_ROLENAME, "角色名称已经存在，请重新输入！");
		codes_map.put(ERROR_STATUS, "状态错误，请联系管理员！");
		codes_map.put(ERROR_VALIDECODE, "验证码错误，请重新输入！");
		codes_map.put(UPPASSWORD_OK, "修改密码成功！");
		codes_map.put(Del_OK, "删除成功！！");
		codes_map.put(Del_ERROR, "删除失败！！");
	}
}

/*
 * Location: C:\Users\UserHao\Desktop\通用框架\wms\WEB-INF\classes\
 * 
 * Qualified Name: com.wms.util.CodesUtil
 * 
 * JD-Core Version: 0.7.0.1
 */