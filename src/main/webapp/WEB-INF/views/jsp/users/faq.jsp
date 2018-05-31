<%--
  Created by IntelliJ IDEA.
  User: v0s004a
  Date: 5/29/18
  Time: 11:38 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page session="false"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<title>IPL score predictor</title>
<meta name="description" content="Cricket" />
<meta charset="utf-8">
<!--Fav Icon:-->
<link rel="shortcut icon" href="/resources/core/images/cricket.ico" />

<!--CSS Styles:-->
<spring:url value="/resources/core/css/home.css" var="homeCss" />
<spring:url value="/resources/core/css/clock.css" var="clockCss" />
<spring:url value="/resources/core/css/footer.css" var="footerCss" />
<spring:url value="/resources/core/css/login.css" var="loginCss" />
<spring:url value="/resources/core/css/faq.css" var="faqCss" />
<link href="${homeCss}" rel="stylesheet" />
<link href="${clockCss}" rel="stylesheet" />
<link href="${footerCss}" rel="stylesheet" />
<link href="${footerCss}" rel="stylesheet" />
<link href="${loginCss}" rel="stylesheet" />
<link href="${faqCss}" rel="stylesheet" />

<!-- Urls -->
<spring:url value="/" var="homeUrl" />

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
                    <a href="${userUrl}" style="color:white;font-size:20px;text-decoration:none;font-family:Comic Sans MS">Indian Premier League</a>
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
                                <a href="/" class="new1" style="color:white;font-size:19px;text-decoration:none;font-family:Comic Sans MS">	IPL is live today. &nbsp;&nbsp;&nbsp;  Sign on to find your score.</a></marquee>
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

        <br />

        <c:if test="${not empty msg}">
            <div class="alert alert-${css} alert-dismissible" role="alert">
                <strong>${msg}</strong>
            </div>
        </c:if>

        <div style="width: 1000px; margin: 0 auto;">
            <div id="contact" class="contact">
                <div id="sitecontent">

                    <section class="cd-faq">
                        <ul class="cd-faq-categories">
                            <li><a class="selected" href="#basics">Basics</a></li>
                            <li><a href="#account">User Account</a></li>
                            <li><a href="#payments">Payments</a></li>
                            <li><a href="#privacy">Privacy</a></li>
                            <li><a href="#delivery">Delivery</a></li>
                        </ul> <!-- cd-faq-categories -->

                        <div class="cd-faq-items">
                            <ul id="basics" class="cd-faq-group">
                                <li class="cd-faq-title"><h2>Basics</h2></li>
                                <li>
                                    <a class="cd-faq-trigger" href="#0">What is the purpose of the website??</a>
                                    <div class="cd-faq-content">
                                        <p>The purpose of this website is to register for the various events available in your city. The website also provides the upcomming tournament details. High quality pictures from the completed and on going tournaments. Winners list from previous tournaments.</p>
                                    </div> <!-- cd-faq-content -->
                                </li>

                                <li>
                                    <a class="cd-faq-trigger" href="#0">How do I sign up?</a>
                                    <div class="cd-faq-content">
                                        <p>You can register on the website by clicking the sign in button and create an account for you. </p>
                                    </div> <!-- cd-faq-content -->
                                </li>

                                <li>
                                    <a class="cd-faq-trigger" href="#0">How to contact the event co-ordinator?</a>
                                    <div class="cd-faq-content">
                                        <p>Most of the details will be available in the particualr event page, Announcements page. If you havent found what you are looking for, click on <a href="contactus.html">contact us</a> page to send us your query. We will respond you back asap.</p>
                                    </div> <!-- cd-faq-content -->
                                </li>

                                <li>
                                    <a class="cd-faq-trigger" href="#0">Who this website belongs to</a>
                                    <div class="cd-faq-content">
                                        <p>If you are a game enthusiasts, and interested in participating game events, then this website is for you. Check the upcomming events, register for your choice of event. Come join us and have fun.</p>
                                    </div> <!-- cd-faq-content -->
                                </li>
                            </ul> <!-- cd-faq-group -->



                            <ul id="account" class="cd-faq-group">
                                <li class="cd-faq-title"><h2>User Account</h2></li>
                                <li>
                                    <a class="cd-faq-trigger" href="#0">I forgot my password. How do I reset it?</a>
                                    <div class="cd-faq-content">
                                        <p>Incase if you forgot the password , then you can click forget password. Incase if you want to change your password, please use the Change Password link on Login page!</p>
                                    </div> <!-- cd-faq-content -->
                                </li>

                                <li>
                                    <a class="cd-faq-trigger" href="#0">Why do I need a account for event registration?</a>
                                    <div class="cd-faq-content">
                                        <p>At any point of time if you want to cancel your registation, you can login to your account and then cancel your registration. Your account will keep track of the events you have registered for.</p>
                                    </div> <!-- cd-faq-content -->
                                </li>

                                <li>
                                    <a class="cd-faq-trigger" href="#0">How do I change my account settings?</a>
                                    <div class="cd-faq-content">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Blanditiis provident officiis, reprehenderit numquam. Praesentium veritatis eos tenetur magni debitis inventore fugit, magnam, reiciendis, saepe obcaecati ex vero quaerat distinctio velit.</p>
                                    </div> <!-- cd-faq-content -->
                                </li>

                                <li>
                                    <a class="cd-faq-trigger" href="#0">How can I edit my profile?</a>
                                    <div class="cd-faq-content">
                                        <p></p>
                                    </div> <!-- cd-faq-content -->
                                </li>
                            </ul> <!-- cd-faq-group -->

                            <ul id="payments" class="cd-faq-group">
                                <li class="cd-faq-title"><h2>Payments</h2></li>
                                <li>
                                    <a class="cd-faq-trigger" href="#0">Can I have an invoice for my subscription?</a>
                                    <div class="cd-faq-content">
                                        <p></p>
                                    </div> <!-- cd-faq-content -->
                                </li>

                                <li>
                                    <a class="cd-faq-trigger" href="#0">Why did my credit card or PayPal payment fail?</a>
                                    <div class="cd-faq-content">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Tenetur accusantium dolorem vel, ad, nostrum natus eos, nemo placeat quos nisi architecto rem dolorum amet consectetur molestiae reprehenderit cum harum commodi beatae necessitatibus. Mollitia a nostrum enim earum minima doloribus illum autem, provident vero et, aspernatur quae sunt illo dolorem. Corporis blanditiis, unde, neque, adipisci debitis quas ullam accusantium repudiandae eum nostrum quis! Velit esse harum qui, modi ratione debitis alias laboriosam minus eaque, quod, itaque labore illo totam aut quia fuga nemo. Perferendis ipsa laborum atque assumenda tempore aspernatur a eos harum non id commodi excepturi quaerat ullam, explicabo, incidunt ipsam, accusantium quo magni ut! Ratione, magnam. Delectus nesciunt impedit praesentium sed, aliquam architecto dolores quae, distinctio consectetur obcaecati esse, consequuntur vel sit quis blanditiis possimus dolorum. Eaque architecto doloremque aliquid quae cumque, vitae perferendis enim, iure fugiat, soluta aut!</p>
                                    </div> <!-- cd-faq-content -->
                                </li>

                                <li>
                                    <a class="cd-faq-trigger" href="#0">Why does my bank statement show multiple charges for one upgrade?</a>
                                    <div class="cd-faq-content">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Blanditiis provident officiis, reprehenderit numquam. Praesentium veritatis eos tenetur magni debitis inventore fugit, magnam, reiciendis, saepe obcaecati ex vero quaerat distinctio velit.</p>
                                    </div> <!-- cd-faq-content -->
                                </li>
                            </ul> <!-- cd-faq-group -->

                            <ul id="privacy" class="cd-faq-group">
                                <li class="cd-faq-title"><h2>Privacy</h2></li>
                                <li>
                                    <a class="cd-faq-trigger" href="#0">Is my acocunt information safe?</a>
                                    <div class="cd-faq-content">
                                        <p></p>
                                    </div> <!-- cd-faq-content -->
                                </li>

                                <li>
                                    <a class="cd-faq-trigger" href="#0">Will my event registration be seen by anyone else?</a>
                                    <div class="cd-faq-content">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Blanditiis provident officiis, reprehenderit numquam. Praesentium veritatis eos tenetur magni debitis inventore fugit, magnam, reiciendis, saepe obcaecati ex vero quaerat distinctio velit.</p>
                                    </div> <!-- cd-faq-content -->
                                </li>

                                <li>
                                    <a class="cd-faq-trigger" href="#0">How can I access my account data?</a>
                                    <div class="cd-faq-content">
                                        <p></p>
                                    </div> <!-- cd-faq-content -->
                                </li>
                            </ul> <!-- cd-faq-group -->

                            <ul id="delivery" class="cd-faq-group">
                                <li class="cd-faq-title"><h2>Event Details</h2></li>
                                <li>
                                    <a class="cd-faq-trigger" href="#0">What should I do if my event registration is not successfull?</a>
                                    <div class="cd-faq-content">
                                        <p></p>
                                    </div> <!-- cd-faq-content -->
                                </li>

                                <li>
                                    <a class="cd-faq-trigger" href="#0">How can I get event notifications?</a>
                                    <div class="cd-faq-content">
                                        <p></p>
                                    </div> <!-- cd-faq-content -->
                                </li>

                                <li>
                                    <a class="cd-faq-trigger" href="#0">How will we get notifications if there is any change in schedule ?</a>
                                    <div class="cd-faq-content">
                                        <p></p>
                                    </div> <!-- cd-faq-content -->
                                </li>

                                <li>
                                    <a class="cd-faq-trigger" href="#0">How do cancellation and refunds work?</a>
                                    <div class="cd-faq-content">
                                        <p></p>
                                    </div> <!-- cd-faq-content -->
                                </li>

                            </ul> <!-- cd-faq-group -->
                        </div> <!-- cd-faq-items -->
                        <a href="#0" class="cd-close-panel">Close</a>
                    </section> <!-- cd-faq -->
                    <script src="/resources/js/faq/jquery-2.1.1.js"></script>
                    <script src="/resources/js/faq/jquery.mobile.custom.min.js"></script>
                    <script src="/resources/js/faq/main.js"></script> <!-- Resource jQuery -->
                </div>
            </div>

        </div>

    </header>

    <br /><br /><br /><br /><br /><br />

    <footer>

        <div class="top">
            <ul class="page-width">
                <li>
                    <h4>About Us</h4>
                    <p>
                        A fun place for all of our friends to have a common platform to test our cricketing skils. Participate in every match day and predict the winning team and we award you points based on the winner.
                        If you are an expert in cricket analysis, come give it a try and see where you stand among others.The first placed winner will be awarded with a special prize.
                    </p>
                </li>

                <li>
                    <h4>QUERIES ?</h4>
                    <a href="tel:+1-617-378-1238" class="phone">+1-617-378-1238</a>
                    <a href="mailto:vamsi.singamaneni@gmail.com" class="mail">vamsi.singamaneni@gmail.com</a>
                </li>
            </ul>
        </div>


        <div class="bottom">
            <ul class="page-width">
                <li>
                    &copy; All rights Reserved @ Vamsi Krishna Singamaneni
                </li>
                <li>
                    <a href="#">Copyrights</a>
                    <a href="#">Terms of Use </a>
                    <a href="#">Privacy Policy</a>
                </li>
            </ul>
        </div>

    </footer>

</div>
</body>
</html>