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
            <li class="font-xxsmall active">Download</li>
        </ol>
        <!-- End Breadcrumb -->
        <h2 class="heading-medium">Customise Your Download</h2>

        <div class="button-toolbar row-fluid">
            <div class="btn-group">
                <!-- <a class="btn btn-default" disabled="disabled" href="#"><span class="glyphicon glyphicon-th" aria-hidden="true"></span> <span class="hidden-xs hidden-sm">Toggle grid view</span></a> -->
                <a class="btn btn-default" href="#"><i class="fa fa-check"></i> <span class="hidden-xs hidden-sm">Select all</span></a>
                <a class="btn btn-default" href="#"><i class="fa fa-times"></i> <span class="hidden-xs hidden-sm">Unselect all</span></a>
            </div>

            <div class="btn-group pull-right">
                <a class="btn btn-default"><i class="fa fa-cog"></i> <span class="hidden-xs">Save preferences</span></a>
                <a class="btn btn-primary" href="#"><span class="hidden-xs">Next <i class="fa fa-chevron-right"></i></span></a>
            </div>

        </div>

        <div class="well">
            <div class="row-fluid">
                <div class="span12">
                    <div class="panel panel-default">
                        <div class="comment-wrapper push">
                            <div class="row-fluid">
                                <div class="span2">
                                    <div class="contrib-stats">
                                        <div class="no-of-questions">
                                            <div class="survey-details">
                                                <div class="survey-counter"><strong><i class="fa fa-cog color--yellow"></i></strong></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="span8">
                                    <h4 class="text-uppercase heading-underlined">Darwin Core Class (field groups)</h4>
                                    <p class="margin-bottom-2">
                                        A description of the field groupings below.
                                    </p>

                                    <div class="list-group">
                                        <g:each in="${darwinCoreGroups}" var="group" status="i">
                                            <g:set var="disabled" value="${(i <= 1) ? true : false }"/>
                                            <a href="#" class="list-group-item ${(disabled)?"list-group-item-success disabled":""} ">
                                                <div class="checkbox pull-left">
                                                    <label><input type="checkbox" value="${group}" ${(disabled)?"checked='checked'":""}></label>
                                                </div>
                                                <div class="pull-left form-control-inline">
                                                    <h4 class="padding-left-1">
                                                        <i class="fa fa-check ${(disabled)?"":"hide"}"></i>
                                                        <g:message code="customGroup.${group}" default="${group}"/>
                                                    </h4>
                                                </div>
                                                <div class="clearfix"></div>
                                            </a>
                                        </g:each>
                                    </div>

                                </div>
                            </div>
                        </div><!-- End comment-wrapper push -->
                    </div>
                </div>
            </div>
        </div>

        <div class="well">
            <div class="row-fluid">
                <div class="span12">
                    <div class="panel panel-default">
                        <div class="comment-wrapper push">
                            <div class="row-fluid">
                                <div class="span2">
                                    <div class="contrib-stats">
                                        <div class="no-of-questions">
                                            <div class="survey-details">
                                                <div class="survey-counter"><strong><i class="fa fa-cog color--yellow"></i></strong></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="span8">
                                    <h4 class="text-uppercase heading-underlined">Species Traits</h4>
                                    <p class="margin-bottom-2">
                                        A description of the field groupings below.
                                    </p>

                                    <div class="list-group">
                                        <g:each in="${speciesTraitsGroup}" var="group" status="i">
                                            <g:set var="disabled" value="${ false }"/>
                                            <a href="#" class="list-group-item ${(disabled)?"list-group-item-success disabled":""} ">
                                                <div class="checkbox pull-left">
                                                    <label><input type="checkbox" value="${group}" ${(disabled)?"checked='checked'":""}></label>
                                                </div>
                                                <div class="pull-left form-control-inline">
                                                    <h4 class="padding-left-1">
                                                        <i class="fa fa-check ${(disabled)?"":"hide"}"></i>
                                                        <g:message code="customGroup.${group}" default="${group}"/>
                                                    </h4>
                                                </div>
                                                <div class="clearfix"></div>
                                            </a>
                                        </g:each>
                                    </div>

                                </div>
                            </div>
                        </div><!-- End comment-wrapper push -->
                    </div>
                </div>
            </div>
        </div><!-- /.well -->

        <div class="well">
            <div class="row-fluid">
                <div class="span12">
                    <div class="panel panel-default">
                        <div class="comment-wrapper push">
                            <div class="row-fluid">
                                <div class="span2">
                                    <div class="contrib-stats">
                                        <div class="no-of-questions">
                                            <div class="survey-details">
                                                <div class="survey-counter"><strong><i class="fa fa-cog color--yellow"></i></strong></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="span8">
                                    <h4 class="text-uppercase heading-underlined">Spatial Intersections</h4>
                                    <p class="margin-bottom-2">
                                        A description of the field groupings below.
                                    </p>

                                    <div class="list-group">
                                        <g:each in="${spatialIntersectionsGroup}" var="group" status="i">
                                            <g:set var="disabled" value="${ false }"/>
                                            <a href="#" class="list-group-item ${(disabled)?"list-group-item-success disabled":""} ">
                                                <div class="checkbox pull-left">
                                                    <label><input type="checkbox" value="${group}" ${(disabled)?"checked='checked'":""}></label>
                                                </div>
                                                <div class="pull-left form-control-inline">
                                                    <h4 class="padding-left-1">
                                                        <i class="fa fa-check ${(disabled)?"":"hide"}"></i>
                                                        <g:message code="customGroup.${group}" default="${group}"/>
                                                    </h4>
                                                </div>
                                                <div class="clearfix"></div>
                                            </a>
                                        </g:each>
                                    </div>

                                </div>
                            </div>
                        </div><!-- End comment-wrapper push -->
                    </div>
                </div>
            </div>
        </div><!-- /.well -->


        <div class="well">
            <div class="row-fluid">
                <div class="span12">
                    <div class="panel panel-default">
                        <div class="comment-wrapper push">
                            <div class="row-fluid">
                                <div class="span2">
                                    <div class="contrib-stats">
                                        <div class="no-of-questions">
                                            <div class="survey-details">
                                                <div class="survey-counter"><strong><i class="fa fa-cog color--yellow"></i></strong></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="span8">
                                    <h4 class="text-uppercase heading-underlined">Data quality</h4>
                                    <p class="margin-bottom-2">
                                        A description of the field groupings below.
                                    </p>

                                    <div class="list-group">
                                        <g:each in="${qualityGroup}" var="group" status="i">
                                            <g:set var="disabled" value="${ false }"/>
                                            <a href="#" class="list-group-item ${(disabled)?"list-group-item-success disabled":""} ">
                                                <div class="checkbox pull-left">
                                                    <label><input type="checkbox" value="${group}" ${(disabled)?"checked='checked'":""}></label>
                                                </div>
                                                <div class="pull-left form-control-inline">
                                                    <h4 class="padding-left-1">
                                                        <i class="fa fa-check ${(disabled)?"":"hide"}"></i>
                                                        <g:message code="customGroup.${group}" default="${group}"/>
                                                    </h4>
                                                </div>
                                                <div class="clearfix"></div>
                                            </a>
                                        </g:each>
                                    </div>

                                </div>
                            </div>
                        </div><!-- End comment-wrapper push -->
                    </div>
                </div>
            </div>
        </div><!-- /.well -->

    </div>
</div>
<g:javascript>
    $( document ).ready(function() {
        $('a.select-download-type').click(function(e) {
            e.preventDefault(); // its link so stop any regular link stuff hapenning
            var link = this;
            if ($(link).hasClass('btn-primary')) {
                // already selected
                $(link).find('span').text('Select');
                $(link).removeClass('btn-primary');
                $(link).addClass('btn-white');
                $(link).find('.fa').addClass('hide');
                $(link).blur(); // prevent BS focus
            } else {
                // not selected
                $('a.select-download-type').find('span').text('Select'); // reset any other selcted buttons
                $('a.select-download-type').removeClass('btn-primary'); // reset any other selcted buttons
                $('a.select-download-type').addClass('btn-white'); // reset any other selcted buttons
                $('a.select-download-type').find('.fa').addClass('hide'); // reset any other selcted buttons
                $(link).find('span').text('Selected');
                $(link).removeClass('btn-white');
                $(link).addClass('btn-primary');
                $(link).find('.fa').removeClass('hide');
                $(link).blur(); // prevent BS focus
            }
        });

    });
</g:javascript>
</body>
</html>