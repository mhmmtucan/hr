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
    <title>Create New Application</title>

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
          href="${pageContext.request.contextPath}/resources/semantic/components/menu..mincss">
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
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/resources/semantic/components/calendar.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/extra.min.css">

    <style>
        .ck-editor__editable {
            min-height: 400px;
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

        <div class="ui vertical stripe left aligned segment" style="padding-top: 60px;">
            <div class="ui center middle aligned container">
                <h2 style="margin-top: 15px; margin-bottom: 15px;" class="ui header">${jobEvent}</h2>
                <form class="ui form" action="/hr/newJob" method="post" name="job">
                    <div class="hidden field">
                        <input id="id" type="hidden" name="id" placeholder="id" value="${job.id}">
                    </div>
                    <div class="required field">
                        <label>Job Title</label>
                        <input id="title" type="text" name="title" placeholder="Title" value="${job.title}">
                    </div>
                    <div class="required field editable">
                        <label>Job Summary</label>
                        <textarea rows="2" name="summary" id="summary"
                                  placeholder="Short version of description">${job.summary}</textarea>
                    </div>

                    <div class="required field editable">
                        <label>Job Description</label>
                        <textarea name="description" id="description">${job.description}</textarea>

                    </div>
                    <div class="required field">
                        <label>Sufficient Qualifications</label>
                        <select name="qualification" class="ui search selection dropdown" multiple=""
                                id="qualification">
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
                    <div class="required field">
                        <label>Range</label>
                        <div class="ui form">
                            <div class="two fields">
                                <div class="field">
                                    <div class="ui calendar" id="rangestart">
                                        <div class="ui input left icon">
                                            <i class="calendar icon"></i>
                                            <input id="activation_date" name="activation_date" type="text"
                                                   placeholder="Start" value="${job.activation_date}">
                                        </div>
                                    </div>
                                </div>
                                <div class="field">
                                    <div class="ui calendar" id="rangeend">
                                        <div class="ui input left icon">
                                            <i class="calendar icon"></i>
                                            <input id="final_date" name="final_date" type="text" placeholder="End"
                                                   value="${job.final_date}">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                    <div class="ui olive mini message">
                        <i class="close icon"></i>
                        <div class="header">
                            Active Job
                        </div>
                        <p>Activating job makes it visible to everyone. The dates which job is seen can be adjusted with
                            date range. Even if date range is selected, job should be activated in order to be
                            shown.</p>
                    </div>

                    <div class="inline field">
                        <div id="isactive" class="ui toggle checkbox">
                            <label>Activate job</label>
                            <input name="isactive" type="checkbox">
                        </div>
                    </div>

                    <div class="required inline field">
                        <div class="ui checkbox">
                            <input id="terms" type="checkbox" tabindex="0" class="hidden">
                            <label>I agree to the <a href="/terms">terms and conditions</a></label>
                        </div>
                    </div>


                    <button class="ui green submit button" type="submit">Submit</button>
                    <div class="ui button" id="cancelBtn">Cancel</div>

                    <div class="ui success small message">
                        <div class="header">Form Completed</div>
                        <p>Job created.</p>
                    </div>
                    <div class="ui error message"></div>
                </form>
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
<script src="${pageContext.request.contextPath}/resources/semantic/components/search.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/semantic/semantic.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/semantic/components/form.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/semantic/components/dropdown.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/semantic/components/calendar.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/ckeditor.js"></script>
<script>
    $(document)
        .ready(function () {
            const token = $('#_csrf').attr('content');
            const header = $('#_csrf_header').attr('content');
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

            let $toggle = $('#isactive');
            if (${jobisactive}) {
                $toggle.checkbox('check');
            }

            $('#cancelBtn').on('click', function () {
                window.location.href = "/job/${job.id}";
            });

            let qualification = "${job.qualification}";
            let qualifications = qualification.split(',');
            $('#qualification').dropdown('set selected', qualifications);

            $('.message .close')
                .on('click', function () {
                    $(this)
                        .closest('.message')
                        .transition('fade');
                });

            ClassicEditor.create(document.querySelector('#description'), {
                cloudServices: {
                    tokenUrl: 'https://33904.cke-cs.com/token/dev/xtVHNwHerveZ9fkBxwR9jtsxzkqHouqJUVg533FcKCy9UUhIJdQwm8rEk97d',
                    uploadUrl: 'https://33904.cke-cs.com/easyimage/upload/'
                }
            });

            $('.ui.form')
                .form({
                    fields: {
                        title: {
                            identifier: 'title',
                            rules: [
                                {
                                    type: 'empty',
                                    prompt: 'Please enter job title'
                                },
                                {
                                    type: 'maxLength[60]',
                                    prompt: 'Please enter at most 60 characters'
                                }
                            ]
                        },
                        summary: {
                            identifier: 'summary',
                            rules: [
                                {
                                    type: 'empty',
                                    prompt: 'Please enter job summary'
                                },
                                {
                                    type: 'maxLength[250]',
                                    prompt: 'Summary should be summary'
                                }
                            ]
                        },
                        description: {
                            identifier: 'description',
                            rules: [
                                {
                                    type: 'empty',
                                    prompt: 'Please enter job description'
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
                        activation_date: {
                            identifier: 'activation_date',
                            rules: [
                                {
                                    type: 'empty',
                                    prompt: 'Please enter an activation date'
                                }
                            ]
                        },
                        final_date: {
                            identifier: 'final_date',
                            rules: [
                                {
                                    type: 'empty',
                                    prompt: 'Please enter job final date'
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


            let $rangestart = $('#rangestart');
            let $rangeend = $('#rangeend');

            $rangestart.calendar({
                type: 'date',
                today: true,
                minDate: new Date(),
                monthFirst: false,
                formatter: {
                    date: function (date, settings) {
                        if (!date) return '';
                        let day = date.getDate() + '';
                        if (day.length < 2) {
                            day = '0' + day;
                        }
                        let month = (date.getMonth() + 1) + '';
                        if (month.length < 2) {
                            month = '0' + month;
                        }
                        let year = date.getFullYear();
                        return day + '-' + month + '-' + year;
                    }
                },
                endCalendar: $rangeend
            });

            $rangeend.calendar({
                type: 'date',
                monthFirst: false,
                formatter: {
                    date: function (date, settings) {
                        if (!date) return '';
                        let day = date.getDate() + '';
                        if (day.length < 2) {
                            day = '0' + day;
                        }
                        let month = (date.getMonth() + 1) + '';
                        if (month.length < 2) {
                            month = '0' + month;
                        }
                        let year = date.getFullYear();
                        return day + '-' + month + '-' + year;
                    }
                },
                startCalendar: $rangestart
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
