package com.sports.cricket.util;

import com.sports.cricket.model.Prediction;
import com.sports.cricket.model.Schedule;
import org.springframework.util.CollectionUtils;

import java.text.ParseException;
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

    public static List<Schedule> validateSchedule(List<Schedule> scheduleList) throws ParseException {

        List<Schedule> validSchedule = new ArrayList<>();

        if(!CollectionUtils.isEmpty(scheduleList)){
            for(Schedule schedule : scheduleList){
                if(null != schedule.getStartDate()){
                    if(ValidateDeadline.isPredictionValid(schedule.getStartDate())){
                        schedule.setCanPredict(true);
                    }else{
                        schedule.setCanPredict(false);
                    }
                    validSchedule.add(schedule);
                }
            }
        }

        return validSchedule;
    }
}
