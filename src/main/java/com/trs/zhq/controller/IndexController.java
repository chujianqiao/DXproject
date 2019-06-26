package com.trs.zhq.controller;

import com.trs.hybase.client.TRSRecord;
import com.trs.zhq.entity.*;
import com.trs.zhq.service.ConfigService;
import com.trs.zhq.service.TRSSearchService;
import com.trs.zhq.service.UserService;
import com.trs.zhq.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.UUID;


@Controller
@RequestMapping({"/"})
public class IndexController {
    @Autowired
    private ConfigService configService;

    @Autowired
    private HttpServletRequest request;

    @Autowired
    private TRSSearchService trsSearchService;

    @Autowired
    private UserService userService;


    @RequestMapping("login")
    public String login() {
        return "login";
    }

    @RequestMapping("toRegister")
    public String toRegister() {
        return "register";
    }

    @RequestMapping("register")
    public String register(Users user) {
        String flag = userService.insertUser(user);
        if (flag.equals("success")) {
            request.setAttribute("flag", "register");
        }else if (flag.equals("same")){
            request.setAttribute("flag", "same");
        }else {
            request.setAttribute("flag", "error");
        }
        return "returnFlag";
    }

    @RequestMapping({ "toLogin" })
    @ResponseBody
    public String toLogin(String username, String passwords, String kaptcha,HttpServletResponse response) {
        try {
            /*synchronized (this){
                String kaptchaExpected = (String) request
                        .getSession()
                        .getAttribute(
                                com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
                // 获取用户页面输入的验证码
                String kaptchaReceived = request.getParameter("kaptcha");
                if (kaptcha == null || !kaptcha.equalsIgnoreCase(kaptchaReceived)
                        ||kaptcha.equals("") || !kaptchaReceived.equalsIgnoreCase(kaptchaExpected)) {
                    return "ERROR_NOT";
                }
            }*/
            Users user = this.trsSearchService.selectUserByUserName(username);
            if (MD5Util.compareWithPasswords(passwords.toUpperCase(),
                    user.getPASSWORD(), user.getID())) {
                if ((StringUtil.isNotNull(user))
                        && (!user.getSTATUS().equals(CodesUtil.NORMAL_USER_STATUS))) {
                    return CodesUtil.ERROR_STATUS;
                }
                /*if (this.trsSearchService.isSuperAdmin(user.getID())) {
                    user.setSuperAdmin(true);
                    LoginUtil.setAuth_map(this.trsSearchService
                            .getUserAllMenusAuthMap(user.getID(), true));
                } else {
                    user.setSuperAdmin(false);
                    LoginUtil.setAuth_map(this.trsSearchService
                            .getUserAllMenusAuthMap(user.getID(), false));
                }*/


                HttpSession session = RequestUtil.getSession();
                /**
                 * 该账号已经被登陆
                 */
                if(null != SessionListener.sessionMap.get( user.getUSERNAME() )){
                    /**
                     * 将已经登陆的信息拿掉,将新的用户登录信息放进去
                     */
                    HttpSession httpSession = SessionListener.sessionMap.get(user.getUSERNAME());
                    ForceLogoutUtils.forceUserLogout( user.getUSERNAME() );

                    SessionListener.sessionMap.put( user.getUSERNAME(), session );
                }
                /**
                 * 该账号未被登陆
                 */
                else{
                    SessionListener.sessionMap.put( user.getUSERNAME(), session );
                }
                RequestUtil.getSession().setAttribute("CONSOLEUSER", user);
                RequestUtil.getSession().setAttribute("CONSOLEUSERNAME",
                        user.getUSERNAME());
                //setLogs(username, "用户：" + username + "登录成功", "成功", 1, "【登录】");
                return "success";
            }
        } catch (Exception e) {
            e.printStackTrace();
           /* setLogs(username, "用户：" + username + "登录失败", "失败", 1, "【登陆】",
                    username, username);*/
            return "error";
        }
        return "error";
    }

