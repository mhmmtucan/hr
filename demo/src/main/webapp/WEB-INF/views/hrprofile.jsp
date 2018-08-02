<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib prefix="th" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <c:url var="home" value="/" scope="request"/>
    <!-- Standard Meta -->
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
    <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>

    <!-- Site Properties -->
    <title>Hr Profile</title>

    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/components/reset.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/components/site.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/semantic.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/components/container.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/components/grid.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/components/header.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/components/image.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/components/menu.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/components/divider.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/components/segment.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/components/button.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/components/list.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/components/icon.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/components/transition.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/extra.min.css">

</head>
<body>

<jsp:include page="templates/extra_menus.jsp">
    <jsp:param name="hrId" value='<%= session.getAttribute("hrId") %>'/>
    <jsp:param name="userId" value='<%= session.getAttribute("userId") %>'/>
</jsp:include>

<!-- Page Contents -->
<div class="pusher">
    <div class="ui vertical masthead segment">
        <jsp:include page="templates/main_menu.jsp">
            <jsp:param name="hrId" value='<%= session.getAttribute("hrId") %>'/>
            <jsp:param name="userId" value='<%= session.getAttribute("userId") %>'/>
        </jsp:include>

        <div style="width: 900px" class="ui text container">
            <h2 style="margin-top: 15px; margin-bottom: 15px;" class="ui left aligned header">Profile</h2>
            <div class="ui vertical segment" style="padding-bottom: 60px;">
                <div class="ui two column grid">
                    <div class="twelve wide column">
                        <div class="ui two column grid" style="height:60px;">
                            <div class="column">
                                <h4 style="margin-top: 15px; margin-bottom: 15px;" class="ui header">My Jobs</h4>
                            </div>
                            <div class="middle aligned column" style="text-align: right;">
                                <div class="ui checkbox">
                                    <input name="hidePassive" type="checkbox">
                                    <label>Hide passives</label>
                                </div>
                            </div>

                        </div>
                        <div class="ui divider"></div>
                        <div class="ui middle aligned selection list">
                            <c:forEach items="${jobs}" var="job">
                                <a class="item" href="/job/${job.id}">
                                    <div class="right floated content">
                                        <div class="content">${job.final_date}
                                        </div>
                                    </div>
                                    <c:choose>
                                        <c:when test="${job.isactive}">
                                            <i class="large toggle on middle aligned green icon activeJob"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="large toggle off middle aligned red icon passiveJob"></i>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="content">
                                        <div class="header">${job.title}</div>
                                    </div>
                                </a>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="four wide column">
                        <div class="ui card" style="margin-top: 50px;">
                            <div class="content">
                                <div class="center aligned header">${hr.name} ${hr.surname}</div>
                                <div class="center aligned description">
                                    <p>${hr.company}</p>
                                </div>
                            </div>
                            <div class="extra content">
                                <div class="center aligned author">
                                    <img class="ui avatar image"
                                         src="http://semantic-ui.com/images/avatar/small/jenny.jpg"> ${hr.username}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </div>


    <div class="ui inverted vertical footer segment">
        <div class="ui container">
            <div class="ui stackable inverted divided equal height stackable grid">
                <div class="three wide column">
                    <h4 class="ui inverted header">About</h4>
                    <div class="ui inverted link list">
                        <a href="#" class="item">Sitemap</a>
                        <a href="#" class="item">Contact Us</a>
                        <a href="#" class="item">Religious Ceremonies</a>
                        <a href="#" class="item">Gazebo Plans</a>
                    </div>
                </div>
                <div class="three wide column">
                    <h4 class="ui inverted header">Services</h4>
                    <div class="ui inverted link list">
                        <a href="#" class="item">Banana Pre-Order</a>
                        <a href="#" class="item">DNA FAQ</a>
                        <a href="#" class="item">How To Access</a>
                        <a href="#" class="item">Favorite X-Men</a>
                    </div>
                </div>
                <div class="seven wide column">
                    <h4 class="ui inverted header">Join Co.</h4>
                    <p>Extra space for a call to action inside the footer that could help re-engage users.</p>
                </div>
            </div>
        </div>
    </div>
</div>


</body>

<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/semantic/components/visibility.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/semantic/components/transition.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/semantic/semantic.min.js"></script>
<script>

    $(document)
        .ready(function () {
            let token = $('#_csrf').attr('content');
            let header = $('#_csrf_header').attr('content');
            // fix menu when passed
            $('.masthead')
                .visibility({
                    once: false,
                    onBottomPassed: function () {
                        $('.fixed.menu').transition('fade in');
                    },
                    onBottomPassedReverse: function () {
                        $('.fixed.menu').transition('fade out');
                    }
                });

            $('.ui.checkbox').checkbox({
                onChecked: function () {
                    let passiveJobs = document.getElementsByClassName("passiveJob");
                    for (let i = 0; i < passiveJobs.length; i++) {
                        passiveJobs[i].parentElement.style.display = "none";
                    }
                },
                onUnchecked: function () {
                    let passiveJobs = document.getElementsByClassName("passiveJob");
                    for (let i = 0; i < passiveJobs.length; i++) {
                        passiveJobs[i].parentElement.style.display = "list-item";
                    }
                },
            });

            $('.linkedInBtn').click(function () {
                $.ajax({
                    type: "POST",
                    beforeSend: function (request) {
                        request.setRequestHeader(header, token);
                    },
                    url: "<spring:url value="/user/login"/>",
                    data: {message: "text"},
                    success: function (response) {
                        window.location.href = response;
                    },
                    error: function (request, textStatus, errorThrown) {
                        console.log(errorThrown);
                    }
                });
            });

        });

</script>

</html>
