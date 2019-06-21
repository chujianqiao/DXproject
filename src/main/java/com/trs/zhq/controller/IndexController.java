package com.trs.zhq.controller;

import com.trs.hybase.client.TRSRecord;
import com.trs.zhq.entity.*;
import com.trs.zhq.service.ConfigService;
import com.trs.zhq.service.TRSSearchService;
import com.trs.zhq.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.http.HttpServletRequest;
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
        start = (start - 1) * end;
        searchWord = "\"" + searchWord + "\"";
        String dbName = "";
        String searchWhere = "";
        if (searchType == 0) {
            dbName = DataBaseConstants.HYBASEWENDANGTABLE;
            searchWhere = "(" + searchWord + ") OR " + "(DX_BIAOTI:" + searchWord + ")";
        } else {
            dbName = DataBaseConstants.HYBASETABLE;
            searchWhere = "(" + searchWord + ") OR " + "(SFILENAME:" + searchWord + ")";
        }
        List<TRSRecord> resultSet = trsSearchService.searchData(dbName, searchWhere, "", start, end);
        int count = trsSearchService.searchDataCount(dbName, searchWhere, "", 0, 10000);
        request.setAttribute("count", count);
        request.setAttribute("start", startBak);
        request.setAttribute("searchWord", searchWordBak);
        request.setAttribute("searchType", searchType);
        request.setAttribute("resultSet", resultSet);
        return "dataContent";
    }

    @RequestMapping("toDetail")
    public String toDetail(String id, String dbName, String searchWord, HttpServletRequest request) {
        searchWord = "\"" + searchWord + "\"";
        String searchWhere = "(DX_ID:" + id + ") AND ((" + searchWord + ") OR (DX_BIAOTI:" + searchWord + " OR DX_ZHENGWEN:" + searchWord + "))";
        List<TRSRecord> resultSet = trsSearchService.searchData(dbName, searchWhere, "", 0, 1);
        TRSRecord trsRecord = resultSet.get(0);
        String title = "";
        try {
            title = trsRecord.getString("DX_BIAOTI");
            title = title.replaceAll("<font color=red>", "");
            title = title.replaceAll("</font>", "");
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("title", title);
        request.setAttribute("trsRecord", trsRecord);
        return "detailContent";
    }

    @RequestMapping("toImport")
    public String toImport(int dataType, HttpServletRequest request) {
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
        return "importContent";
    }

    @RequestMapping("importData")
    public String importData(int dataType, ChengXu chengXu, ErJinZhi erJinZhi, FenXi fenXi,
                             MoCai moCai, PinPu pinPu, ShuCai shuCai, WangLuo wangLuo,
                             XinYuan xinYuan, HttpServletRequest request) throws Exception {
        String flag = trsSearchService.insertData(chengXu, erJinZhi, fenXi, moCai, pinPu, shuCai, wangLuo, xinYuan, dataType);
        if (flag.equals("success")) {
            request.setAttribute("flag", "success");
        }
        return "returnFlag";
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
