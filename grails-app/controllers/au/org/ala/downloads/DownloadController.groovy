/*
 * Copyright (C) 2016 Atlas of Living Australia
 * All Rights Reserved.
 * The contents of this file are subject to the Mozilla Public
 * License Version 1.1 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/MPL/
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 */

package au.org.ala.downloads

import org.codehaus.groovy.grails.web.servlet.mvc.GrailsParameterMap

class DownloadController {
    def userPrefsService, authService, downloadService

    static defaultAction = "options1"

    def options1(DownloadParams downloadParams) {
        //log.debug "downloadParams = ${downloadParams}"
        log.debug "biocacheDownloadParamString = ${downloadParams.biocacheDownloadParamString()}"
        log.debug "request.getHeader('referer') = ${request.getHeader('referer')}"

        if (downloadParams.searchParams) {
            render (view:'options1', model: [
                    searchParams: downloadParams.searchParams,
                    targetUri: downloadParams.targetUri
            ])
        } else {
            flash.message = "Download error - No search query parameters were provided."
            def redirectUri = request.getHeader('referer') ?: "/"
            redirect(uri: redirectUri)
        }
    }

    def options2(DownloadParams downloadParams) {
        //cleanupParams(params)
        def email = authService?.getEmail()
        def userId = authService?.getUserId()
        if (!downloadParams.downloadType || !downloadParams.reasonTypeId) {
            flash.message = "No type or reason selected. Please try again."
            redirect(action: "options1", params: params)
        } else if (downloadParams.downloadType == "basic-dwc" && downloadParams.downloadFormat == "custom") {
            render (view:'options2', model: [
                    customSections: grailsApplication.config.customSections,
                    mandatoryFields: grailsApplication.config.mandatoryFields,
                    userSavedFields: userPrefsService.getUserSavedFields(userId),
                    searchParams: downloadParams.searchParams,
                    targetUri: downloadParams.targetUri
            ])
        } else {
            // trigger triggerDownload
            log.debug "downloadService is a ${downloadService.class.getName()}"
            log.debug "downloadParams is a ${downloadParams.class.getName()}"
            downloadParams.extra = grailsApplication.config.extraFields ?: downloadParams.extra
            downloadParams.email = email
            def json = downloadService.triggerDownload(downloadParams)
            render (view:'confirm', model: [searchParams: downloadParams.searchParams, targetUri: downloadParams.targetUri, json: json ])
        }
    }

    def confirm () {
        // testing only
        //render (view:'/triggerDownload/options3')
    }

    private cleanupParams(params) {
        def removeParams = ["action","controller"]
        GrailsParameterMap paramsCopy = params.clone() // to avoid concurrent access exception
        paramsCopy.each {
            if (removeParams.contains(it.key)) {
                params.remove(it.key)
            }
        }
    }
}
