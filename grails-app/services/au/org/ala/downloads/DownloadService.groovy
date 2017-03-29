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
import net.sf.json.JSONArray

/**
 * Service to perform the records downloads (marshalls to appropriate web service)
 */
class DownloadService {
    def grailsApplication
    def webService
    def biocacheService

    /**
     * Records download service
     *
     * @param downloadParams
     * @return
     * @throws Exception
     */
    def triggerDownload(DownloadParams downloadParams) throws Exception {

        if (downloadParams.downloadType == DownloadType.RECORDS.type) {
            // set some defaults
            downloadParams.file = downloadParams.file?:downloadParams.downloadType + "-" + new Date().format("yyyy-MM-dd")
            // catch different formats
            if (downloadParams.downloadFormat == DownloadFormat.DWC.format) {
                // DwC download
                downloadParams.fields = biocacheService.getDwCFields() // was: grailsApplication.config.downloads.dwcFields
                triggerOfflineDownload(downloadParams)
            } else if (downloadParams.downloadFormat == DownloadFormat.LEGACY.format) {
                // Legacy download
                downloadParams.extra = (grailsApplication.config.flatten().containsKey("biocache.downloads.extra")) ? grailsApplication.config.biocache.downloads.extra : ""
                downloadParams.dwcHeaders = false
                log.debug "downloadParams = ${downloadParams} | ${grailsApplication.config.biocache.downloads.extra}"
                triggerOfflineDownload(downloadParams)
            } else if (downloadParams.downloadFormat == DownloadFormat.CUSTOM.format) {
                // Custom download
                List customFields = []
                downloadParams.customClasses.each {
                    log.debug "classs = ${it}"

                    List dwcClasses = grailsApplication.config.flatten().containsKey("downloads.customSections.darwinCore") ? grailsApplication.config.downloads.customSections.darwinCore : []
                    log.debug "dwcClasses = ${dwcClasses}"
                    if (dwcClasses.contains(it)) {
                        customFields.addAll(biocacheService.getFieldsForDwcClass(it))
                    } else if (grailsApplication.config.downloads.containsKey(it)) {
                        def fields = grailsApplication.config.downloads.get(it)
                        customFields.addAll(fields)
                    } else if (it == "qualityAssertions") {
                        downloadParams.qa = "includeall"
                    } else if (it == "miscellaneousFields") {
                        downloadParams.includeMisc = true
                    } else if (it == "selectedLayers") {
                        //already added to extra
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
        String url = grailsApplication.config.downloads.indexedDownloadUrl + downloadParams.biocacheDownloadParamString()
        log.debug "Doing GET on ${url}"
        Map resp = webService.get(url)

        if (resp?.resp) {
            resp.resp.put("requestUrl", url)
            resp.resp
        } else {
            throw new Exception(resp?.error)
        }
    }

    @Cacheable('longTermCache')
    def List getLoggerReasons() {
        def url = "${grailsApplication.config.logger.baseUrl}/logger/reasons"
        try {
            webService.get(url).resp.findAll { !it.deprecated } // skip deprecated reason codes
        } catch (Exception ex) {
            log.error "Error calling logger service: ${ex.message}", ex
        }
    }

    @Cacheable('longTermCache')
    def List getLoggerSources() {
        def url = "${grailsApplication.config.logger.baseUrl}/logger/sources"
        try {
            webService.get(url).resp
        } catch (Exception ex) {
            log.error "Error calling logger service: ${ex.message}", ex
        }
    }
}
