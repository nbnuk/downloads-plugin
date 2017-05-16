%{--
  - Copyright (C) 2017 Atlas of Living Australia
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
  User: dos009
  Date: 10/05/2017
  Time: 4:23 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <meta name="fluidLayout" content="false"/>
    <title><g:message code="downloads.fields.heading" default="Occurrence Record Fields"/></title>
    <r:require module="download"/>
</head>

<body>
    <h1><g:message code="downloads.fields.heading" default="Occurrence Record Fields"/></h1>
    <div class="row">
        <div class="span12">
            <g:message code="downloads.fields.filters" default="Filters"/>:
            <div class="btn-group"">
                <g:link class="btn btn-mini ${downloads.btnState(fld:'filter', val:'')}" action="fields" params="${params + [filter:'']}">All fields</g:link>
                <g:link class="btn btn-mini ${downloads.btnState(fld:'filter', val:'dwcTerm:.*')}" action="fields" params="${params + [filter:"dwcTerm:.*"]}">only DwC terms</g:link>
                <g:link class="btn btn-mini ${downloads.btnState(fld:'filter', val:'el[0-9]*')}" action="fields" params="${params + [filter:'el[0-9]*']}">only environmental layer</g:link>
                <g:link class="btn btn-mini ${downloads.btnState(fld:'filter', val:'cl[0-9]*')}" action="fields" params="${params + [filter:'cl[0-9]*']}">only contextual layer</g:link>
                <g:link class="btn btn-mini ${downloads.btnState(fld:'filter', val:'indexed:true')}" action="fields" params="${params + [filter:'indexed:true']}">only indexed fields</g:link>
            </div>
            &nbsp;&nbsp;&nbsp;
            <g:message code="downloads.fields.search" default="Search"/>:
            <form class="form-inline" style="display:inline-block;">
                <div class="input-append">
                    <input class="span2 input-mini" name="filter" id="appendedInputButton" type="text" value="${params.filter}">
                    <input class="btn btn-mini" type="submit" value="Search">
                </div>
            </form>
        </div>
    </div>
    <div class="row" id="table-metadata">
        <g:set var="start" value="${((params.getInt('offset')?:0) + 1)}"/>
        <g:set var="end" value="${(start + ((params.getInt('max')?:10) - 1))}"/>
        <g:set var="end" value="${(end > fieldsMax ? fieldsMax : end)}"/>
        <div class="span6" id="pagination-details"><g:message code="downloads.fields.showing.results" args="[start, end, fieldsMax]" /></div>
        <div class="span6" id="sort-widgets">
            <g:message code="downloads.fields.items.per.page" default="items per page"/>:
            <select id="per-page" name="per-page" class="input-small" onchange="location = this.value;">
                <option value="${g.createLink(action:'fields',params:params + [max:'10'])}" ${params.max == '10' ? 'selected': ''}>10</option>
                <option value="${g.createLink(action:'fields',params:params + [max:'20'])}" ${params.max == '20' ? 'selected': ''}>20</option>
                <option value="${g.createLink(action:'fields',params:params + [max:'50'])}" ${params.max == '50' ? 'selected': ''}>50</option>
                <option value="${g.createLink(action:'fields',params:params + [max:'100'])}" ${params.max == '100' ? 'selected': ''}>100</option>
            </select>&nbsp;

            <g:message code="downloads.fields.sort" default="sort"/>:
            <select id="sort" name="sort" class="input-small" onchange="location = this.value;">
                <option value="${g.createLink(action:'fields',params:params + [sort:'name'])}" ${params.sort == 'name' ? 'selected': ''}>Field name</option>
                <option value="${g.createLink(action:'fields',params:params + [sort:'downloadName'])}" ${params.sort == 'downloadName' ? 'selected': ''}>Download name</option>
                <option value="${g.createLink(action:'fields',params:params + [sort:'dwcTerm'])}" ${params.sort == 'dwcTerm' ? 'selected': ''}>DwC term</option>
                <option value="${g.createLink(action:'fields',params:params + [sort:'classs'])}" ${params.sort == 'classs' ? 'selected': ''}>DwC class</option>
            </select>&nbsp;
            <g:message code="downloads.fields.order" default="order"/>:
            <select id="dir" name="dir" class="input-small" onchange="location = this.value;">
                <option value="${g.createLink(action:'fields',params:params + [order:'ASC'])}" ${params.order == 'ASC' ? 'selected': ''}>Ascending</option>
                <option value="${g.createLink(action:'fields',params:params + [order:'DESC'])}" ${params.order == 'DESC' ? 'selected': ''}>Descending</option>
            </select>
        </div>
    </div>
    <table id="fieldsTable" class="table table-bordered table-striped">
        <tr>
            <th><g:message code="downloads.fields.search.name" default="Search name"/></th>
            <th><g:message code="downloads.fields.download.name" default="Download name"/></th>
            <th><g:message code="downloads.fields.dwc.term" default="DwC term"/></th>
            <th><g:message code="downloads.fields.dwc.class" default="DwC class"/></th>
            <th><g:message code="downloads.fields.description" default="Description"/></th>
            <th><g:message code="downloads.fields.download.description" default="Download description"/></th>
            <th><g:message code="downloads.fields.attributes" default="Attributes"/></th>
        </tr>
        <g:each in="${fields}" var="fld">
            <tr>
                <td>${fld.name}</td>
                <td>${fld.downloadName}</td>
                <td>${downloads.formatDwcTerm(field:fld)}</td>
                <td>${fld.classs}</td>
                <td>${fld.description}</td>
                <td>${fld.downloadDescription}</td>
                <td>
                    <g:if test="${fld.indexed}"><span class="label label-info tooltips" title="${message(code:"downloads.fields.tooltip.indexed")}">I</span></g:if>
                    <g:if test="${fld.stored}"><span class="label label-success tooltips" title="${message(code:"downloads.fields.tooltip.stored")}">S</span></g:if>
                    <g:if test="${fld.multivalued}"><span class="label label-inverse tooltips" title="${message(code:"downloads.fields.tooltip.multivalued")}">M</span></g:if>
                    <span class="label tooltips" title="${message(code:"downloads.fields.tooltip.datatype")}">${fld.dataType}</span>
                </td>
            </tr>
        </g:each>
    </table>
    <div  class="pagination">
        <g:paginate total="${fieldsMax}" params="${[filter:params.filter]}"/>
    </div>

<g:javascript>
    $( document ).ready(function() {
        $('.tooltips').tooltip();
    });
</g:javascript>
</body>
</html>