    @RequestMapping("logout")
    public String logout() {
        Users user = LoginUtil.getConsoleLoginUser();
        RequestUtil.getSession().removeAttribute("CONSOLEUSER");
        RequestUtil.getSession().removeAttribute("CONSOLEUSERNAME");
        SessionListener.sessionMap.remove( user.getUSERNAME() );
        RequestUtil.getSession().invalidate();

        return "login";
    }

    @RequestMapping("index")
    public String toIndex() {
        return "index";
    }

    @RequestMapping("searchData")
    public String searchData(String searchWord, int start, int end, String selectSort, int searchType, HttpServletRequest request) {
        int startBak = start;
        String searchWordBak = searchWord;
        start = (start - 1) * end;
        String dbName = "";
        String searchWhere = "";
        List<TRSRecord> resultSet = new ArrayList<>();
        int count = 0;
        if (StringUtils.isEmpty(selectSort)){
            selectSort = "RELEVANCE";
        }

        /**
         * 字段检索
         */
        if (searchWord.indexOf(":")>0||searchWord.indexOf("：")>0){
            searchWord.replaceAll("：",":");
            String searchWords[] = searchWord.split(":");
            searchWord = "\"" + searchWords[1] + "\"";
            searchWhere = searchWords[0] + ":" + searchWord;
            if (searchType == 0) {
                dbName = DataBaseConstants.HYBASEWENDANGTABLE;
            } else {
                dbName = DataBaseConstants.HYBASETABLE;
            }
            resultSet = trsSearchService.searchData(dbName, searchWhere, selectSort, start, end);
            count = trsSearchService.searchDataCount(dbName, searchWhere, "", 0, 10000);
        }else {
            searchWord = "\"" + searchWord + "\"";
            if (searchType == 0) {
                dbName = DataBaseConstants.HYBASEWENDANGTABLE;
                searchWhere = "(" + searchWord + ") OR " + "(DX_BIAOTI:" + searchWord + ")";
            } else {
                dbName = DataBaseConstants.HYBASETABLE;
                searchWhere = "(" + searchWord + ") OR " + "(SFILENAME:" + searchWord + ")";
            }
            resultSet = trsSearchService.searchData(dbName, searchWhere, selectSort, start, end);
            count = trsSearchService.searchDataCount(dbName, searchWhere, "", 0, 10000);
        }

        request.setAttribute("count", count);
        request.setAttribute("start", startBak);
        request.setAttribute("searchWord", searchWordBak);
        request.setAttribute("searchType", searchType);
        request.setAttribute("resultSet", resultSet);
        request.setAttribute("selectSort", selectSort);
        return "dataContent";
    }

