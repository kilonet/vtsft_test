package com.vtsft.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * author: apokrevsky
 * date: 06/05/2014
 */
@Controller
public class EditInsurancePage {

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String render() {
        return "insurance";
    }


}
