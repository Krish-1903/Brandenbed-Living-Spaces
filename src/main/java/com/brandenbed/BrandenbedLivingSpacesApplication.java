package com.brandenbed;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class BrandenbedLivingSpacesApplication extends SpringBootServletInitializer{
	
	@Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(BrandenbedLivingSpacesApplication.class);
    }

	public static void main(String[] args) {
		SpringApplication.run(BrandenbedLivingSpacesApplication.class, args);
	}

}
