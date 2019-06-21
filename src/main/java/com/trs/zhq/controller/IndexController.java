package com.trs.zhq.controller;

import com.trs.hybase.client.TRSException;
import com.trs.hybase.client.TRSRecord;
import com.trs.hybase.client.TRSResultSet;
import com.trs.zhq.config.DBConfig;
import com.trs.zhq.entity.*;
import com.trs.zhq.service.ConfigService;
import com.trs.zhq.service.TRSSearchService;
import com.trs.zhq.util.*;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.List;


@Controller
@RequestMapping({"/"})
public class IndexController {
    @Autowired
    private ConfigService configService;

    @Autowired
    private TRSSearchService trsSearchService;

    @RequestMapping("index")
    public String ImportFile() {
        System.out.println(111);
        return "index";
    }

    @RequestMapping("searchData")
    public String searchData(String searchWord, int start, int end, int searchType, HttpServletRequest request) {
        int startBak = start;
        String searchWordBak = searchWord;
        start = (start-1)*end;
        searchWord = "\"" + searchWord + "\"";
        String dbName = "";
        String searchWhere = "";
        if(searchType==0){
            dbName = DataBaseConstants.HYBASEWENDANGTABLE;
            searchWhere = "(" + searchWord + ") OR " + "(DX_BIAOTI:" + searchWord + ")";
        }else{
            dbName = DataBaseConstants.HYBASETABLE;
            searchWhere = "(" + searchWord + ") OR " + "(SFILENAME:" + searchWord + ")";
        }
        List<TRSRecord> resultSet = trsSearchService.searchData(dbName, searchWhere,"",start,end);
        int count = trsSearchService.searchDataCount(dbName, searchWhere,"",0,10000);
        request.setAttribute("count",count);
        request.setAttribute("start",startBak);
        request.setAttribute("searchWord",searchWordBak);
        request.setAttribute("searchType",searchType);
        request.setAttribute("resultSet",resultSet);
        return "dataContent";
    }

