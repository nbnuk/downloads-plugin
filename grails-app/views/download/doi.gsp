<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <meta name="fluidLayout" content="false"/>
    <title><g:message code="download.doilanding.pageTitle"  args="[doi.doi]"/></title>
    <asset:javascript src="ala/downloads.js" />
    <asset:stylesheet src="ala/downloads.css" />
</head>
<body>
<div class="container">

    <div class="row row-m-b" align="center"><h3><a href="${g.createLink(controller: 'download', action: 'doi')}?doi=${doi.doi}" type="button" class="btn btn-info">DOI ${doi.doi}</a></h3></div>

    <div class="row row-m-b"><b>Occurrences:</b> ${doi?.applicationMetadata?.recordCount}</div>
    <div class="row row-m-b"><b>Title:</b> ${doi.title}</div>
    <div class="row row-m-b"><b>Description:</b> ${doi.description}</div>
    <div class="row row-m-b"><b>Licence:</b> ${doi.licence}</div>
    <div class="row row-m-b"><b>Authors:</b> ${doi.authors}</div>
    <div class="row row-m-b"><b>Date Created:</b> ${doi.dateCreated}</div>
    <div class="row row-m-b"><b>Date Minted:</b> ${doi.dateCreated}</div>
    <div class="row row-m-b"><b>SearchUrl:</b><a href="${doi.applicationMetadata?.searchUrl}"> ${URLDecoder.decode(doi.applicationMetadata?.searchUrl, 'UTF-8')}</a></div>
    <div class="row row-m-b"><b>File:</b> <a href="${grailsApplication?.config.doiService.baseUrl}/doi/${URLEncoder.encode(doi.doi, 'UTF-8')}/download"> ${doi.filename}</a></div><br>

    <div class="row">
        Datasets:
        <div class="fwtable">
            <table class="table table-bordered table-striped table-responsive">
                <thead>
                <tr>
                    <th>Name</th>
                    <th>Licence</th>
                    <th style="text-align: center">Count</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${doi.applicationMetadata?.datasets}" var="dataset">
                    <tr>
                        <td class="col-xs-4"><a href="${grailsApplication?.config.collections.baseUrl}/public/show/${dataset.uid}">${dataset.name}</a></td>
                        <td class="col-xs-3">${dataset.licence}</td>
                        <td class="col-xs-1" align="center">${dataset.count}</td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

    </div>
</div>
</body>
</html>
