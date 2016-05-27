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
<div class="row-fluid">
    <div class="span10 offset1">
        <h1 class="hidden">Welcome to the Atlas of Living Australia website</h1><!-- Show the H1 on each page -->

        <!-- Breadcrumb -->
        <ol class="breadcrumb hidden-print">
            <li><a class="font-xxsmall" href="${grailsApplication.config.organisation.baseUrl}">Home</a><span class="divider">/</span></li>
            <li><a class="font-xxsmall" href="${g.createLink(uri:'/')}">Occurrence Records</a><span class="divider">/</span></li>
            <li class="font-xxsmall active">Download</li>
        </ol>
        <!-- End Breadcrumb -->
        <h2 class="heading-medium">Download</h2>

        <div class="well">
            <div id="grid-view" class="row-fluid">
                <div class="span12">
                    <!-- <h4>Pre-sets Download</h4> -->

                    <div class="panel panel-default">
                        <div class="comment-wrapper push">

                            <div class="row-fluid ">
                                <div class="span2">
                                    <h4 class="heading-medium-alt">Step 1</h4>
                                </div>
                                <div class="span10">
                                    <p>Select your download type below, and then progress to step 2.</p>
                                </div>
                            </div>
                            <div class="row-fluid margin-top-1">
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
                                    <h4 class="text-uppercase=heading-underlined">Occurence records </h4>
                                    <p>
                                        A ZIP archive containing a comma separated values (CSV) file which includes a
                                        subset of location, taxon and event information.
                                    </p>

                                    %{--<p class="separator t-center margin-bottom-2"><span>Download type options</span></p>--}%
                                    <form id="downloadFormatForm" class="form-horizontal hide">
                                        <div class="control-group">
                                            <label for="file" class="control-label">Filename</label>
                                            <div class="controls">
                                                <input type="text" id="file" name="file" value="${filename}" class="input-lg"/>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label for="downloadFormat" class="control-label"><span class="color--mellow-red" style="font-size:18px">*</span>Download format</label>
                                            <div class="controls">
                                                <select class="form-control input-lg" id="downloadFormat">
                                                    <option value="" disabled selected>Select a download format</option>
                                                    <g:each in="${au.org.ala.downloads.DownloadFormat.values()}" var="df">
                                                        <option value="${df.format}"><g:message code="format.${df.format}" /></option>
                                                    </g:each>
                                                </select>
                                                <p class="help-block hide"><strong>This field is mandatory.</strong>  </p>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="span3">
                                    <a href="#" id="select-${au.org.ala.downloads.DownloadType.RECORDS.type}" class="select-download-type btn-bs3 btn-white btn-large btn-block margin-top-1 margin-bottom-1 font-xxsmall" type="button">
                                        <i class="fa fa-check color--white hide"></i><span>Select</span>
                                    </a>
                                </div><!-- End span3 -->
                                <hr class="visible-phone"/>
                            </div><!-- End row -->
                            <div class="row-fluid margin-top-1">
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
                                    <h4 class="text-uppercase=heading-underlined">Species checklist </h4>
                                    <p class="font-xsmall">
                                        A comma separated values (CSV) file, listing the distinct species in the occurrence records
                                        result set.
                                    </p>
                                </div>
                                <div class="span3">

                                    <a href="#" id="select-${au.org.ala.downloads.DownloadType.CHECKLIST.type}" class="select-download-type btn-bs3 btn-white btn-large btn-block margin-top-1 margin-bottom-1 font-xxsmall" type="button">
                                        <i class="fa fa-check color--white hide"></i><span>Select</span>
                                    </a>
                                </div><!-- End span3 -->
                                <hr class="visible-phone"/>
                            </div><!-- End row -->

                            <div class="row-fluid margin-top-1">
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
                                    <h4 class="text-uppercase=heading-underlined">Species field-guide </h4>
                                    <p>
                                        A PDF document containing species profile information (including photos and maps) for the
                                        list of distinct species in the occurrence record set.
                                    </p>
                                </div>
                                <div class="span3">
                                    <a href="#" id="select-${au.org.ala.downloads.DownloadType.FIELDGUIDE.type}" class="select-download-type btn-bs3 btn-white btn-large btn-block margin-top-1 margin-bottom-1 font-xxsmall" type="button">
                                        <i class="fa fa-check color--white hide"></i><span>Select</span>
                                    </a>
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
                                <div class="span2">
                                    <h4 class="heading-medium-alt">Step 2</h4>
                                </div>
                                <div class="span10">
                                    <p>Select your download reason and then click the "Next" button.</p>
                                </div>
                            </div>
                            <div class="row-fluid">
                                <div class="span2">
                                    <div class="contrib-stats">
                                        <div class="no-of-questions">
                                            <div class="survey-details">
                                                <div class="survey-counter"><strong><i class="fa fa-tags color--apple"></i></strong></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="span7">
                                    <form class="form-horizontal margin-top-1">
                                        <div class="form-group">
                                            <label for="downloadReason" class="control-label heading-xsmall"><span class="color--mellow-red">*</span>Industry/application</label>
                                            <div class="controls">
                                                <select class="form-control input-lg" id="downloadReason">
                                                    <option value="" disabled selected>Select a reason ...</option>
                                                    <g:each var="it" in="${downloads.getLoggerReasons()}">
                                                        <option value="${it.id}">${it.name}</option>
                                                    </g:each>
                                                </select>
                                                <p class="help-block"><strong>This field is mandatory.</strong> Choose the best "use type" from the drop-down menu above.</p>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="span3">
                                    <a href="#" id="nextBtn" class="btn btn-large btn-primary btn-block margin-top-1 margin-bottom-1 font-xxsmall" type="button">Next <i class="fa fa-chevron-right color--white"></i></a>
                                </div><!-- End span3 -->
                            </div>
                            <div class="row-fluid">
                                <div class="span12">
                                    <!-- Alert Information -->
                                    <div id="errorAlert" class="alert alert-danger alert-dismissible hide" role="alert">
                                        <button type="button" class="close" onclick="$(this).parent().hide()" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <strong>Error:</strong> Ensure that you 1) select your download <b>type</b><span id="errorFormat" class="hide"> and select a download <b>format</b></span>, 2) select a download <b>reason</b>

                                    </div>
                                    <!-- End Alert Information -->
                                </div>
                            </div><!-- End body -->
                        </div><!-- End comment-wrapper push -->
                    </div>
                </div>
            </div>
        </div>
        <div class="alert alert-info alert-dismissible" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
            By downloading this content you are agreeing to use it in accordance with the Atlas of Living
            Australia <a href="http://www.ala.org.au/about-the-atlas/terms-of-use/#TOUusingcontent">Terms of Use</a>
            and any Data Provider Terms associated with the data download.
        </div>
    </div><!-- /.span10  -->
