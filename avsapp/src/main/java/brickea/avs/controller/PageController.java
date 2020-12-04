package brickea.avs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {
    @GetMapping("/hello")
    public String hello(){
        return "hello";
    }
}
