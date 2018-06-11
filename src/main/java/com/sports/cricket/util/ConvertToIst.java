package com.sports.cricket.util;

import com.sports.cricket.model.Prediction;
import com.sports.cricket.model.Standings;
import org.springframework.util.CollectionUtils;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class ConvertToIst {

    private static final String DATE_FORMAT = "dd-M-yyyy hh:mm:ss a";

    public static List<Prediction> convertToIstDate(List<Prediction> predictionList){

        if (!CollectionUtils.isEmpty(predictionList)){
            for (Prediction prediction : predictionList){
                if (null != prediction.getPredictedTime()){
                    if (prediction.getPredictedTime().trim().length() > 5) {
                        prediction.setPredictedTime(convertDateTime(prediction.getPredictedTime()));
                    }
                }
            }
        }

        return  predictionList;
    }

    public static List<Standings> convertStandingsToIstDate(List<Standings> standingsList){

        if (!CollectionUtils.isEmpty(standingsList)){
            for (Standings standings : standingsList){
                if (null != standings.getPredictedDate()){
                    if (standings.getPredictedDate().trim().length() > 5) {
                        standings.setPredictedDate(convertDateTime(standings.getPredictedDate()));
                    }
                }
            }
        }

        return  standingsList;
    }

    public static String convertDateTime(String dateInString){
       // String dateInString = LocalDateTime.now().format(DateTimeFormatter.ofPattern(DATE_FORMAT));
        LocalDateTime ldt = LocalDateTime.parse(dateInString, DateTimeFormatter.ofPattern(DATE_FORMAT));

        ZoneId utcZoneId = ZoneId.of("UTC");
        System.out.println("TimeZone : " + utcZoneId);

        //LocalDateTime + ZoneId = ZonedDateTime
        ZonedDateTime utcZonedDateTime = ldt.atZone(utcZoneId);
        System.out.println("Date (UTC) : " + utcZonedDateTime);

        ZoneId kolkataZoneId = ZoneId.of("Asia/Kolkata");
        System.out.println("TimeZone : " + kolkataZoneId);

        ZonedDateTime kolkataDateTime = utcZonedDateTime.withZoneSameInstant(kolkataZoneId);
        System.out.println("Date (Kolkata) : " + kolkataDateTime);

        DateTimeFormatter format = DateTimeFormatter.ofPattern(DATE_FORMAT);
        System.out.println("\n---DateTimeFormatter---");
        System.out.println("Date (UTC) : " + format.format(utcZonedDateTime));
        System.out.println("Date (kolkata) : " + format.format(kolkataDateTime));

        return format.format(kolkataDateTime);
    }

   /* // Local CST
    public static String convertDateTime(String dateInString){
        // String dateInString = LocalDateTime.now().format(DateTimeFormatter.ofPattern(DATE_FORMAT));
        LocalDateTime ldt = LocalDateTime.parse(dateInString, DateTimeFormatter.ofPattern(DATE_FORMAT));

        ZoneId cstZoneId = ZoneId.of("America/Chicago");
        System.out.println("TimeZone : " + cstZoneId);

        //LocalDateTime + ZoneId = ZonedDateTime
        ZonedDateTime cstZonedDateTime = ldt.atZone(cstZoneId);
        System.out.println("Date (CST) : " + cstZonedDateTime);

        ZoneId kolkataZoneId = ZoneId.of("Asia/Kolkata");
        System.out.println("TimeZone : " + kolkataZoneId);

        ZonedDateTime kolkataDateTime = cstZonedDateTime.withZoneSameInstant(kolkataZoneId);
        System.out.println("Date (Kolkata) : " + kolkataDateTime);

        DateTimeFormatter format = DateTimeFormatter.ofPattern(DATE_FORMAT);
        System.out.println("\n---DateTimeFormatter---");
        System.out.println("Date (cst) : " + format.format(cstZonedDateTime));
        System.out.println("Date (kolkata) : " + format.format(kolkataDateTime));

        return format.format(kolkataDateTime);
    }
*/
}
