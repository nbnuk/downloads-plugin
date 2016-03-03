%{--
  - Copyright (C) 2016 Atlas of Living Australia
  - All Rights Reserved.
  - The contents of this file are subject to the Mozilla Public
  - License Version 1.1 (the "License"); you may not use this file
  - except in compliance with the License. You may obtain a copy of
  - the License at http://www.mozilla.org/MPL/
  - Software distributed under the License is distributed on an "AS
  - IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
  - implied. See the License for the specific language governing
  - rights and limitations under the License.
  --}%

<%--
  Created by IntelliJ IDEA.
  User: dos009@csiro.au
  Date: 22/02/2016
  Time: 1:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <meta name="fluidLayout" content="false"/>
    <title>ALA Data Download</title>
    <r:require module="download"/>
</head>
<body>
<div class="row">
    <div class="span10">
        <h1 class="hidden">Welcome to the Atlas of Living Australia website</h1><!-- Show the H1 on each page -->

    <!-- Breadcrumb -->
        <ol class="breadcrumb hidden-print">
            <li><a class="font-xxsmall" href="${grailsApplication.config.organisation.baseUrl}">Home</a><span class="divider">/</span></li>
            <li><a class="font-xxsmall" href="${g.createLink(uri:'/')}">Occurrence Records</a><span class="divider">/</span></li>
            <!-- <li><a class="font-xxsmall" href="#">Long page title example</a></li> -->
            <!-- <li><a class="font-xxsmall" href="#">What a great redesign</a></li> -->
            <li class="font-xxsmall active">Downloads</li>
        </ol>
        <!-- End Breadcrumb -->
        <h2 class="heading-medium">Download</h2>

        <div class="well">
            <div id="grid-view" class="row-fluid">
                <div class="span12">
                    <!-- <h4>Pre-sets Download</h4> -->

                    <div class="panel panel-default">
                        <div class="comment-wrapper push">

                            <div class="row-fluid">
                                <div class="span12">
                                    <h4 class="heading-medium-alt">Step 1</h4>
                                    <p>
                                        Select your download type from 1 of the 3 options below, and then progress to step 2.
                                    </p>
                                </div>
                            </div>
                            <div class="row-fluid">
                                <div class="span2">
                                    <div class="contrib-stats">
                                        <div class="no-of-questions">
                                            <div class="survey-details">
                                                <div class="survey-counter"><strong><i class="fa fa-table color--yellow"></i></strong></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="span7">
                                    <h4 class="text-uppercase heading-underlined">Basic occurance download</h4>
                                    <p>
                                        A basic Darwin Core Occurrence record including a subset of location, taxon and event information.
                                    </p>

                                    <p class="separator t-center margin-bottom-2"><span>Download type options</span></p>
                                    <form class="form-horizontal">
                                        <div class="form-group">
                                            <label for="inputEmail3" class="span3 control-label heading-small"><span class="color--mellow-red">*</span>Select type</label>
                                            <div class="span8">
                                                <select class="form-control input-lg" required="" autofocus="">
                                                    <option>Full Darwin Core</option>
                                                    <option>Legacy Format Occurrence</option>
                                                    <option>Customise Your Download</option>
                                                    <!-- <option>Problem logging and feedback</option> -->
                                                </select>
                                                <p class="help-block"><strong>This field is mandatory.</strong> Use the dropdown to select the relevant download type.</p>
                                            </div>
                                        </div>
                                    </form>

                                </div>
                                <div class="span3">
                                    <a href="#" id="select-basic-dwc" class="select-download-type btn-bs3 btn-white btn-large btn-block margin-top-1 margin-bottom-1 font-xxsmall" type="button">
                                        Select
                                    </a>
                                    <!-- <a href="#" class="btn btn-large btn-success btn-block margin-bottom-1 font-xxsmall" type="button">Customise</a> -->
                                </div><!-- End span3 -->
                            </div><!-- End row -->

                            <div class="row-fluid">
                                <div class="span2">
                                    <div class="contrib-stats">
                                        <div class="no-of-questions">
                                            <div class="survey-details">
                                                <div class="survey-counter"><strong><i class="fa fa-list-alt color--apple"></i></strong></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="span7">
                                    <h4 class="text-uppercase heading-underlined">Species Checklist Download</h4>
                                    <p class="font-xsmall">
                                        The list of taxa in the occurrence record record set. Each individual species is only listed once.
                                    </p>
                                </div>
                                <div class="span3">

                                    <a href="#" id="select-checklist" class="select-download-type btn-bs3 btn-white btn-large btn-block margin-top-1 margin-bottom-1 font-xxsmall" type="button">
                                        Select
                                    </a>
                                    <!-- <a href="#" class="btn btn-large btn-success btn-block margin-bottom-1 font-xxsmall" type="button">Customise</a> -->
                                </div><!-- End span3 -->
                            </div><!-- End row -->

                            <div class="row-fluid">
                                <div class="span2">
                                    <div class="contrib-stats">
                                        <div class="no-of-questions">
                                            <div class="survey-details">
                                                <div class="survey-counter"><strong><i class="fa fa-file-pdf-o color--mellow-red"></i></strong></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="span7">
                                    <h4 class="text-uppercase heading-underlined">Species Field-Guide Download</h4>
                                    <p>
                                        A document containing species profile information for the taxa in the occurrence record set.  Each individual species is only listed once.
                                    </p>
                                </div>
                                <div class="span3">

                                    <a href="#" id="select-basic-fieldguide" class="select-download-type btn-bs3 btn-white btn-large btn-block margin-top-1 margin-bottom-1 font-xxsmall" type="button">
                                        Select
                                    </a>
                                    <!-- <a href="#" class="btn btn-large btn-success btn-block margin-bottom-1 font-xxsmall" type="button">Customise</a> -->
                                </div><!-- End span3 -->
                            </div><!-- End row -->
                        </div><!-- End comment-wrapper push -->
                    </div>
                </div>
            </div>
        </div>
        <div class="well">
            <div class="row-fluid">
                <div class="span12">
                    <!-- <h4>Species Download</h4> -->
                    <div class="panel panel-default">
                        <div class="comment-wrapper push">
                            <div class="row-fluid">
                                <div class="span12">
                                    <h4 class="heading-medium-alt">Step 2</h4>
                                    <p>
                                        Select your download reason and then select the Queue Download button to begin your download.
                                    </p>
                                </div>
                            </div>
                            <div class="row-fluid">
                                <div class="span2">
                                    <div class="contrib-stats">
                                        <div class="no-of-questions">
                                            <div class="survey-details">
                                                <div class="survey-counter"><strong><i class="fa fa-download color--apple"></i></strong></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="span7">
                                    <!-- <h4 class="text-uppercase heading-underlined">Species Checklist Download</h4>
                        <p class="font-xsmall">
                          The list of taxa in the occurrence record record set. Each individual species is only listed once.
                        </p>

                        <p class="separator t-center margin-bottom-2"><span>Download reason</span></p> -->

                                    <form class="form-horizontal margin-top-1">
                                        <div class="form-group">
                                            <label for="inputEmail3" class="span3 control-label heading-medium"><span class="color--mellow-red">*</span>Tell us why</label>
                                            <div class="span8">
                                                <select class="form-control input-lg" required="true" autofocus>
                                                    <option>Select a reason ...</option>
                                                    <option>Option 1</option>
                                                    <option>Option 2</option>
                                                    <option>Option 3</option>
                                                </select>
                                                <p class="help-block"><strong>This field is mandatory.</strong> To queue your download, tell us why you are downloading this file.</p>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="span3">

                                    <a href="#" class="btn btn-large btn-primary btn-block margin-top-1 margin-bottom-1 font-xxsmall" type="button">Queue Download</a>

                                </div><!-- End span3 -->
                            </div>
                            <div class="row-fluid">
                                <div class="span12">
                                    <!-- Alert Information -->
                                    <div class="alert alert-danger alert-dismissible" role="alert">
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <strong>Error:</strong> Ensure that you 1) select your download type, 2) tell us why and 3) queue the download.
                                    </div>
                                    <!-- End Alert Information -->
                                </div>
                            </div><!-- End body -->
                        </div><!-- End comment-wrapper push -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<g:javascript>
    $( document ).ready(function() {
        $('a.select-download-type').click(function(e) {
            e.preventDefault(); // its link so stop any regular link stuff hapenning
            var link = this;
            if ($(link).hasClass('btn-primary')) {
                // already selected
                $(link).text('Select');
                $(link).removeClass('btn-primary');
                $(link).addClass('btn-white');
                $(link).blur(); // prevent BS focus
            } else {
                // not selected
                $('a.select-download-type').text('Select'); // reset any other selcted buttons
                $('a.select-download-type').removeClass('btn-primary'); // reset any other selcted buttons
                $('a.select-download-type').addClass('btn-white'); // reset any other selcted buttons
                $(link).text('Selected');
                $(link).removeClass('btn-white');
                $(link).addClass('btn-primary');
                $(link).blur(); // prevent BS focus
            }
        });

    });
</g:javascript>
</body>
</html>