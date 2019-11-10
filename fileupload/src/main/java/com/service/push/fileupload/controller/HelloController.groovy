package com.service.push.fileupload.controller

import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class HelloController {
    @RequestMapping("/hello")
    def hello(){
        return "hello"
    }
}
