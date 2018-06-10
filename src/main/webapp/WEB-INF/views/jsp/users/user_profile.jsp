<%--
  Created by IntelliJ IDEA.
  User: v0s004a
  Date: 5/27/18
  Time: 9:31 AM
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
        <c:set var="role" value="${session.role}"/>
        <c:set var="action_out" value="disable"/>
        <c:set var="action_in" value="enable"/>
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

        <c:if test="${fn:containsIgnoreCase(userLogin.isAdminActivated, 'N')}">
                <div class="alert alert-${css} alert-dismissible" role="alert">
                    <h2 style="color:darkslateblue;font-size:15px;text-decoration:none;font-family:Comic Sans MS"><strong>Contact the admin to activate your account..!!</strong></h2>
                </div>
        </c:if>

        <c:if test="${fn:containsIgnoreCase(userLogin.isAdminActivated, 'Y')}">
        <c:if test="${not empty msg}">
            <div class="alert alert-${css} alert-dismissible" role="alert">
                <h2 style="color:darkslateblue;font-size:15px;text-decoration:none;font-family:Comic Sans MS"><strong>${msg}</strong></h2>
            </div>
        </c:if>
        </c:if>

        <div style="width: 1000px; margin: 0 auto;">
            <h1>Hello ${user_name}, Here is your profile .. !</h1>
            <br />

            <table class="table table-striped">
                <thead>
                <tr>
                    <th>Member #</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email Id</th>
                    <th>Role</th>
                    <th>Action</th>
                </tr>
                </thead>

                    <c:if test="${not empty userLogin}">
                        <tr style="color:black;font-size:20px;text-decoration:none;font-family:Comic Sans MS">
                            <td style="text-align:left;"> ${userLogin.memberId}</td>
                            <td style="text-align:left;">${userLogin.firstName}</td>
                            <td style="text-align:left;">${userLogin.lastName}</td>
                            <td style="text-align:left;">${userLogin.email}</td>
                            <td style="text-align:left;">${userLogin.role}</td>
                            <td style="text-align:left;">
                            <c:if test="${fn:containsIgnoreCase(userLogin.isAdminActivated, 'Y')}">
                               <spring:url value="/member/${userLogin.memberId}/optOut/${action_out}" var="optOutUrl" />
                               <spring:url value="/member/${userLogin.memberId}/optOut/${action_in}" var="optInUrl" />
                               <c:if test="${fn:containsIgnoreCase(userLogin.isActive, 'Y')}">
                                   <c:if test="${userLogin.limitReached}">
                                       <button class="btn btn-info">Active</button>
                                       <button class="btn btn-danger" onclick="location.href='${optOutUrl}'">Opt Out</button>
                                   </c:if>
                                   <c:if test="${!userLogin.limitReached}">
                                       <button class="btn btn-info">Active</button>
                                   </c:if>
                               </c:if>
                               <c:if test="${fn:containsIgnoreCase(userLogin.isActive, 'N')}">
                                   <button class="btn btn-danger"> In Active</button>
                                   <button class="btn btn-info" onclick="location.href='${optInUrl}'">Activate</button>
                               </c:if>
                            </c:if>
                        </tr>
                    </c:if>
            </table>


            <br /><br /><br /><br /><br />

        </div>

    </header>

    <jsp:include page="../fragments/nav_footer.jsp"/>

</div>
</body>
</html>
