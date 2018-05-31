package com.sports.cricket.validations;

import com.sports.cricket.model.Prediction;
import com.sports.cricket.model.Register;
import com.sports.cricket.model.Schedule;
import com.sports.cricket.util.ValidateDeadline;
import org.springframework.util.CollectionUtils;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

public class ResultValidator {

    static List<ErrorDetails> errorsList = null;

    public static List<ErrorDetails> isMatchResultValid(Schedule schedule){

        errorsList = new ArrayList<>();
        ErrorDetails errorDetails = null;
        if (schedule.getWinner().equalsIgnoreCase(schedule.getHomeTeam())){

        }else if(schedule.getWinner().equalsIgnoreCase(schedule.getAwayTeam())){

        }else if(schedule.getWinner().equalsIgnoreCase("draw")){

        }else{
            errorDetails = new ErrorDetails();
            errorDetails.setErrorField("winner");
            errorDetails.setErrorMessage("Please select a valid result ..!");
            errorsList.add(errorDetails);
        }

        return errorsList;
    }

}
