<%--
  Created by IntelliJ IDEA.
  User: v0s004a
  Date: 5/4/18
  Time: 1:18 AM
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
                <li><a href="/register">Registration</a>
                    <ul>
                        <li><a href="/register">IPL</a></li>
                        <li><a href="#">Soccer</a></li>
                        <li><a href="#">Kabadi</a>
                        </li>
                    </ul>
                </li>
        <li><a href="/login" class="">My Account</a>
            <ul>
                <li><a href="/login">Login</a></li>
            </ul>
        </li>
        <li><a href="/faq" class="">FAQ's</a></li>
        <li><a href="contactus.html" class="">Contact Us</a></li>
    </ul>

</nav>
</html>
