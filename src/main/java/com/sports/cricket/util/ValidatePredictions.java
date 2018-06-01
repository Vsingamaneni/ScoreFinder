package com.sports.cricket.util;

import com.sports.cricket.model.Prediction;
import com.sports.cricket.model.Schedule;
import com.sports.cricket.model.SchedulePrediction;
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

    public static SchedulePrediction setCount(Schedule schedule, List<Prediction> predictionList, SchedulePrediction schedulePrediction){

        String homeTeam = schedule.getHomeTeam();
        String awayTeam = schedule.getAwayTeam();
        String notSelected = "default";

        Integer homeTeamCount = 0;
        Integer awayTeamCount = 0;
        Integer notSelectedCount = 0;

        for(Prediction prediction : predictionList){
            if(prediction.getSelected().equalsIgnoreCase(homeTeam)){
                homeTeamCount = homeTeamCount+1;
            }else if(prediction.getSelected().equalsIgnoreCase(awayTeam)){
                awayTeamCount = awayTeamCount+1;
            }else if(prediction.getSelected().equalsIgnoreCase(notSelected)){
                notSelectedCount = notSelectedCount+1;
            }
        }

        schedulePrediction.setHomeTeamCount(homeTeamCount);
        schedulePrediction.setAwayTeamCount(awayTeamCount);
        schedulePrediction.setNotPredicted(notSelectedCount);

        try {
            if(ValidateDeadline.isDeadLineReached(schedule.getStartDate())){
                schedulePrediction.setDeadlinReached(true);
                if (homeTeamCount == 0 ){
                    schedulePrediction.setHomeWinAmount(0);
                }else {
                    schedulePrediction.setHomeWinAmount((schedule.getMatchFee() * (awayTeamCount + notSelectedCount)) / homeTeamCount);
                }

                if (awayTeamCount == 0 ) {
                    schedulePrediction.setAwayWinAmount(0);
                }else {
                    schedulePrediction.setAwayWinAmount((schedule.getMatchFee() * (homeTeamCount + notSelectedCount)) / awayTeamCount);
                }
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }

        return  schedulePrediction;
    }

    public static List<Prediction> appendDeadline(List<Schedule> scheduleList, List<Prediction> predictionList){

        for(Schedule schedule : scheduleList){
            for(Prediction prediction : predictionList){
                if(prediction.getMatchNumber() == schedule.getMatchNumber()){
                    prediction.setCanPredict(schedule.isCanPredict());
                }
            }
        }


        return predictionList;
    }

    public static List<Schedule> isScheduleAfterRegistration(List<Schedule> scheduleList , String registeredDate) throws ParseException {

        List<Schedule> finalSchedule = scheduleList;

        for ( Schedule schedule : scheduleList){
           if (ValidateDeadline.isPredictionAfterRegistration(registeredDate, schedule.getStartDate())){
                finalSchedule.remove(schedule);
           }
        }
     return finalSchedule;
    }
}
