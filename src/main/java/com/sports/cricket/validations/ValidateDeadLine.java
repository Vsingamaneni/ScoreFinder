package com.sports.cricket.validations;

import com.sports.cricket.model.Prediction;
import com.sports.cricket.model.Register;
import com.sports.cricket.model.Schedule;
import com.sports.cricket.util.ValidateDeadline;
import org.springframework.util.CollectionUtils;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

public class ValidateDeadLine {

    public static List<Prediction> validatePredictions(Schedule schedule, List<Prediction> predictionList, List<Register> registerList){

        try {
            if(!ValidateDeadline.isDeadLineReached(schedule.getStartDate())){
                return predictionList;
            }else{
                predictionList = getDefaultPredictions(schedule, registerList, predictionList);
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }


        return predictionList;
    }

    private static List<Prediction> getDefaultPredictions(Schedule schedule, List<Register> registerList, List<Prediction> predictionList) throws ParseException {

        Prediction defaultPrediction;
        List<Prediction> finalPredictionList = predictionList;

        List<Integer> memberList = new ArrayList<>();
        List<Integer> predictionMemberList = new ArrayList<>();

        for(Register register : registerList){
            if(register.getIsActive().equalsIgnoreCase("y")) {
                if(!ValidateDeadline.isPredictionAfterRegistration(register.getRegisteredTime(), schedule.getStartDate())) {
                    memberList.add(register.getMemberId());
                }
            }
        }

        for(Prediction prediction : predictionList){
            predictionMemberList.add(prediction.getMemberId());
        }

        List<Integer> copyMemberList = new ArrayList<>(memberList);
        List<Integer> copyPredictionMemberList = new ArrayList<>(predictionMemberList);

        copyMemberList.removeAll(copyPredictionMemberList);

        if(!CollectionUtils.isEmpty(copyMemberList)) {
            for (Register register : registerList) {
                if(!CollectionUtils.isEmpty(copyMemberList)) {
                    if (register.getMemberId() == copyMemberList.get(0)) {
                        defaultPrediction = new Prediction();
                        defaultPrediction.setMemberId(register.getMemberId());
                        defaultPrediction.setPredictedTime("N/A");
                        defaultPrediction.setSelected("default");
                        defaultPrediction.setFirstName(register.getfName());
                        defaultPrediction.setHomeTeam(schedule.getHomeTeam());
                        defaultPrediction.setAwayTeam(schedule.getAwayTeam());
                        defaultPrediction.setMatchNumber(schedule.getMatchNumber());
                        finalPredictionList.add(defaultPrediction);
                        copyMemberList.remove(0);
                    }
                }
            }
        }

        return finalPredictionList;
    }

    public static List<Prediction> mapScheduleToPredictions(List<Schedule> scheduleList, List<Prediction> predictionList){

        for (Schedule schedule : scheduleList){
            for (Prediction prediction : predictionList){
                if (schedule.getMatchNumber() != prediction.getMatchNumber()){
                    continue;
                }else{
                    prediction.setCanPredict(schedule.isCanPredict());
                }
            }
        }

        return predictionList;
    }

    public static List<Prediction> isUpdatePossible(Schedule schedule, List<Prediction> predictionList){

            for (Prediction prediction : predictionList){
                if (schedule.getMatchNumber() != prediction.getMatchNumber()){
                    continue;
                }else{
                    prediction.setCanPredict(schedule.isCanPredict());
                }
        }

        return predictionList;
    }
}
