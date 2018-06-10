<%--
  Created by IntelliJ IDEA.
  User: v0s004a
  Date: 5/15/18
  Time: 9:30 PM
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

        <div style="width: 1000px; margin: 0 auto;">
            <h1>Active Users</h1>

            <table class="table table-striped">
                <thead>
                <tr>
                    <th>Member #</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Is Active</th>
                    <th>Action</th>
                </tr>
                </thead>

                <c:forEach var="register" items="${registerList}">
                    <c:if test="${register.isActive.equalsIgnoreCase('Y')}">
                    <tr style="color:black;font-size:20px;text-decoration:none;font-family:Comic Sans MS">
                        <td style="text-align:left;"> ${register.memberId}</td>
                        <td style="text-align:left;">${register.fName}</td>
                        <td style="text-align:left;">${register.lName}</td>
                        <td style="text-align:left;">${register.isActive}</td>
                        <td style="text-align:left;">
                                <spring:url value="/member/${register.memberId}/authorize" var="userUrl" />
                    </tr>
                    </c:if>
                </c:forEach>
            </table>


            <br /><br /><br /><br /><br />

            <h1>Inactive/ Opted out Users</h1>

            <table class="table table-striped">
                <thead>
                <tr>
                    <th>Member #</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Is Active</th>
                    <th>Action</th>
                </tr>
                </thead>

                <c:forEach var="register" items="${registerList}">
                    <c:if test="${register.isActive.equalsIgnoreCase('N')}">
                    <tr style="color:black;font-size:20px;text-decoration:none;font-family:Comic Sans MS">
                        <td style="text-align:left;"> ${register.memberId}</td>
                        <td style="text-align:left;">${register.fName}</td>
                        <td style="text-align:left;">${register.lName}</td>
                        <td style="text-align:left;">${register.isActive}</td>
                        <td style="text-align:left;">
                            <spring:url value="/member/${register.memberId}/authorize" var="userUrl" />
                            <button class="btn btn-info" onclick="location.href='${userUrl}'">Authorize</button>
                    </tr>
                    </c:if>
                </c:forEach>
            </table>

        </div>

    </header>

    <br /><br /><br /><br /><br /><br />

    <jsp:include page="../fragments/nav_footer.jsp"/>

</div>
</body>
</html>