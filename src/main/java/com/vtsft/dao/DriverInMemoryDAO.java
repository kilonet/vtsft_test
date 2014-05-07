package com.vtsft.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.vtsft.models.Driver;

/**
 * author: apokrevsky
 * date: 05/05/2014
 */
@Component
public class DriverInMemoryDAO {

    private Map<Integer, Driver> drivers = new HashMap<>();

    public void add(Driver driver) {
        drivers.put(driver.getId(), driver);
    }

    public List<Driver> findByName(String name) {
        List<Driver> result = new ArrayList<>();
        for (Driver driver: drivers.values()) {
            if (driver.getName().toLowerCase().contains(name.toLowerCase())) {
                result.add(driver);
                if (result.size() == 5) {
                    break;
                }
            }
        }
        return result;
    }

}
