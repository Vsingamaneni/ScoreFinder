<%--
  Created by IntelliJ IDEA.
  User: v0s004a
  Date: 4/30/18
  Time: 11:14 PM
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
<spring:url value="loginUser" var="loginUrl" />

<div class="container">

        <form action="/loginUser" modelAttribute="loginForm" method="POST">

            Please enter your username
            <input type="text" name="name"/>
            <br />


            Please enter your password
            <input type="text" name="password"/>
            <br />

            <button class="btn btn-danger" onclick="post('${loginUrl}')">login</button>

        </form>

</div>

<jsp:include page="../fragments/footer.jsp" />

</body>
</html>
