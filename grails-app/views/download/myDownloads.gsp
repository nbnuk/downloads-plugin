<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <meta name="fluidLayout" content="false"/>
    <title><g:message code="download.page.title"/></title>
    <asset:javascript src="downloads.js" />
    <asset:stylesheet src="downloads.css" />
</head>

<body>
<div class="container">
    <div class="row"><h3><g:message code="download.mydownloads.pageTitle"/></h3></div>
    <div class="row" id="table-metadata">
        <g:set var="start" value="${((params.getInt('offset')?:0) + 1)}"/>
        <g:set var="end" value="${(start + ((params.getInt('max')?:10) - 1))}"/>
        <g:set var="end" value="${(end > totalRecords ? totalRecords : end)}"/>
        <div class="span5" id="pagination-details">
            <g:message code="downloads.fields.showing.results" args="[start, end, totalRecords]" />
            <g:if test="${params.filter}">
                (filter: ${params.filter})
            </g:if>
        </div>
        <div class="span7" id="sort-widgets">
            <g:message code="download.mydownloads.items.per.page" default="items per page"/>:
            <select id="per-page" name="per-page" class="input-small" onchange="location = this.value;">
                <option value="${g.createLink(action:'mydownloads',params:params + [max:'10'])}" ${params.max == '10' ? 'selected': ''}>10</option>
                <option value="${g.createLink(action:'mydownloads',params:params + [max:'20'])}" ${params.max == '20' ? 'selected': ''}>20</option>
                <option value="${g.createLink(action:'mydownloads',params:params + [max:'50'])}" ${params.max == '50' ? 'selected': ''}>50</option>
                <option value="${g.createLink(action:'mydownloads',params:params + [max:'100'])}" ${params.max == '100' ? 'selected': ''}>100</option>
            </select>&nbsp;

        <g:message code="download.mydownloads.sort" default="sort"/>:
            <select id="sort" name="sort" class="input-small" onchange="location = this.value;">
                <option value="${g.createLink(action:'mydownloads',params:params + [sort:'doi'])}" ${params.sort == 'doi' ? 'selected': ''}><g:message code="download.mydownloads.doi" default="Doi"/></option>
                <option value="${g.createLink(action:'mydownloads',params:params + [sort:'dateMinted'])}" ${params.sort == 'dateMinted' ? 'selected': ''}><g:message code="download.mydownloads.dateMinted" default="Date"/></option>
                <option value="${g.createLink(action:'mydownloads',params:params + [sort:'title'])}" ${params.sort == 'title' ? 'selected': ''}><g:message code="download.mydownloads.title" default="Title"/></option>
            </select>&nbsp;
        <g:message code="download.mydownloads.order" default="order"/>:
            <select id="dir" name="dir" class="input-small" onchange="location = this.value;">
                <option value="${g.createLink(action:'mydownloads',params:params + [order:'ASC'])}" ${params.order == 'ASC' ? 'selected': ''}><g:message code="downloads.fields.ascending" default="Ascending"/></option>
                <option value="${g.createLink(action:'mydownloads',params:params + [order:'DESC'])}" ${params.order == 'DESC' ? 'selected': ''}><g:message code="downloads.fields.descending" default="Descending"/></option>
            </select>
        </div>
    </div>

    <div class="row">
    <div class="fwtable">
        <table class="table table-bordered table-striped table-responsive">
            <thead>
                <tr>
                    <th class="col-sm-2">Download</th>
                    <th class="col-sm-2">Date</th>
                    %{--<th class="col-xs-2">Title</th>--}%
                    <th class="col-sm-1">Records</th>
                    <th class="col-sm-1">Datasets</th>
                    <th class="col-sm-6">Search Query</th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${dois}" var="doi">
                   <tr>
                       <td><a href="${g.createLink(controller: 'download', action: 'doi')}?doi=${doi.doi}" type="button" class="doi doi-sm"><span>DOI</span><span>${doi.doi}</span></a></td>
                       <td><g:formatDate date="${doi.dateMinted}" format="yyyy-MM-dd h:mm a"/></td>
                       %{--<td>${doi.title}</td>--}%
                       <td><g:formatNumber number="${doi.applicationMetadata?.recordCount}" type="number" /></td>
                       <td><g:formatNumber number="${doi.applicationMetadata?.datasets?.size()}" type="number" /></td>
                       <g:set var="searchQuery" value="${URLDecoder.decode(doi?.applicationMetadata['searchUrl'], 'UTF-8')}"/>
                       <td><a href="${searchQuery}">Re-run search</a> <downloads:formatSearchQuery searchUrl="${doi.applicationMetadata?.searchUrl}" /></td>
                   </tr>
                </g:each>
            </tbody>
        </table>
    </div>
    <div  class="pagination">
        <g:paginate total="${totalRecords}" params="${[filter:params.filter]}"/>
    </div>
    </div>
</div>
 %{--   </div>
</div>--}%
</body>
%{--        <g:set var="showLongTimeWarning" value="${totalRecords && (totalRecords > grailsApplication.config.downloads.maxRecords)}"/>--}%
