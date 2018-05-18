package com.sports.cricket.dao;

import com.sports.cricket.model.Prediction;
import com.sports.cricket.model.Schedule;

import java.util.List;

public interface ScheduleDao {

    List<Schedule> findAll();

    List<Schedule> scheduleList();

    Schedule findById(Integer matchNumber);

    List<Prediction> findPredictions(Integer memberId);

    boolean savePrediction(Prediction prediction);

    boolean updatePrediction(Prediction prediction);

    Prediction getPrediction(Integer memberId, Integer matchId);

    boolean deletePrediction(Integer predictionId);

    boolean authorizeMember(Integer memberID);

    List<Prediction> getPredictionsByMatch(Integer matchId);

}
