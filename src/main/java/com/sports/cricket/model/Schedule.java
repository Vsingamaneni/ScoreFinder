package com.sports.cricket.model;

public class Schedule {

    private Integer matchNumber;

    private String homeTeam;

    private String awayTeam;

    private String startDate;

    private boolean isactive;

    private boolean canPredict;

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
}
