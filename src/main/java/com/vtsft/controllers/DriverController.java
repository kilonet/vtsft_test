package com.vtsft.controllers;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vtsft.dao.DriverInMemoryDAO;
import com.vtsft.models.Driver;
import com.vtsft.models.DriverClass;

/**
 * author: apokrevsky
 * date: 05/05/2014
 */
@Controller
public class DriverController {

    @Autowired
    private DriverInMemoryDAO driverDAO;

    @RequestMapping(value = "/drivers", method = RequestMethod.GET)
    public @ResponseBody List<Driver> findDrivers(@RequestParam String query) {

        return driverDAO.findByName(query);

    }

    @RequestMapping(value = "/driverSave", method = RequestMethod.POST)
    public @ResponseBody void saveDriver(@RequestBody Driver driver) {
        driverDAO.add(driver);
    }

    @RequestMapping(value = "/driverClasses", method = RequestMethod.GET)
    public @ResponseBody List<DriverClass> getDriverClasses() {
        return Arrays.asList(DriverClass.values());
    }

}
