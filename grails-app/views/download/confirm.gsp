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
<%@ page import="grails.converters.JSON" contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <meta name="fluidLayout" content="false"/>
    <title>ALA Data Download</title>
    <r:require module="download"/>
    <style type="text/css">
        a h4 > .fa {
            width: 18px;
            margin-right: 5px;
            color:#9A9A9A;
        }
        a h4 {
            font-size: 16px;
        }
        .list-group-item {
            padding:5px 0px;
        }
        .margin-top-1 {
            margin-top: 2em;
        }
        textarea {
            width: 100%;
        }
        .progress {
            height: 12px;
            margin-bottom: 10px;
        }

    </style>
</head>
<body>
<div class="row">
    <div class="span4 offset4">
        <h1 class="hidden">Welcome to the Atlas of Living Australia website</h1><!-- Show the H1 on each page -->
        <!-- downloadParams = ${downloadParams as grails.converters.JSON} -->
        <!-- Breadcrumb -->
        <ol class="breadcrumb hidden-print">
            <li><a class="font-xxsmall" href="${grailsApplication.config.organisation.baseUrl}">Home</a><span class="divider">/</span></li>
            <li><a class="font-xxsmall" href="${g.createLink(uri:'/')}">Occurrence Records</a><span class="divider">/</span></li>
            <li class="font-xxsmall active">Download</li>
        </ol>
        <!-- End Breadcrumb -->

        <div class="well">
            <div class="row-fluid">
                <div class="span12">
                    <div class="logo-brand">
                        <div class="font-awesome-icon-large">
                            <i class="fa fa-check-circle color--apple"></i>
                        </div>
                        <h2 class="heading-medium-large"> <g:message code="download.confirm.thanks" default="Thank you for your download"/></h2>
                        <p class="lead">
                            <g:if test="${isQueuedDownload && json}">
                                <g:message code="download.confirm.queued" default="Your download is now being queued"/>
                            </g:if>
                            <g:elseif test="${isFieldGuide && downloadUrl}">
                                <g:message code="download.confirm.ready" default="Your field guide is ready"/>
                            </g:elseif>
                            <g:else>
                                <g:message code="download.confirm.started" default="Your download has completed"/>
                            </g:else>
                        </p>
                        <p>
                            <g:if test="${isQueuedDownload && json}">
                                <g:message code="download.confirm.emailed" default="An email containing a link to the download file will be sent to your email address (linked to your ALA account) when it is completed."/>
                                <div class="progress active">
                                    <div class="bar" style="width: 100%;"></div>
                                </div>
                                <div id="queueStatus"></div>
                            </g:if>
                            <g:elseif test="${isFieldGuide && downloadUrl}">
                                <button id="fieldguideBtn" class="btn btn-large btn-success btn-block"><g:message code="download.confirm.browser" default="View the field guide (new window)"/></button>
                            </g:elseif>
                            <g:elseif test="${isChecklist && downloadUrl}">
                                <g:message code="download.confirm.browser" default="Check your downloads folder or your browser's downloads window."/>
                            </g:elseif>
                            <g:else>
                                <g:message code="download.confirm.completed" default="The download has already been run. Click the button below to start over."/>
                            </g:else>
                        </p>
                        <p>&nbsp;</p>
                    </div>
                    <a href="${downloadParams.targetUri}${downloadParams.searchParams}" class="btn btn-primary btn-block margin-bottom-1 font-xxsmall"
                           type="button"><g:message code="download.confirm.returnToSearch" default="Return to search results"/></a>
                    <g:if test="${isQueuedDownload && json}">
                        <button class="btn btn-link btn-block margin-bottom-1" id="downloadUrl"><g:message code="download.confirm.rawUrlBtn" default="View the raw download URL"/></button>
                    </g:if>
                </div>
            </div>
        </div>
    </div>
</div>
<g:javascript>
    $( document ).ready(function() {

        $('#downloadUrl').click(function(e) {
            //e.preventDefault();
            var button = '<button class="btn" data-clipboard-action="copy" data-clipboard-target="#requestUrl">Copy to clipboard</button>';
            bootbox.dialog("<h4>Raw download URL</h4><textarea id='requestUrl'>${json?.requestUrl}</textarea>",
                [{
                    "label" : "Copy to clipboard",
                    "class" : "btn-success",
                    "callback" : function() {
                        new Clipboard('.btn-success', {
                            target: function(trigger) {
                                return document.getElementById("requestUrl");
                            }
                        });
                    }
                },
                {
                    "label" : "Close",
                    "class" : "btn",
                }]
            );
        });

        $('#fieldguideBtn').click(function(e) {
            e.preventDefault();
            var url = "${downloadUrl}";
            window.open(url);
        });

        var isChecklist  = "${isChecklist}";
        var downloadUrl  = "${downloadUrl}";
        if (isChecklist == "true" && downloadUrl) {
            window.location.href = downloadUrl;
        }

        <g:if test="${json}">
            // Update status of offline download
            var jsonResponse = ${json?.encodeAsJSON()};

            if (jsonResponse) {
                updateStatus(jsonResponse);
            }
        </g:if>
    });

    /**
    * Check offline download statusUrl and update UI, recursively
    *
    * @param json
    */
    function updateStatus(json) {
        var timeout = 20 * 1000; // time between checks
        //console.log("updateStatus", json);
        if (json.status) {
            if (json.statusUrl) {
                $('#queueStatus').html("Download is <span>" + json.status +"</span>");
                $('.progress').addClass('progress-striped');

                setTimeout(function(){
                    $.getJSON(json.statusUrl, function(data) {
                        updateStatus(data);
                    }).fail(function( jqxhr, textStatus, error ) {
                        $('#queueStatus').html( "Request Failed: " + textStatus + ", " + error );
                    });
                }, timeout);
            } else if (json.downloadUrl) {
                $('#queueStatus').html("Download is <span>" + json.status +"</span>. <a href='" + json.downloadUrl + "'>Retrieve download file</a>");
                $('.progress').removeClass('progress-striped');
            } else {
                $('#queueStatus').html("There was a problem getting the status: <code>" + json + "</code>");
                $('.progress').removeClass('progress-striped');
            }
        }
    }

</g:javascript>
</body>
</html>