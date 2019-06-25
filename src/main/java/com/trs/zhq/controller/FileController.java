package com.trs.zhq.controller;

import com.alibaba.fastjson.JSONObject;
import com.trs.zhq.entity.Progress;
import com.trs.zhq.util.FileUtil;
import com.trs.zhq.util.HybaseConnectionUtil;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.Properties;

@Controller
public class FileController {

    //上传文件
    @RequestMapping(value = "/up", method = RequestMethod.POST)
    public @ResponseBody
    String up(@RequestParam("file") MultipartFile file, String TRSID, String TFileName, Integer datatype, HttpServletRequest request) throws IOException {
        String fileType = "";
        String dir = "";
        if (datatype != null) {
            dir = FileUtil.getDataType(datatype);
        } else {
            dir = "qita";
        }
        if (!StringUtils.isEmpty(TFileName)) {
            int pos = TFileName.lastIndexOf(".");
            fileType = pos != -1 ? TFileName.substring(pos) : "";
        }
        if (!file.isEmpty()) {
            Properties properties = new Properties();
            properties.load(HybaseConnectionUtil.class.getClassLoader().getResourceAsStream("file.properties"));
            String url = properties.getProperty("fileRootPath");
//            String path = request.getSession().getServletContext().getRealPath("/") + "upload/";
            String path = url + dir + "//";
            String fileName = TRSID + fileType;
            File rootDir = new File(path);
            if (!rootDir.exists()) {
                rootDir.mkdirs();
            }
            File target = new File(path + fileName);
            file.transferTo(target);
        }
        return "upload success";
    }


    //进度条
    @GetMapping(value = "/size")
    public @ResponseBody
    Progress getProgress(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Progress progress = (Progress) session.getAttribute("status");
        System.out.println(progress + "controller");
        return progress;
    }

    @RequestMapping(value = "/download")
    @ResponseBody
    public String download(HttpServletRequest request, HttpServletResponse response, String filePath, String fileName) {
        JSONObject jsonObject = new JSONObject();
        ServletOutputStream sos = null;
        FileInputStream in = null;
        BufferedOutputStream outputStream = null;
        try {
            File file = new File(filePath);
            long size = file.length();
            fileName = new String(fileName.getBytes("UTF-8"), "iso-8859-1");//为了解决中文名称乱码问题
            response.reset();
            response.setHeader("Accept-Ranges", "bytes");
            //设置文件下载是以附件的形式下载
            response.setHeader("Content-disposition", String.format("attachment; filename=\"%s\"", fileName));
            response.addHeader("Content-Length", String.valueOf(size));

            sos = response.getOutputStream();
            in = new FileInputStream(file);
            outputStream = new BufferedOutputStream(sos);
            byte[] b = new byte[1024];
            int i = -1;
            while ((i = in.read(b)) > 0) {
                outputStream.write(b, 0, i);
            }
            outputStream.flush();
            sos.close();
            outputStream.close();
            in.close();
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            try {
                if (outputStream != null) {
                    outputStream.close();
                }
                if (sos != null) {
                    sos.close();
                }
                if (in != null) {
                    in.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return jsonObject.toJSONString();
    }



    /*@RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ResponseBody
    public String handleFileUpload(HttpServletRequest request){
        List<MultipartFile> files = ((MultipartHttpServletRequest)request).getFiles("file");
        MultipartFile file = null;
        BufferedOutputStream stream = null;
        for (int i =0; i< files.size(); ++i) {
            file = files.get(i);
            if (!file.isEmpty()) {
                try {
                    BufferedOutputStream bufferedOutputStream = new BufferedOutputStream(new FileOutputStream(new File("D:\\logs\\" + file.getOriginalFilename())));
                    bufferedOutputStream.write(file.getBytes());
                    bufferedOutputStream.flush();
                    bufferedOutputStream.close();
                } catch (Exception e) {
                    return "You failed to upload " + i + " => " + e.getMessage();
                }
            } else {
                return "You failed to upload " + i + " because the file was empty.";
            }
        }
        return "1";
    }*/


//    //文件下载相关代码
//    //@RequestMapping(value = "/download",method = RequestMethod.POST)
//    public String download(@RequestBody Map<String, String> map) throws Exception {
//        String url = map.get("url");
//        BufferedInputStream bis = null;
//        BufferedOutputStream bos = null;
//        //获取下载文件露肩
//        String downLoadPath = "C:\\Users\\Island\\Desktop\\1533471907(1).png";
//        /*response.setHeader("content-type", "application/octet-stream");
//        //获取文件的长度
//        long fileLength = new File(downLoadPath).length();
//        //设置文件输出类型
//        response.setContentType("application/octet-stream");
//        //设置输出长度
//        response.setHeader("Content-Length", String.valueOf(fileLength));*/
//    /********************************************************************/
//        //获取输入流
//        bis = new BufferedInputStream(new FileInputStream(downLoadPath));
//        //输出流
//        bos = new BufferedOutputStream(new FileOutputStream(new File(url+"\\test.png")));
//        byte[] buff = new byte[2048];
//        int bytesRead;
//        while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
//            bos.write(buff, 0, bytesRead);
//        }
//        //关闭流
//        bis.close();
//        bos.close();
//    return "1";
//}


}
