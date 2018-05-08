package com.sports.cricket.dao;

import com.sports.cricket.model.Register;
import com.sports.cricket.model.User;
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

        String sql = "INSERT INTO REGISTER(event, title, fname, lname, emailId, gender, mobile, country, encryptedPass, saltKey, securityKey, isActive) "
                    + "VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?)";


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
            ps.setString(11, registration.getSecurity());
            ps.setString(12, registration.getIsActive());

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

        Map<String, Object> params = new HashMap<String, Object>();
        params.put("email", userLogin.getEmail());

        String selectSQL = "SELECT * FROM REGISTER where emailId = ?";

       Register register = (Register) jdbcTemplate.queryForObject(selectSQL,new Object[] { userLogin.getEmail() }, new BeanPropertyRowMapper(Register.class));

       if(null != register
            && null != register.getEncryptedPass() && null != register.getSaltKey()){
               if(!VerifyProvidedPassword.decryptPassword(userLogin.getPassword(), register)){
                   System.out.println("Passwords mismatch");
               }
               userLogin.setFirstName(register.getfName());
               userLogin.setLoginSuccess(true);
           }



        System.out.println("Successfully Retrieved the member" + register);

        return userLogin;
    }

}
