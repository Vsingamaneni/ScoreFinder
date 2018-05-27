package com.sports.cricket.util;

import com.sports.cricket.model.*;
import com.sports.cricket.service.RegistrationService;
import com.sports.cricket.service.ScheduleService;
import com.sports.cricket.validator.ValidateDeadLine;

import java.util.ArrayList;
import java.util.List;

public class MatchUpdates {

    public SchedulePrediction setUpdates(Schedule schedule, ScheduleService scheduleService, RegistrationService registrationService ){
        SchedulePrediction schedulePrediction = new SchedulePrediction();
        schedulePrediction.setSchedule(schedule);
        List<Prediction> predictionsList =  scheduleService.getPredictionsByMatch(schedule.getMatchNumber());
        List<Register> userLoginList = registrationService.getAllUsers();
        predictionsList = ValidateDeadLine.validatePredictions(schedule, predictionsList, userLoginList);
        schedulePrediction.setPrediction(predictionsList);
        schedulePrediction = ValidatePredictions.setCount(schedule, predictionsList, schedulePrediction);

        return  schedulePrediction;
    }

    public static Result mapResult(Schedule schedule, SchedulePrediction schedulePrediction){
        Result result = new Result();

        result.setMatchNumber(schedulePrediction.getSchedule().getMatchNumber());
        result.setHomeTeam(schedule.getHomeTeam());
        result.setAwayTeam(schedule.getAwayTeam());
        result.setStartDate(schedule.getStartDate());
        result.setWinner(schedule.getWinner());

        if (schedule.getWinner().equalsIgnoreCase(schedule.getHomeTeam())) {
            result.setWinningAmount(schedulePrediction.getHomeWinAmount());
        } else if (schedule.getWinner().equalsIgnoreCase(schedule.getAwayTeam())) {
            result.setWinningAmount(schedulePrediction.getAwayWinAmount());
        } else if (schedule.getWinner().equalsIgnoreCase("default")) {
            result.setWinningAmount((new Integer(0)).doubleValue());
        }

        result.setHomeTeamCount(schedulePrediction.getHomeTeamCount());
        result.setAwayTeamCount(schedulePrediction.getAwayTeamCount());
        result.setNotPredictedCount(schedulePrediction.getNotPredicted());
        result.setMatchDay(schedule.getMatchDay());

        return result;
    }

    public static List<Standings> updateStandings(SchedulePrediction schedulePrediction) {
        List<Standings> standingsList = new ArrayList<>();

        List<Prediction> predictionList = schedulePrediction.getPrediction();

        Standings standings;

        for(Prediction prediction : predictionList){
            standings = new Standings();

            standings.setMemberId(prediction.getMemberId());
            standings.setMatchNumber(prediction.getMatchNumber());
            standings.setHomeTeam(prediction.getHomeTeam());
            standings.setAwayTeam(prediction.getAwayTeam());
            standings.setMatchDate(schedulePrediction.getSchedule().getStartDate());
            standings.setPredictedDate(prediction.getPredictedTime());
            standings.setSelected(prediction.getSelected());
            standings.setWinner(schedulePrediction.getSchedule().getWinner());

            if(standings.getSelected().equalsIgnoreCase(standings.getWinner())){
                if(standings.getWinner().equalsIgnoreCase(standings.getHomeTeam())) {
                    standings.setWonAmount(schedulePrediction.getHomeWinAmount());
                }else if(standings.getWinner().equalsIgnoreCase(standings.getAwayTeam())) {
                    standings.setWonAmount(schedulePrediction.getAwayWinAmount());
                }
                standings.setLostAmount((new Integer(0)).doubleValue());
            }else{
                standings.setWonAmount((new Integer(0)).doubleValue());
                standings.setLostAmount(schedulePrediction.getSchedule().getMatchFee());
            }

            standingsList.add(standings);
        }

        return standingsList;
    }
}
