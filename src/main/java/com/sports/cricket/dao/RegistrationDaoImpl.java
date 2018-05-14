package com.sports.cricket.dao;

import com.sports.cricket.model.Prediction;
import com.sports.cricket.model.Register;
import com.sports.cricket.model.UserLogin;
import com.sports.cricket.password.EncryptedPassword;
import com.sports.cricket.password.ProtectUserPassword;
import com.sports.cricket.password.VerifyProvidedPassword;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public class RegistrationDaoImpl implements RegistrationDao {


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
    public boolean registerUser(Register registration) {

        System.out.println("Inside Member Registration");

        if(registration != null
                && null != registration.getPassword()){
            EncryptedPassword encryptedPassword = ProtectUserPassword.encryptPassword(registration.getPassword());
            registration.setEncryptedPass(encryptedPassword.getEncryptedPassword());
            registration.setSaltKey(encryptedPassword.getSalt());
            registration.setIsActive("Y");
        }

        String sql = "INSERT INTO REGISTER(event, title, fname, lname, emailId, gender, mobile, country, encryptedPass, saltKey, securityQuestion, securityAnswer, securityKey, isActive) "
                    + "VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?)";


        Connection conn = null;

        try {
            conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, registration.getEvent());
            ps.setString(2, registration.getTitle());
            ps.setString(3, registration.getfName());
            ps.setString(4, registration.getlName());
            ps.setString(5, registration.getEmailId());
            ps.setString(6, registration.getGender());
            ps.setString(7, registration.getMobile());
            ps.setString(8, registration.getCountry());
            ps.setString(9, registration.getEncryptedPass());
            ps.setString(10, registration.getSaltKey());
            ps.setString(11, registration.getSecurityQuestion());
            ps.setString(12, registration.getSecurityAnswer());
            ps.setString(13, registration.getSecurity());
            ps.setString(14, registration.getIsActive());

            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);

        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {}
            }
        }


        System.out.println("Member Update Done");

        return true;
    }

    @Override
    public UserLogin loginUser(UserLogin userLogin) {
        System.out.println("Inside Member Login");

        Map<String, Object> params = new HashMap<>();
        params.put("email", userLogin.getEmail());

        String selectSQL = "SELECT * FROM REGISTER where emailId = ?";

       Register register = (Register) jdbcTemplate.queryForObject(selectSQL,new Object[] { userLogin.getEmail() }, new BeanPropertyRowMapper(Register.class));

       if(null != register
            && null != register.getEncryptedPass() && null != register.getSaltKey()){
               if(!VerifyProvidedPassword.decryptPassword(userLogin.getPassword(), register)){
                   System.out.println("Passwords mismatch");
               }else{
                   System.out.println("Incorrect Password");
               }
               userLogin.setFirstName(register.getfName());
               userLogin.setMemberId(register.getMemberId());
               userLogin.setLoginSuccess(true);
           }

        return userLogin;
    }

    @Override
    public Register getUser(String emailId) {
        System.out.println("Inside retrieving User");

        Map<String, Object> params = new HashMap<String, Object>();
        params.put("email", emailId);

        String selectSQL = "SELECT * FROM REGISTER where emailId = ?";

        Register register = (Register) jdbcTemplate.queryForObject(selectSQL,new Object[] { emailId }, new BeanPropertyRowMapper(Register.class));

        if(null != register
                && null != register.getSecurityAnswer()
                && null != register.getSecurityQuestion()){
            System.out.println("Retrieved user successfully");
        }

        return register;
    }

    @Override
    public boolean updatePassword(Register register) {
        System.out.println("Inside Updating Password");

        if(register != null
                && null != register.getPassword()){
            EncryptedPassword encryptedPassword = ProtectUserPassword.encryptPassword(register.getPassword());
            register.setEncryptedPass(encryptedPassword.getEncryptedPassword());
            register.setSaltKey(encryptedPassword.getSalt());
        }

        String sql = "UPDATE REGISTER SET encryptedPass = '" +register.getEncryptedPass() +"', saltKey = '" +register.getSaltKey() +"' where emailId = '" + register.getEmailId() +"'";

/*

        Connection conn = null;

        try {
            conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, register.getEncryptedPass());
            ps.setString(2, register.getSaltKey());
            ps.setString(3, register.getEmailId());

            ps.executeUpdate();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);

        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {}
            }
        }
*/
    int row = jdbcTemplate.update(sql);

        System.out.println("Password Update Done");

        return true;
    }

}