<%--
  Created by IntelliJ IDEA.
  User: v0s004a
  Date: 5/7/18
  Time: 11:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page session="false"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<nav style="font-weight:bold; margin: 30px auto;">

    <ul class="navigation">
        <li><a href="/" class="active">Home</a></li>
        <li><a href="/profile">My Account</a>
            <ul>
                <li><a href="/profile">Profile</a></li>
                <li><a href="/showPredictions">Predictions</a></li>
                <li><a href="/currentPredictions">MatchDay Predictions</a></li>
                <li><a href="/standings">Standings</a></li>
                <li><a href="/history">History</a></li>
                <li><a href="/forget">Change Password</a></li>
            </ul>
        </li>
        <li><a href="#" class="">FAQ's</a></li>
        <li><a href="#" class="">Contact Us</a></li>
        <li><a href="/logout" class="">Logout</a></li>
    </ul>

</nav>
</html>
