package com.vtsft.models;

import java.util.Date;

public class Driver {

    private int id;
    private String name;
    private Date birthDate;
    private boolean isMale;
    private DriverClass driverClass;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public boolean isMale() {
        return isMale;
    }

    public void setMale(boolean isMale) {
        this.isMale = isMale;
    }

    public DriverClass getDriverClass() {
        return driverClass;
    }

    public void setDriverClass(DriverClass driverClass) {
        this.driverClass = driverClass;
    }
}
