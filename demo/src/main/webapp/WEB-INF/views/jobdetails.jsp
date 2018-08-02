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
    <title>${job.title}</title>

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
          href="${pageContext.request.contextPath}/resources/semantic/components/sidebar.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/components/transition.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/components/calendar.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/extra.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/loader.css">

    <style>
        .ui.big.label, .ui.big.labels .label {
            margin: 2px;
            font-size: 1.1rem;
        }

        .circular.ui.icon.button {
            font-size: 0.9rem;
        }

        #toggleStatus {
            font-size: 0.9em;
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            padding-left: 4rem !important;
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
    <div class="ui vertical masthead segment">
        <jsp:include page="templates/main_menu.jsp">
            <jsp:param name="hrId" value='<%= session.getAttribute("hrId") %>'/>
            <jsp:param name="userId" value='<%= session.getAttribute("userId") %>'/>
        </jsp:include>

        <div style="position: relative">

        </div>

        <div class="loader" id="loader-2">
            <span></span>
            <span></span>
            <span></span>
        </div>

        <div id="main-content" style="width: 1000px;visibility: hidden;" class="ui container">
            <div class="ui three column grid">
                <div class="row">
                    <div class="ten wide column">
                        <h2 style="margin-top: 15px; margin-bottom: 15px;" class="ui header">${job.title}</h2>
                    </div>

                    <c:if test="${role == 'ROLE_HR'}">
                        <div class="six wide middle aligned column"
                             style="display: flex !important;justify-content: flex-end;flex-direction: row;">
                            <div id="isactive" class="ui toggle checkbox"
                                 style=";right: 92px;position: relative;">
                                <c:if test="${job.isactive}">
                                    <label id="toggleStatus">Active&nbsp;</label>
                                </c:if>
                                <c:if test="${!job.isactive}">
                                    <label id="toggleStatus">Passive</label>
                                </c:if>
                                <input name="isactive" type="checkbox"
                                       style="position: absolute;top: 50%;transform: translateY(-50%);">
                            </div>
                            <div>
                                <button id="jobEdit" class="circular ui icon button"
                                        style="">Edit
                                    <i class="icon edit"></i>
                                </button>
                            </div>
                            <div>
                                <button id="jobDelete" class="circular ui icon button">Delete
                                    <i class="icon minus circle"></i>
                                </button>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>


            <div class="ui vertical segment" style="padding-bottom: 60px;">
                <div class="ui two column grid">
                    <div class="eleven wide column">
                        <h4 class="ui horizontal divider header">
                            <i class="tag icon"></i>
                            Job Description
                        </h4>
                        <textarea name="content" id="editor" disabled>${job.description}</textarea>
                    </div>

                    <div class="five wide column">
                        <div class="ui fluid card">
                            <div class="content">
                                <div class="center aligned header">${job.company}</div>
                                <div class="ui vertical segment"
                                     style="padding: 20px 20px 10px 20px; border-bottom-width: 0;">
                                    <img src="${pageContext.request.contextPath}/resources/img/company/big/${job.company}.png"
                                         class="ui centered medium image">
                                </div>

                                <div class="center aligned description" style="padding-top: 10px;">
                                    <p>${job.hr.company_info}</p>
                                </div>
                            </div>
                            <div class="extra content">
                                <div class="center aligned author">
                                    <img class="ui avatar image"
                                         src="${pageContext.request.contextPath}/resources/img/people_placeholder/${job.hr.username}.png">
                                    Hr: ${job.hr.name} ${job.hr.surname}
                                </div>
                            </div>
                        </div>

                        <div class="ui segments">
                            <div class="ui secondary center aligned segment">
                                <div>
                                    Activation: ${job.activation_date}
                                </div>
                            </div>
                            <div class="ui center aligned segment">
                                <div>
                                    Closing: ${job.final_date}
                                </div>
                            </div>
                        </div>


                        <h4 style="margin-top: 20px;" class="ui horizontal divider header">
                            <i class="bar chart icon"></i>
                            Qualifications
                        </h4>
                        <div style="border-bottom-width: 0;" class="ui center aligned vertical segment">
                            <c:forEach items="${qualifications}" var="qual">
                                <div class="ui circular blue big label">${qual}
                                </div>
                            </c:forEach>
                        </div>

                        <c:if test="${role == 'ROLE_USER'}">
                            <div style="border-bottom-width: 0;" class="ui center aligned vertical segment">
                                <div class="center aligned">
                                    <div id="joinBtn" class="ui labeled button" tabindex="0">
                                        <div id="inner-joinBtn" class="ui button">
                                            <i class="black tie icon"></i> Join ${job.company}
                                        </div>
                                        <p class="ui basic left pointing label">
                                            <span id="applicationCount">${applicationCount}</span>
                                        </p>
                                    </div>
                                    <div style="visibility: hidden;" id="joinError" class="ui error message">Login
                                        First!
                                    </div>
                                </div>
                            </div>
                        </c:if>

                    </div>
                </div>
            </div>


            <c:if test="${role == 'ROLE_HR'}">
                <div style="margin-bottom: 60px;">
                    <div class="ui vertical segment" style="border-bottom-width: 0;">
                        <h2 style="margin-top: 30px; margin-bottom: 15px;" class="ui header">Applicants
                            for ${job.title}</h2>

                        <div class="ui two column center aligned grid">
                            <div class="fourteen wide column">
                                <div class="ui fluid right action left icon input">
                                    <i class="search icon"></i>
                                    <input id="userSearchText" type="text" placeholder="Search">
                                    <div id="searchCriteria" class="ui basic floating dropdown button">
                                        <div class="text">For Applicants</div>
                                        <i style="margin-left: 12px;" class="dropdown icon"></i>
                                        <div class="menu">
                                            <div id="for-applicants" class="item">For Applicants</div>
                                            <div id="for-users" class="item">For All Users</div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="two wide column">
                                <div class="ui labeled icon top right pointing dropdown button">
                                    <i class="filter icon"></i>
                                    <span class="text">Order</span>
                                    <div class="menu">
                                        <div class="header">
                                            <i class="tags icon"></i>
                                            Order by name
                                        </div>
                                        <div id="name-asc" class="item">
                                            Ascending
                                        </div>
                                        <div id="name-desc" class="item">
                                            Descending
                                        </div>
                                        <div class="divider"></div>
                                        <div class="header">
                                            <i class="tags icon"></i>
                                            Order by Surname
                                        </div>
                                        <div id="surname-asc" class="item">
                                            Ascending
                                        </div>
                                        <div id="surname-desc" class="item">
                                            Descending
                                        </div>
                                        <div class="divider"></div>
                                        <div class="header">
                                            <i class="tags icon"></i>
                                            Order by Score
                                        </div>
                                        <div id="score-asc" class="item">
                                            Ascending
                                        </div>
                                        <div id="score-desc" class="item">
                                            Descending
                                        </div>
                                        <div class="divider"></div>
                                        <div class="header">
                                            <i class="tags icon"></i>
                                            Order by Status
                                        </div>
                                        <div id="status-asc" class="item">
                                            Ascending
                                        </div>
                                        <div id="status-desc" class="item">
                                            Descending
                                        </div>
                                        <div class="divider"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="ui message">
                        <i class="close icon"></i>
                        <div class="header">
                            Live Search!
                        </div>
                        <p>Search Box can be used to search both applicants and all users. When search box is empty,
                            it shows the current applicants.</p>
                    </div>

                    <div id="main-list" class="ui middle aligned divided list">

                        <table id="main-table" class="ui sortable-table very basic table">
                            <thead>
                            <tr>
                                <th class="name-sort">Name</th>
                                <th class="surname-sort">Surname</th>
                                <th class="surname-sort">University</th>
                                <th class="surname-sort">Department</th>
                                <th class="surname-sort">GPA</th>
                                <th class="surname-sort">Exp</th>
                                <th class="score-sort">Score</th>
                                <th class="status-sort">Status</th>
                                <th class="no-sort"></th>
                            </tr>
                            </thead>

                            <tbody id="applicantsBody">
                            <c:forEach items="${applications}" var="app">
                                <tr>
                                    <td><img class="ui avatar image"
                                             src="${app.user.picture_url}">
                                        <a href="/user/profile/${app.user.id}">${app.user.name} </a></td>
                                    <td class="">${app.user.surname}</td>
                                    <td class="">${app.user.university}</td>
                                    <td class="">${app.user.department}</td>
                                    <td class="">${app.user.gpa}</td>
                                    <td class="">${app.user.experience}</td>
                                    <td data-sort-value="${app.user_score}" class="">${app.user_score}</td>
                                    <td id="${app.user.id}" data-value="${app.id}"
                                        <c:if test="${app.currentstatus == 'Accepted'}">class="positive"></c:if>
                                        <c:if test="${app.currentstatus == 'Pending'}">class="warning"></c:if>
                                        <c:if test="${app.currentstatus == 'Rejected'}">class="negative"></c:if>

                                        <c:if test="${app.user.blacklisted == true}">Blacklisted</c:if>
                                        <c:if test="${app.user.blacklisted == false}">${app.currentstatus}</c:if>
                                    </td>

                                    <td>
                                        <div class="center aligned content">
                                            <c:if test="${app.user.blacklisted == false}">
                                                <div class="ui buttons">
                                                    <c:if test="${app.currentstatus == 'Accepted'}">
                                                        <button value="${app.id}"
                                                                class="ui positive disabled button acceptBtn">
                                                            Accept
                                                        </button>
                                                        <div class="or"></div>
                                                        <button value="${app.id}" class="ui negative button rejectBtn">
                                                            Reject
                                                        </button>
                                                    </c:if>
                                                    <c:if test="${app.currentstatus == 'Pending'}">
                                                        <button value="${app.id}" class="ui positive button acceptBtn">
                                                            Accept
                                                        </button>
                                                        <div class="or"></div>
                                                        <button value="${app.id}" class="ui negative button rejectBtn">
                                                            Reject
                                                        </button>
                                                    </c:if>
                                                    <c:if test="${app.currentstatus == 'Rejected'}">
                                                        <button value="${app.id}" class="ui positive button acceptBtn">
                                                            Accept
                                                        </button>
                                                        <div class="or"></div>
                                                        <button value="${app.id}"
                                                                class="ui negative disabled button rejectBtn">
                                                            Reject
                                                        </button>
                                                    </c:if>
                                                    <c:if test="${app.currentstatus == 'Blacklisted'}">
                                                        <button value="${app.id}"
                                                                class="ui positive disabled button acceptBtn">
                                                            Accept
                                                        </button>
                                                        <div class="or"></div>
                                                        <button value="${app.id}"
                                                                class="ui negative disabled button rejectBtn">
                                                            Reject
                                                        </button>
                                                    </c:if>
                                                </div>
                                            </c:if>

                                        </div>
                                    </td>
                                </tr>

                            </c:forEach>
                            </tbody>

                        </table>
                    </div>

                </div>
            </c:if>
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

