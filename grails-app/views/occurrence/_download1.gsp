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
  Time: 11:29 AM
  To change this template use File | Settings | File Templates.
--%>
<style type="text/css">
    /* Colours and Swatchs
    ================================= */

    .swatch-colour{height:70px;width:100%;display:block;border-bottom:1px solid #ccc;}
    .color--dark-grey{color: #9d9d9d;} .backgroundcolor--dark-grey{background-color: #9d9d9d;}
    .color--dark-red{color: #C44D34;} .backgroundcolor--dark-red{background-color: #C44D34;}
    .color--green{color: #006435;} .backgroundcolor--green{background-color: #006435;}
    .color--medium-blue{color: #2475A4;} .backgroundcolor--medium-blue{background-color: #2475A4;}
    .color--medium-grey{color: #637073;} .backgroundcolor--medium-grey{background-color: #637073;}
    .color--mellow-red{color: #DF3034;} .backgroundcolor--mellow-red{background-color: #DF3034;}
    .color--off-black{color: #212121;} .backgroundcolor--off-black{background-color: #212121;}
    .color--off-white{color: #F2F2F2;} .backgroundcolor--off-white{background-color: #F2F2F2;}
    .color--pink{color: #D0367D;} .backgroundcolor--pink{background-color: #D0367D;}
    .color--primary-red{color: #F26649;} .backgroundcolor--primary-red{background-color: #F26649;}
    .color--purple{color: #2E358B;} .backgroundcolor--purple{background-color: #2E358B;}
    .color--red{color: #B10E1E;} .backgroundcolor--red{background-color: #B10E1E;}
    .color--white{color: #fff !important;} .backgroundcolor--white{background-color: #fff;}
    .color--yellow{color: #FFBF47;} .backgroundcolor--yellow{background-color: #FFBF47;}
    .color--apple{color: #65B044;} .backgroundcolor--apple{background-color: #65B044;}
    .color-lochmara {color: #0087BE;} .background-lochmara {background-color: #0087BE;}
    .color-facebook {color: #507CBE;} .background-facebook {background-color: #507CBE;}


/* Survey (Panel)
================================= */

    .panel .survey-heading {background-color: #fff;border-color: #fff;color: #262626;font-size: 16px;font-weight: 700;padding: 10px 15px 0 15px;text-align: center;}
    .survey-colour {height: 10px;width: 100%;display: block;border-bottom: 1px solid #ccc;}
    .no-of-questions {vertical-align: top;margin-right: 10px;}
    #content2 .survey-details {display: inline-block;font-size: 11px;color: #777;}
    #content2 .survey-counter {display: inline-block;font-size: 64px;}
    .survey-subtitle {color: #222;font-size: 18px;text-align: center;display: block;text-transform: uppercase;margin-bottom: 0.2em;font-weight: 700;}
    .survey-date {color: #9a9a9a;font-size: 14px;text-align: center;display: block;}
    .survey-footer {padding: 10px 15px;background-color: #f5f5f5;border-top: 1px solid #ddd;border-bottom-right-radius: 3px;border-bottom-left-radius: 3px;text-align: center;}
    .survey-title {font-size: 19px;font-weight: 900;color: #222;line-height: 1.3;margin-bottom: 0;}
    .survey-sidetitle {font-size: 23px;font-weight: 500;color: #222;line-height: 1.3;margin-bottom: 10px;}
    .survey-type {font-size: 12px;line-height: 1.3;text-transform: uppercase;margin-bottom: 0;font-weight: 400;}
    .panel-survey{border: 3px solid green;}
    .panel-survey.type-content {border: 3px solid #65B044;}
    .panel-survey.type-usability {border: 3px solid #DF3034;}
    .panel-survey.type-feedback {border: 3px solid #0087BE;}
    .panel-survey.type-closed {border: 3px solid #9D9D9D;}

</style>

<g:set var="biocacheServiceUrl" value="${downloads.getBiocacheAjaxUrl()}"/>
<div id="download" class="modal hide" tabindex="-1" role="dialog" aria-labelledby="downloadsLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="downloadsLabel"><g:message code="download.download.title" default="Download"/></h3>
    </div>
    <div class="modal-body">
        <h4 class="heading-medium-alt">Step 1</h4>
        <div class="row-fluid">
            <div class="span2">
                <div class="survey-details">
                    <div class="survey-counter"><strong><i class="fa fa-table color--yellow"></i></strong></div>
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
                        <label for="inputEmail3" class="col-sm-3 control-label heading-medium"><span class="color--mellow-red">*</span>Select type</label>
                        <div class="col-sm-8">
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

            </div>
        </div><!-- /.row-fluid -->
        <div class="row-fluid">
            <div class="span2">
                <div class="survey-counter"><strong><i class="fa fa-list-alt color--apple"></i></strong></div>
            </div>
            <div class="span7">

            </div>
            <div class="span3">

            </div>
        </div><!-- /.row-fluid -->
        <div class="row-fluid">
            <div class="span2">
                <div class="survey-counter"><strong><i class="fa fa-file-pdf-o color--mellow-red"></i></strong></div>
            </div>
            <div class="span7">

            </div>
            <div class="span3">

            </div>
        </div><!-- /.row-fluid -->
    </div><!-- /.modal-body -->
    <div class="modal-footer">
        <button class="btn" data-dismiss="modal" aria-hidden="true"><g:message code="download.button.close" default="Close"/></button>
    </div><!-- /.modal-footer -->
</div><!-- /.modal#download -->
