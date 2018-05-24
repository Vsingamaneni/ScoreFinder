<%--
  Created by IntelliJ IDEA.
  User: v0s004a
  Date: 5/1/18
  Time: 11:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" >

<head>
    <meta charset="UTF-8">
    <title>Registration Form</title>

    <!--Fav Icon:-->
    <link rel="shortcut icon" href="/resources/core/images/cricket.ico" />

    <!--CSS Styles:-->
    <spring:url value="/resources/core/css/home.css" var="homeCss" />
    <spring:url value="/resources/core/css/clock.css" var="clockCss" />
    <spring:url value="/resources/core/css/footer.css" var="footerCss" />
    <spring:url value="/resources/core/css/style.css" var="styleCss" />
    <spring:url value="/resources/core/css/register.css" var="registerCss" />
    <link href="${homeCss}" rel="stylesheet" />
    <link href="${clockCss}" rel="stylesheet" />
    <link href="${footerCss}" rel="stylesheet" />
    <link href="${styleCss}" rel="stylesheet" />
    <link href="${registerCss}" rel="stylesheet" />

    <link href='https://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css' rel='stylesheet' type='text/css'>
    <link href='http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/css/datepicker.min.css' rel='stylesheet' type='text/css'>
    <link href='http://cdnjs.cloudflare.com/ajax/libs/bootstrap-switch/1.8/css/bootstrap-switch.css' rel='stylesheet' type='text/css'>
    <link href='https://davidstutz.github.io/bootstrap-multiselect/css/bootstrap-multiselect.css' rel='stylesheet' type='text/css'>
    <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js' type='text/javascript'></script>
    <script src='http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.0/js/bootstrap.min.js' type='text/javascript'></script>
    <script src='http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/js/bootstrap-datepicker.min.js' type='text/javascript'></script>
    <script src='http://cdnjs.cloudflare.com/ajax/libs/bootstrap-switch/1.8/js/bootstrap-switch.min.js' type='text/javascript'></script>
    <script src='https://davidstutz.github.io/bootstrap-multiselect/js/bootstrap-multiselect.js' type='text/javascript'></script>

    <spring:url value="/registerUser" var="registerUrl" />
    <spring:url value="/register" var="cancelUrl" />

</head>

<body>

