package com.service.push.fileupload;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

@EnableEurekaClient
@SpringBootApplication
public class FileuploadApplication {

    public static void main(String[] args) {
        SpringApplication.run(FileuploadApplication.class, args);
    }

}
