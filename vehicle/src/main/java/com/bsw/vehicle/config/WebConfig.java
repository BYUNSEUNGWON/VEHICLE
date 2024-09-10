package com.bsw.vehicle.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer{
	
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // /files/** 경로를 D:/upload/img/ 디렉토리에 매핑
        registry.addResourceHandler("/vehicle/files/**")
                .addResourceLocations("file:D:/upload/img/");
    }
}
