package com.sports.cricket.util;

import com.sports.cricket.model.Prediction;
import com.sports.cricket.model.Register;
import com.sports.cricket.model.Schedule;
import com.sports.cricket.model.SchedulePrediction;
import com.sports.cricket.service.RegistrationService;
import com.sports.cricket.service.ScheduleService;
import com.sports.cricket.validator.ValidateDeadLine;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class MatchUpdates {

   /* private ScheduleService scheduleService;

    private  RegistrationService registrationService;

    public ScheduleService getScheduleService() {
        return scheduleService;
    }

    @Autowired
    public void setScheduleService(ScheduleService scheduleService) {
        this.scheduleService = scheduleService;
    }

    public RegistrationService getRegistrationService() {
        return registrationService;
    }

    @Autowired
    public void setRegistrationService(RegistrationService registrationService) {
        this.registrationService = registrationService;
    }*/

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
}
