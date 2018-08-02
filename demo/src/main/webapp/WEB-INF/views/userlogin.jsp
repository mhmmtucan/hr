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
    <title>Complete User Details</title>

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
          href="${pageContext.request.contextPath}/resources/semantic/components/divider.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/components/dropdown.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/components/segment.min.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/components/button.min.css">
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
    <div class="ui vertical masthead center aligned segment">
        <jsp:include page="templates/main_menu.jsp">
            <jsp:param name="hrId" value='<%= session.getAttribute("hrId") %>'/>
            <jsp:param name="userId" value='<%= session.getAttribute("userId") %>'/>
        </jsp:include>


        <div class="ui left aligned text container">
            <div>
                <img src="${pictureURL}">
            </div>
            <form class="ui form" action="/user/details/complete" method="post" name="user">
                <div class="two fields">
                    <div class="required field">
                        <label>Name</label>
                        <input id="name" type="text" name="name" placeholder="Name" value="${name}">
                    </div>

                    <div class="required field">
                        <label>Surname</label>
                        <input id="surname" type="text" name="surname" placeholder="Surname" value="${surname}">
                    </div>
                </div>
                <div class="two fields">
                    <div class="required field">
                        <label>Headline</label>
                        <input id="title" type="text" name="title" placeholder="Headline" value="${title}">
                    </div>
                    <div class="required field">
                        <label>Work experience (years) </label>
                        <input id="experience" type="text" name="experience" placeholder="Number of years"
                               value="${experience}">
                    </div>
                </div>

                <div class="three fields">
                    <div class="required field">
                        <label>University</label>
                        <input id="university" type="text" name="university" placeholder="University"
                               value="${university}">
                    </div>

                    <div class="required field">
                        <label>Department</label>
                        <input id="department" type="text" name="department" placeholder="Department"
                               value="${department}">
                    </div>

                    <div class="required field">
                        <label>GPA</label>
                        <input id="gpa" type="text" name="gpa" placeholder="GPA" value="${gpa}">
                    </div>
                </div>

                <div class="field">
                    <label>High School</label>
                    <input id="highschool" type="text" name="highschool" placeholder="High School"
                           value="${highschool}">
                </div>



                <div class="required field">
                    <label>Select Qualifications</label>
                    <select name="qualification" class="ui search selection dropdown" multiple="" id="qualification">
                        <option value="">Choose Qualifications</option>
                        <option value="adobe-illustrator">Adobe Illustrator</option>
                        <option value="adobe-photoshop">Adobe Photoshop</option>
                        <option value="agile-development">Agile Development</option>
                        <option value="android">Android</option>
                        <option value="assembly">Assembly</option>
                        <option value="c">C</option>
                        <option value="cplusplus">C++</option>
                        <option value="csharp">C#</option>
                        <option value="css">CSS</option>
                        <option value="data-analysis">Data Analysis</option>
                        <option value="delphi">Delphi</option>
                        <option value="digital-marketing">Digital Marketing</option>
                        <option value="elixir">Elixir</option>
                        <option value="go">Go</option>
                        <option value="graphic-design">Graphic Design</option>
                        <option value="html">HTML</option>
                        <option value="ios">iOS</option>
                        <option value="java">Java</option>
                        <option value="javascript">JavaScript</option>
                        <option value="kanban">Kanban</option>
                        <option value="kotlin">Kotlin</option>
                        <option value="machine-learning">Machine Learning</option>
                        <option value="matlab">MATLAB</option>
                        <option value="microsoft-excel">Microsoft Excel</option>
                        <option value="microsoft-word">Microsoft Word</option>
                        <option value="nosql">NoSql</option>
                        <option value="node.js">Node.js</option>
                        <option value="object-oriented-programming">Object-Oriented Programming</option>
                        <option value="php">PHP</option>
                        <option value="python">Python</option>
                        <option value="r">R</option>
                        <option value="react">React</option>
                        <option value="react-native">React Native</option>
                        <option value="ruby">Ruby</option>
                        <option value="sap-products">SAP Prodcuts</option>
                        <option value="sql">SQL</option>
                        <option value="scrum">Scrum</option>
                        <option value="sketch">Sketch</option>
                        <option value="software-development">Software Development</option>
                        <option value="swift">Swift</option>
                        <option value="ruby">Ruby</option>
                        <option value="visual-basic">Visiual Basic</option>
                        <option value="web-development">Web Development</option>
                        <option value="web-services">Web Services</option>
                        <option value="wordpress">Wordpress</option>
                    </select>
                </div>

                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                <div class="required inline field">
                    <div class="ui checkbox">
                        <input id="terms" type="checkbox" tabindex="0" class="hidden">
                        <label>I agree to the <a href="/terms">terms and conditions</a></label>
                    </div>
                </div>
                <button class="ui button" type="submit">Submit</button>
                <div class="ui button" id="cancelEditBtn">Cancel</div>

                <div class="ui success small message">
                    <div class="header">Form Completed</div>
                </div>
                <div class="ui error message"></div>
            </form>
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
<script src="${pageContext.request.contextPath}/resources/semantic/components/search.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/semantic/semantic.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/semantic/components/form.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/semantic/components/dropdown.min.js"></script>
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


            $('.ui.checkbox').checkbox();

            $('#cancelEditBtn').on('click', function () {
                window.location.href = "/user/profile/" + "<%=session.getAttribute("userId")%>";
            });

            let qualification = "${qualifications}";
            let qualifications = qualification.split(',');
            $('#qualification').dropdown('set selected', qualifications);

            $('.ui.form')
                .form({
                    fields: {
                        name: {
                            identifier: 'name',
                            rules: [
                                {
                                    type: 'empty',
                                    prompt: 'Please enter name'
                                }
                            ]
                        },
                        surname: {
                            identifier: 'surname',
                            rules: [
                                {
                                    type: 'empty',
                                    prompt: 'Please entersurname'
                                }
                            ]
                        },
                        title: {
                            identifier: 'title',
                            rules: [
                                {
                                    type: 'empty',
                                    prompt: 'Please enter current work title or student'
                                }
                            ]
                        },
                        university: {
                            identifier: 'university',
                            rules: [
                                {
                                    type: 'empty',
                                    prompt: 'Please enter university'
                                }
                            ]
                        },
                        department: {
                            identifier: 'department',
                            rules: [
                                {
                                    type: 'empty',
                                    prompt: 'Please enter department of university'
                                }
                            ]
                        },
                        gpa: {
                            identifier: 'gpa',
                            rules: [
                                {
                                    type: 'empty',
                                    prompt: 'Please enter gpa'
                                }
                            ]
                        },
                        experience: {
                            identifier: 'experience',
                            rules: [
                                {
                                    type: 'empty',
                                    prompt: 'Please enter the number of years at work'
                                }
                            ]
                        },
                        qualification: {
                            identifier: 'qualification',
                            rules: [
                                {
                                    type: 'minCount[2]',
                                    prompt: 'Please select at least two skills'
                                }
                            ]
                        },
                        terms: {
                            identifier: 'terms',
                            rules: [
                                {
                                    type: 'checked',
                                    prompt: 'You must agree terms and conditions'
                                }
                            ]
                        }
                    }
                })
            ;


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
