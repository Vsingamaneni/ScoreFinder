package com.sports.cricket.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class ValidateDeadline {

    public static boolean isPredictionValid(String date) throws ParseException {

        boolean isValid;

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy MMM dd HH:mm:ss");
        Date matchDate = sdf.parse(date);

        Date today = Calendar.getInstance().getTime();
        String currentDate = sdf.format(today);
        Date current = sdf.parse(currentDate);

        if (matchDate.compareTo(current) > 0) {
            isValid = true;
        } else if (matchDate.compareTo(current) < 0) {
            isValid = false;
        } else if (matchDate.compareTo(current) == 0) {
           isValid = false;
        } else {
            isValid = false;
        }

        return isValid;
    }

}
