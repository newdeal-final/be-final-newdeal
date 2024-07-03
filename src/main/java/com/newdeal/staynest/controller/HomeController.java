package com.newdeal.staynest.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {

    @GetMapping("/")
    public ModelAndView main() {
        return new ModelAndView("main");
    }

    @GetMapping("/search")
    public ModelAndView search() {
        return new ModelAndView("search/search");
    }


    @GetMapping("/reserve")
    public ModelAndView reserve() {
        return new ModelAndView("reserve/reserve");
    }
}
