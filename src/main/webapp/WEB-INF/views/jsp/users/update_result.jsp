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
            <jsp:include page="../fragments/nav_admin.jsp"/>
        </c:if>

        <br />

        <c:if test="${not empty msg}">
            <div class="alert alert-${css} alert-dismissible" role="alert">
                <strong>${msg}</strong>
            </div>
        </c:if>

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
                        <input type=hidden id="matchDay" name="matchDay" value="${schedule.matchDay}">
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


          <%--  <c:forEach var="schedule" items="${schedules}">
            <div class='container' style="width: 1000px;">
                <div class='panel panel-primary dialog-panel'>
                    <div class='panel-heading' style="background-color: #082a3e;">
                        <h5 style="text-align: left;">Hello ${userDetails.fName}, Answer your security question.! </h5>
                    </div>
                    <div class='panel-body'>
                        <form action="/updatePassword" modelAttribute="registerForm" method="POST" class='form-horizontal' role='form'>
                            <br />
                            <input type=hidden id="emailId" name="emailId" value="${userDetails.emailId}">
                            <div class='form-group'>
                                <label class='control-label col-md-2 col-md-offset-2' for='id_secuity_question'>Security Question</label>
                                <div class='col-md-2'>
                                    <select class='form-control' id='id_sec_question' name="securityQuestion" style=" width:300px;">
                                        <option>      -- SELECT --     </option>
                                        <option>${userDetails.securityQuestion}</option>
                                    </select>
                                </div>
                            </div>
                            <div class='form-group'>
                                <label class='control-label col-md-2 col-md-offset-2' for='id_email'>Security Answer</label>
                                <div class='col-md-6'>
                                    <div class='form-group'>
                                        <div class='col-md-11'>
                                            <input class='form-control' id='id_security_answer' placeholder='Security Question Answer' name="securityAnswer" type='text'>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class='form-group'>
                                <label class='control-label col-md-2 col-md-offset-2' for='id_password'>Password</label>
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
                                <div class='col-md-offset-4 col-md-3'>
                                    <button class='btn-lg btn-primary' type='submit' onclick="post('${resetPasswordUrl}')">Update Password</button>
                                </div>
                                <div class='col-md-3'>
                                    <button class='btn-lg btn-danger' style='float:right' type='submit'><a href="/" style="color:white;">Cancel</a></button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
                <br /><br />
            </c:forEach>--%>

            <br /><br />


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