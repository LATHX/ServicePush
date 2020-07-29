package com.service.push.server;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {
    @RequestMapping("/aaa")
    public String aaa(){
        return "aaa";
    }
}
