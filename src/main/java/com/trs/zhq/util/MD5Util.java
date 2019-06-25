package com.trs.zhq.util;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5Util {
	public static String getMD5(String str) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");

			md.update(str.getBytes());

			return new BigInteger(1, md.digest()).toString(16);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static String MD5(String s) {
		char[] hexDigits = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				'A', 'B', 'C', 'D', 'E', 'F' };
		try {
			byte[] btInput = s.getBytes();

			MessageDigest mdInst = MessageDigest.getInstance("MD5");

			mdInst.update(btInput);

			byte[] md = mdInst.digest();

			int j = md.length;
			char[] str = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte byte0 = md[i];
				str[(k++)] = hexDigits[(byte0 >>> 4 & 0xF)];
				str[(k++)] = hexDigits[(byte0 & 0xF)];
			}
			return new String(str);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static String sortFromEndAndMd5(String pass, String userid) {
		return MD5(pass + MD5(userid));
	}

	public static String decodeStr(String str) {
		return str;
	}

	public static boolean compareWithPasswords(String submitPassword,
                                               String dbPassword, String userid) {
		if (dbPassword.equals(sortFromEndAndMd5(submitPassword, userid))) {
			return true;
		}
		return false;
	}
	public static String md5(String string) throws NoSuchAlgorithmException {
		if(string == null){
			return null;
		}
		char hexDigits[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				'A', 'B', 'C', 'D', 'E', 'F'};
		byte[] btInput = string.getBytes();
		try{
			/** 获得MD5摘要算法的 MessageDigest 对象 */
			MessageDigest mdInst = MessageDigest.getInstance("MD5");
			/** 使用指定的字节更新摘要 */
			mdInst.update(btInput);
			/** 获得密文 */
			byte[] md = mdInst.digest();
			/** 把密文转换成十六进制的字符串形式 */
			int j = md.length;
			char str[] = new char[j * 2];
			int k = 0;
			for (byte byte0 : md) {
				str[k++] = hexDigits[byte0 >>> 4 & 0xf];
				str[k++] = hexDigits[byte0 & 0xf];
			}
			return new String(str);
		}catch(NoSuchAlgorithmException e){
			return null;
		}
	}
	public static void main(String[] args) {
		System.out.println(sortFromEndAndMd5(MD5("tfsadmin"),
				"e7864ab3-9578-45b5-8a34-208d57eed6df41"));
	}
}

/*
 * Location: C:\Users\UserHao\Desktop\通用框架\wms\WEB-INF\classes\
 * 
 * Qualified Name: com.wms.util.MD5Util
 * 
 * JD-Core Version: 0.7.0.1
 */