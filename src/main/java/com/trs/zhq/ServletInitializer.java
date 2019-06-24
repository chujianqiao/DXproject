package com.trs.zhq;

import com.trs.zhq.listener.CustomMultipartResolver;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.web.multipart.MultipartResolver;

public class ServletInitializer extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(ZhqApplication.class);
    }

    @Bean(name = "multipartResolver")
    public MultipartResolver multipartResolver()
    {
        return new CustomMultipartResolver();
    }

}
