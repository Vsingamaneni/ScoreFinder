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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <title>Score Finder</title>
    <meta name="description" content="score finder" />
    <meta charset="utf-8">
    <!--Fav Icon:-->
    <link rel="shortcut icon" href="/resources/core/images/football.ico" />

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
                            <td><img src="/resources/core/images/teams/${schedule.homeTeam}.jpg" alt="Home Team Image Missing" style="width:150px;height:150px;border-radius: 50%;"></td>
                            <td><img style=" display: block; margin-left: auto; margin-right: auto; width: 50px;" src="${vs}" alt="Vs Missing" style="width:30px;height:30px;"></td>
                            <td><img src="/resources/core/images/teams/${schedule.awayTeam}.jpg" alt="Away Team Image Missing" style="width:150px;height:150px;border-radius: 50%;"></td>
                        </tr>
                        <tr>
                            <td style="color:#082a3e;font-size:20px;text-decoration:none;font-family:Comic Sans MS;text-align: center;">${fn:toUpperCase(schedule.homeTeam)}</td>
                            <td style="color:#082a3e;font-size:20px;text-decoration:none;font-family:Comic Sans MS;text-align: center;">vs</td>
                            <td style="color:#082a3e;font-size:20px;text-decoration:none;font-family:Comic Sans MS;text-align: center;">${fn:toUpperCase(schedule.awayTeam)}</td>
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
                            var now = new Date();
                            initializeClock('clockdiv${schedule.lineNumber}', new Date(Date.parse("${schedule.utcFormatDate}")).toUTCString());
                            function getTimeRemaining(endtime) {
                                var t = Date.parse(endtime) - Date.parse(new Date(now.getTime() + now.getTimezoneOffset() * 60000));
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
                <p style="color:white;font-size:15px;text-decoration:none;font-family:Comic Sans MS;"> FIFA world cup tournament 2018 is about to commence.
                    Registrations are open now and will be closed soon.</p>
            </li>
        </ul>

        <jsp:include page="../fragments/nav_footer.jsp"/>

        <script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/1.18.0/TweenMax.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/1.18.0/plugins/ScrollToPlugin.min.js"></script>
        <script src="/resources/js/web.js"></script>

    </div>
    </div>
    </body>

</html>
