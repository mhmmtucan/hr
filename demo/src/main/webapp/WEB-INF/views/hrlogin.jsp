<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: muhammetucan
  Date: 30.06.2018
  Time: 13:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Redirecting...</title>
</head>
<body>

<c:set var="hrUsername" value="${hrUsername}"/>
<c:set var="hrId" value="${hrId}"/>

<%
    session.setAttribute("hrLoggedIn", "true");
    session.setAttribute("hrUsername", pageContext.getAttribute("hrUsername"));
    session.setAttribute("hrId", pageContext.getAttribute("hrId"));
%>

</body>

<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script>
    $(document).ready(function () {
        window.location.href = "<spring:url value="/"/>";
    });


</script>
</html>