    @RequestMapping("toDetail")
    public String toDetail(String id, String dbName,String searchWord, HttpServletRequest request) {
        searchWord = "\"" + searchWord + "\"";
        String searchWhere = "(DX_ID:" + id +") AND ((" + searchWord + ") OR (DX_BIAOTI:" + searchWord + " OR DX_ZHENGWEN:" + searchWord + "))";
        List<TRSRecord> resultSet = trsSearchService.searchData(dbName, searchWhere,"",0,1);
        TRSRecord trsRecord = resultSet.get(0);
        String title = "";
        try {
            title = trsRecord.getString("DX_BIAOTI");
            title = title.replaceAll("<font color=red>","");
            title = title.replaceAll("</font>","");
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("title",title);
        request.setAttribute("trsRecord",trsRecord);
        return "detailContent";
    }

    @RequestMapping("toImport")
    public String toImport(int dataType, HttpServletRequest request){
        String fieldString = "";
        if(dataType==0){
            fieldString = SelectFiledUtil.SJ_PINPU_FIELD;
        }else if(dataType==1){
            fieldString = SelectFiledUtil.SJ_MOCAI_FIELD;
        }else if(dataType==2){
            fieldString = SelectFiledUtil.SJ_SHUCAI_FIELD;
        }else if(dataType==3){
            fieldString = SelectFiledUtil.SJ_XINYUAN_FIELD;
        }else if(dataType==4){
            fieldString = SelectFiledUtil.SJ_WANGLUO_FIELD;
        }else if(dataType==5){
            fieldString = SelectFiledUtil.SJ_ERJINZHI_FIELD;
        }else if(dataType==6){
            fieldString = SelectFiledUtil.SJ_FENXI_FIELD;
        }else if(dataType==7){
            fieldString = SelectFiledUtil.SJ_CHENGXU_FIELD;
        }
        request.setAttribute("fieldString",fieldString);
        request.setAttribute("dataType",dataType);
        return "importContent";
    }

    @RequestMapping("importData")
    public String importData(int dataType, ChengXu chengXu, ErJinZhi erJinZhi, FenXi fenXi,
                           MoCai moCai, PinPu pinPu, ShuCai shuCai, WangLuo wangLuo,
                           XinYuan xinYuan, HttpServletRequest request)throws Exception {
        String flag = trsSearchService.insertData(chengXu,erJinZhi,fenXi,moCai,pinPu,shuCai,wangLuo,xinYuan,dataType);
        if (flag.equals("success")){
            request.setAttribute("flag","success");
        }
        return "returnFlag";
    }


    @RequestMapping(value = {"importWhiteList"}, method = {org.springframework.web.bind.annotation.RequestMethod.POST})
    @ResponseBody
    public ResultDataUtil importWhiteList(MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
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
        return configService.importData(file, savePath);
    }

    @RequestMapping("exportData")
    @ResponseBody
    public String exportData(HttpServletRequest request,HttpServletResponse response, String userName, Integer siteType, String keyWord, String siteList) {
        if(keyWord == null || "".equals(keyWord.trim())){
            keyWord = "%";
        }
        if(siteList == null || "".equals(siteList.trim())){
            siteList = "%";
        }
        if (siteType == null) return "";
        if (siteType == 0) {
            DBConfig.DB_URL = DBConfig.DB_URL_WEB;
            DBConfig.serverTable = DBConfig.TABLE_WEB;
            DBConfig.groupType = "外部网站";
            DBConfig.biaodashi = "IR_SITENAME=(" + siteList.replaceAll(",", "%,") + "%) AND (" + keyWord + ")";
        } else if (siteType == 1) {
            DBConfig.DB_URL = DBConfig.DB_URL_WEB;
            DBConfig.serverTable = DBConfig.TABLE_INTRANET;
            DBConfig.groupType = "内部网站";
            DBConfig.biaodashi = "IR_SITENAME=(" + siteList.replaceAll(",", "%,") + "%) AND (" + keyWord + ")";
        } else if (siteType == 2) {
            DBConfig.DB_URL = DBConfig.DB_URL_WEI;
            DBConfig.serverTable = DBConfig.TABLE_WEINBO;
            DBConfig.groupType = "微博";
            DBConfig.biaodashi = "IR_SCREEN_NAME=(" + siteList.replaceAll(",", "%,") + "%) AND (" + keyWord + ")";
        } else {
            DBConfig.DB_URL = DBConfig.DB_URL_WEI;
            DBConfig.serverTable = DBConfig.TABLE_WEIXIN;
            DBConfig.groupType = "微信";
            DBConfig.biaodashi = "IR_AUTHORS=(" + siteList.replaceAll(",", "%,") + "%) AND (" + keyWord + ")";
        }
        Boolean isAdmin = false;
        if ("cnoocadmin".equals(userName)) {
            isAdmin = true;
            userName = "%";
            if (siteType == 1) {
                DBConfig.biaodashi = DBConfig.biaodashi_intranet;
            } else {
                DBConfig.biaodashi = DBConfig.biaodashi_web;
            }
        }
        //统计列表
        try {
//            CountSensitiveWords.countBySize();
            CountSensitiveWords.detail(userName, isAdmin);

            //下载文件
            String filename = System.currentTimeMillis() + "疑似信息.xlsx";
            //解决firefox的文件名乱码
            String agent = request.getHeader("USER-AGENT");
//            response.setContentType("application/octet-stream");
            // 1.设置文件ContentType类型，这样设置，会自动判断下载文件类型
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            if (agent != null && agent.toLowerCase().indexOf("firefox") > 0) {
                String downloadName = new String(filename.getBytes("GB2312"), "ISO-8859-1");
                response.setHeader("Content-Disposition", "attachment; filename=" + downloadName);
            } else {
                // 2.设置文件头：最后一个参数是设置下载文件名(假如我们叫a.pdf)
                response.setHeader("Content-Disposition", "attachment;fileName="
                        + URLEncoder.encode(filename, "UTF-8"));
            }
            System.out.println(DBConfig.detailFile);
            OutputStream os = response.getOutputStream();
            InputStream is = new FileInputStream(DBConfig.detailFile);
            byte[] bytes = new byte[1024 * 8];
            int len = -1;
            while ((len = is.read(bytes)) != -1) {
                os.write(bytes, 0, len);
            }
            is.close();
            os.close();
            os.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "true";
    }

}
