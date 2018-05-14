package com.sports.cricket.dao;

import com.sports.cricket.model.Prediction;
import com.sports.cricket.model.Schedule;
import com.sports.cricket.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.core.Local;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ScheduleDaoImpl implements ScheduleDao {

    DataSource dataSource;
    JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Autowired
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Schedule> findAll() {
        String sql = "SELECT * FROM schedule where isActive = TRUE";

        List<Schedule> result = jdbcTemplate.query(sql, new BeanPropertyRowMapper(Schedule.class));

        return result;
    }

    @Override
    public List<Schedule> scheduleList() {
        String sql = "SELECT * FROM SCHEDULE";

        List<Schedule> result = jdbcTemplate.query(sql, new BeanPropertyRowMapper(Schedule.class));

        return result;
    }

    @Override
    public Schedule findById(Integer matchNumber) {

        Map<String, Object> params = new HashMap<String, Object>();
        params.put("matchNumber", matchNumber);

        String sql = "SELECT * FROM SCHEDULE where matchNumber = ?";

        Schedule result = null;
        try {
            result = (Schedule) jdbcTemplate.queryForObject(sql, new Object[]{matchNumber}, new BeanPropertyRowMapper(Schedule.class));
        } catch (EmptyResultDataAccessException e) {
        }

        return result;
    }

    @Override
    public List<Prediction> findPredictions(Integer memberId) {
        String sql = "SELECT * FROM PREDICTIONS where memberId = " + memberId;

        List<Prediction> result = jdbcTemplate.query(sql, new BeanPropertyRowMapper(Prediction.class));

        return result;
    }

    @Override
    public boolean savePrediction(Prediction prediction) {

        boolean isSuccess = false;

        String sql = "INSERT INTO PREDICTIONS(memeberId, matchNumber, homeTeam, awayTeam, firstName, selected, predictedTime)" +
                    "VALUES (?,?,?,?,?,?,?)";


        Connection conn = null;

        try {
            conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, prediction.getMemberId());
            ps.setInt(2, prediction.getMatchNumber());
            ps.setString(3, prediction.getHomeTeam());
            ps.setString(4, prediction.getAwayTeam());
            ps.setString(5, prediction.getFirstName());
            ps.setString(6, prediction.getSelected());
            ps.setString(7, getTime().toString());

            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                    isSuccess = true;
                } catch (SQLException e) {}
            }
        }

        return isSuccess;
    }

    @Override
    public boolean updatePrediction(Prediction prediction) {
        boolean isSuccess = false;

        String sql = "UPDATE PREDICTIONS SET selected = ? , predictedTime = ? where predictionId = ?";


        Connection conn = null;

        try {
            conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, prediction.getSelected());
            ps.setString(2, getTime().toString());
            ps.setInt(3, prediction.getPredictionId());


            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                    isSuccess = true;
                } catch (SQLException e) {}
            }
        }

        return isSuccess;
    }

    @Override
    public Prediction getPrediction(Integer memberId, Integer matchId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("memberId", memberId);
        params.put("matchId", matchId);

        String sql = "SELECT * FROM PREDICTIONS where memeberId = ? and matchNumber =?";

        Prediction prediction = null;
        try {
            prediction = (Prediction) jdbcTemplate.queryForObject(sql, new Object[]{memberId, matchId}, new BeanPropertyRowMapper(Prediction.class));
        } catch (EmptyResultDataAccessException e) {
        }

        return prediction;
    }

    @Override
    public boolean deletePrediction(Integer predictionId) {
        boolean isSuccess = false;

        String sql = "DELETE FROM PREDICTIONS where predictionId = ?";


        Connection conn = null;

        try {
            conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, predictionId);

            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                    isSuccess = true;
                } catch (SQLException e) {}
            }
        }

        return isSuccess;
    }

    private SqlParameterSource getSqlParameterByModel(Prediction prediction) {

        MapSqlParameterSource paramSource = new MapSqlParameterSource();
        paramSource.addValue("memberId", prediction.getMemberId());
        paramSource.addValue("matchNumber", prediction.getMatchNumber());
        paramSource.addValue("homeTeam", prediction.getHomeTeam());
        paramSource.addValue("awayTeam", prediction.getAwayTeam());
        paramSource.addValue("selected", prediction.getSelected());
        paramSource.addValue("predictedTime", getTime().toString());

        return paramSource;
    }

    private LocalDateTime getTime(){
        return java.time.LocalDateTime.now();
    }
}
