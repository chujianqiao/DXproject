package com.trs.zhq.util;

import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtil {
	public static String idGenerator() {
		return UUID.randomUUID().toString() + new Random().nextInt(100);
	}

	public static String sortFromEnd(String str, String userid) {
		StringBuffer sbf = new StringBuffer(str).reverse();
		return sbf.toString();
	}

	public static String generatorSysNumberForStringValue(long systemnumber) {
		// String result_ = systemnumber;
		// if (StringUtils.isEmpty(Long.valueOf(systemnumber))) {
		// return "00000000";
		// }
		// int length_strValue = result_.length();
		// for (int i = length_strValue; i < 8; i++) {
		// result_ = "0" + result_;
		// }
		// return result_;
		return null;
	}

	public static boolean isNotNull(Object obj) {
		return !StringUtils.isEmpty(obj);
	}

	public static boolean isNull(Object obj) {
		return StringUtils.isEmpty(obj);
	}
	
	
	//十六进制	
	public static boolean isHexNumber(String str){
		boolean flag = false;		
		for(int i=0;i<str.length();i++){			
			char cc = str.charAt(i);			
			if(cc=='0'||cc=='1'||cc=='2'||cc=='3'||cc=='4'||cc=='5'||cc=='6'||cc=='7'||cc=='8'||cc=='9'||cc=='A'||cc=='B'||cc=='C'||
					cc=='D'||cc=='E'||cc=='F'||cc=='a'||cc=='b'||cc=='c'||cc=='c'||cc=='d'||cc=='e'||cc=='f'){				
				flag = true;			
				}		
			}		
		return flag;	
	}

	/**
	 * 16进制转换成为string类型字符串
	 * @param s
	 * @return
	 */
	public static String hexStringToString(String s) {
	    if (s == null || s.equals("")) {
	        return null;
	    }
	    s = s.replace(" ", "");
	    byte[] baKeyword = new byte[s.length() / 2];
	    for (int i = 0; i < baKeyword.length; i++) {
	        try {
	            baKeyword[i] = (byte) (0xff & Integer.parseInt(s.substring(i * 2, i * 2 + 2), 16));
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	    try {
	        s = new String(baKeyword, "UTF-8");
	        new String();
	    } catch (Exception e1) {
	        e1.printStackTrace();
	    }
	    return s;
	}
	public static String[] split(String line) {

		List<String> list = new ArrayList<>();

		int start = 0;
		int end = -1;


		while(true) {

			start = end + 1;

			if(line.charAt(start) == '\"') {
				end = line.indexOf("\"", start ) + 1;
			} else {
				end = line.indexOf("," , start );
			}

			if(end < 0) {
				//最后了
				end = line.length() ;
			}

			String p1 = line.substring(start, end);

			list.add(p1);

			if(end >= line.length() - 1) {
				break;
			}

		}


		return list.toArray(new String[0]) ;
	}

	/**
	 * @param text  带"{img}"字符的字符串
	 * @return 替换成img标签
	 */
	public static String filterImgAndRepleace(String text) {
		if (text == null || "".equals(text)) {
			return null;
		}
		String contextPath = RequestUtil.getRequest().getContextPath();
		String imgpath =contextPath+"/readfile.do?name=";
		List<String> list = new ArrayList();
		Pattern p = Pattern.compile("(\\{\\w{1,5}\\d{17}\\w{2,}\\d\\.\\w{2,5}\\})");
		Matcher matcher = p.matcher(text);
		while (matcher.find()) {
			System.out.println(matcher.group());
			String group = matcher.group();
			list.add(group);
		}
		StringBuilder stringBuilder = new StringBuilder();
		for (String s : list) {
			if (stringBuilder.length() == 0) {
				stringBuilder.append(text);
			}
			String sp = s.substring(1, s.length() - 1);
			String s1 = stringBuilder.toString().replaceAll("\\" + s.substring(0, s.length() - 1) + "\\}",
					"<img src=\"" +imgpath+ sp + "\">");
//			String s1 = stringBuilder.toString().replaceAll("\\" + s.substring(0, s.length() - 1) + "\\}",
//					"<img src=\"" +contextPath+"/readfile.do?name="+ sp + "\">");
			stringBuilder.delete(0, stringBuilder.length());
			stringBuilder.append(s1);
		}

		return stringBuilder.toString().equals("")?text:stringBuilder.toString();
	}
	/**
	 * @param str  带img标签的字符串
	 * @return 替换成{img} 与filterImgAndRepleace方法正好相反
	 */
	public static String filterImgTagAndRepleace(String str) {
		if(str==null||"".equals(str)){
			return null;
		}
		Pattern p = Pattern.compile("(<img src=\".[a-zA-Z_0-9/\\?=\\.]+\">)");
		Matcher matcher = p.matcher(str);
		StringBuilder stringBuilder=new StringBuilder();
		stringBuilder.append(str);
		while (matcher.find()){
			String group = matcher.group();
			String name = "name=";
			String substring = group.substring(group.lastIndexOf(name) + name.length(), group.lastIndexOf("\">"));
			String replaceAll =matcher.replaceFirst("{"+substring+"}");
			stringBuilder.delete(0,stringBuilder.length());
			stringBuilder.append(replaceAll);
			matcher=p.matcher(stringBuilder.toString());

		}
		return stringBuilder.toString();
	}

	/**
	 * @param str 转义字符
	 * @return
	 */
	public static String texttohtml(String str){
		String value = str.replaceAll("\"","&quot;");
		return value;
	}
	public static void main(String[] args) {
		System.out.println(generatorSysNumberForStringValue(12L));
	}
}
