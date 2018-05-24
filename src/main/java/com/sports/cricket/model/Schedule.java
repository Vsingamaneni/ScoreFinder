package com.sports.cricket.model;

public class Schedule {

    private Integer matchNumber;

    private String homeTeam;

    private String awayTeam;

    private String startDate;

    private String winner;

    private boolean isactive;

    private boolean canPredict;

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

    public boolean isIsactive() {
        return isactive;
    }

    public void setIsactive(boolean isactive) {
        this.isactive = isactive;
    }

    public boolean isCanPredict() {
        return canPredict;
    }

    public void setCanPredict(boolean canPredict) {
        this.canPredict = canPredict;
    }

    public Integer getMatchDay() {
        return matchDay;
    }

    public void setMatchDay(Integer matchDay) {
        this.matchDay = matchDay;
    }
}
