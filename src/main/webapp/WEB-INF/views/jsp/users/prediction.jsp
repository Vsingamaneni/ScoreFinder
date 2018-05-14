<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%--
  Created by IntelliJ IDEA.
  User: v0s004a
  Date: 5/9/18
  Time: 9:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" >

<head>
    <meta charset="UTF-8">
    <title>Login Form</title>

    <!--Fav Icon:-->
    <link rel="shortcut icon" href="/resources/core/images/cricket.ico" />

    <!--CSS Styles:-->
    <spring:url value="/resources/core/css/home.css" var="homeCss" />
    <spring:url value="/resources/core/css/clock.css" var="clockCss" />
    <spring:url value="/resources/core/css/footer.css" var="footerCss" />
    <spring:url value="/resources/core/css/style.css" var="styleCss" />
    <link href="${homeCss}" rel="stylesheet" />
    <link href="${clockCss}" rel="stylesheet" />
    <link href="${footerCss}" rel="stylesheet" />
    <link href="${styleCss}" rel="stylesheet" />

    <link href='https://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css' rel='stylesheet' type='text/css'>
    <link href='//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/css/datepicker.min.css' rel='stylesheet' type='text/css'>
    <link href='//cdnjs.cloudflare.com/ajax/libs/bootstrap-switch/1.8/css/bootstrap-switch.css' rel='stylesheet' type='text/css'>
    <link href='https://davidstutz.github.io/bootstrap-multiselect/css/bootstrap-multiselect.css' rel='stylesheet' type='text/css'>
    <script src='//cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js' type='text/javascript'></script>
    <script src='//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.0/js/bootstrap.min.js' type='text/javascript'></script>
    <script src='//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/js/bootstrap-datepicker.min.js' type='text/javascript'></script>
    <script src='//cdnjs.cloudflare.com/ajax/libs/bootstrap-switch/1.8/js/bootstrap-switch.min.js' type='text/javascript'></script>
    <script src='https://davidstutz.github.io/bootstrap-multiselect/js/bootstrap-multiselect.js' type='text/javascript'></script>

    <spring:url value="loginUser" var="loginUrl" />
    <c:if test="${not empty session}">
        <c:set var="user_name" value="${session.firstName}"/>
        <c:set var="user_id" value="${session.memberId}" />
    </c:if>

</head>

<body>

<div style="width: 1250px; margin: 0 auto;">
    <header>

        <nav class="navbar navbar-inverse " style="background-color: #082a3e">
            <div class="container">
                <div class="navbar-header">
                    <a class="navbar-brand" href="${urlHome}" style="color:white;font-size:20px;text-decoration:none;font-family:Comic Sans MS">Indian Premier League</a>
                </div>
                <div id="navbar">
                    <ul class="nav navbar-nav navbar-right">
                        <li class="active"><a href="#" style="color:white;font-size:15px;text-decoration:none;font-family:Comic Sans MS">Welcome ${user_name}</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <header>

            <c:if test="${not empty session}">
                <jsp:include page="../fragments/nav_after_login.jsp"/>
            </c:if>

    <spring:url value="/match/${user_id}/add" var="predictionUrl" />
    <spring:url value="/showPredictions" var="cancelUrl" />

        <div style="width: 60%; margin: 0 auto;">

            <div class='container'>
                <div class='panel panel-primary dialog-panel'>
                    <div class='panel-heading' style="background-color: #082a3e;">
                        <h5 style="text-align: left;">Good Luck ${session.firstName} !!</h5>
                    </div>
                    <div class='panel-body'>
                        <form action="${predictionUrl}" modelAttribute="predictionForm" method="POST" class='form-horizontal' role='form'>
                            <div class='form-group'>
                                <label class='control-label col-md-2 col-md-offset-2' for='id_event'>Match</label>
                                <div class='col-md-2'>
                                    <select class='form-control' id='id_event' name="event">
                                        <option>${fn:toUpperCase(scheduleForm.homeTeam)} vs ${fn:toUpperCase(scheduleForm.awayTeam)}</option>
                                    </select>
                                </div>
                            </div>
                            <input type=hidden id="memberId" name="memberId" value="${user_id}">
                            <input type=hidden id="matchNumber" name="matchNumber" value="${scheduleForm.matchNumber}">
                            <input type=hidden id="homeTeam" name="homeTeam" value="${scheduleForm.homeTeam}">
                            <input type=hidden id="awayTeam" name="awayTeam" value="${scheduleForm.awayTeam}">
                            <div class='form-group'>
                                <label class='control-label col-md-2 col-md-offset-2' for='id_name'>Name</label>
                                <div class='col-md-2'>
                                    <select class='form-control' id='id_name' name="firstName">
                                        <option>${user_name}</option>
                                    </select>
                                </div>
                            </div>
                            <div class='form-group'>
                                <label class='control-label col-md-2 col-md-offset-2' for='id_selected'>Your Choice</label>
                                <div class='col-md-2'>
                                    <select class='form-control' id='id_gender' name="selected">
                                        <option>${fn:toUpperCase(scheduleForm.homeTeam)}</option>
                                        <option>${fn:toUpperCase(scheduleForm.awayTeam)}</option>
                                    </select>
                                </div>
                            </div>

                            <div class='form-group'>
                                <div class='col-md-offset-4 col-md-3'>
                                    <button class='btn-lg btn-primary' type='submit' onclick="post('${predictionUrl}')">Lock It!!</button>
                                </div>
                                <div class='col-md-3'>
                                    <button class='btn-lg btn-danger' style='float:right' type='submit' onclick="('${cancelUrl}')">Cancel</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

</div>

<jsp:include page="../fragments/footer.jsp" />

</body>
</html>