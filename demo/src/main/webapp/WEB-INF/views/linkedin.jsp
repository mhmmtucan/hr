<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
    <c:url var="home" value="/" scope="request" />
    <c:set var="baseURL" value="${pageContext.request.localName}"/>
    <meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
    <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
</head>

<body>

<%
    String linkedInCode = request.getQueryString().substring(5);
%>
</body>

<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script>
    $(document).ready(function(){
        //Perform Ajax request.
        let token = $('#_csrf').attr('content');
        let header = $('#_csrf_header').attr('content');
        $.ajax({
            url: "<spring:url value="/accessToken"/>",
            beforeSend: function (request) {
                request.setRequestHeader(header, token);
            },
            type: 'post',
            data : "<%=linkedInCode%>",
            success: function (response) {
                window.location.href = "<spring:url value="/user/details"/>";
            },
            error: function (xhr, ajaxOptions, thrownError) {
                let errorMsg = 'Ajax request failed: ' + xhr.responseText;
                alert(errorMsg);
            }
        });
    });


</script>

</html>