    @RequestMapping("toDetail")
    public String toDetail(String id, String dbName, int searchType, String searchWord, HttpServletRequest request) {
        searchWord = "\"" + searchWord + "\"";
        String searchWhere = "";
        if (searchType == 0) {
            searchWhere = "(DX_ID:" + id + ") AND ((" + searchWord + ") OR (DX_BIAOTI:" + searchWord + " OR DX_ZHENGWEN:" + searchWord + "))";
        } else {
            id = id.replaceAll("<font color=red>", "").replaceAll("</font>", "");;
            searchWhere = "(TRSID:" + id + ") AND ((" + searchWord + ") OR (SUSERCOMMENT:" + searchWord + "))";
        }

        //searchWhere = "(DX_ID:" + id + ") AND ((" + searchWord + ") OR (DX_BIAOTI:" + searchWord + " OR DX_ZHENGWEN:" + searchWord + "))";
        List<TRSRecord> resultSet = trsSearchService.searchData(dbName, searchWhere, "", 0, 1);
        TRSRecord trsRecord = resultSet.get(0);
        String title = "";
        try {
            if (searchType == 0) {
                title = trsRecord.getString("DX_BIAOTI");
                title = title.replaceAll("<font color=red>", "");
                title = title.replaceAll("</font>", "");
            } else {
                title = trsRecord.getString("SFILENAME");
                title = title.replaceAll("<font color=red>", "");
                title = title.replaceAll("</font>", "");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("title", title);
        request.setAttribute("trsRecord", trsRecord);
        request.setAttribute("searchType", searchType);
        request.setAttribute("dbName", dbName);
        return "detailContent";
    }

    @RequestMapping("toImport")
    public String toImport(int dataType, HttpServletRequest request) {
        String TRSID = UUID.randomUUID().toString().replaceAll("-","");
        String fieldString = "";
        if (dataType == 0) {
            fieldString = SelectFiledUtil.SJ_PINPU_FIELD;
        } else if (dataType == 1) {
            fieldString = SelectFiledUtil.SJ_MOCAI_FIELD;
        } else if (dataType == 2) {
            fieldString = SelectFiledUtil.SJ_SHUCAI_FIELD;
        } else if (dataType == 3) {
            fieldString = SelectFiledUtil.SJ_XINYUAN_FIELD;
        } else if (dataType == 4) {
            fieldString = SelectFiledUtil.SJ_WANGLUO_FIELD;
        } else if (dataType == 5) {
            fieldString = SelectFiledUtil.SJ_ERJINZHI_FIELD;
        } else if (dataType == 6) {
            fieldString = SelectFiledUtil.SJ_FENXI_FIELD;
        } else if (dataType == 7) {
            fieldString = SelectFiledUtil.SJ_CHENGXU_FIELD;
        }
        request.setAttribute("fieldString", fieldString);
        request.setAttribute("dataType", dataType);
        request.setAttribute("TRSID", TRSID);
        return "importContent";
    }

    @RequestMapping("importData")
    public String importData(String TRSID, String TFileName, int dataType, ChengXu chengXu, ErJinZhi erJinZhi, FenXi fenXi,
                             MoCai moCai, PinPu pinPu, ShuCai shuCai, WangLuo wangLuo,
                             XinYuan xinYuan, HttpServletRequest request) throws Exception {
        String TFilePath = "";
        if(!StringUtils.isEmpty(TFileName)){
            Properties properties = new Properties();
            properties.load(HybaseConnectionUtil.class.getClassLoader().getResourceAsStream("file.properties"));
            String path = properties.getProperty("fileRootPath");
            int pos = TFileName.lastIndexOf(".");
            String fileType = "";
//            fileType = pos != -1 ? TFileName.substring(pos) : "";
//            TFilePath = path + FileUtil.getDataType(dataType) + "//" + TRSID + fileType;
            TFilePath = path + FileUtil.getDataType(dataType) + "\\" + TFileName;
        } else {
            TFileName = "";
        }
            String flag = trsSearchService.insertData(TFilePath, TFileName, TRSID, chengXu, erJinZhi, fenXi, moCai, pinPu, shuCai, wangLuo, xinYuan, dataType);

        if (flag.equals("success")) {
            request.setAttribute("flag", "success");
        }
        return "returnFlag";
    }

    @RequestMapping("getLoginUser")
    @ResponseBody
    public int getConsoleLoginUser(String tel) {
        try {
            return LoginUtil.getConsoleLoginUserName() == null ? -1 : 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }


    /*public ResultDataUtil importWhiteList(MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
        //得到上传文件的保存目录，将上传的文件存放于WEB-INF目录下，不允许外界直接访问，保证上传文件的安全
//        String savePath = this.getServletContext().getRealPath("/WEB-INF/upload");
        //springboot环境下, 以jar包(项目根目录)所在目录作为文件资料的根目录, 这里定义 data/upload 作为文件上传的存放路径
        //!jar包运行时, 这里有 file: 前缀!
        //String savePath = rootFile.getAbsolutePath() + "data/upload";       //不要直接拼接路径  避免 分隔符多或少
        File savePath = null;
        try {
            savePath = new File(FileUtil.getJarRootPath(), "data/upload");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        //判断上传文件的保存目录是否存在
        if (!savePath.exists() && !savePath.isDirectory()) {
            //创建目录
            boolean created = savePath.mkdirs();
            if (!created) {
                throw new RuntimeException("路径: '" + savePath.getAbsolutePath() + "'创建失败");
            }
        }
        return null;
    }*/


}
