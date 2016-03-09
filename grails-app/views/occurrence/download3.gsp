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

</style>
</head>
<body>
<div class="row">
    <div class="span4 offset4">
        <h1 class="hidden">Welcome to the Atlas of Living Australia website</h1><!-- Show the H1 on each page -->

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
                        <h2 class="heading-medium-large">Thank you for your download</h2>
                        <p class="lead">
                            Your download is now being queued.
                        </p>
                        <p>
                            It will be sent to your email address linked to your ALA account when it is completed.
                        </p>
                        <p>&nbsp;</p>
                        %{--<p>Close this window at any time.</p>--}%
                    </div>
                    %{--<p class="separator t-center margin-bottom-2"><span>Or</span></p>--}%
                    <a href="#" class="btn btn-lg btn-default btn-block margin-bottom-1 font-xxsmall" type="button">Return to your previous search</a>
                </div>
            </div>
        </div>

        ${raw(toolbar)}

    </div>
</div>
<g:javascript>
    $( document ).ready(function() {
        $('.list-group-item.disabled').click(function(e) {
            e.preventDefault(); // prevent page jump
        }).tooltip();

        // catch clicks on list group items
        $('a.list-group-item').not('.disabled').click(function(e) {
            e.preventDefault(); // its link so stop any regular link stuff hapenning
            var link = this;
            if ($(link).hasClass('list-group-item-success')) {
                // already selected
                deselectItem(link);
            } else {
                // not selected
                selectItem(link);
            }
        });

        $('.select-all-btn').click(function(e) {
            e.preventDefault();
            $('a.list-group-item').not('.disabled').each(function(i) {
                selectItem(this);
            });
        });

        $('.select-none-btn').click(function(e) {
            e.preventDefault();
            $('a.list-group-item').not('.disabled').each(function(i) {
                deselectItem(this);
            });
        });

    });

    function selectItem(item) {
        $(item).find('i.fa').removeClass('${unselectedItem}');
        $(item).find('i.fa').addClass('${selectedItem}');
        $(item).addClass('list-group-item-success');
        $(item).find('input').attr('checked','checked');
        $(item).blur(); // prevent BS focus
    }

    function deselectItem(item) {
        $(item).removeClass('disabled').removeClass('list-group-item-success');
        $(item).find('.fa').addClass('${unselectedItem}');
        $(item).find('.fa').removeClass('${selectedItem}');
        $(item).find('input').removeAttr('checked');
        $(item).blur(); // prevent BS focus
    }

</g:javascript>
</body>
</html>