<div style="width: 1250px; margin: 0 auto;">

    <jsp:include page="../fragments/header.jsp" />

    <header>

        <jsp:include page="../fragments/nav_before_login.jsp" />

        <c:if test="${fn:length(registerErrorDetails) > 0}">
            <h2 style="color:red;font-size:15px;text-decoration:none;font-family:Comic Sans MS"> Please fix the below errors..!!</h2>
        </c:if>
        <c:forEach var="registerErrorDetail" items="${registerErrorDetails}">
            <c:if test="${not empty registerErrorDetail.errorMessage}" >
                <h2 style="color:red;font-size:15px;text-decoration:none;font-family:Comic Sans MS"> *** ${registerErrorDetail.errorMessage} </h2>
            </c:if>
        </c:forEach>

        <div class='container' style="width: 1000px;">
            <div class='panel panel-primary dialog-panel'>
                <div class='panel-heading' style="background-color: #082a3e;">
                    <h5 style="text-align: left;">Score Finder - Reservation</h5>
                </div>
                <div class='panel-body'>
                    <form action="/registerUser" modelAttribute="registerForm" method="POST" class='form-horizontal' role='form'>
                        <div class='form-group'>
                            <label class='control-label col-md-2 col-md-offset-2' for='id_event'>Registration Event</label>
                            <div class='col-md-2'>
                                <select class='form-control' id='id_event' name="event">
                                    <option>Cricket</option>
                                    <option>Kabaddi</option>
                                    <option>Football</option>
                                </select>
                            </div>
                        </div>
                        <div class='form-group'>
                            <label class='control-label col-md-2 col-md-offset-2' for='id_title'>Name</label>
                            <div class='col-md-8'>
                                <div class='col-md-2'>
                                    <div class='form-group internal'>
                                        <select class='form-control' id='id_title' name="title">
                                            <option>Mr</option>
                                            <option>Ms</option>
                                            <option>Mrs</option>
                                            <option>Miss</option>
                                            <option>Dr</option>
                                        </select>
                                    </div>
                                </div>
                                <div class='col-md-3 indent-small'>
                                    <div class='form-group internal'>
                                        <input class='form-control' id='id_first_name' placeholder='First Name' name="fName" type='text'>
                                    </div>
                                </div>
                                <div class='col-md-3 indent-small'>
                                    <div class='form-group internal'>
                                        <input class='form-control' id='id_last_name' placeholder='Last Name' name="lName" type='text'>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class='form-group'>
                            <label class='control-label col-md-2 col-md-offset-2' for='id_email'>Email ID</label>
                            <div class='col-md-6'>
                                <div class='form-group'>
                                    <div class='col-md-11'>
                                        <input class='form-control' id='id_email' placeholder='E-mail' name="emailId" type='text'>
                                    </div>
                                </div>
                                <div class='form-group internal'>
                                    <div class='col-md-11'>
                                        <input class='form-control' id='id_confirm_email' placeholder='Confirm E-mail' name="confirmEmailId" type='text'>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class='form-group'>
                            <label class='control-label col-md-2 col-md-offset-2' for='id_email'>Password</label>
                            <div class='col-md-6'>
                                <div class='form-group'>
                                    <div class='col-md-11'>
                                        <input class='form-control' id='id_password' placeholder='password' name="password" type='text'>
                                    </div>
                                </div>
                                <div class='form-group internal'>
                                    <div class='col-md-11'>
                                        <input class='form-control' id='id_confirm_password' placeholder='Confirm Password' name="confirmPassword" type='text'>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class='form-group'>
                            <label class='control-label col-md-2 col-md-offset-2' for='id_gender'>Registration Event</label>
                            <div class='col-md-2'>
                                <select class='form-control' id='id_gender' name="gender">
                                    <option>Male</option>
                                    <option>Female</option>
                                </select>
                            </div>
                        </div>
                        <div class='form-group'>
                            <label class='control-label col-md-2 col-md-offset-2' for='id_mobile'>Mobile # </label>
                            <div class='col-md-6'>
                                <div class='form-group'>
                                    <div class='col-md-11'>
                                        <input class='form-control' id='id_mobile' placeholder='Phone: (xxx) - xxx xxxx' name="mobile" type='text'>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class='form-group'>
                            <label class='control-label col-md-2 col-md-offset-2' for='id_country'>Country </label>
                            <div class='col-md-2'>
                                <select class='form-control' id='id_country' name="country">
                                    <option>India</option>
                                    <option>United States</option>
                                    <option>England</option>
                                    <option>Other</option>
                                </select>
                            </div>
                        </div>
                        <div class='form-group'>
                            <label class='control-label col-md-2 col-md-offset-2' for='id_secuity_question'>Security Question</label>
                            <div class='col-md-2'>
                                <select class='form-control' id='id_sec_question' name="securityQuestion" style=" width:300px;">
                                    <option>      -- SELECT --     </option>
                                    <option>Who is your favourite cricketer</option>
                                    <option>Which cricketer do you resemble</option>
                                    <option>What is first name of your best friend</option>
                                </select>
                            </div>
                        </div>
                        <div class='form-group'>
                            <label class='control-label col-md-2 col-md-offset-2' for='id_security_answer'>Security Answer</label>
                            <div class='col-md-6'>
                                <div class='form-group'>
                                    <div class='col-md-11'>
                                        <input class='form-control' id='id_security_answer' placeholder='Security Question Answer' name="securityAnswer" type='text'>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class='form-group'>
                            <label class='control-label col-md-2 col-md-offset-2' for='id_secuirty_code'>Security Code</label>
                            <div class='col-md-6'>
                                <div class='form-group'>
                                    <div class='col-md-11'>
                                        <input class='form-control' id='id_security' placeholder='Admin Security Code' name="security" type='text'>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div class='form-group'>
                            <%--@declare id="id_terms"--%><label class='control-label col-md-2 col-md-offset-2' for='id_terms'>Terms & Conditions</label>
                            <div class='col-md-8'>
                                <div class='make-switch' data-off-label='NO' data-on-label='YES' id='id_agree' style='float:left'>
                                    <input id='id_agree_terms' type='checkbox' value='YES' name="terms">
                                </div>
                            </div>
                        </div>


                        <div class='form-group'>
                            <div class='col-md-offset-4 col-md-3'>
                                <button class='btn-lg btn-primary' type='submit' onclick="post('${registerUrl}')">Register</button>
                            </div>
                            <div class='col-md-3'>
                                <button class='btn-lg btn-danger' style='float:right' type='submit'><a href="/index" style="color:white;">Cancel</a></button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </header>

    <br /><br /><br /><br /><br />

    <footer>

        <div class="top">
            <ul class="page-width">
                <li>
                    <h4>About Us</h4>
                    <p>
                        A fun place for all of our friends to have a common platform to test our cricketing skils. Participate in every match day and predict the winning team and we award you points based on the winner.
                        If you are an expert in cricket analysis, come give it a try and see where you stand among others.The first placed winner will be awarded with a special prize.
                    </p>
                </li>

                <li>
                    <h4>QUERIES ?</h4>
                    <a href="tel:+1-617-378-1238" class="phone">+1-617-378-1238</a>
                    <a href="mailto:vamsi.singamaneni@gmail.com" class="mail">vamsi.singamaneni@gmail.com</a>
                </li>
            </ul>
        </div>


        <div class="bottom">
            <ul class="page-width">
                <li>
                    &copy; All rights Reserved @ Vamsi Krishna Singamaneni
                </li>
                <li>
                    <a href="#">Copyrights</a>
                    <a href="#">Terms of Use </a>
                    <a href="#">Privacy Policy</a>
                </li>
            </ul>
        </div>

    </footer>

    <script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/1.18.0/TweenMax.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/1.18.0/plugins/ScrollToPlugin.min.js"></script>
    <script src="resources/core/js/register.js"></script>

</div>
</body>

</html>
