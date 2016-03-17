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
import org.codehaus.groovy.grails.web.json.JSONArray
import org.codehaus.groovy.grails.web.json.JSONObject

/**
 * Service to perform the records downloads (marshalls to appropriate web service)
 */
class DownloadService {
    def grailsApplication, webService

    def triggerDownload(DownloadParams downloadParams) throws Exception {

        if (downloadParams.downloadType == DownloadType.RECORDS.type) {
            // set some defaults
            downloadParams.dwcHeaders = true
            downloadParams.file = downloadParams.downloadType + "-" + new Date().format("yyyy-MM-dd")
            // catch different formats
            if (downloadParams.downloadFormat == DownloadFormat.DWC.format) {
                downloadParams.fields = grailsApplication.config.dwcFields
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
                        customFields.addAll(getFieldsForDwcClass(it))
                    } else if (grailsApplication.config.containsKey(it)) {
                        def fields = grailsApplication.config.get(it)
                        customFields.addAll(fields)
                    } else if (it == "qualityAssertions") {
                        downloadParams.qa = true
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

        } else if (downloadParams.downloadType == DownloadType.FIELDGUIDE.type) {

        } else {
            def msg = "Download type not recognised: ${downloadParams.downloadType}"
            log.warn msg
            throw new IllegalArgumentException(msg)
        }
    }

    JSONObject triggerOfflineDownload(DownloadParams downloadParams)  throws Exception {
        String url = grailsApplication.config.indexedDownloadUrl + downloadParams.biocacheDownloadParamString()
        log.debug "Doing GET on ${url}"
        JSONObject json = webService.getJsonElements(url)
        json.put("requestUrl",url)
        json
    }

    @Cacheable('longTermCache')
    List getFieldsForDwcClass(String classsName) {
        List fields = []

        if (classsName) {
            def fieldsMap = getFieldsMap()
            fields = fieldsMap.get(classsName)
        } else {
            throw new IllegalArgumentException("classsName argument not provided")
        }

        fields
    }

    Map getFieldsMap() {
        JSONArray fields = webService.getBiocacheFields() // cached
        Map fieldsByClassMap = [:]
        Map classLookup = grailsApplication.config.classMappings

        fields.each { JSONObject field ->

            if (field && field.containsKey("dwcTerm")) {
                String classsName = (field.containsKey("classs")) ? field.get("classs") : "Misc"
                String key = classLookup.get(classsName) ?: "Misc"
                List fieldsList = fieldsByClassMap.get(key) ?: []
                fieldsList.add(field.get("downloadName"))
                fieldsByClassMap.put(key, fieldsList) // overwrites with new list
            }
        }

        fieldsByClassMap
    }
}
