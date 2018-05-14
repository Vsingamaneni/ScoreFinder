package com.sports.cricket.util;

import com.sports.cricket.model.Prediction;
import com.sports.cricket.model.Schedule;

import java.util.ArrayList;
import java.util.List;

public class ValidatePredictions {

    public static List<Schedule> validatePrediction(List<Schedule> scheduleList, List<Prediction> predictionList){

        boolean isFound = false;
        List<Schedule> finalSchedule = new ArrayList<>();

        for (Schedule schedule : scheduleList) {
            for (Prediction prediction : predictionList) {
                isFound = false;
                if (schedule.getMatchNumber() == prediction.getMatchNumber()) {
                    isFound = true;
                    break;
                }
            }
            if (!isFound) {
                finalSchedule.add(schedule);
            }
        }

        return finalSchedule;
    }
}
