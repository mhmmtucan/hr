<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
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
    <title>${user.name} ${user.surname}</title>
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
          href="${pageContext.request.contextPath}/resources/semantic/components/form.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/components/search.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/components/divider.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/components/dropdown.min.css">
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

    <style>
        .ui.big.label, .ui.big.labels .label {
            margin: 2px;
            font-size: 1.1rem;
        }

        .profile-img {
            position: absolute !important;
            margin: auto !important;
            top: 0 !important;
            left: 0 !important;
            right: 0 !important;
            bottom: 0 !important;
            border-radius: 50% !important;
            width: 150px !important;
            height: 150px !important;
        }

        .profile-title {
            font-size: 1.2em;
            color: #009688;
            font-style: italic;
        }

    </style>

</head>
<body>


<jsp:include page="templates/extra_menus.jsp">
    <jsp:param name="hrId" value='<%= session.getAttribute("hrId") %>'/>
    <jsp:param name="userId" value='<%= session.getAttribute("userId") %>'/>
</jsp:include>

<!-- Page Contents -->
<div class="pusher">
    <div class="ui vertical masthead center aligned segment">
        <jsp:include page="templates/main_menu.jsp">
            <jsp:param name="hrId" value='<%= session.getAttribute("hrId") %>'/>
            <jsp:param name="userId" value='<%= session.getAttribute("userId") %>'/>
        </jsp:include>
        <div class="ui container" style="margin-top: 20px;">
            <div class="ui two column centered grid">
                <div class="left floated sixteen wide column">
                    <div class="ui items">
                        <div class="item">
                            <div class="image" style="height: 150px;margin-top: 30px;">
                                <img class="profile-img" src="${user.picture_url}">
                            </div>
                            <div class="content">
                                <div class="header"><h2>${user.name} ${user.surname}
                                    <c:if test="${role == 'ROLE_USER'}">
                                        <a id="editProfile"><i class="edit outline icon"></i>
                                        </a>
                                    </c:if>
                                </h2></div>
                                <div class="meta">
                                    <span class="profile-title">${user.title}</span>
                                </div>
                                <div class="description">
                                    <span><b>Universtiy:</b></span> ${user.university} <br>
                                    <span><b>Department:</b></span> ${user.department} <br>
                                    <span><b>GPA:</b></span> ${user.gpa} <br>
                                    <span><b>High School:</b></span> ${user.highschool} <br>
                                    <span><b>Experience:</b></span> ${user.experience} <br>
                                    <span><b>LinkedIn Url:</b></span> <a
                                        href="${user.publicprofile_url}">${user.publicprofile_url}</a> <br>
                                    <span><b>Score:</b></span> ${user.score} <br>
                                </div>
                                <div class="extra">
                                    <div>
                                        <c:forEach items="${user.qualification}" var="qual">
                                            <div class="ui label">${qual}
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <c:if test="${role == 'ROLE_HR'}">
                                        <div id="blackListBtn" class="ui left floated basic red button">
                                            Black List User
                                            <i class="right chevron icon"></i>
                                        </div>
                                        <div id="blackListCancelBtn" class="ui left floated basic green button">
                                            Cancel Blacklisting
                                            <i class="right chevron icon"></i>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="appListRow" class="one column row">
                    <div class="column">
                        <div class="ui middle aligned selection list appList">
                            <c:forEach items="${applications}" var="app">
                                <a class="item appItem" href="/job/${app.job.id}" style="">
                                    <c:choose>
                                        <c:when test="${app.currentstatus == 'Accepted'}">
                                            <i class="check circle green icon middle aligned"></i>
                                        </c:when>
                                        <c:when test="${app.currentstatus == 'Pending'}">
                                            <i class="question circle yellow icon middle aligned"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="times circle red icon middle aligned"></i>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="content">
                                        <div class="header"> ${app.job.title} - ${app.job.hr.company}</div>
                                        <div class="description">Status: ${app.currentstatus}</div>
                                    </div>

                                </a>
                                <c:if test="${role == 'ROLE_USER'}">
                                    <div class="item appItemBtn">
                                    <span class="right floated content">
                                        <form action="/job/${app.job.id}/application/${app.id}/cancel" method="post"
                                              name="cancel">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                            <button class="ui basic negative tiny button"
                                                    type="submit">Cancel Application</button>
                                        </form>
                                    </span>
                                    </div>
                                </c:if>

                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <c:if test="${role == 'ROLE_HR'}">
            <div class="ui modal">
                <i class="close icon"></i>
                <div class="header">
                    You are blacklisting ${user.name} ${user.surname}
                </div>
                <div class="image content">
                    <div class="ui medium image">
                        <img src="${user.picture_url}">
                    </div>
                    <div class="description">
                        <div class="ui header">Be careful!</div>
                        <p>Blacklisting a user permits making new applications and all former applications will
                            be canceled. We strongly discourage this operation. However, if it is required
                            please
                            state
                            a reason.</p>
                        <div class="ui form">
                            <div class="ui required field">
                                <label>Why are you blacklisting ${user.name} ${user.surname}?</label>
                                <input type="text" id="blreason" placeholder="Black listing reason">
                                <div class="ui error message"></div>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="actions">
                    <div class="ui black deny button">
                        Nope
                    </div>
                    <div id="blackListConfirmBtn" class="ui negative right labeled icon button">
                        Blacklist
                        <i class="times icon"></i>
                    </div>
                </div>
            </div>
        </c:if>

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
<script src="${pageContext.request.contextPath}/resources/semantic/components/search.min.js"></script>
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

            let $blackListBtn = $('#blackListBtn');
            let $blackListCancelBtn = $('#blackListCancelBtn');

            if ("${role}" == "ROLE_HR") {
                if ("${user.blacklisted}" == "true") {
                    $blackListBtn.text("Blacklisted!");
                    $blackListBtn.attr("class", "ui left floated basic red disabled button");
                } else {
                    $blackListCancelBtn.text("Canceled!");
                    $blackListCancelBtn.attr("class", "ui left floated basic green disabled button");
                }
            }

            if ("${role}" == "ROLE_USER") {
                // change css so that list is displayed correctly
                $('.appItem').attr("style", "display:inline-block;width:80%");
                $('.appItemBtn').attr("style", "display:inline-block;background: rgba(0, 0, 0, 0.0);color: rgba(0, 0, 0, 0.0);");
            }

            $('#editProfile').click(function () {
                $.ajax({
                    type: "POST",
                    beforeSend: function (request) {
                        request.setRequestHeader(header, token);
                    },
                    url: "/user/profile/${user.id}/edit",
                    data: "${user.id}",
                    contentType: 'text/plain',
                    success: function (response) {
                        document.open();
                        document.write(response);
                        document.close();
                    },
                    error: function (request, textStatus, errorThrown) {
                        console.log(errorThrown);
                    }
                });
            });

            $blackListBtn.click(function () {
                $('.ui.modal')
                    .modal('show');
            });


            $('.ui.form')
                .form({
                    fields: {
                        blreason: {
                            identifier: 'blreason',
                            rules: [
                                {
                                    type: 'empty',
                                    prompt: 'Please enter a reason'
                                }
                            ]
                        }
                    }
                })
            ;

            $('#blackListConfirmBtn').click(function () {
                $.ajax({
                    type: "POST",
                    beforeSend: function (request) {
                        request.setRequestHeader(header, token);
                    },
                    url: "/user/${user.id}/blacklist",
                    data: document.getElementById("blreason").value,
                    success: function (response) {
                        $blackListBtn.text("Blacklisted!");
                        $blackListBtn.attr("class", "ui left floated basic red disabled button");
                        $blackListCancelBtn.text("Cancel Blacklisting");
                        $blackListCancelBtn.attr("class", "ui left floated basic green button");
                        $('#appListRow').load(document.URL + ' #appListRow');
                    },
                    error: function (request, textStatus, errorThrown) {
                        console.log(errorThrown);
                    }
                });
            });

            $blackListCancelBtn.click(function () {
                $.ajax({
                    type: "POST",
                    beforeSend: function (request) {
                        request.setRequestHeader(header, token);
                    },
                    url: "/user/${user.id}/blacklist/cancel",
                    data: "cancel",
                    success: function (response) {
                        $blackListCancelBtn.text("Canceled!");
                        $blackListCancelBtn.attr("class", "ui left floated basic green disabled button");
                        $blackListBtn.text("Black List User");
                        $blackListBtn.attr("class", "ui left floated basic red button");
                        $('#appListRow').load(document.URL + ' #appListRow');
                    },
                    error: function (request, textStatus, errorThrown) {
                        console.log(errorThrown);
                    }
                });
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
