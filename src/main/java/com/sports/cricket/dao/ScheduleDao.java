package com.sports.cricket.dao;

import com.sports.cricket.model.Schedule;

import java.util.List;

public interface ScheduleDao {

    List<Schedule> findAll();

}
