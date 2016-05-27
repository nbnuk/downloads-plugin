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

import grails.converters.JSON

/**
 * Download controller
 */
class DownloadController {
    def customiseService, authService, downloadService, biocacheService

    static defaultAction = "options1"

    def options1(DownloadParams downloadParams) {
        //log.debug "downloadParams = ${downloadParams}"
        log.debug "biocacheDownloadParamString = ${downloadParams.biocacheDownloadParamString()}"
        log.debug "request.getHeader('referer') = ${request.getHeader('referer')}"
        downloadParams.file = DownloadType.RECORDS.type + "-" + new Date().format("yyyy-MM-dd")

        if (downloadParams.searchParams) {
            render (view:'options1', model: [
                    searchParams: downloadParams.searchParams,
                    targetUri: downloadParams.targetUri,
                    filename: downloadParams.file
            ])
        } else {
            flash.message = "Download error - No search query parameters were provided."
            def redirectUri = request.getHeader('referer') ?: "/"
            redirect(uri: redirectUri)
        }
    }

    def options2(DownloadParams downloadParams) {

        downloadParams.email = authService?.getEmail() ?: downloadParams.email // if AUTH is not present then email should be populated via input on page

        if (!downloadParams.downloadType || !downloadParams.reasonTypeId) {
            flash.message = "No type or reason selected. Please try again."
            redirect(action: "options1", params: params)
        } else if (downloadParams.downloadType == DownloadType.RECORDS.type && downloadParams.downloadFormat == DownloadFormat.CUSTOM.format && !downloadParams.customClasses) {
            // Customise download screen
            Map sectionsMap = biocacheService.getFieldsMap()
            log.debug "sectionsMap = ${sectionsMap as JSON}"
            Map customSections = grailsApplication.config.downloads.customSections
            // customSections.darwinCore = sectionsMap.keySet()
            render (view:'options2', model: [
                    customSections: customSections,
                    mandatoryFields: grailsApplication.config.downloads.mandatoryFields,
                    userSavedFields: customiseService.getUserSavedFields(request?.cookies?.find { it.name == 'download_fields'}, authService?.getUserId()),
                    downloadParams: downloadParams
            ])
        } else if (downloadParams.downloadType == DownloadType.RECORDS.type) {
            // Records download -> confirm
            def json = downloadService.triggerDownload(downloadParams)
            log.debug "json = ${json}"
            render (view:'confirm', model: [
                    isQueuedDownload: true,
                    downloadParams: downloadParams,
                    json: json // Map
            ])
        } else if (downloadParams.downloadType == DownloadType.CHECKLIST.type) {
            // Checklist download
            def extraParamsString = "&facets=species_guid&lookup=true"
            render (view:'confirm', model: [
                    isQueuedDownload: false,
                    isChecklist: true,
                    downloadParams: downloadParams,
                    downloadUrl: grailsApplication.config.downloads.checklistDownloadUrl + downloadParams.biocacheDownloadParamString() + extraParamsString
            ])
        } else if (downloadParams.downloadType == DownloadType.FIELDGUIDE.type) {
            // Field guide download
            def extraParamsString = "&facets=species_guid"
            render (view:'confirm', model: [
                    isQueuedDownload: false,
                    isFieldGuide: true,
                    downloadParams: downloadParams,
                    downloadUrl: grailsApplication.config.downloads.fieldguideDownloadUrl + downloadParams.biocacheDownloadParamString() + extraParamsString
            ])
        }
    }

    def confirm () {
        // testing only
    }

    def saveUserPrefs() {
        List fields = params.list("fields")

        try {
            def res = customiseService.setUserSavedFields(authService?.getUserId(), fields)
            render res as JSON
        } catch (Exception ex) {
            log.error("Error saving user preferences: ${ex.message}", ex)
            render(status: "400", text: "Error saving user preferences: ${ex.message}")
        }

    }

    def getDescription(String id) {
        if (id) {
            String description = biocacheService.getDwCDescriptionForField(id)
            Map response = [field: id, description: ""]

            if (description) {
                response.description = description
            }

            render (response as JSON)
        } else {
            render (status: 400, text: "no field provided")
        }
    }
}
