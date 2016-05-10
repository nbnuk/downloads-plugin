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

import grails.plugin.cache.Cacheable

/**
 * Service to perform the records downloads (marshalls to appropriate web service)
 */
class DownloadService {
    def grailsApplication
    def webService
    def biocacheService

    def triggerDownload(DownloadParams downloadParams) throws Exception {

        if (downloadParams.downloadType == DownloadType.RECORDS.type) {
            // set some defaults
            downloadParams.file = downloadParams.downloadType + "-" + new Date().format("yyyy-MM-dd")
            // catch different formats
            if (downloadParams.downloadFormat == DownloadFormat.DWC.format) {
                downloadParams.fields = biocacheService.getDwCFields() // was: grailsApplication.config.dwcFields
                triggerOfflineDownload(downloadParams)
            } else if (downloadParams.downloadFormat == DownloadFormat.LEGACY.format) {
                downloadParams.extra = (grailsApplication.config.flatten().containsKey("biocache.downloads.extra")) ? grailsApplication.config.biocache.downloads.extra : ""
                downloadParams.dwcHeaders = false
                triggerOfflineDownload(downloadParams)
            } else if (downloadParams.downloadFormat == DownloadFormat.CUSTOM.format) {
                List customFields = []
                downloadParams.customClasses.each {
                    log.debug "classs = ${it}"

                    List dwcClasses = grailsApplication.config.flatten().containsKey("customSections.darwinCore") ? grailsApplication.config.customSections.darwinCore : []
                    log.debug "dwcClasses = ${dwcClasses}"
                    if (dwcClasses.contains(it)) {
                        customFields.addAll(biocacheService.getFieldsForDwcClass(it))
                    } else if (grailsApplication.config.containsKey(it)) {
                        def fields = grailsApplication.config.get(it)
                        customFields.addAll(fields)
                    } else if (it == "qualityAssertions") {
                        downloadParams.qa = "includeall"
                    } else if (it == "miscellaneousFields") {
                        downloadParams.includeMisc = true
                    } else {
                        throw new Exception("Custom field class not recognised: ${it}")
                    }
                }
                downloadParams.fields = customFields.join(",")
                triggerOfflineDownload(downloadParams)
            } else {
                def msg = "Download records format not recognised: ${downloadParams.downloadFormat}"
                log.warn msg
                throw new IllegalArgumentException(msg)
            }

        } else if (downloadParams.downloadType == DownloadType.CHECKLIST.type) {
            log.info "${DownloadType.CHECKLIST.type} download triggered"
        } else if (downloadParams.downloadType == DownloadType.FIELDGUIDE.type) {
            log.info "${DownloadType.FIELDGUIDE.type} download triggered"
        } else {
            def msg = "Download type not recognised: ${downloadParams.downloadType}"
            log.warn msg
            throw new IllegalArgumentException(msg)
        }
    }

    Map triggerOfflineDownload(DownloadParams downloadParams) throws Exception {
        String url = grailsApplication.config.indexedDownloadUrl + downloadParams.biocacheDownloadParamString()
        log.debug "Doing GET on ${url}"
        Map resp = webService.get(url)

        if (resp?.resp) {
            resp.resp.put("requestUrl", url)
            resp.resp
        } else {
            throw new Exception(resp?.error)
        }
    }




}
