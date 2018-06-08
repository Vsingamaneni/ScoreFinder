<%--
  Created by IntelliJ IDEA.
  User: v0s004a
  Date: 5/7/18
  Time: 1:32 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page session="false" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
       <c:set var="role" value="${session.role}"/>
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

        <c:if test="${role.equalsIgnoreCase('admin')}">
            <jsp:include page="../fragments/nav_admin.jsp"/>
        </c:if>
        <c:if test="${role.equalsIgnoreCase('member')}">
            <jsp:include page="../fragments/nav_after_login.jsp"/>
        </c:if>

        <br />

        <c:if test="${not empty msg}">
            <div class="alert alert-${css} alert-dismissible" role="alert">
                <strong>${msg}</strong>
            </div>
        </c:if>

        <div style="width: 1000px; margin: 0 auto;">
        <h1>My Predictions</h1>

        <table class="table table-striped">
            <thead>
            <tr>
                <th>#Game</th>
                <th>Fixture</th>
                <th>My Prediction</th>
                <th>Predicted Time</th>
                <th>Action</th>
            </tr>
            </thead>

            <c:forEach var="predictions" items="${predictions}">
                <tr style="color:black;font-size:20px;text-decoration:none;font-family:Comic Sans MS">
                    <td style="text-align:left;"> ${predictions.matchNumber}</td>
                    <td style="text-align:left;">${predictions.homeTeam} vs ${predictions.awayTeam}</td>
                    <td style="text-align:left;">${predictions.selected}</td>
                    <td style="text-align:left;">${predictions.predictedTime}</td>
                    <td style="text-align:left;">
                        <spring:url value="/prediction/${predictions.predictionId}/${predictions.matchNumber}/view" var="userUrl" />
                        <spring:url value="/prediction/${predictions.predictionId}/${predictions.matchNumber}/update" var="updateUrl" />
                        <spring:url value="/prediction/${predictions.predictionId}/delete" var="deleteUrl" />

                        <button class="btn btn-info" onclick="location.href='${userUrl}'">View</button>
                        <c:if test="${predictions.canPredict}">
                            <button class="btn btn-primary" onclick="location.href='${updateUrl}'">Update</button>
                            <button class="btn btn-danger" onclick="location.href=('${deleteUrl}')">Delete</button></td>
                        </c:if>
                </tr>
            </c:forEach>
        </table>


        <br /><br /><br /><br /><br />

        <h1>Upcoming Matches</h1>

        <table class="table table-striped">
            <thead>
            <tr>
                <th>#Game</th>
                <th>Deadline</th>
                <th>Fixture</th>
                <th>Action</th>
            </tr>
            </thead>

            <c:forEach var="schedule" items="${schedules}">
                <tr style="color:black;font-size:20px;text-decoration:none;font-family:Comic Sans MS">
                    <td style="text-align:left;">${schedule.matchNumber}</td>
                    <td style="text-align:left;">${schedule.startDate}</td>
                    <td style="text-align:left;">${schedule.homeTeam} vs ${schedule.awayTeam}</td>
                    <td style="text-align:left;">
                        <spring:url value="/match/${session.memberId}/${schedule.matchNumber}/predict" var="predictUrl" />
                        <c:if test="${schedule.canPredict}">
                            <button class="btn btn-primary" onclick="location.href='${predictUrl}'">Predict</button>
                        </c:if>
                         <c:if test="${!schedule.canPredict}">
                            <button class="btn btn-danger" onclick="location.href='#'">You Missed it</button>
                         </c:if>

                </tr>
            </c:forEach>
        </table>

        </div>

    </header>

        <br /><br /><br /><br /><br /><br />

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

</div>
</body>
</html>