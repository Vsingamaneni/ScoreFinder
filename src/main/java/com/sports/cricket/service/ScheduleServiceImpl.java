package com.sports.cricket.service;

import com.sports.cricket.dao.ScheduleDao;
import com.sports.cricket.model.Prediction;
import com.sports.cricket.model.Schedule;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("scheduleService")
public class ScheduleServiceImpl implements ScheduleService {

    ScheduleDao scheduleDao;

    @Autowired
    public void setScheduleDao(ScheduleDao scheduleDao) {
        this.scheduleDao = scheduleDao;
    }

    @Override
    public List<Schedule> findAll() {
        return scheduleDao.findAll();
    }

    @Override
    public List<Schedule> scheduleList() {
        return scheduleDao.scheduleList();
    }

    @Override
    public Schedule findById(Integer matchNumber) {
        return scheduleDao.findById(matchNumber);
    }

    @Override
    public List<Prediction> findPredictions(Integer memberId) {
        return scheduleDao.findPredictions(memberId);
    }

    @Override
    public boolean savePrediction(Prediction prediction) {
        return scheduleDao.savePrediction(prediction);
    }

    @Override
    public boolean updatePrediction(Prediction prediction) {
        return scheduleDao.updatePrediction(prediction);
    }

    @Override
    public Prediction getPrediction(Integer memberId, Integer matchId) {
        return scheduleDao.getPrediction(memberId, matchId);
    }

    @Override
    public boolean deletePrediction(Integer predictionId) {
        return scheduleDao.deletePrediction(predictionId);
    }

}
