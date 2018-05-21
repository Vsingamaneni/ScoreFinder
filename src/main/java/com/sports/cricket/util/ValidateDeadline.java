package com.sports.cricket.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class ValidateDeadline {

    // Validates the prediction is valid or not
    public static boolean isPredictionValid(String date) throws ParseException {

        boolean isValid;

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy MMM dd HH:mm:ss");
        Date matchDate = sdf.parse(date);

        Date today = Calendar.getInstance().getTime();
        String currentDate = sdf.format(today);
        Date current = sdf.parse(currentDate);

        // Match Date is after current Date
        if (matchDate.compareTo(current) > 0) {
            isValid = true;
        }
        // Match Date is before Current Date
        else if (matchDate.compareTo(current) < 0) {
            isValid = false;
        } else if (matchDate.compareTo(current) == 0) {
           isValid = false;
        } else {
            isValid = false;
        }

        return isValid;
    }


    // Validates the prediction is valid or not
    public static boolean isDeadLineReached(String deadline) throws ParseException {

        boolean isDeadLineReached;

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy MMM dd HH:mm:ss");
        Date matchDate = sdf.parse(deadline);

        Date today = Calendar.getInstance().getTime();
        String currentDate = sdf.format(today);
        Date current = sdf.parse(currentDate);

        if (matchDate.compareTo(current) > 0) {
            isDeadLineReached = false;
        }
        else if (matchDate.compareTo(current) < 0) {
            isDeadLineReached = true;
        } else if (matchDate.compareTo(current) == 0) {
            isDeadLineReached = true;
        } else {
            isDeadLineReached = true;
        }

        return isDeadLineReached;
    }

}
