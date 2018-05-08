package com.sports.cricket.service;

import com.sports.cricket.model.Register;
import com.sports.cricket.model.UserLogin;

public interface RegistrationService {

    boolean registerUser(Register registration);

    UserLogin loginUser(UserLogin userLogin);

}
