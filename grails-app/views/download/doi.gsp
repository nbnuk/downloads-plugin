<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <meta name="fluidLayout" content="false"/>
    <meta name="breadcrumbParent" content="${g.createLink(action:'myDownloads')},${message(code: "download.mydownloads.pageTitle")}"/>
    <meta name="breadcrumb" content="Download ${doi.doi}"/>
    <title><g:message code="download.doilanding.pageTitle"  args="[doi.doi]"/></title>
    <asset:javascript src="downloads.js" />
    <asset:stylesheet src="downloads.css" />
</head>
<body>
<div class="container">
<div class="row">
    <div class="col-md-12" id="doiTitle">
        <h2><a href="${grailsApplication.config.doiService.doiResolverUrl}${doi.doi}" type="button" class="doi"><span>DOI</span><span>${doi.doi}</span></a></h2>
        <h3>Occurrence records download on <g:formatDate date="${doi.dateCreated}" format="yyyy-MM-dd"/></h3>
    </div>
    <div class="col-md-12 text-right">
        <a href="${grailsApplication?.config.doiService.baseUrl}/doi/${URLEncoder.encode(doi.doi, 'UTF-8')}/download" class="btn btn-primary"><i class="glyphicon glyphicon-download-alt"></i>&nbsp; Download file</a>
    </div>
    <div class="col-md-12"><b>File:</b> <a href="${grailsApplication?.config.doiService.baseUrl}/doi/${URLEncoder.encode(doi.doi, 'UTF-8')}/download"> ${doi.filename?:'download file not found'}</a></div><br>
    <div class="col-md-12"><b>Record count:</b> <g:formatNumber number="${doi.applicationMetadata?.recordCount}" type="number" /></div>
    <div class="col-md-8 col-sm-12"><b>Search query:</b> <downloads:formatSearchQuery searchUrl="${doi.applicationMetadata?.searchUrl}" /> </div>
    <div class="col-md-12"><b>Search URL:</b><a href="${doi.applicationMetadata?.searchUrl}"> ${URLDecoder.decode(doi.applicationMetadata?.queryTitle?.encodeAsRaw(), 'UTF-8')}</a></div>
    <div class="col-md-12"><b>Licence:</b>
        <g:if test="${doi.licence}">
            <ul>
                <g:each in="${doi.licence}" var="licence" >
                    <li>${licence}</li>
                </g:each>
            </ul>
        </g:if>
    </div>
    <div class="col-md-12"><b>Authors:</b> ${doi.authors}</div>
    <div class="col-md-12"><b>Date Created:</b> <g:formatDate date="${doi.dateCreated}" format="yyyy-MM-dd h:mm a"/></div>
    <div class="col-md-12"><b>Citation URL:</b> <a href="${grailsApplication.config.doiService.doiResolverUrl}${doi.doi}">${grailsApplication.config.doiService.doiResolverUrl}${doi.doi}</a></div><br>

</div>
    <div class="row">
        <div class="fwtable table-responsive col-md-12">
            <p><b>Datasets (<g:formatNumber number="${doi.applicationMetadata?.datasets?.size()}" type="number" />)</b></p>
            <table class="table table-bordered table-striped ">
                <thead>
                <tr>
                    <th>Name</th>
                    <th>Licence</th>
                    <th style="text-align: center">Record count</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${doi.applicationMetadata?.datasets.sort{a,b -> b.count as Integer <=> a.count as Integer}}" var="dataset">
                    <tr>
                        <td class="col-xs-4"><a href="${grailsApplication?.config.collections.baseUrl}/public/show/${dataset.uid}">${dataset.name}</a></td>
                        <td class="col-xs-3">${dataset.licence}</td>
                        <td class="col-xs-1" align="center"><g:formatNumber number="${dataset.count}" type="number" /></td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

    </div>
</div>
</body>
</html>
