package com.sports.cricket.config;

import javax.sql.DataSource;

import com.sports.cricket.dao.*;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

@Configuration
public class SpringJDBCConfiguration {

    // Website login Details
    /*@Bean
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("com.mysql.jdbc.Driver");
        // Google cloud URL - 35.194.225.158
        //dataSource.setUrl(System.getProperty("cloudsql"));
        dataSource.setUrl("jdbc:mysql://35.201.185.22:3306/sports");
        //dataSource.setUrl("jdbc:mysql://google/sports?cloudSqlInstance=scorefinder-206414:asia-east1:scorefinderapp&amp;socketFactory=com.google.cloud.sql.mysql.SocketFactory&amp;");
        //dataSource.setUrl("jdbc:mysql://google/sports?cloudSqlInstance=scorefinderapp&socketFactory=com.google.cloud.sql.mysql.SocketFactory&user=vamsi&password=rooney&useSSL=false");
        dataSource.setUsername("root");
        dataSource.setPassword("");
        //dataSource.setPassword("BNIers16706");
        *//*dataSource.setUrl("jdbc:mysql://node73943-scorefinder.whelastic.net/sports");
        dataSource.setUsername("root");
        dataSource.setPassword("BNIers16706");*//*

        return dataSource;
    }*/

    /*// Google cloud local
    @Bean
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("com.mysql.jdbc.Driver");
        dataSource.setUrl("jdbc:mysql://35.201.185.22:3306/sports");
        dataSource.setUsername("root");
        dataSource.setPassword("");
        return dataSource;
    }*/

    // Google Cloud connection
    @Bean
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setUrl(System.getProperty("worldcup"));
        return dataSource;
    }

    /*// Local MySQL details
    @Bean
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("com.mysql.jdbc.Driver");
        dataSource.setUrl("jdbc:mysql://localhost:3306/sports");
        dataSource.setUsername("root");
        dataSource.setPassword("");

        return dataSource;
    }*/

    @Bean
    public JdbcTemplate jdbcTemplate() {
        JdbcTemplate jdbcTemplate = new JdbcTemplate();
        jdbcTemplate.setDataSource(dataSource());
        return jdbcTemplate;
    }

    @Bean
    public UserDao userDao(){
        UserDaoImpl userDao = new UserDaoImpl();
        userDao.setJdbcTemplate(jdbcTemplate());
        userDao.setDataSource(dataSource());
        return userDao;
    }

    @Bean
    public ScheduleDao scheduleDao(){
        ScheduleDaoImpl scheduleDao = new ScheduleDaoImpl();
        scheduleDao.setDataSource(dataSource());
        scheduleDao.setJdbcTemplate(jdbcTemplate());
        return scheduleDao;
    }

    @Bean
    public RegistrationDao registrationDao(){
        RegistrationDaoImpl registrationDao = new RegistrationDaoImpl();
        registrationDao.setDataSource(dataSource());
        registrationDao.setJdbcTemplate(jdbcTemplate());
        return registrationDao;
    }


}