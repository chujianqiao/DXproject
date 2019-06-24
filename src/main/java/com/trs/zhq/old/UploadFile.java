/*
package com.trs.zhq.controller;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;


import java.io.File;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UploadFile extends HttpServlet {

    @RequestMapping("uploadFile")
    public void uploadFile(HttpServletRequest request, HttpServletResponse response) {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload sfu = new ServletFileUpload(factory);
        sfu.setHeaderEncoding("utf-8");
        String savePath = this.getServletConfig().getServletContext()
                .getRealPath("");
        String folad = "uploads";
        savePath = savePath + "\\" + folad + "\\";

        String fileMd5 = null;
        String chunk = null;

        try {
            List<FileItem> items = sfu.parseRequest(request);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    String fieldName = item.getFieldName();
                    if (fieldName.equals("fileMd5")) {
                        fileMd5 = item.getString("utf-8");

                    }
                    if (fieldName.equals("chunk")) {
                        chunk = item.getString("utf-8");
                    }
                } else {
                    File file = new File(savePath + "/" + fileMd5);
                    if (!file.exists()) {
                        file.mkdir();
                    }
                    File chunkFile = new File(savePath + "/" + fileMd5 + "/" + chunk);
                    FileUtils.copyInputStreamToFile(item.getInputStream(), chunkFile);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}

*/
