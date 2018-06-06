<%--
  Created by IntelliJ IDEA.
  User: v0s004a
  Date: 4/30/18
  Time: 12:03 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.sports.cricket.model.Schedule" %>
<%@ page import="java.util.List" %>
<%@ page session="false"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
    <title>Score predictor</title>
    <meta name="description" content="score finder" />
    <meta charset="utf-8">
    <!--Fav Icon:-->
    <link rel="shortcut icon" href="/resources/core/images/cricket.ico" />

    <!--CSS Styles:-->
    <spring:url value="/resources/core/css/home.css" var="homeCss" />
    <spring:url value="/resources/core/css/clock.css" var="clockCss" />
    <spring:url value="/resources/core/css/footer.css" var="footerCss" />
    <spring:url value="/resources/core/css/login.css" var="loginCss" />
    <spring:url value="/resources/core/js/timer/flipclock.css" var="flipClockcss" />
    <link href="${homeCss}" rel="stylesheet" />
    <link href="${clockCss}" rel="stylesheet" />
    <link href="${footerCss}" rel="stylesheet" />
    <link href="${loginCss}" rel="stylesheet" />

    <!-- Urls -->
    <spring:url value="/" var="homeUrl" />

    <!-- Images -->
   <spring:url value="/resources/core/images/teams/vs.jpg" var="vs" />

    <!-- js -->
    <spring:url value="/resources/core/js/index.js" var="timerJs" />
    <script src="${timerJs}"></script>


    <c:if test="${not empty user}">
        <c:set var="user_name" value="${user.firstName}"/>
        <c:set var="role" value="${user.role}"/>
    </c:if>

    <body>
    <div style="width: 1250px; margin: 0 auto;">
        <header>
            <div id="head-top">
                <ul class="page-width">
                    <li class="logo">
                        <a href="${userUrl}" style="color:white;font-size:20px;text-decoration:none;font-family:Comic Sans MS">Score Finder</a>
                    </li>
                    <c:if test="${not empty user_name}">
                        <li class="right">
                            <a href="#" style="color:white;font-size:20px;text-decoration:none;font-family:Comic Sans MS">Welcome ${user_name}</a>
                        </li>
                    </c:if>
                    <c:if test="${empty user_name}">
                    <li class="right">
                        <a style="text-decoration:none;">
                            <marquee onmouseover="stop();" onmouseout="start();" scrollAmount="20" scrollDelay="300" direction="side" width="100%"  style="margin-top: 0px">
                                <a href="/" class="new1" style="color:white;font-size:19px;text-decoration:none;font-family:Comic Sans MS">	Matches are live today. &nbsp;&nbsp;&nbsp;  Sign on to find your score.</a></marquee>
                        </a>
                    </li>
                    </c:if>
                </ul>
            </div>

            <c:if test="${empty user_name}">
                <jsp:include page="../fragments/nav_before_login.jsp"/>
            </c:if>

            <c:if test="${not empty user_name && role.equals('member')}">
                <jsp:include page="../fragments/nav_after_login.jsp"/>
            </c:if>

            <c:if test="${not empty user_name && role.equals('admin')}">
                <jsp:include page="../fragments/nav_admin.jsp"/>
            </c:if>

        </header>

        <c:choose>
            <c:when test="${empty schedules}">
                I see!  There are no schedules
            </c:when>
            <c:otherwise>
                <c:forEach var="schedule" items="${schedules}">
                    <var count =0></var>
                    <table style=" margin: 0px auto;">
                        <tr>
                            <td><img src="/resources/core/images/teams/${schedule.homeTeam}.jpg" alt="Home Team Image Missing" style="width:250px;height:250px;"></td>
                            <td><img style=" display: block; margin-left: auto; margin-right: auto; width: 50px;" src="${vs}" alt="Vs Missing" style="width:50px;height:50px;"></td>
                            <td><img src="/resources/core/images/teams/${schedule.awayTeam}.jpg" alt="Away Team Image Missing" style="width:250px;height:250px;"></td>
                        </tr>
                    </table>

                    <ul id="x3-boxes" >
                        <li class="bg-1"></li>
                        <li>

                            <h4>COUNTDOWN CLOCK	</h4>
                            <hr>
                            <div id="clockdiv${schedule.lineNumber}">

                                <div>
                                    <span class="days"></span>
                                    <div class="smalltext">Days</div>
                                </div>
                                <div>
                                    <span class="hours"></span>
                                    <div class="smalltext">Hours</div>
                                </div>
                                <div>
                                    <span class="minutes"></span>
                                    <div class="smalltext">Minutes</div>
                                </div>
                                <div>
                                    <span class="seconds"></span>
                                    <div class="smalltext">Seconds</div>
                                </div>
                            </div>

                        </li>
                        <script type="text/javascript">
                            initializeClock('clockdiv${schedule.lineNumber}', new Date(Date.parse("${schedule.startDate}")));
                            function getTimeRemaining(endtime) {
                                var t = Date.parse(endtime) - Date.parse(new Date());
                                var seconds = Math.floor((t / 1000) % 60);
                                var minutes = Math.floor((t / 1000 / 60) % 60);
                                var hours = Math.floor((t / (1000 * 60 * 60)) % 24);
                                var days = Math.floor(t / (1000 * 60 * 60 * 24));
                                return {
                                    'total': t,
                                    'days': days,
                                    'hours': hours,
                                    'minutes': minutes,
                                    'seconds': seconds
                                };
                            }

                            function initializeClock(id, endtime) {
                                var clock = document.getElementById(id);
                                var daysSpan = clock.querySelector('.days');
                                var hoursSpan = clock.querySelector('.hours');
                                var minutesSpan = clock.querySelector('.minutes');
                                var secondsSpan = clock.querySelector('.seconds');

                                function updateClock() {
                                    var t = getTimeRemaining(endtime);

                                    daysSpan.innerHTML = t.days;
                                    hoursSpan.innerHTML = ('0' + t.hours).slice(-2);
                                    minutesSpan.innerHTML = ('0' + t.minutes).slice(-2);
                                    secondsSpan.innerHTML = ('0' + t.seconds).slice(-2);

                                    if (t.total <= 0) {
                                        clearInterval(timeinterval);
                                    }
                                }

                                updateClock();
                                var timeinterval = setInterval(updateClock, 1000);
                            }

                        </script>

                    </ul>

                </c:forEach>
            </c:otherwise>
        </c:choose>


        <div id="ch-list">

            <h2>up comming Events</h2>
            <hr>

        </div>

        <ul id="logos" class="page-width">
            <li>
                <p align="center"> Fifa world cup tournament 2018 is about to commence.
                    Registrations are open now and will be closed on 10-June 2018.</p>
            </li>
        </ul>


        <footer>

            <div class="top">
                <ul class="page-width">
                    <li>
                        <h4>About Us</h4>
                        <p>
                            A fun place for all of our friends to have a common platform to test our predicting skils. Participate in every match day and predict the winning team and we award you points based on the winner.
                            If you are an expert in soccer analysis, come give it a try and see where you stand among others.The first placed winner will be awarded with a special prize.
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
        <script src="resources/js/web.js"></script>

    </div>
    </div>
    </body>

</html>
