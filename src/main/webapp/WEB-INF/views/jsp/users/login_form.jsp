<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: v0s004a
  Date: 5/1/18
  Time: 11:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" >

<head>
    <meta charset="UTF-8">
    <title>Login Form</title>

    <!--Fav Icon:-->
    <link rel="shortcut icon" href="/resources/core/images/football.ico" />

    <!--CSS Styles:-->
    <spring:url value="/resources/core/css/home.css" var="homeCss" />
    <spring:url value="/resources/core/css/clock.css" var="clockCss" />
    <spring:url value="/resources/core/css/footer.css" var="footerCss" />
    <spring:url value="/resources/core/css/style.css" var="styleCss" />
    <link href="${homeCss}" rel="stylesheet" />
    <link href="${clockCss}" rel="stylesheet" />
    <link href="${footerCss}" rel="stylesheet" />
    <link href="${styleCss}" rel="stylesheet" />

    <spring:url value="loginUser" var="loginUrl" />

</head>

<body>

<div style="width: 1250px; margin: 0 auto;">

    <jsp:include page="../fragments/header.jsp" />

    <header>

        <jsp:include page="../fragments/nav_before_login.jsp" />

        <br />

        <c:if test="${not empty msg}">
            <div class="alert alert-${css} alert-dismissible" role="alert">
                <h2 style="color:red;font-size:15px;text-decoration:none;font-family:Comic Sans MS"><strong>${msg}</strong></h2>
            </div>
        </c:if>

        <c:if test="${not empty loginErrorDetails}">
            <h2 style="color:red;font-size:15px;text-decoration:none;font-family:Comic Sans MS"> Please fix the below errors..!!</h2>
        </c:if>
        <c:forEach var="loginErrorDetails" items="${loginErrorDetails}">
            <c:if test="${not empty loginErrorDetails.errorMessage}" >
                <h2 style="color:red;font-size:15px;text-decoration:none;font-family:Comic Sans MS"> *** ${loginErrorDetails.errorMessage} </h2>
            </c:if>
        </c:forEach>

        <br /><br /><br /><br /><br /><br /><br /><br />

        <div class="log-form">
            <h2 style="color:white;font-size:15px;text-decoration:none;font-family:Comic Sans MS">Login to your account</h2>
            <form action="/loginUser" modelAttribute="userLogin" method="POST">
                <input type="text" title="username" placeholder="username" name="email"/>
                <input type="password" title="username" placeholder="password" name="password"/>
                <button type="submit" class="btn" onclick="post('${loginUrl}')">Login</button>
                <a class="forgot" href="/forget">Forgot Username?</a>
            </form>
        </div><!--end log form -->
        <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>


    </header>

    <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />

    <jsp:include page="../fragments/nav_footer.jsp"/>

    <script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/1.18.0/TweenMax.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/1.18.0/plugins/ScrollToPlugin.min.js"></script>
    <script src="resources/core/js/web.js"></script>

</div>
</body>

</html>
