<%--
  Created by IntelliJ IDEA.
  User: v0s004a
  Date: 5/22/18
  Time: 3:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page session="false" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="shortcut icon" href="/resources/core/images/cricket.ico" />

    <!--CSS Styles:-->
    <spring:url value="/resources/core/css/home.css" var="homeCss" />
    <spring:url value="/resources/core/css/clock.css" var="clockCss" />
    <spring:url value="/resources/core/css/footer.css" var="footerCss" />
    <spring:url value="/resources/core/css/login.css" var="loginCss" />
    <link href="${homeCss}" rel="stylesheet" />
    <link href="${clockCss}" rel="stylesheet" />
    <link href="${footerCss}" rel="stylesheet" />
    <link href="${loginCss}" rel="stylesheet" />

    <spring:url value="/resources/core/css/hello.css" var="coreCss" />
    <spring:url value="/resources/core/css/bootstrap.min.css" var="bootstrapCss" />
    <link href="${bootstrapCss}" rel="stylesheet" />
    <link href="${coreCss}" rel="stylesheet" />

    <spring:url value="/" var="urlHome" />
    <spring:url value="/users/add" var="urlAddUser" />

    <c:if test="${not empty session}">
        <c:set var="user_name" value="${session.firstName}"/>
    </c:if>

    <spring:url value="/logout" var="logoutUrl" />

</head>
<body>
<div style="width: 1250px; margin: 0 auto;">

    <nav class="navbar navbar-inverse " style="background-color: #082a3e">
        <div class="container">
            <div class="navbar-header">
                <a class="navbar-brand" href="${urlHome}" style="color:white;font-size:20px;text-decoration:none;font-family:Comic Sans MS">Score Finder</a>
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
            <jsp:include page="../fragments/nav_admin.jsp"/>
        </c:if>

        <br />

        <c:if test="${not empty msg}">
            <div class="alert alert-${css} alert-dismissible" role="alert">
                <strong>${msg}</strong>
            </div>
        </c:if>

        <c:if test="${fn:length(errorDetailsList) > 0}">
            <h2 style="color:red;font-size:15px;text-decoration:none;font-family:Comic Sans MS"> Please fix the below errors..!!</h2>
        </c:if>
        <c:forEach var="errorDetail" items="${errorDetailsList}">
            <c:if test="${not empty errorDetail.errorField}" >
                <h2 style="color:red;font-size:15px;text-decoration:none;font-family:Comic Sans MS"> *** ${errorDetail.errorMessage} </h2>
            </c:if>
        </c:forEach>

        <div style="width: 1000px; margin: 0 auto;">
            <h1>Update Match Result</h1>

            <c:forEach var="schedule" items="${schedules}">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>Match#</th>
                        <th>Fixture</th>
                        <th>Winner</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tr style="color:black;font-size:20px;text-decoration:none;font-family:Comic Sans MS">
                        <form action="/matchResult/update/" modelAttribute="schedule" method="POST" class='form-horizontal' role='form'>
                        <td style="text-align:left;"> ${schedule.matchNumber}</td>
                        <td style="text-align:left;">${fn:toUpperCase(schedule.homeTeam)} vs ${fn:toUpperCase(schedule.awayTeam)}</td>
                        <input type=hidden id="matchNumber" name="matchNumber" value="${schedule.matchNumber}">
                        <input type=hidden id="homeTeam" name="homeTeam" value="${schedule.homeTeam}">
                        <input type=hidden id="awayTeam" name="awayTeam" value="${schedule.awayTeam}">
                        <input type=hidden id="matchDay" name="matchDay" value="${schedule.matchDay}">
                        <input type=hidden id="matchFee" name="matchFee" value="${schedule.matchFee}">
                        <input type=hidden id="startDate" name="startDate" value="${schedule.startDate}">
                        <td style="text-align:left;">
                            <select class='form-control' id='id_winner' name="winner" style=" width:100px;">
                                <option>--SELECT--</option>
                                <option>${fn:toUpperCase(schedule.homeTeam)}</option>
                                <option>${fn:toUpperCase(schedule.awayTeam)}</option>
                                <option>DRAW</option>
                            </select>
                        </td>
                        <td style="text-align:left;">
                            <button type="submit" class="btn-lg btn-primary"><a style="color:white;font-size:15px;text-decoration:none;font-family:Comic Sans MS">Update</a></button>
                        </td>
                        </form>
                    </tr>
                </table>
                <br /><br />
            </c:forEach>

            <br /><br />


        </div>

    </header>

    <br /><br /><br />

    <jsp:include page="../fragments/nav_footer.jsp"/>

</div>
</body>
</html>