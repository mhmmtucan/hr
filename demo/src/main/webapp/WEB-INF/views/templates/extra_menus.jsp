<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: muhammetucan
  Date: 2.07.2018
  Time: 08:50
  To change this template use File | Settings | File Templates.
--%>

<c:set var="role" value="${role}"/>

<!-- Following Menu -->
<div class="ui large top fixed hidden menu">
    <div class="ui container">
        <a href="/" class="isactive item">Home</a>
        <a class="item">Company</a>
        <a class="item">Careers</a>
        <a href="/job/all" class="item">Jobs</a>
        <div class="right menu">

            <c:if test="${role == 'ROLE_ANONYMOUS'}">
                <div style="margin-top: 5px;">
                    <button class="ui button linkedInBtn"
                            onmouseover="this.style.backgroundColor = '#0077b5'; this.style.color = '#FFF'"
                            onmouseout="this.style.backgroundColor = '#E0E1E2'; this.style.color = 'rgba(0, 0, 0, 0.6)'">
                        <i class="linkedin in icon"></i>Login with LinkedIn
                    </button>
                    <a href="hr/login" class="ui button"><i class="h square icon"></i>HR Login</a>
                </div>
            </c:if>

            <c:if test="${role != 'ROLE_ANONYMOUS'}">
                <div class="item">
                    <c:if test="${role == 'ROLE_HR' || role == 'ROLE_UNKNOWN_HR'}">
                        <div>
                            <a href="/hr/newJob" class="ui button"><i class="plus icon"></i>Create</a>
                        </div>
                        <div>
                            <a href="/hr/profile/${param.hrId}" class="ui button"><i class="user icon"></i>Profile</a>
                        </div>
                        <div>
                            <a href="/logout" class="ui button"><i class="sign out alternate icon"></i>Logout</a>
                        </div>
                    </c:if>
                    <c:if test="${role == 'ROLE_USER'}">
                        <div>
                            <a href="/user/profile/${param.userId}" class="ui button"><i
                                    class="user icon"></i>Profile</a>
                        </div>
                        <div>
                            <a href="/user/logout" class="ui button"><i class="sign out alternate icon"></i>Logout</a>
                        </div>

                    </c:if>
                </div>
            </c:if>

        </div>
    </div>
</div>