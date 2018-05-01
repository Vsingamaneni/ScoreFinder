package com.sports.cricket.dao;

import com.sports.cricket.model.Schedule;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.List;

@Repository
public class ScheduleDaoImpl implements ScheduleDao {

    DataSource dataSource;
    JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Autowired
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Schedule> findAll() {
        String sql = "SELECT * FROM schedule where isActive = TRUE";

        List<Schedule> result = jdbcTemplate.query(sql,  new BeanPropertyRowMapper(Schedule.class));

        //namedParameterJdbcTemplate.query(sql, new UserMapper());

        return result;
    }
}
