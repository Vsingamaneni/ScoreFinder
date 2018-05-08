package com.sports.cricket.dao;


import com.sports.cricket.model.Register;
import com.sports.cricket.model.UserLogin;

public interface RegistrationDao {

    boolean registerUser(Register registration);

    UserLogin loginUser(UserLogin userLogin);
}
