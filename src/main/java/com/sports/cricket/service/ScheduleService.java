package com.sports.cricket.service;

import com.sports.cricket.model.Prediction;
import com.sports.cricket.model.Schedule;

import java.util.List;

public interface ScheduleService {

    List<Schedule> findAll();

    List<Schedule> scheduleList();

    Schedule findById(Integer matchNumber);

    List<Prediction> findPredictions(Integer memberId);

    boolean savePrediction(Prediction prediction);

    boolean updatePrediction(Prediction prediction);

    Prediction getPrediction(Integer predictionId, Integer matchId);

    boolean deletePrediction(Integer predictionId);

    boolean authorizeMember(Integer memberId);

    List<Prediction> getPredictionsByMatch(Integer matchId);

    boolean updateMatchResult(Schedule schedule);

    Integer totalMatches(Integer matchDay);

    boolean updateMatchDay(Integer matchDay);

}
