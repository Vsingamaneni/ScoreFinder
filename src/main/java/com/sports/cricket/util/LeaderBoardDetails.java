package com.sports.cricket.util;

import com.sports.cricket.model.LeaderBoard;
import com.sports.cricket.model.Register;
import com.sports.cricket.model.Standings;

import java.util.ArrayList;
import java.util.List;

public class LeaderBoardDetails {

    public static List<LeaderBoard> mapLeaderBoard(List<Standings> standingsList , List<Register> registerList){

        List<LeaderBoard> leaderBoardList = new ArrayList<>();

        LeaderBoard leaderBoard;

        for(Register register : registerList){
            leaderBoard = new LeaderBoard();
            leaderBoard.setMemberId(register.getMemberId());
            leaderBoard.setFirstName(register.getfName());
            leaderBoard.setLastName(register.getlName());
            leaderBoard.setWonAmount((new Integer(0)).doubleValue());
            leaderBoard.setLostAmount((new Integer(0)).doubleValue());
            for(Standings standings : standingsList){
                if(standings.getMemberId() == register.getMemberId()){
                    leaderBoard.setWonAmount(leaderBoard.getWonAmount() + standings.getWonAmount());
                    leaderBoard.setLostAmount(leaderBoard.getLostAmount() + standings.getLostAmount());
                }
            }
            leaderBoard.setTotal(leaderBoard.getWonAmount() - leaderBoard.getLostAmount());
            leaderBoard.setIsActive(register.getIsActive());
            leaderBoardList.add(leaderBoard);
        }

        return leaderBoardList;
    }

    public static List<Standings> getStandings(List<Standings> standingsList, Integer memberId){

        List<Standings> userStandingsList = new ArrayList<>(standingsList);

        for(Standings standings : standingsList){
            if(standings.getMemberId() != memberId ){
                userStandingsList.remove(standings);
            }
        }

        return userStandingsList;
    }

    public static boolean isLimitReached(List<Standings> standingsList, Integer memberId, Integer maxLimit){

        double lostAmount = 0;
        double maxLimitValue = (double)maxLimit;

        for(Standings standings : standingsList){
            if(standings.getMemberId() == memberId)
            {
                lostAmount = lostAmount + standings.getLostAmount();
            }
        }

        if(lostAmount > maxLimitValue){
            return true;
        }

        return false;
    }

}