</div><!-- /.row-fuid  -->
<g:javascript>
    $( document ).ready(function() {
        // click event on download type select buttons
        $('a.select-download-type').click(function(e) {
            e.preventDefault(); // its a link so stop any regular link stuff hapenning
            var link = this;
            if ($(link).hasClass('btn-success')) {
                // already selected so de-select it
                $(link).find('span').text('Select');
                $(link).removeClass('btn-success');
                $(link).addClass('btn-white');
                $(link).find('.fa').addClass('hide');
                $(link).blur(); // prevent BS focus

                if ($(link).attr('id') == "select-${au.org.ala.downloads.DownloadType.RECORDS.type}") {
                    // show type options
                    $('#downloadFormatForm').slideUp();
                }
            } else {
                // not selected
                $('a.select-download-type').find('span').text('Select'); // reset any other selcted buttons
                $('a.select-download-type').removeClass('btn-success'); // reset any other selcted buttons
                $('a.select-download-type').addClass('btn-white'); // reset any other selcted buttons
                $('a.select-download-type').find('.fa').addClass('hide'); // reset any other selcted buttons
                $(link).find('span').text('Selected');
                $(link).removeClass('btn-white');
                $(link).addClass('btn-success');
                $(link).find('.fa').removeClass('hide');
                $(link).blur(); // prevent BS focus

                if ($(link).attr('id') == "select-${au.org.ala.downloads.DownloadType.RECORDS.type}") {
                    // show type options
                    $('#downloadFormatForm').slideDown();
                } else {
                    $('#downloadFormatForm').slideUp();
                    $('#downloadReason').focus();
                }
            }
        });

        // download format change event
        $('#downloadFormat').on('change', function(e) {
            console.log('this selected val', $(this).find(":selected").val());
            if ($(this).find(":selected").val()) {
                // set focus on reason code
                $('#downloadReason').focus();
            }
        });

        // click event on next button
        $('#nextBtn').click(function(e) {
            e.preventDefault();
            // do form validation
            var type = $('.select-download-type.btn-success').attr('id');
            var format = $('#downloadFormat').find(":selected").val();
            var reason = $('#downloadReason').find(":selected").val();
            var file = $('#file').val();
            //alert("format = " + format);
            if (type) {
                type = type.replace(/^select-/,''); // remove prefix
                $('#errorAlert').hide();

                if (type == "${au.org.ala.downloads.DownloadType.RECORDS.type}") {
                    // check for format
                    if (!format) {
                        $('#downloadType').focus();
                        $('#errorAlert').show();
                        $('#errorFormat').show();
                        return false;
                    } else {
                        $('#errorFormat').hide();
                        $('#errorAlert').hide();
                    }
                }

                if (!reason) {
                    $('#errorAlert').show();
                    $('#downloadReason').focus();
                } else {
                    // go to next screen
                    $('#errorAlert').hide();
                    var sourceTypeId = "${downloads.getSourceId()}";
                    window.location = "${g.createLink(action:'options2')}?searchParams=${searchParams.encodeAsURL()}&targetUri=${targetUri.encodeAsURL()}&downloadType=" + type + "&reasonTypeId=" + reason + "&sourceTypeId=" + sourceTypeId + "&downloadFormat=" + format + "&file=" + file;
                }
            } else {
                $('#errorAlert').show();
            }
        });

        var flashMessage = "${flash.message}";
        if (flashMessage) {
            $('#errorAlert').show();
        }

    });
</g:javascript>
</body>
</html>