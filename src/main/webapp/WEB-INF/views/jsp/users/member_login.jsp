<%--
  Created by IntelliJ IDEA.
  User: v0s004a
  Date: 5/7/18
  Time: 1:32 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page session="false"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<body>
<div style="width: 1250px; margin: 0 auto;">
<jsp:include page="../fragments/header.jsp" />

    <jsp:include page="../fragments/navigation.jsp" />

<div class="container">

    <c:if test="${not empty msg}">
        <div class="alert alert-${css} alert-dismissible" role="alert">
            <strong>${msg}</strong>
        </div>
    </c:if>

    <h1>Session Details</h1>
    <br />

    <c:if test="${not empty session}">
        <div class="alert alert-${css} alert-dismissible" role="alert">
            <strong>${session.firstName}  logged in</strong>
            <strong>${session.firstName}  logged in</strong>
        </div>
    </c:if>


</div>

<jsp:include page="../fragments/footer.jsp" />
</div>
</body>
</html>