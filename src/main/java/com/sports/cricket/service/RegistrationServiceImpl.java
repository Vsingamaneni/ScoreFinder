package com.sports.cricket.service;

import com.sports.cricket.dao.RegistrationDao;
import com.sports.cricket.model.Register;
import com.sports.cricket.model.UserLogin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("registrationService")
public class RegistrationServiceImpl implements RegistrationService {

    RegistrationDao registrationDao;

    @Autowired
    public void setRegistrationDao(RegistrationDao registrationDao) {
        this.registrationDao = registrationDao;
    }

    @Override
    public boolean registerUser(Register registration) {
       return registrationDao.registerUser(registration);
    }

    @Override
    public UserLogin loginUser(UserLogin userLogin) {
        return registrationDao.loginUser(userLogin);
    }

    @Override
    public Register getUser(String emailId) {
        return registrationDao.getUser(emailId);
    }

    @Override
    public boolean updateUser(Register register) {
        return registrationDao.updatePassword(register);
    }

}
