package com.sports.cricket.model;

import java.io.Serializable;

public class LeaderBoard implements Serializable {

    private static final long serialVersionUID = 522472595622271147L;

    private Integer rank;

    private Integer memberId;

    private String firstName;

    private String lastName;

    private double wonAmount;

    private double lostAmount;

    private double total;

    private String isActive;

    public Integer getRank() {
        return rank;
    }

    public void setRank(Integer rank) {
        this.rank = rank;
    }

    public Integer getMemberId() {
        return memberId;
    }

    public void setMemberId(Integer memberId) {
        this.memberId = memberId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public double getWonAmount() {
        return wonAmount;
    }

    public void setWonAmount(double wonAmount) {
        this.wonAmount = wonAmount;
    }

    public double getLostAmount() {
        return lostAmount;
    }

    public void setLostAmount(double lostAmount) {
        this.lostAmount = lostAmount;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getIsActive() {
        return isActive;
    }

    public void setIsActive(String isActive) {
        this.isActive = isActive;
    }
}
