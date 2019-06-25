package com.trs.zhq.entity;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "fileConfig")
public class FileConfig {
    @Value("${fileRootPath}")
    private String fileRootPath;


    public String getFileRootPath() {
        return fileRootPath;
    }

    public void setFileRootPath(String fileRootPath) {
        this.fileRootPath = fileRootPath;
    }

    @Override
    public String toString() {
        return "FileConfig{" +
                "fileRootPath='" + fileRootPath + '\'' +
                '}';
    }
}
