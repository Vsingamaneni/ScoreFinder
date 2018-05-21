package com.sports.cricket.validator;

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


    private static List<Prediction> getDefaultPredictions(Schedule schedule, List<Register> registerList, List<Prediction> predictionList){

        Prediction defaultPrediction;
        List<Prediction> finalPredictionList = predictionList;

        List<Integer> memberList = new ArrayList<>();
        List<Integer> predictionMemberList = new ArrayList<>();

        for(Register register : registerList){
            memberList.add(register.getMemberId());
        }

        for(Prediction prediction : predictionList){
            predictionMemberList.add(prediction.getMemberId());
        }

        List<Integer> copyMemeberList = new ArrayList<>(memberList);
        List<Integer> copypPredictionMemberList = new ArrayList<>(predictionMemberList);

        copyMemeberList.removeAll(copypPredictionMemberList);

        if(!CollectionUtils.isEmpty(copyMemeberList)) {
            for (Register register : registerList) {
                if(!CollectionUtils.isEmpty(copyMemeberList)) {
                    if (register.getMemberId() == copyMemeberList.get(0)) {
                        defaultPrediction = new Prediction();
                        defaultPrediction.setMemberId(register.getMemberId());
                        defaultPrediction.setPredictedTime("N/A");
                        defaultPrediction.setSelected("default");
                        defaultPrediction.setFirstName(register.getfName());
                        defaultPrediction.setHomeTeam(schedule.getHomeTeam());
                        defaultPrediction.setAwayTeam(schedule.getAwayTeam());
                        defaultPrediction.setMatchNumber(schedule.getMatchNumber());
                        finalPredictionList.add(defaultPrediction);
                        copyMemeberList.remove(0);
                    }
                }
            }
        }

        return finalPredictionList;
    }
}