</body>

<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/semantic/components/visibility.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/semantic/components/transition.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/semantic/components/search.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/semantic/semantic.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/semantic/components/form.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/semantic/components/dropdown.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/semantic/components/tablesort.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/10.1.0/classic/ckeditor.js"></script>
<script>
    $(document)
        .ready(function () {
            let token = $('#_csrf').attr('content');
            let header = $('#_csrf_header').attr('content');

            setTimeout(function () {
                $('#main-content').attr("style", "width: 1000px;");
                $('#loader-2').attr("style", "visibility: hidden;")
            }, 1000);

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

            $('.ui.checkbox').checkbox();

            $('.ui.dropdown').dropdown();

            $('.message .close')
                .on('click', function () {
                    $(this)
                        .closest('.message')
                        .transition('fade')
                    ;
                });

            ClassicEditor
                .create(document.querySelector('#editor'))
                .then(editor => {
                    let ck = document.querySelector('.ck-editor__editable');
                    ck.setAttribute("contenteditable", "false");
                    ck.style.borderColor = "white";
                    document.querySelector('.ck-editor__nested-editable').setAttribute("contenteditable", "false");
                    document.querySelector('.ck-editor__top').style.display = "none";
                    document.querySelector('.ck-widget.ck-widget_selected').style.cssText = 'outline:none !important';
                })
                .catch(error => {
                    console.error(error);
                    document.querySelector('.ck-editor__top').style.display = "none";
                    document.querySelector('.ck-widget.ck-widget_selected').style.cssText = 'outline:none !important';
                });


            $('#jobEdit').click(function (event) {
                $.ajax({
                    type: "POST",
                    beforeSend: function (request) {
                        request.setRequestHeader(header, token);
                    },
                    url: "/job/${job.id}/edit",
                    data: "text",
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

            $('#jobDelete').click(function (event) {
                if (document.getElementById("jobDelete").innerText.includes("Delete")) {
                    document.getElementById("jobDelete").style.width = "72.73px";
                    document.getElementById("jobDelete").innerText = "Sure?";
                } else {
                    $.ajax({
                        type: "POST",
                        beforeSend: function (request) {
                            request.setRequestHeader(header, token);
                        },
                        url: "/job/${job.id}/delete",
                        data: "text",
                        success: function (response) {
                            window.location.href = "/hr/profile/<%=session.getAttribute("hrId")%>";

                        },
                        error: function (request, textStatus, errorThrown) {
                            console.log(errorThrown);
                        }
                    });
                }
            });


            if ("${role}" === "ROLE_USER" && ${applicationMade} == true) {
                let inner_joinBtn = document.getElementById("inner-joinBtn");
                inner_joinBtn.setAttribute("class", "ui disabled button");
                inner_joinBtn.innerText = "Applied!";
                inner_joinBtn.style.cursor = "default";
            }

            let mainTable, userSearch, searchTableBody, applicationTableBody, searchCriteriaDropdown, forApplicants,
                forAllUsers;

            if ("${role}" == "ROLE_HR") {
                userSearch = document.getElementById("userSearchText");
                mainTable = document.getElementById("main-table");
                searchTableBody = document.createElement("tbody");
                searchTableBody.setAttribute("id", "searchBody");
                applicationTableBody = document.getElementById("applicantsBody");
                searchCriteriaDropdown = $('#searchCriteria');
                forApplicants = document.getElementById("for-applicants");
                forAllUsers = document.getElementById("for-users");
                userSearch.addEventListener("keyup", searchFn, false);
                forApplicants.addEventListener("click", searchFn, false);
                forAllUsers.addEventListener("click", searchFn, false);
            }

            function searchFn(event) {
                let charCode = event.keyCode;
                let data = userSearch.value;
                console.log(event.type);
                if (data == "") {
                    if (document.getElementById("searchBody").parentNode == document.getElementById("main-table")) {
                        document.getElementById("main-table").removeChild(document.getElementById("searchBody"));
                    }
                    document.getElementById("main-table").appendChild(applicationTableBody);
                    //applicationTableBody.style.display = "table-row-group";
                } else {
                    if ((charCode > 63 && charCode < 91) || (charCode > 96 && charCode < 123) || charCode == 8 || event.type == "click") {
                        let url = "";

                        if (event.type == "click") {
                            if (event.target == forApplicants) {
                                url = "/search/applicants/${job.id}";
                            } else if (event.target == forAllUsers) {
                                url = "/search/users";
                            }
                        } else {
                            if (searchCriteriaDropdown.dropdown('get text') == "For Applicants") {
                                url = "/search/applicants/${job.id}";
                            } else if (searchCriteriaDropdown.dropdown('get text') == "For All Users") {
                                url = "/search/users";
                            }
                        }

                        $.ajax({
                            type: "POST",
                            beforeSend: function (request) {
                                request.setRequestHeader(header, token);
                            },
                            url: url,
                            data: data,
                            contentType: 'text/plain',
                            dataType: 'json',
                            success: function (response) {
                                // create lists
                                // show no result
                                while (searchTableBody.firstChild) {
                                    searchTableBody.removeChild(searchTableBody.firstChild)
                                }
                                if (response.result == 0) {

                                } else {
                                    for (let i = 0; i < response.users.length; i++) {

                                        let tr = document.createElement("tr");

                                        let td_name = document.createElement("td");
                                        let img = document.createElement("img");
                                        img.setAttribute("class", "ui avatar image");

                                        img.setAttribute("src", response.users[i].picture_url);
                                        let anchor = document.createElement("a");
                                        anchor.innerText = response.users[i].name;
                                        anchor.setAttribute("href", "/user/profile/" + response.users[i].id);
                                        td_name.appendChild(img);
                                        td_name.appendChild(anchor);

                                        let td_surname = document.createElement("td");
                                        td_surname.innerText = response.users[i].surname;

                                        let td_score = document.createElement("td");
                                        td_score.innerText = response.users[i].score;

                                        let td_university = document.createElement("td");
                                        td_university.innerText = response.users[i].university;

                                        let td_department = document.createElement("td");
                                        td_department.innerText = response.users[i].department;

                                        let td_gpa = document.createElement("td");
                                        td_gpa.innerText = response.users[i].gpa;

                                        let td_exp = document.createElement("td");
                                        td_exp.innerText = response.users[i].experience;

                                        tr.appendChild(td_name);
                                        tr.appendChild(td_surname);
                                        tr.appendChild(td_university);
                                        tr.appendChild(td_department);
                                        tr.appendChild(td_gpa);
                                        tr.appendChild(td_exp);
                                        tr.appendChild(td_score);

                                        // below attributes will change with applications
                                        if (searchCriteriaDropdown.dropdown('get text') == "For Applicants") {
                                            let dataSource = applicationTableBody.querySelector('[id="' + response.users[i].id + '"]');
                                            let td_status = document.createElement("td");
                                            td_status.innerHTML = dataSource.innerText;
                                            let td_buttons = document.createElement("td");
                                            let div_content = document.createElement("div");
                                            div_content.setAttribute("class", "center aligned content");
                                            let div_buttons = document.createElement("div");
                                            div_buttons.setAttribute("class", "ui buttons");
                                            let btn_accept = document.createElement("button");
                                            btn_accept.innerText = "Accept";
                                            btn_accept.setAttribute("value", dataSource.dataset.value);
                                            let btn_reject = document.createElement("button");
                                            btn_reject.innerText = "Reject";
                                            btn_reject.setAttribute("value", dataSource.dataset.value);

                                            if (td_status.innerText.includes("Accepted")) {
                                                btn_accept.setAttribute("class", "ui positive disabled button acceptBtn");
                                                btn_reject.setAttribute("class", "ui negative button rejectBtn");
                                            } else if (td_status.innerText.includes("Pending")) {
                                                btn_accept.setAttribute("class", "ui positive button acceptBtn");
                                                btn_reject.setAttribute("class", "ui negative button rejectBtn");
                                            } else if (td_status.innerText.includes("Rejected")) {
                                                btn_accept.setAttribute("class", "ui positive button acceptBtn");
                                                btn_reject.setAttribute("class", "ui negative disabled button rejectBtn");
                                            } else {
                                                btn_accept.setAttribute("class", "ui positive disabled button acceptBtn");
                                                btn_reject.setAttribute("class", "ui negative disabled button rejectBtn");
                                            }

                                            let div_or = document.createElement("div");
                                            div_or.setAttribute("class", "or");
                                            div_buttons.appendChild(btn_accept);
                                            div_buttons.appendChild(div_or);
                                            div_buttons.appendChild(btn_reject);
                                            div_content.appendChild(div_buttons);
                                            td_buttons.appendChild(div_content);

                                            tr.appendChild(td_status);
                                            tr.appendChild(td_buttons);
                                        }
                                        searchTableBody.appendChild(tr);
                                    }

                                    if (document.getElementById("applicantsBody") != null) {
                                        if (document.getElementById("applicantsBody").parentNode == document.getElementById("main-table")) {
                                            document.getElementById("main-table").removeChild(document.getElementById("applicantsBody"));
                                            //document.getElementById("applicantsBody").style.display = "none";

                                        }
                                    }
                                    document.getElementById("main-table").appendChild(searchTableBody);
                                }
                            },
                            error: function (request, textStatus, errorThrown) {
                                console.log("Error occured" + errorThrown);
                            }
                        });

                    }

                }
            }

            let $toggle = $('#isactive');
            let toggleStatus = document.getElementById("toggleStatus");
            if (${job.isactive}) {
                $toggle.checkbox('check');
            }

            $toggle.checkbox({
                onChecked: function () {
                    $.ajax({
                        type: "POST",
                        beforeSend: function (request) {
                            request.setRequestHeader(header, token);
                        },
                        url: "/job/${job.id}/activate",
                        data: {message: "text"},
                        success: function (response) {
                            toggleStatus.innerText = "Active  ";
                        },
                        error: function (request, textStatus, errorThrown) {
                            console.log(errorThrown);
                        }
                    });
                },
                onUnchecked: function () {
                    $.ajax({
                        type: "POST",
                        beforeSend: function (request) {
                            request.setRequestHeader(header, token);
                        },
                        url: "/job/${job.id}/deactivate",
                        data: {message: "text"},
                        success: function (response) {
                            toggleStatus.innerText = "Passive";
                        },
                        error: function (request, textStatus, errorThrown) {
                            console.log(errorThrown);
                        }
                    });
                }
            });

            $('table').tablesort();
            let tablesort = $('table.sortable-table').data('tablesort');

            $('#name-asc').click(function () {
                tablesort.sort($("th.name-sort"), 'asc');
            });

            $('#name-desc').click(function () {
                tablesort.sort($("th.name-sort"), 'desc');
            });

            $('#surname-asc').click(function () {
                tablesort.sort($("th.surname-sort"), 'asc');
            });

            $('#surname-desc').click(function () {
                tablesort.sort($("th.surname-sort"), 'desc');
            });

            $('thead th.score-sort').data('sortBy', function (th, td, tablesort) {
                return Number(td.text());
            });

            $('#score-asc').click(function () {
                tablesort.sort($("th.score-sort"), 'asc');
            });

            $('#score-desc').click(function () {
                tablesort.sort($("th.score-sort"), 'desc');
            });

            $('#status-asc').click(function () {
                tablesort.sort($("th.status-sort"), 'asc');
            });

            $('#status-desc').click(function () {
                tablesort.sort($("th.status-sort"), 'desc');
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

            $('#joinBtn').click(function () {
                let joinError = document.getElementById("joinError");
                let para = document.createElement("p");
                let br = document.createElement("br");
                let anchor = document.createElement("a");

                para.innerText = "Restricted User!";
                anchor.setAttribute("href", "/contact");
                anchor.innerText = "Contact Us";
                para.appendChild(br);
                para.appendChild(anchor);

                if ("${userLoggedIn}" == "false") {
                    document.getElementById("joinError").style.visibility = "visible";
                } else if ("${userLoggedIn}" == "true" && ${userBlackListed} == true) {
                    document.getElementById("joinError").style.visibility = "visible";
                    document.getElementById("joinError").innerHTML = para.innerHTML;
                } else if (document.getElementById("inner-joinBtn").getAttribute("class") == "ui disabled button") {
                    // do nothing for now
                } else {
                    $.ajax({
                        type: "POST",
                        beforeSend: function (request) {
                            request.setRequestHeader(header, token);
                        },
                        url: "<spring:url value="/job/application/${job.id}"/>",
                        success: function (response) {
                            let inner_joinBtn = document.getElementById("inner-joinBtn");
                            inner_joinBtn.setAttribute("class", "ui disabled button");
                            inner_joinBtn.innerText = "Applied!";
                            inner_joinBtn.style.cursor = "default";
                            $('#applicationCount').load(document.URL + ' #applicationCount');
                        },
                        error: function (request, textStatus, errorThrown) {
                            alert(errorThrown);
                            console.log("error" + errorThrown);
                        }
                    });

                }
            });

            $(document).on('click', '.acceptBtn', function (event) {
                event.target.setAttribute("class", "ui positive loading button acceptBtn");
                let acceptUrl = "/job/${job.id}/application/" + event.target.value + "/accept";
                $.ajax({
                    type: "POST",
                    beforeSend: function (request) {
                        request.setRequestHeader(header, token);
                    },
                    url: acceptUrl,
                    data: "text",
                    dataType: 'text',
                    success: function (response) {
                        location.reload();
                        //$('#main-list').load(document.URL + ' #main-table');
                    },
                    error: function (request, textStatus, errorThrown) {
                        console.log(errorThrown);
                    }
                });
            });

            $(document).on('click', '.rejectBtn', function (event) {
                event.target.setAttribute("class", "ui negative loading button rejectBtn");
                let rejectUrl = "/job/${job.id}/application/" + event.target.value + "/reject";
                $.ajax({
                    type: "POST",
                    beforeSend: function (request) {
                        request.setRequestHeader(header, token);
                    },
                    url: rejectUrl,
                    data: "text",
                    dataType: 'text',
                    success: function (response) {
                        location.reload();
                        //$('#main-list').load(document.URL + ' #main-table');
                    },
                    error: function (request, textStatus, errorThrown) {
                        console.log(errorThrown);
                    }
                });
            });
        });

</script>


</html>
