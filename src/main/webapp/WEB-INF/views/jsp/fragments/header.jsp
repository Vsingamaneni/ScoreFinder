<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<head>
<title>IPL Score Finder</title>

<spring:url value="/resources/core/css/hello.css" var="coreCss" />
<spring:url value="/resources/core/css/bootstrap.min.css"
	var="bootstrapCss" />
<link href="${bootstrapCss}" rel="stylesheet" />
<link href="${coreCss}" rel="stylesheet" />
</head>

<spring:url value="/" var="urlHome" />
<spring:url value="/login" var="loginUrl" />

<nav class="navbar navbar-inverse " style="background-color: #082a3e">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="${urlHome}" style="color:white;font-size:20px;text-decoration:none;font-family:Comic Sans MS">Indian Premier League</a>
		</div>
		<div id="navbar">
			<ul class="nav navbar-nav navbar-right">
				<li class="active"><a href="${loginUrl}" style="color:white;font-size:15px;text-decoration:none;font-family:Comic Sans MS">login</a></li>
			</ul>
		</div>
	</div>
</nav>