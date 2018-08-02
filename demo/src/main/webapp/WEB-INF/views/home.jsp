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
    <title>Join A Company</title>
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
          href="${pageContext.request.contextPath}/resources/semantic/components/transition.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/extra.min.css">

    <style>
        .landing-image {
            background-image: url('${pageContext.request.contextPath}/resources/img/background.png') !important;
            background-size: cover !important;
            background-position: right bottom !important;
            background-repeat: no-repeat !important;
        }

        .card {
            border-radius: 6px !important;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.13), 0 6px 6px rgba(0, 0, 0, 0.20) !important;
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
    <div class="ui vertical fullscreen masthead left aligned segment landing-image">
        <jsp:include page="templates/main_menu.jsp">
            <jsp:param name="hrId" value='<%= session.getAttribute("hrId") %>'/>
            <jsp:param name="userId" value='<%= session.getAttribute("userId") %>'/>
        </jsp:include>

        <div class="ui left aligned container">
            <h1 style="margin-top: 130px;" class="ui header">
                Imagine-a-<span id="typed"></span>
            </h1>
            <h2>Do whatever you want when you want to.</h2>
            <div class="row">
                <div class="column">
                    <div class="ui huge form">
                        <div class="two fields">
                            <div class="ui icon field">
                                <input id="homeSearchText" placeholder="Search Your Dream Job or Company..."
                                       type="text" style="max-width: 700px !important;margin-left: 0px !important;">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="searchResults" class="ui middle aligned selection list" style="width: 50%;">
            </div>


        </div>
    </div>

    <div class="ui grid" style="margin-top: 120px;">
        <div class="row" style="margin-left: 120px;">
            <h2 class="ui left aligned header">
                <i class="magnet icon" style="font-size: 1.0em;"></i>
                <div class="content">
                    Featured Jobs
                </div>
            </h2>
        </div>
        <div class="centered row">
            <div class="ui equal width center aligned grid">
                <c:forEach items="${featuredJobs}" var="job">
                    <div class="column">
                        <a class="ui card" href="/job/${job.id}">
                            <div class="left aligned content">
                                <div class="header" style="height: 46px;">${job.title}</div>
                                <div class="meta">
                                    <span class="category">Active until ${job.final_date}</span>
                                </div>
                                <div class="description" style="height: 120px;">
                                    <p>${job.summary}</p>
                                </div>
                            </div>
                            <div class="extra content">
                                <div class="right floated author">
                                    <img class="ui mini right spaced rounded image"
                                         src="${pageContext.request.contextPath}/resources/img/company/big/${job.company}.png"> ${job.hr.company}
                                </div>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </div>

        </div>

        <div class="row" style="margin-top: 25px;">
            <div class="column center aligned">
                <div id="allJobs" class="center aligned column">
                    <a class="ui huge button">Show All Jobs</a>
                </div>
            </div>

        </div>
    </div>

    <div class="ui vertical stripe segment">
        <div class="ui middle aligned stackable grid container">
            <div class="row">
                <div class="eight wide column">
                    <h3 class="ui header">We Help Companies and Companions</h3>
                    <p>We can give your company superpowers to do things that they never thought possible. Let us
                        delight your customers and empower your needs...through pure data analytics.</p>
                    <h3 class="ui header">We Make Bananas That Can Dance</h3>
                    <p>Yes that's right, you thought it was the stuff of dreams, but even bananas can be
                        bioengineered.</p>
                </div>
                <div class="six wide right floated column">
                    <img src="${pageContext.request.contextPath}/resources/img/suit.jpg"
                         class="ui large bordered rounded image">
                </div>
            </div>
            <div class="row">
                <div class="center aligned column">
                    <a class="ui huge button">Check Them Out</a>
                </div>
            </div>
        </div>
    </div>


    <div class="ui vertical stripe quote segment">
        <div class="ui equal width stackable internally celled grid">
            <div class="center aligned row">
                <div class="column">
                    <h3>"What a Company"</h3>
                    <p>That is what they all say about us</p>
                </div>
                <div class="column">
                    <h3>"I shouldn't have gone with their competitor."</h3>
                    <p>
                        <img src="${pageContext.request.contextPath}/resources/img/people/person1.jpg"
                             class="ui avatar image"> <b>Nan</b>
                        Chief Fun Officer Acme Toys
                    </p>
                </div>
            </div>
        </div>
    </div>

    <div class="ui vertical stripe segment">
        <div class="ui text container">
            <h3 class="ui header">Breaking The Grid, Grabs Your Attention</h3>
            <p>Instead of focusing on content creation and hard work, we have learned how to master the art of doing
                nothing by providing massive amounts of whitespace and generic content that can seem massive, monolithic
                and worth your attention.</p>
            <a class="ui large button">Read More</a>
            <h4 class="ui horizontal header divider">
                <a href="#">Case Studies</a>
            </h4>
            <h3 class="ui header">Did We Tell You About Our Bananas?</h3>
            <p>Yes I know you probably disregarded the earlier boasts as non-sequitur filler content, but its really
                true. It took years of gene splicing and combinatory DNA research, but our bananas can really dance.</p>
            <a class="ui large button">I'm Still Quite Interested</a>
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
<script src="${pageContext.request.contextPath}/resources/js/typed.min.js"></script>
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

            // create sidebar and attach to menu open
            $('#allJobs').click(function () {
                window.location.href = "/job/page/1";
            });


            let typed = new Typed('#typed', {
                strings: ['Company', 'Future', 'Life', 'Hobby', 'Day', 'Job'],
                typeSpeed: 100,
                backSpeed: 70,
                backDelay: 1200,
                startDelay: 300,
                loop: true
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

            let homeSearchText = document.getElementById('homeSearchText');
            homeSearchText.onkeydown = (function (event) {
                if (event.keyCode == 13) {
                    if (homeSearchText.value != "") {
                        $.ajax({
                            type: "POST",
                            beforeSend: function (request) {
                                request.setRequestHeader(header, token);
                            },
                            url: "<spring:url value="/search/job"/>",
                            data: homeSearchText.value,
                            dataType: 'json',
                            success: function (response) {
                                if (response.result == "0") {
                                    document.getElementById("searchResults").innerText = response.jobs;
                                } else {
                                    let searchResults = document.getElementById("searchResults");

                                    while (searchResults.firstChild) {
                                        searchResults.removeChild(searchResults.firstChild);
                                    }
                                    console.log(response);
                                    for (let i = 0; i < response.jobs.length; i++) {
                                        let itemDiv = document.createElement("div");
                                        itemDiv.setAttribute("class", "item");

                                        let contentDiv = document.createElement("div");
                                        contentDiv.setAttribute("class", "content");

                                        let aHeader = document.createElement("a");
                                        aHeader.setAttribute("class", "header");

                                        contentDiv.appendChild(aHeader);
                                        itemDiv.appendChild(contentDiv);

                                        aHeader.innerText = response.jobs[i].title + " - " + response.jobs[i].hr.company;
                                        aHeader.setAttribute("href", "/job/" + response.jobs[i].id);

                                        searchResults.appendChild(itemDiv);
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

        });

</script>

</html>
