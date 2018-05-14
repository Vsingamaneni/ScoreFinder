<%--
  Created by IntelliJ IDEA.
  User: v0s004a
  Date: 5/12/18
  Time: 1:42 AM
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
    <link href='//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/css/datepicker.min.css' rel='stylesheet' type='text/css'>
    <link href='//cdnjs.cloudflare.com/ajax/libs/bootstrap-switch/1.8/css/bootstrap-switch.css' rel='stylesheet' type='text/css'>
    <link href='https://davidstutz.github.io/bootstrap-multiselect/css/bootstrap-multiselect.css' rel='stylesheet' type='text/css'>
    <script src='//cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js' type='text/javascript'></script>
    <script src='//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.0.0/js/bootstrap.min.js' type='text/javascript'></script>
    <script src='//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/js/bootstrap-datepicker.min.js' type='text/javascript'></script>
    <script src='//cdnjs.cloudflare.com/ajax/libs/bootstrap-switch/1.8/js/bootstrap-switch.min.js' type='text/javascript'></script>
    <script src='https://davidstutz.github.io/bootstrap-multiselect/js/bootstrap-multiselect.js' type='text/javascript'></script>

    <spring:url value="/showPredictions" var="showPredictionUrl" />
    <c:if test="${not empty session}">
        <c:set var="user_name" value="${session.firstName}"/>
    </c:if>

    <spring:url value="/showPredictions" var="homeUrl" />

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

    <spring:url value="/resources/core/js/hello.js" var="coreJs" />
    <spring:url value="/resources/core/js/bootstrap.min.js"
                var="bootstrapJs" />

    <script src="${coreJs}"></script>
    <script src="${bootstrapJs}"></script>

    <c:if test="${not empty session}">
        <c:set var="user_name" value="${session.firstName}"/>
        <c:set var="user_id" value="${session.memberId}" />
    </c:if>

    <spring:url value="/match/${user_id}/${predictionForm.predictionId}/save" var="updateUrl" />

</head>
<body>
<div style="width: 1250px; margin: 0 auto;">

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

        <br />
        <h1>${fn:toUpperCase(session.firstName)} , Your prediction details</h1>
    </header>
        <br />

    <div style="width: 60%; margin: 0 auto;">

        <div class='container'>
            <div class='panel panel-primary dialog-panel'>
                <div class='panel-heading' style="background-color: #082a3e;">
                    <h5 style="text-align: left;">Good Luck ${session.firstName} !!</h5>
                </div>
                <div class='panel-body'>
                    <form action="${updateUrl}" modelAttribute="predictionForm" method="POST" class='form-horizontal' role='form'>
                        <input type=hidden id="predictionId" name="predictionId" value="${predictionForm.predictionId}">
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
                                <button class='btn-lg btn-primary' type='submit' onclick="post('${updateUrl}')">Update</button>
                            </div>
                            <div class='col-md-3'>
                                <button class='btn-lg btn-danger' style='float:right' type='submit' onclick="post('${homeUrl}')">Cancel</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>


        <br /><br /><br /><br />

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
