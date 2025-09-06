package com.brandenbed.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {

        // 1. Serve images from /src/main/webapp/images/
        registry.addResourceHandler("/images/**")
                .addResourceLocations("/images/");

        // 2. Serve static resources from src/main/resources/static/images/
        registry.addResourceHandler("/static-images/**")
                .addResourceLocations("classpath:/static/images/");

        // 3. Serve uploaded images saved at runtime in /uploads folder
        // (relative to project root / container working directory)
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("file:uploads/");
    }
}
