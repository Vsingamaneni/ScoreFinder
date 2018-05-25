package com.sports.cricket.model;

import java.util.List;

public class SchedulePrediction {

    private Schedule schedule;

    private List<Prediction> prediction;

    private Integer homeTeamCount;

    private Integer awayTeamCount;

    private Integer notPredicted;

    private double homeWinAmount;

    private boolean isDeadlinReached;

    private double awayWinAmount;

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

    public Integer getHomeTeamCount() {
        return homeTeamCount;
    }

    public void setHomeTeamCount(Integer homeTeamCount) {
        this.homeTeamCount = homeTeamCount;
    }

    public Integer getAwayTeamCount() {
        return awayTeamCount;
    }

    public void setAwayTeamCount(Integer awayTeamCount) {
        this.awayTeamCount = awayTeamCount;
    }

    public Integer getNotPredicted() {
        return notPredicted;
    }

    public void setNotPredicted(Integer notPredicted) {
        this.notPredicted = notPredicted;
    }

    public double getHomeWinAmount() {
        return homeWinAmount;
    }

    public void setHomeWinAmount(double homeWinAmount) {
        this.homeWinAmount = homeWinAmount;
    }

    public double getAwayWinAmount() {
        return awayWinAmount;
    }

    public void setAwayWinAmount(double awayWinAmount) {
        this.awayWinAmount = awayWinAmount;
    }

    public boolean isDeadlinReached() {
        return isDeadlinReached;
    }

    public void setDeadlinReached(boolean deadlinReached) {
        isDeadlinReached = deadlinReached;
    }
}
