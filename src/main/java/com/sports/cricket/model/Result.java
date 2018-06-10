package com.sports.cricket.model;

import java.io.Serializable;

public class Result implements Serializable {

    private static final long serialVersionUID = 7526472295622776127L;

    private Integer matchNumber;

    private String homeTeam;

    private String awayTeam;

    private String startDate;

    private String winner;

    private Double winningAmount;

    private Integer homeTeamCount;

    private Integer awayTeamCount;

    private Integer drawTeamCount;

    private Integer notPredictedCount;

    private Integer matchDay;

    public Integer getMatchNumber() {
        return matchNumber;
    }

    public void setMatchNumber(Integer matchNumber) {
        this.matchNumber = matchNumber;
    }

    public String getHomeTeam() {
        return homeTeam;
    }

    public void setHomeTeam(String homeTeam) {
        this.homeTeam = homeTeam;
    }

    public String getAwayTeam() {
        return awayTeam;
    }

    public void setAwayTeam(String awayTeam) {
        this.awayTeam = awayTeam;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getWinner() {
        return winner;
    }

    public void setWinner(String winner) {
        this.winner = winner;
    }

    public Double getWinningAmount() {
        return winningAmount;
    }

    public void setWinningAmount(Double winningAmount) {
        this.winningAmount = winningAmount;
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

    public Integer getDrawTeamCount() {
        return drawTeamCount;
    }

    public void setDrawTeamCount(Integer drawTeamCount) {
        this.drawTeamCount = drawTeamCount;
    }

    public Integer getNotPredictedCount() {
        return notPredictedCount;
    }

    public void setNotPredictedCount(Integer notPredictedCount) {
        this.notPredictedCount = notPredictedCount;
    }

    public Integer getMatchDay() {
        return matchDay;
    }

    public void setMatchDay(Integer matchDay) {
        this.matchDay = matchDay;
    }
}
