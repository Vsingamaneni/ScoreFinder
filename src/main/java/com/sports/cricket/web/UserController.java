package com.sports.cricket.web;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.sports.cricket.model.*;
import com.sports.cricket.service.RegistrationService;
import com.sports.cricket.service.ScheduleService;
import com.sports.cricket.util.ValidatePredictions;
import com.sports.cricket.validations.ErrorDetails;
import com.sports.cricket.validations.FormValidator;
import com.sports.cricket.validator.LoginValidator;
import com.sports.cricket.validator.ValidateDeadLine;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sports.cricket.service.UserService;
import com.sports.cricket.validator.UserFormValidator;

@Controller
@ControllerAdvice
public class UserController {

	private final Logger logger = LoggerFactory.getLogger(UserController.class);

    UserLogin userLogin = new UserLogin();

	@Autowired
	UserFormValidator userFormValidator;

	@Autowired
	LoginValidator loginValidator;

    FormValidator formValidator = new FormValidator();

	private UserService userService;
	private ScheduleService scheduleService;
	private RegistrationService registrationService;

	@Autowired
	public void setScheduleService(ScheduleService scheduleService) {
		this.scheduleService = scheduleService;
	}

	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	@Autowired
	public void setRegistrationService(RegistrationService registrationService) {
		this.registrationService = registrationService;
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(Model model, HttpSession httpSession) {
		logger.debug("index()");
		return "redirect:/index";
	}

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String showHomePage(Model model, HttpSession httpSession) {

	    if(null != httpSession.getAttribute("user")){
	        userLogin.setFirstName(httpSession.getAttribute("user").toString());
	        userLogin.setRole(httpSession.getAttribute("role").toString());
	        model.addAttribute("user" , userLogin);
        }

        logger.debug("showHomePage()");
        model.addAttribute("schedules", scheduleService.findAll());
        return "users/index";

    }

	// Remove this
	@RequestMapping(value = "/users", method = RequestMethod.GET)
	public String showAllUsers(Model model) {

		logger.debug("showAllUsers()");
		model.addAttribute("users", userService.findAll());
		return "users/list";

	}

	// Show login page
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String showLogin(ModelMap model,  HttpSession httpSession) {

		List<ErrorDetails> loginErrorDetails = (List<ErrorDetails>)httpSession.getAttribute("loginErrorDetails");
		String loginError = (String)httpSession.getAttribute("msg");

		if(null != loginErrorDetails
			&& loginErrorDetails.size() > 0 ){
			model.addAttribute("loginErrorDetails", loginErrorDetails);

            httpSession.removeAttribute("loginErrorDetails");
		}

		if(null != loginError){
		    model.addAttribute("msg" , loginError);
            httpSession.removeAttribute("msg");
        }

		UserLogin userLogin = new UserLogin();

		logger.debug("showLogin()");
		model.addAttribute("userLogin" , userLogin);
		if(null == httpSession.getAttribute("login")) {
            return "users/login_form";
        }else{
		    return "redirect:/";
        }
	}

	// Validate the login details
	@RequestMapping(value = "/loginUser", method = RequestMethod.POST)
	public String loginUser(@ModelAttribute("userLogin") UserLogin userLogin, ModelMap model
			,  HttpSession httpSession) {

		model.addAttribute("userLogin" , userLogin);

		if(null != httpSession.getAttribute("loginErrorDetails")) {
            httpSession.removeAttribute("loginErrorDetails");
        }

        if(null != model.get("loginErrorDetails")) {
            model.remove("loginErrorDetails");
        }

		List<ErrorDetails> loginErrorDetails = formValidator.isLoginValid(userLogin);

		if( null != loginErrorDetails
			&& loginErrorDetails.size() > 0 ){
			model.addAttribute("loginErrorDetails" , loginErrorDetails);
			httpSession.setAttribute("loginErrorDetails", loginErrorDetails);
			return "redirect:/login";
		}

		logger.debug("saveOrUpdateLogin() : {}", "");
		UserLogin loginDetails = registrationService.loginUser(userLogin);

		if(loginDetails.isLoginSuccess()) {
			model.addAttribute("session", loginDetails);
			//model.addAttribute("msg", "User logged in");
			httpSession.setAttribute("login" , loginDetails);
			httpSession.setAttribute("user", loginDetails.getFirstName());
			httpSession.setAttribute("role", loginDetails.getRole());
			httpSession.setAttribute("session" , userLogin);

			/*List<Schedule> schedules = scheduleService.scheduleList();
			List<Prediction> predictions = scheduleService.findPredictions(loginDetails.getMemberId());

			List<Schedule> finalSchedule = ValidatePredictions.validatePrediction(schedules, predictions);

			model.addAttribute("predictions", predictions);
			model.addAttribute("schedules", finalSchedule);

			httpSession.setMaxInactiveInterval(5*60);*/

			return "redirect:/showPredictions";
		}else{
			model.addAttribute("msg", "User Login Failed!");
			httpSession.setAttribute("msg" , "User Login Failed");
			return "redirect:/login";
		}
	}

	// Update Result
	@RequestMapping(value = "/updateResult", method = RequestMethod.GET)
	public String updateResult(ModelMap model, HttpSession httpSession) throws ParseException {

		UserLogin userLogin = (UserLogin) httpSession.getAttribute("login");
		if(null != model.get("msg")) {
            model.remove("msg");
        }

		if(null == userLogin){
			return "redirect:/";
		}else {
			model.addAttribute("session", userLogin);
			String value = (String)httpSession.getAttribute("msg");
			if(null != value){
				model.addAttribute("msg" , value);
			}
			Schedule schedule = new Schedule();
			httpSession.removeAttribute("msg");
			httpSession.setAttribute("login" , userLogin);
			httpSession.setAttribute("user", userLogin.getFirstName());
			httpSession.setAttribute("role", userLogin.getRole());
			httpSession.setAttribute("session" , userLogin);
			model.addAttribute("schedule" , schedule);

			List<Schedule> schedules = scheduleService.findAll();

			model.addAttribute("schedules", schedules);

			httpSession.setMaxInactiveInterval(5*60);
			return "users/update_result";
		}
	}


	@RequestMapping(value = "/matchResult/update", method = RequestMethod.POST)
	public String updateMatchResult(@ModelAttribute("schedule") Schedule schedule, ModelMap model, HttpSession httpSession) throws ParseException {

		UserLogin userLogin = (UserLogin) httpSession.getAttribute("login");
		if(null != model.get("msg")) {
			model.remove("msg");
		}

		if(null == userLogin){
			return "redirect:/";
		} else if(!userLogin.getRole().equalsIgnoreCase("admin")){
			return "redirect:/";
		}
		else {
			model.addAttribute("session", userLogin);
			String value = (String)httpSession.getAttribute("msg");

			if(null != value){
				model.addAttribute("msg" , value);
			}

			httpSession.removeAttribute("msg");
			httpSession.setAttribute("login" , userLogin);
			httpSession.setAttribute("user", userLogin.getFirstName());
			httpSession.setAttribute("session" , userLogin);
			httpSession.setAttribute("role", userLogin.getRole());

			boolean isUpdateSuccess = false;
			boolean isUpdateMatchDaySuccess = false;

			if(null != schedule
					&& null != schedule.getWinner()) {
				Integer totalMatches = scheduleService.totalMatches(schedule.getMatchDay());
				isUpdateSuccess = scheduleService.updateMatchResult(schedule);
				if(totalMatches == 1){
					isUpdateMatchDaySuccess = scheduleService.updateMatchDay(schedule.getMatchDay()+1);
				}
			}

			if(isUpdateSuccess){
				httpSession.setAttribute("msg" , "Match result is updated successfully ..!!");
			}

			httpSession.setMaxInactiveInterval(5*60);
			return "redirect:/updateResult";
		}
	}
	// Display predictions
	@RequestMapping(value = "/showPredictions", method = RequestMethod.POST)
	public String showAllPredictions(ModelMap model, HttpSession httpSession) {
			return "redirect:/showPredictions";
	}

    // Display predictions
    @RequestMapping(value = "/showPredictions", method = RequestMethod.GET)
    public String showPredictions(ModelMap model, HttpSession httpSession) throws ParseException {

        UserLogin userLogin = (UserLogin) httpSession.getAttribute("login");
        if(null != model.get("msg")) {
            model.remove("msg");
        }

        if(null == userLogin){
            return "redirect:/";
        }else {
            model.addAttribute("session", userLogin);
            //model.addAttribute("msg", "User logged in");
            String value = (String)httpSession.getAttribute("msg");
            if(null != value){
                model.addAttribute("msg" , value);
            }
            httpSession.removeAttribute("msg");
            httpSession.setAttribute("login" , userLogin);
            httpSession.setAttribute("user", userLogin.getFirstName());
            httpSession.setAttribute("role", userLogin.getRole());
            httpSession.setAttribute("session" , userLogin);

            List<Schedule> schedules = ValidatePredictions.validateSchedule(scheduleService.scheduleList());
            List<Prediction> predictions = scheduleService.findPredictions(userLogin.getMemberId());
            List<Schedule> finalSchedule = ValidatePredictions.validatePrediction(schedules, predictions);

            model.addAttribute("predictions", predictions);
            model.addAttribute("schedules", finalSchedule);

            httpSession.setMaxInactiveInterval(5*60);
            return "users/member_login";
        }
    }

	// Display predictions
	@RequestMapping(value = "/prediction/{predictionId}/{matchNumber}/view", method = RequestMethod.GET)
	public String showMemberSelected(@PathVariable("predictionId") Integer predictionId, @PathVariable("matchNumber") Integer matchNumber, Model model, HttpSession httpSession) {

		UserLogin userLogin = (UserLogin) httpSession.getAttribute("login");

		if(null == userLogin){
			return "redirect:/";
		}else {

			Prediction prediction = scheduleService.getPrediction(predictionId,matchNumber);

			model.addAttribute("session", userLogin);
			model.addAttribute("prediction", prediction);
			httpSession.setAttribute("login" , userLogin);

			return "users/show_prediction";
		}
	}

	// Register User
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String showRegisterForm(Model model, HttpSession httpSession) {

        List<ErrorDetails> registerErrorDetails = (List<ErrorDetails>)httpSession.getAttribute("registerErrorDetails");

        if(null != registerErrorDetails
                && registerErrorDetails.size() > 0 ){
            model.addAttribute("registerErrorDetails", registerErrorDetails);
            httpSession.removeAttribute("registerErrorDetails");
        }

		Register register = new Register();

		logger.debug("showRegister()");
		model.addAttribute("registerForm" , register);

        if(null == httpSession.getAttribute("login")) {
            return "users/register_form";
        }else{
            return "redirect:/";
        }
	}

    @RequestMapping(value = "/registerUser", method = RequestMethod.POST)
    public String registerUser(@ModelAttribute("registerForm") Register register, ModelMap model
            ,final RedirectAttributes redirectAttributes , HttpSession httpSession) {

        logger.debug("registerUser() : {}", "");

        if(null != httpSession.getAttribute("registerErrorDetails")) {
            httpSession.removeAttribute("registerErrorDetails");
        }

        if(null != model.get("registerErrorDetails")) {
            model.remove("registerErrorDetails");
        }

        List<ErrorDetails> registerErrorDetails = formValidator.isRegisterValid(register);

        if( null != registerErrorDetails
                && registerErrorDetails.size() > 0 ){
            model.addAttribute("registerErrorDetails" , registerErrorDetails);
            httpSession.setAttribute("registerErrorDetails", registerErrorDetails);
            return "redirect:/register";
        }

        boolean success = registrationService.registerUser(register);

        if(success) {
            redirectAttributes.addFlashAttribute("msg", "User added successfully!");
            return "redirect:/login";
        }else{
            redirectAttributes.addFlashAttribute("msg", "Registration Failed!");
            return "redirect:/register";
        }

    }

	// Display predictions
	@RequestMapping(value = "/member/{memberId}/authorize", method = RequestMethod.GET)
	public String authorizeMember(@PathVariable("memberId") Integer memberId, Model model, HttpSession httpSession) {

		UserLogin userLogin = (UserLogin) httpSession.getAttribute("login");

		if(null == userLogin){
			return "redirect:/";
		}else {
			boolean isAuthSuccess = scheduleService.authorizeMember(memberId);

			model.addAttribute("session", userLogin);
			model.addAttribute("isAuthSuccess", isAuthSuccess);
			httpSession.setAttribute("login" , userLogin);

			return "redirect:/showAllUsers";
		}
	}


	// Show All Users
	@RequestMapping(value = "/showAllUsers", method = RequestMethod.GET)
	public String showAllUsers(Model model, HttpSession httpSession) {

		logger.debug("showAllUsers()");

		UserLogin userLogin = (UserLogin) httpSession.getAttribute("login");

		if(null != userLogin.getRole() && !userLogin.getRole().equalsIgnoreCase("admin")){
			httpSession.setAttribute("msg", "You need to be an admin to view this page.!");
			return "redirect:/showPredictions";
		}
		model.addAttribute("session" , userLogin);
		model.addAttribute("login", userLogin);
		model.addAttribute("userLogin", userLogin);
		List<Register> registerList = registrationService.getAllUsers();
		model.addAttribute("registerList", registerList);

		return "users/members_list";
	}

	// Show Current Predictions
	@RequestMapping(value = "/currentPredictions", method = RequestMethod.GET)
	public String showCurrentPredictions(Model model, HttpSession httpSession) {

		logger.debug("showCurrentPredictions()");

		UserLogin userLogin = (UserLogin) httpSession.getAttribute("login");

		if(null != userLogin.getRole() && !userLogin.getRole().equalsIgnoreCase("admin")){
			httpSession.setAttribute("msg", "You need to be an admin to view this page.!");
			return "redirect:/showPredictions";
		}
		model.addAttribute("session" , userLogin);
		model.addAttribute("login", userLogin);
		model.addAttribute("userLogin", userLogin);
		List<Schedule> currentSchedule = scheduleService.findAll();

		List<Prediction> predictionsList;
		List<SchedulePrediction> schedulePredictionsList = new ArrayList<>();
		SchedulePrediction schedulePrediction;
		for(Schedule schedule : currentSchedule){
		    schedulePrediction = new SchedulePrediction();
		    schedulePrediction.setSchedule(schedule);
			predictionsList =  scheduleService.getPredictionsByMatch(schedule.getMatchNumber());
			List<Register> userLoginList = registrationService.getAllUsers();
			predictionsList = ValidateDeadLine.validatePredictions(schedule, predictionsList, userLoginList);
			schedulePrediction.setPrediction(predictionsList);
			schedulePrediction = ValidatePredictions.setCount(schedule, predictionsList, schedulePrediction);
            schedulePredictionsList.add(schedulePrediction);
		}

        model.addAttribute("schedulePredictions" , schedulePredictionsList);

		return "users/prediction_list";
	}

	// Forget Password
	@RequestMapping(value = "/forget", method = RequestMethod.GET)
	public String forgetPassword(Model model, HttpSession httpSession) {

		Register register = new Register();

		logger.debug("forgetPassword()");
		model.addAttribute("registerForm" , register);

		if(null == httpSession.getAttribute("login")) {
			return "users/forget_password";
		}else{
			return "redirect:/resetPassword";
		}
	}

	// Rest Password
	@RequestMapping(value = "/resetPassword", method = RequestMethod.GET)
	public String resetPasswordAfterLogin( Model model, HttpSession httpSession) {

		logger.debug("resetPasswordAfterLogin()");
		Register userDetails = null;
		if(null != httpSession.getAttribute("login")){

			UserLogin userLogin = (UserLogin) httpSession.getAttribute("login");
			userDetails = registrationService.getUser(userLogin.getEmail());
			Register register = new Register();

			model.addAttribute("registerForm", register);
			model.addAttribute("userDetails", userDetails);

			return "users/reset_password";

		}
		else{
			return "redirect:/";
		}
	}

	// Register User
	@RequestMapping(value = "/resetPassword", method = RequestMethod.POST)
	public String resetPassword(@ModelAttribute("registerForm") Register register, Model model, HttpSession httpSession) {

		logger.debug("resetPassword()");
		Register userDetails = null;

			if (null != register.getEmailId()) {
				userDetails = registrationService.getUser(register.getEmailId());
			}

			logger.debug("forgetPassword()");
			model.addAttribute("registerForm", register);
			model.addAttribute("userDetails", userDetails);

			if (null == httpSession.getAttribute("login")) {
				return "users/reset_password";
			} else {
				return "redirect:/";
			}
	}

	// Update Password
	@RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
	public String updatePassword(@ModelAttribute("registerForm") Register register, Model model, HttpSession httpSession) {

		logger.debug("inside updatePassword()");
		boolean isUpdateSuccess = false;
		if(null != register.getEmailId()){
			isUpdateSuccess = registrationService.updateUser(register);
		}

		logger.debug("forgetPassword()");
		model.addAttribute("registerForm" , register);
		model.addAttribute("isUpdateSuccess", isUpdateSuccess);
		model.addAttribute("msg" , "You have successfully Updated your password ..!!");

		if(null == httpSession.getAttribute("login")) {
			return "redirect:/login";
		}else{
			return "redirect:/showPredictions";
		}
	}

	// show update form
	@RequestMapping(value = "/match/{memberId}/{matchNumber}/predict", method = RequestMethod.GET)
	public String predictMatch(@PathVariable("memberId") Integer memberId, @PathVariable("matchNumber") Integer matchNumber, Model model, HttpSession httpSession) {

		logger.debug("predictMatch() : {}", memberId, matchNumber);

		Schedule schedule = scheduleService.findById(matchNumber);

		Prediction prediction = new Prediction();

		model.addAttribute("scheduleForm", schedule);
		model.addAttribute("predictionForm", prediction);
		model.addAttribute("session" , httpSession.getAttribute("session"));

		return "users/prediction";

	}

	// show update form
	@RequestMapping(value = "/prediction/{predictionId}/delete", method = RequestMethod.GET)
	public String deletePrediction(@PathVariable("predictionId") Integer predictionId, Model model, HttpSession httpSession) {

		logger.debug("deletePrediction() : {}", predictionId);

		boolean isDeleteSuccess = scheduleService.deletePrediction(predictionId);

		model.addAttribute("isDeleteSuccess", isDeleteSuccess);
		model.addAttribute("session" , httpSession.getAttribute("session"));
		httpSession.setAttribute("msg", "Prediction deleted successfully ..!! ");

		return "redirect:/showPredictions";

	}


	// show update prediction form
	@RequestMapping(value = "/prediction/{memberId}/{matchNumber}/update", method = RequestMethod.GET)
	public String showCurrentPrediction(@PathVariable("memberId") Integer memberId, @PathVariable("matchNumber") Integer matchNumber, Model model, HttpSession httpSession) {

		logger.debug("showCurrentPrediction() : {}", memberId, matchNumber);

		UserLogin userLogin = (UserLogin)httpSession.getAttribute("login");

		if(null == userLogin){
			return "redirect:/";
		}

		Schedule schedule = scheduleService.findById(matchNumber);
		Prediction prediction = scheduleService.getPrediction(memberId, matchNumber);

		model.addAttribute("scheduleForm", schedule);
		model.addAttribute("predictionForm", prediction);
		model.addAttribute("session" , httpSession.getAttribute("session"));
		httpSession.setAttribute("msg", "Update for match " + prediction.getHomeTeam() + " vs " + prediction.getAwayTeam() + " is saved successfully ..!! ");

		return "users/update_prediction";

	}

	// Update Prediction details
	@RequestMapping(value = "/match/{memberId}/{matchNumber}/save", method = RequestMethod.POST)
	public String saveUpdatedPrediction(@ModelAttribute("predictionForm") Prediction prediction, @PathVariable("memberId") Integer memberId, @PathVariable("matchNumber") Integer matchNumber, Model model, HttpSession httpSession) {

		logger.debug("saveUpdatedPrediction() : {}", memberId, matchNumber);

		boolean savePrediction = scheduleService.updatePrediction(prediction);

		model.addAttribute("isPredictionSuccess", savePrediction);
		model.addAttribute("session" , httpSession.getAttribute("session"));

		return "redirect:/showPredictions";
	}

	// Update Prediction details
	@RequestMapping(value = "/match/{memberId}/add", method = RequestMethod.POST)
	public String savePrediction(@ModelAttribute("predictionForm") Prediction prediction, @PathVariable("memberId") Integer memberId, Model model, HttpSession httpSession) {

		logger.debug("savePrediction() : {}", memberId, memberId);

		boolean savePrediction = scheduleService.savePrediction(prediction);

		//Prediction prediction = new Prediction();

		//model.addAttribute("scheduleForm", schedule);
		model.addAttribute("isPredictionSuccess", savePrediction);
		model.addAttribute("session" , httpSession.getAttribute("session"));
		//model.addAttribute("msg" , "Your Prediction for " + prediction.getHomeTeam() + " vs " + prediction.getAwayTeam() + " is Saved Successfully!!");
		httpSession.setAttribute("msg" , "Your Prediction for " + prediction.getHomeTeam() + " vs " + prediction.getAwayTeam() + " is Saved Successfully!!");

		return "redirect:/showPredictions";
	}

	// Update Prediction details
	@RequestMapping(value = "/match/{memberId}/update", method = RequestMethod.POST)
	public String updatePrediction(@ModelAttribute("predictionForm") Prediction prediction, @PathVariable("memberId") Integer memberId, Model model, HttpSession httpSession) {

		logger.debug("updatePrediction() : {}", memberId, memberId);

		boolean savePrediction = scheduleService.savePrediction(prediction);

		model.addAttribute("isPredictionSuccess", savePrediction);
		model.addAttribute("session" , httpSession.getAttribute("session"));

		return "redirect:/showPredictions";
	}


	@RequestMapping(value = "/logout", method = RequestMethod.POST)
    public String logoutUser(Model model,  HttpSession httpSession) {

        logger.debug("logoutUser()");
        httpSession.invalidate();
       return "pages/logout";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logoutUserAgain(Model model,  HttpSession httpSession) {

        logger.debug("logoutUser()");
        httpSession.invalidate();
        return "pages/logout";
    }

	// save or update user
	@RequestMapping(value = "/users", method = RequestMethod.POST)
	public String saveOrUpdateUser(@ModelAttribute("userForm") @Validated User user,
			BindingResult result, Model model, final RedirectAttributes redirectAttributes) {

		logger.debug("saveOrUpdateUser() : {}", user);

		if (result.hasErrors()) {
			populateDefaultModel(model);
			return "users/userform" +
					"";
		} else {

			redirectAttributes.addFlashAttribute("css", "success");
			if(user.isNew()){
				redirectAttributes.addFlashAttribute("msg", "User added successfully!");
			}else{
				redirectAttributes.addFlashAttribute("msg", "User updated successfully!");
			}
			
			userService.saveOrUpdate(user);
			
			// POST/REDIRECT/GET
			return "redirect:/users/" + user.getId();

			// POST/FORWARD/GET
			// return "user/list";

		}

	}

	// show add user form
	@RequestMapping(value = "/users/add", method = RequestMethod.GET)
	public String showAddUserForm(Model model) {

		logger.debug("showAddUserForm()");

		User user = new User();

		// set default value
		user.setName("mkyong123");
		user.setEmail("test@gmail.com");
		user.setAddress("abc 88");
		//user.setPassword("123");
		//user.setConfirmPassword("123");
		user.setNewsletter(true);
		user.setSex("M");
		user.setFramework(new ArrayList<String>(Arrays.asList("Spring MVC", "GWT")));
		user.setSkill(new ArrayList<String>(Arrays.asList("Spring", "Grails", "Groovy")));
		user.setCountry("SG");
		user.setNumber(2);

		model.addAttribute("userForm", user);

		populateDefaultModel(model);

		return "users/userform";

	}

	// show update form
	@RequestMapping(value = "/users/{id}/update", method = RequestMethod.GET)
	public String showUpdateUserForm(@PathVariable("id") int id, Model model) {

		logger.debug("showUpdateUserForm() : {}", id);

		User user = userService.findById(id);
		model.addAttribute("userForm", user);
		
		populateDefaultModel(model);
		
		return "users/userform";

	}

	// delete user
	@RequestMapping(value = "/users/{id}/delete", method = RequestMethod.POST)
	public String deleteUser(@PathVariable("id") int id, final RedirectAttributes redirectAttributes) {

		logger.debug("deleteUser() : {}", id);

		userService.delete(id);
		
		redirectAttributes.addFlashAttribute("css", "success");
		redirectAttributes.addFlashAttribute("msg", "User is deleted!");
		
		return "redirect:/users";

	}

	// show user
	@RequestMapping(value = "/users/{id}", method = RequestMethod.GET)
	public String showUser(@PathVariable("id") int id, Model model) {

		logger.debug("showUser() id: {}", id);

		User user = userService.findById(id);
		if (user == null) {
			model.addAttribute("css", "danger");
			model.addAttribute("msg", "User not found");
		}
		model.addAttribute("user", user);

		return "users/show";

	}

	@RequestMapping(value = "/members/{id}", method = RequestMethod.GET)
	public String showRegister(@PathVariable("id") String name, Model model) {

		logger.debug("showRegister() id: {}", name);

		/*User user = userService.findById(name);
		if (user == null) {
			model.addAttribute("css", "danger");
			model.addAttribute("msg", "User not found");
		}
		model.addAttribute("user", user);*/

		return "users/show";

	}

	private void populateDefaultModel(Model model) {

		List<String> frameworksList = new ArrayList<String>();
		frameworksList.add("Spring MVC");
		frameworksList.add("Struts 2");
		frameworksList.add("JSF 2");
		frameworksList.add("GWT");
		frameworksList.add("Play");
		frameworksList.add("Apache Wicket");
		model.addAttribute("frameworkList", frameworksList);

		Map<String, String> skill = new LinkedHashMap<String, String>();
		skill.put("Hibernate", "Hibernate");
		skill.put("Spring", "Spring");
		skill.put("Struts", "Struts");
		skill.put("Groovy", "Groovy");
		skill.put("Grails", "Grails");
		model.addAttribute("javaSkillList", skill);

		List<Integer> numbers = new ArrayList<Integer>();
		numbers.add(1);
		numbers.add(2);
		numbers.add(3);
		numbers.add(4);
		numbers.add(5);
		model.addAttribute("numberList", numbers);

		Map<String, String> country = new LinkedHashMap<String, String>();
		country.put("US", "United Stated");
		country.put("CN", "China");
		country.put("SG", "Singapore");
		country.put("MY", "Malaysia");
		model.addAttribute("countryList", country);

	}

	@ExceptionHandler(EmptyResultDataAccessException.class)
	public ModelAndView handleEmptyData(HttpServletRequest req, Exception ex) {

		logger.debug("handleEmptyData()");
		logger.error("Request: {}, error ", req.getRequestURL(), ex);

		ModelAndView model = new ModelAndView();
		model.setViewName("user/show");
		model.addObject("msg", "user not found");

		return model;

	}

}