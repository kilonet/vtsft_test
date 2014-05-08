package com.vtsft.auxiliary;


import java.util.Calendar;
import java.util.Date;
import java.util.Random;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.vtsft.dao.DriverInMemoryDAO;
import com.vtsft.models.Driver;
import com.vtsft.models.DriverClass;

public class ContextListener implements ServletContextListener {

    private Random random = new Random();

    // Public constructor is required by servlet spec
    public ContextListener() {
    }

    public void contextInitialized(ServletContextEvent sce) {

        // generate test data

        final WebApplicationContext springContext = WebApplicationContextUtils.getWebApplicationContext(sce.getServletContext());
        DriverInMemoryDAO driverDAO = springContext.getBean(DriverInMemoryDAO.class);
        Calendar calendar = Calendar.getInstance();
        calendar.set(1940, Calendar.JANUARY, 1);
        for (int i = 0; i < 100; i++) {
            Driver driver = new Driver();
            driver.setId(i);
            driver.setBirthDate(new Date(calendar.getTimeInMillis() + Math.abs(random.nextLong()) % (1000L * 3600L * 24L * 365L * 60L)));
            driver.setMale(random.nextInt() % 5 != 0);
            driver.setName(getName(driver.isMale()));
            driver.setDriverClass(DriverClass.values()[random.nextInt(DriverClass.values().length)]);
            driverDAO.add(driver);
        }

    }

    private static final String[] MALE_FIRST_NAMES = {"Иван", "Пётр", "Степан", "Олег", "Владимир", "Игорь", "Александр", "Илья", "Дмитрий"};
    private static final String[] MALE_LAST_NAMES = {"Иванов", "Петров", "Степанов", "Олегов", "Владимиров", "Игорев", "Александров", "Ильин", "Дмитриев"};
    private static final String[] MALE_MIDDLE_NAMES = {"Иванович", "Петрович", "Степанович", "Олегович", "Владимирович", "Игоревич", "Александрович", "Ильич", "Дмитриевич"};

    private static final String[] FEMALE_FIRST_NAMES = {"Ольга", "Наталья", "Ирина", "Оксана", "Алина", "Марина", "Мария", "Жанна", "Вероника"};
    private static final String[] FEMALE_LAST_NAMES = {"Иванова", "Петрова", "Степанова", "Олегова", "Владимирова", "Игорева", "Александрова", "Ильина", "Дмитриева"};
    private static final String[] FEMALE_MIDDLE_NAMES = {"Ивановна", "Петровна", "Степановна", "Олеговна", "Владимировна", "Игоревна", "Александровна", "Ильинична", "Дмитриевна"};

    private String getName(boolean male) {
        if (male) {
            return MALE_LAST_NAMES[random.nextInt(MALE_LAST_NAMES.length)] + " " +
                    MALE_FIRST_NAMES[random.nextInt(MALE_FIRST_NAMES.length)] + " " +
                   MALE_MIDDLE_NAMES[random.nextInt(MALE_MIDDLE_NAMES.length)];
        }
        return FEMALE_LAST_NAMES[random.nextInt(FEMALE_LAST_NAMES.length)] + " " +
               FEMALE_FIRST_NAMES[random.nextInt(FEMALE_FIRST_NAMES.length)] + " " +
               FEMALE_MIDDLE_NAMES[random.nextInt(FEMALE_MIDDLE_NAMES.length)];
    }

    public void contextDestroyed(ServletContextEvent sce) {
    }

}
