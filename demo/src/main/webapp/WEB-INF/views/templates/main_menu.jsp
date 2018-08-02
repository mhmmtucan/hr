<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: muhammetucan
  Date: 2.07.2018
  Time: 08:58
--%>

<c:set var="role" value="${role}"/>

<div class="ui container">
    <div class="ui large secondary menu">

        ${param.isLogged}

        <a href="/"><img width="140" src="${pageContext.request.contextPath}/resources/img/logo.png"></a>
        <div class="right item">
            <c:if test="${role == 'ROLE_ANONYMOUS'}">
                <button class="ui button linkedInBtn"
                        onmouseover="this.style.backgroundColor = '#0077b5'; this.style.color = '#FFF'"
                        onmouseout="this.style.backgroundColor = '#E0E1E2'; this.style.color = 'rgba(0, 0, 0, 0.6)'">
                    <i class="linkedin in icon"></i>Login with LinkedIn
                </button>
                <a href="/hr/login" class="ui button"><i class="h square icon"></i>HR Login</a>
            </c:if>
            <c:if test="${role != 'ROLE_ANONYMOUS'}">
                <div class="item">
                    <c:if test="${role == 'ROLE_HR' || role == 'ROLE_UNKNOWN_HR'}">
                        <a href="/hr/newJob" class="ui button"><i class="plus icon"></i>Create</a>
                        <a href="/hr/profile/${param.hrId}" class="ui button"><i class="user icon"></i>Profile</a>
                        <a href="/logout" class="ui button"><i class="sign out alternate icon"></i>Logout</a>
                    </c:if>
                    <c:if test="${role == 'ROLE_USER'}">
                        <a href="/user/profile/${param.userId}" class="ui button"><i class="user icon"></i>Profile</a>
                        <a href="/user/logout" class="ui button"><i class="sign out alternate icon"></i>Logout</a>
                    </c:if>
                </div>
            </c:if>

        </div>

    </div>
</div>