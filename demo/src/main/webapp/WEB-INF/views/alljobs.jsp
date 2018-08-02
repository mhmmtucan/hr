<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
    <!-- Standard Meta -->
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
    <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>

    <!-- Site Properties -->
    <title>Jobs</title>
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
          href="${pageContext.request.contextPath}/resources/semantic/components/search.min.css">
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
          href="${pageContext.request.contextPath}/resources/semantic/components/message.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/components/transition.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/components/form.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/extra.min.css">


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

        <div class="ui text left aligned container" style="margin-bottom: 75px;">

            <div class="row" style="margin-top: 40px;margin-bottom: 40px;">
                <div class="column">
                    <div class="ui huge form">
                        <div class="ui icon field">
                            <input id="allJobSearchText" placeholder="Search Your Dream Job or Company..." type="text">
                        </div>
                    </div>
                </div>
            </div>

            <div class="ui warning message" style="display: none">
                <i class="close icon"></i>
                <div class="header">
                    All Jobs Viewed!
                </div>
                Please reconsider unreviewed job postings. Click Next Page button for returning beginning of list.
            </div>


            <div id="allItems" class="ui divided items">
                <c:forEach items="${activeJobs}" var="job">

                    <div class="item">
                        <div class="image" style="display:flex;align-items:center;justify-content:center;">
                            <img src="${pageContext.request.contextPath}/resources/img/company/centered/${job.company}.png">
                        </div>

                        <div class="content">
                            <a href="/job/${job.id}" class="header">${job.title}</a>

                            <div class="meta">
                                <span class="cinema">${job.activation_date} / ${job.final_date}</span>
                            </div>

                            <div class="description">
                                <p>${job.summary}</p>
                            </div>

                            <div class="extra">
                                <c:forEach items="${job.qualificationList}" var="qual">
                                    <div class="ui label">${qual}</div>
                                </c:forEach>
                            </div>

                        </div>
                    </div>


                </c:forEach>
            </div>

            <div id="allJobSearchResults" class="ui divided items" style="display: none;">
            </div>

            <c:if test="${isPagination == true}">
                <div id="pageBtns">
                    <form action="/job/page/${pageNumber+1}" method="post" style="float: right">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <button id="nextPageBtn" name="nextPageBtn" class="ui right labeled icon button" type="submit">
                            <i class="right arrow icon"></i>Next Page
                        </button>
                    </form>
                    <c:if test="${pageNumber > 1}">
                        <form action="/job/page/${pageNumber-1}" method="post" style="float: right">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <button id="prevPageBtn" name="prevPageBtn" class="ui right labeled icon button"
                                    type="submit"><i class="left arrow icon"></i>Prev Page
                            </button>
                        </form>
                    </c:if>
                </div>
            </c:if>
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
<script src="${pageContext.request.contextPath}/resources/semantic/components/sidebar.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/semantic/components/transition.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/semantic/components/search.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/semantic/semantic.min.js"></script>
<script>
    $(document)
        .ready(function () {
            // fix menu when passed
            let token = $('#_csrf').attr('content');
            let header = $('#_csrf_header').attr('content');
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

            if (${maxJobReached == true}) {
                $('.ui.warning.message').attr("style", "display:block");
            }

            let jobSearch = document.getElementById("allJobSearchText");
            let allItems = document.getElementById("allItems");
            let allJobSearchResults = document.getElementById("allJobSearchResults");
            let pageBtns = document.getElementById("pageBtns");

            jobSearch.onkeyup = (function (event) {
                let charCode = event.keyCode;
                let url = "/search/job";
                let data = jobSearch.value;

                if (data == "") {
                    // remove search results from screen
                    // show all items
                    allItems.style.display = "block";
                    allJobSearchResults.style.display = "none";
                    pageBtns.style.display = "block";

                } else {
                    if (event.keyCode == 13) {
                        allItems.style.display = "none";
                        allJobSearchResults.style.display = "block";
                        pageBtns.style.display = "none";

                        while (allJobSearchResults.firstChild) {
                            allJobSearchResults.removeChild(allJobSearchResults.firstChild)
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
                                if (response.result == 0) {
                                    // show empty results
                                } else {
                                    console.log(response);
                                    // populate with data

                                    for (let i = 0; i < response.jobs.length; i++) {
                                        let item = document.createElement("div");
                                        item.setAttribute("class", "item");

                                        let image = document.createElement("div");
                                        image.setAttribute("class", "image");
                                        let img = document.createElement("img");
                                        img.setAttribute("src", "${pageContext.request.contextPath}/resources/img/company/centered/" + response.jobs[i].company + ".png");
                                        image.appendChild(img);

                                        let content = document.createElement("div");
                                        content.setAttribute("class", "content");

                                        let header = document.createElement("a");
                                        header.setAttribute("class", "header");
                                        header.setAttribute("href", "/job/" + response.jobs[i].id);
                                        header.innerText = response.jobs[i].title;

                                        let meta = document.createElement("div");
                                        meta.setAttribute("class", "meta");

                                        let span = document.createElement("span");
                                        span.setAttribute("class", "cinema");
                                        span.innerText = response.jobs[i].activation_date + " / " + response.jobs[i].final_data;
                                        meta.appendChild(span);

                                        let description = document.createElement("div");
                                        description.setAttribute("class", "description");

                                        let para = document.createElement("p");
                                        para.innerText = response.jobs[i].summary;
                                        description.appendChild(para);

                                        let extra = document.createElement("div");
                                        extra.setAttribute("class", "extra");

                                        for (let j = 0; j < response.jobs[i].qualificationList.length; j++) {
                                            let label = document.createElement("div");
                                            label.setAttribute("class", "ui label");
                                            label.innerText = response.jobs[i].qualificationList[j];
                                            extra.appendChild(label);
                                        }

                                        item.appendChild(image);
                                        content.appendChild(header);
                                        content.appendChild(meta);
                                        content.appendChild(description);
                                        content.appendChild(extra);
                                        item.appendChild(content);

                                        allJobSearchResults.appendChild(item);
                                    }

                                }
                            },
                            error: function (request, textStatus, errorThrown) {
                                console.log("Error occured" + errorThrown);
                            }
                        });
                    }
                }
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
