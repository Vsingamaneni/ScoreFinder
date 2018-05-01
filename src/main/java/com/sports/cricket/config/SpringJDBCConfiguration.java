package com.sports.cricket.config;

import javax.sql.DataSource;

import com.sports.cricket.dao.ScheduleDao;
import com.sports.cricket.dao.ScheduleDaoImpl;
import com.sports.cricket.dao.UserDao;
import com.sports.cricket.dao.UserDaoImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

@Configuration
public class SpringJDBCConfiguration {
    @Bean
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        //MySQL database we are using
        dataSource.setDriverClassName("com.mysql.jdbc.Driver");
        dataSource.setUrl("jdbc:mysql://localhost:3306/sports");//change url
        dataSource.setUsername("root");//change userid
        dataSource.setPassword("");//change pwd

        //H2 database
        /*
        dataSource.setDriverClassName("org.h2.Driver");
        dataSource.setUrl("jdbc:h2:tcp://localhost/~/test");
        dataSource.setUsername("sa");
        dataSource.setPassword("");*/
        return dataSource;
    }

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

    public ScheduleDao scheduleDao(){
        ScheduleDaoImpl scheduleDao = new ScheduleDaoImpl();
        scheduleDao.setDataSource(dataSource());
        scheduleDao.setJdbcTemplate(jdbcTemplate());
        return scheduleDao;
    }

}