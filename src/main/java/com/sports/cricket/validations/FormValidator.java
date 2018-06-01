package com.sports.cricket.validations;

import com.sports.cricket.model.Register;
import com.sports.cricket.model.Restrictions;
import com.sports.cricket.model.UserLogin;
import com.sports.cricket.validator.EmailValidator;

import java.util.ArrayList;
import java.util.List;

public class FormValidator {

    EmailValidator emailValidator = new EmailValidator();

    List<ErrorDetails> errorsList = null;

    public List<ErrorDetails> isLoginValid(UserLogin userLogin){

        errorsList = new ArrayList<>();
        ErrorDetails errorDetails;

        if(null == userLogin){
            errorDetails = new ErrorDetails();
            errorDetails.setErrorField("userLogin");
            errorDetails.setErrorMessage("User Login details are empty..!!");
            errorsList.add(errorDetails);
        }

        if(null != userLogin){
            if(null == userLogin.getEmail() || userLogin.getEmail().isEmpty()){
                errorDetails = new ErrorDetails();
                errorDetails.setErrorField("email");
                errorDetails.setErrorMessage("Email Id cannot be empty ..!!");
                errorsList.add(errorDetails);
            }else if(null != userLogin.getEmail() && !userLogin.getEmail().isEmpty()){
                if(!emailValidator.valid(userLogin.getEmail())) {
                    errorDetails = new ErrorDetails();
                    errorDetails.setErrorField("email");
                    errorDetails.setErrorMessage("Invalid Email ID format ..!!");
                    errorsList.add(errorDetails);
                }
            }

            if(null == userLogin.getPassword() || userLogin.getPassword().isEmpty()){
                errorDetails = new ErrorDetails();
                errorDetails.setErrorField("password");
                errorDetails.setErrorMessage("Password is empty..!!");
                errorsList.add(errorDetails);
            }
        }

        return errorsList;
    }

    public List<ErrorDetails> isRegisterValid(Register register, Restrictions restrictions){
        errorsList = new ArrayList<>();
        ErrorDetails errorDetails = null;

        if(null == register){
            errorDetails = new ErrorDetails();
            errorDetails.setErrorField("register");
            errorDetails.setErrorMessage("Register details are empty..!!");
            errorsList.add(errorDetails);
        }

        if(null != register){
            if(null == register.getfName() || register.getfName().isEmpty()){
                errorDetails = new ErrorDetails();
                errorDetails.setErrorField("firstName");
                errorDetails.setErrorMessage("First Name cannot be empty ..!!");
                errorsList.add(errorDetails);
            }

            if(null == register.getfName() || register.getfName().isEmpty()){
                errorDetails = new ErrorDetails();
                errorDetails.setErrorField("lastName");
                errorDetails.setErrorMessage("Last Name cannot be empty ..!!");
                errorsList.add(errorDetails);
            }

            if(null == register.getEmailId() || register.getEmailId().isEmpty()){
                errorDetails = new ErrorDetails();
                errorDetails.setErrorField("emailId");
                errorDetails.setErrorMessage("emailId cannot be empty ..!!");
                errorsList.add(errorDetails);
            }else if(null != register.getEmailId() && ! register.getEmailId().isEmpty()){
                if(!emailValidator.valid(register.getEmailId())) {
                    errorDetails = new ErrorDetails();
                    errorDetails.setErrorField("email");
                    errorDetails.setErrorMessage("Invalid Email ID format ..!!");
                    errorsList.add(errorDetails);
                }
            }

            if(null == register.getConfirmEmailId() || register.getConfirmEmailId().isEmpty()){
                errorDetails = new ErrorDetails();
                errorDetails.setErrorField("confirmEmailId");
                errorDetails.setErrorMessage("Confirm EmailId cannot be empty ..!!");
                errorsList.add(errorDetails);
            }else if(null != register.getConfirmEmailId() && ! register.getConfirmEmailId().isEmpty()){
                if(!emailValidator.valid(register.getConfirmEmailId())) {
                    errorDetails = new ErrorDetails();
                    errorDetails.setErrorField("confirmEmail");
                    errorDetails.setErrorMessage("Invalid Confirm Email ID format ..!!");
                    errorsList.add(errorDetails);
                }
            }

            if(null != register && !register.getEmailId().isEmpty() && !register.getConfirmEmailId().isEmpty()){
                if(!register.getEmailId().equalsIgnoreCase(register.getConfirmEmailId())){
                    errorDetails = new ErrorDetails();
                    errorDetails.setErrorField("emailId");
                    errorDetails.setErrorMessage("Both Email and Confirm Email didnt match!!");
                    errorsList.add(errorDetails);
                }
            }

            if(null == register.getPassword() || register.getPassword().isEmpty()){
                errorDetails = new ErrorDetails();
                errorDetails.setErrorField("password");
                errorDetails.setErrorMessage("Password cannot be empty ..!!");
                errorsList.add(errorDetails);
            }

            if(null == register.getConfirmPassword() || register.getConfirmPassword().isEmpty()){
                errorDetails = new ErrorDetails();
                errorDetails.setErrorField("confirmPassword");
                errorDetails.setErrorMessage("Confirm Password cannot be empty ..!!");
                errorsList.add(errorDetails);
            }

            if(null != register && !register.getPassword().isEmpty() && !register.getConfirmPassword().isEmpty()){
                if(!register.getPassword().equalsIgnoreCase(register.getConfirmPassword())){
                    errorDetails = new ErrorDetails();
                    errorDetails.setErrorField("password");
                    errorDetails.setErrorMessage("Both Password and Confirm Password didn't match!!");
                    errorsList.add(errorDetails);
                }
            }

            if ( null != restrictions){
                if( null != restrictions.getSecurityCode()) {
                    if (!restrictions.getSecurityCode().equalsIgnoreCase(register.getSecurity())) {
                        errorDetails = new ErrorDetails();
                        errorDetails.setErrorField("securityCode");
                        errorDetails.setErrorMessage("Security Code didn't match. Contact admin to get the right code");
                        errorsList.add(errorDetails);
                    }
                } else{
                    errorDetails = new ErrorDetails();
                    errorDetails.setErrorField("securityCode");
                    errorDetails.setErrorMessage("Security Code cannot be empty..!");
                    errorsList.add(errorDetails);
                }
            }

            if(null == register.getSecurityAnswer() || register.getSecurityAnswer().isEmpty()){
                errorDetails = new ErrorDetails();
                errorDetails.setErrorField("securityAnswer");
                errorDetails.setErrorMessage("Security Answer cannot be empty ..!!");
                errorsList.add(errorDetails);
            }

            if(null == register.getSecurity() || register.getSecurity().isEmpty()){
                errorDetails = new ErrorDetails();
                errorDetails.setErrorField("securityKey");
                errorDetails.setErrorMessage("Security Key cannot be empty ..!!");
                errorsList.add(errorDetails);
            }

            if(null == register.getTerms() || register.getTerms().isEmpty() || null != register.getTerms() && !register.getTerms().equalsIgnoreCase("yes"))  {
                errorDetails = new ErrorDetails();
                errorDetails.setErrorField("terms");
                errorDetails.setErrorMessage("You must accept terms and conditions to register!!");
                errorsList.add(errorDetails);
            }
        }

        return errorsList;
    }
}
