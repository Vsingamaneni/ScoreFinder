<%--
  Created by IntelliJ IDEA.
  User: v0s004a
  Date: 5/10/18
  Time: 10:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page session="false"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">
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
    <link href='https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/css/datepicker.min.css' rel='stylesheet' type='text/css'>
    <link href='https://cdnjs.cloudflare.com/ajax/libs/bootstrap-switch/1.8/css/bootstrap-switch.css' rel='stylesheet' type='text/css'>>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js' type='text/javascript'></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.0/js/bootstrap.min.js' type='text/javascript'></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/js/bootstrap-datepicker.min.js' type='text/javascript'></script>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/bootstrap-switch/1.8/js/bootstrap-switch.min.js' type='text/javascript'></script>

    <spring:url value="/showPredictions" var="showPredictionUrl" />
    <c:if test="${not empty session}">
        <c:set var="user_name" value="${session.firstName}"/>
    </c:if>

    <script
            src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

    <spring:url value="/resources/core/js/hello.js" var="coreJs" />
    <spring:url value="/resources/core/js/bootstrap.min.js"
                var="bootstrapJs" />

    <script src="${coreJs}"></script>
    <script src="${bootstrapJs}"></script>

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
            <jsp:include page="../fragments/nav_after_login.jsp"/>
        </c:if>
    </header>

    <br /><br />

    <c:if test="${not empty msg}">
        <div class="alert alert-${css} alert-dismissible" role="alert">
            <strong>${msg}</strong>
        </div>
    </c:if>

    <h1>${fn:toUpperCase(prediction.firstName)} , Your prediction details</h1>
    <br />

        <div style="text-align:center;">
            <table style="margin: auto;" >
                <tr>
                    <td><b>Match #</b></td>
                    <td><b>${fn:toUpperCase(prediction.matchNumber)}</b></td>
                </tr>
                <tr>
                    <td><b>Match</b></td>
                    <td><b>${fn:toUpperCase(prediction.homeTeam)} vs ${fn:toUpperCase(prediction.awayTeam)}</b></td>
                </tr>
                <tr>
                    <td><b>Choice</b></td>
                    <td><b>${fn:toUpperCase(prediction.selected)}</b></td>
                </tr>
                <tr>
                    <td><b>Time</b></td>
                    <td><b>${fn:toUpperCase(prediction.predictedTime)}</b></td>
                </tr>
            </table>

        <br /><br /><br />
    <div class='form-group'>
        <div class='col-md-offset-4 col-md-3'>
            <button class='btn-lg btn-primary' type='submit' onclick="post('${showPredictionUrl}')">Go Back</button>
        </div>
    </div>
    </div>


<br /><br /><br /><br />

    <jsp:include page="../fragments/nav_footer.jsp"/>
</div>
</body>
</html>
