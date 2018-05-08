<%--
  Created by IntelliJ IDEA.
  User: v0s004a
  Date: 5/1/18
  Time: 11:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page session="false"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">

<jsp:include page="../fragments/header.jsp" />
<spring:url value="registerUser" var="registerUrl" />

<c:if test="${not empty msg}">
    <div class="alert alert-${css} alert-dismissible" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
        <strong>${msg}</strong>
    </div>
</c:if>


<div class="container">

    <form action="/registerUser" modelAttribute="registerForm" method="POST">

        Please enter your firstName
        <input type="text" name="fName"/>
        <br />

        Please enter your lastName
        <input type="text" name="lName"/>
        <br />

        Please enter your email
        <input type="text" name="email"/>
        <br />


        Please enter your password
        <input type="text" name="password"/>
        <br />


        Please enter your confirm password
        <input type="text" name="confirmPassword"/>
        <br />


        Please enter your sex
        <input type="text" name="sex"/>
        <br />


        Please enter your mobileNumber
        <input type="text" name="mobileNumber"/>
        <br />

        Please enter your country
        <input type="text" name="country"/>
        <br />


        Please enter your securityKey
        <input type="text" name="securityKey"/>
        <br />


        <button class="btn btn-danger" onclick="post('${registerUrl}')">login</button>
    </form>

</div>

<jsp:include page="../fragments/footer.jsp" />

</body>
</html>
