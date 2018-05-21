package com.sports.cricket.model;

import java.util.List;

public class SchedulePrediction {

    private Schedule schedule;

    private List<Prediction> prediction;

    public Schedule getSchedule() {
        return schedule;
    }

    public void setSchedule(Schedule schedule) {
        this.schedule = schedule;
    }

    public List<Prediction> getPrediction() {
        return prediction;
    }

    public void setPrediction(List<Prediction> prediction) {
        this.prediction = prediction;
    }
}
