<%--
  Created by IntelliJ IDEA.
  User: v0s004a
  Date: 5/13/18
  Time: 10:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" >

<head>
    <meta charset="UTF-8">
    <title>Forget Password</title>

    <!--Fav Icon:-->
    <link rel="shortcut icon" href="/resources/core/images/football.ico" />

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
    <link href='https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/css/datepicker.min.css' rel='stylesheet' type='text/css'>
    <link href='https://cdnjs.cloudflare.com/ajax/libs/bootstrap-switch/1.8/css/bootstrap-switch.css' rel='stylesheet' type='text/css'>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js' type='text/javascript'></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.0/js/bootstrap.min.js' type='text/javascript'></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/js/bootstrap-datepicker.min.js' type='text/javascript'></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/bootstrap-switch/1.8/js/bootstrap-switch.min.js' type='text/javascript'></script>

    <spring:url value="/resetPassword" var="resetPasswordUrl" />

</head>

<body>

<div style="width: 1250px; margin: 0 auto;">

    <jsp:include page="../fragments/header.jsp" />

    <header>

        <jsp:include page="../fragments/nav_before_login.jsp" />

        <br /><br />

        <c:if test="${not empty errorDetailsList}">
            <h2 style="color:red;font-size:15px;text-decoration:none;font-family:Comic Sans MS"> Please fix the below errors..!!</h2>
        </c:if>
        <c:forEach var="errorDetails" items="${errorDetailsList}">
            <c:if test="${not empty errorDetails.errorMessage}" >
                <h2 style="color:red;font-size:15px;text-decoration:none;font-family:Comic Sans MS"> *** ${errorDetails.errorMessage} </h2>
            </c:if>
        </c:forEach>

        <br /><br />

        <div class='container' style="width: 1000px;">
            <div class='panel panel-primary dialog-panel'>
                <div class='panel-heading' style="background-color: #082a3e;">
                    <h5 style="text-align: left;">Forgot Your Password ? Fill in the email details to get you in Again.</h5>
                </div>
                <div class='panel-body'>
                    <form action="${resetPasswordUrl}" modelAttribute="registerForm" method="POST" class='form-horizontal' role='form'>
                        <br />
                        <div class='form-group'>
                            <label class='control-label col-md-2 col-md-offset-2' for='id_email'>Email ID</label>
                            <div class='col-md-6'>
                                <div class='form-group'>
                                    <div class='col-md-11'>
                                        <input class='form-control' id='id_email' placeholder='E-mail' name="emailId" type='text'>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class='form-group'>
                            <label class='control-label col-md-2 col-md-offset-2' for='id_email'>Confirm Email ID</label>
                            <div class='col-md-6'>
                                <div class='form-group'>
                                    <div class='col-md-11'>
                                        <input class='form-control' id='id_confirm_email' placeholder='Confirm E-mail' name="confirmEmailId" type='text'>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class='form-group'>
                            <div class='col-md-offset-4 col-md-3'>
                                <button class='btn-lg btn-primary' type='submit' onclick="post('${resetPasswordUrl}')">Reset Password</button>
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

    <jsp:include page="../fragments/nav_footer.jsp"/>

    <script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/1.18.0/TweenMax.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/1.18.0/plugins/ScrollToPlugin.min.js"></script>
    <script src="resources/core/js/register.js"></script>

</div>
</body>

</html>
