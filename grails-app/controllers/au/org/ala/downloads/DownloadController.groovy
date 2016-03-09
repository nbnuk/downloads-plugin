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
    def customiseService

    static defaultAction = "download1"
    static removeParams = ["action","controller"]

    def download1() {
        cleanupParams(params)
        render (view:'/occurrence/download1', model: [
                searchParams: params.toQueryString()
        ])
    }

    def download2() {
        cleanupParams(params)
        def downloadType = params.downloadType
        def downloadFormat = params.format
        def downloadReason = params.reasonCode

        if (!downloadType || !downloadReason) {
            flash.message = "No type or reason selected. Please try again."
            redirect(action: "download1", params: params)
        } else if (downloadType == "basic-dwc" && downloadFormat == "custom") {
            render (view:'/occurrence/download2', model: [
                    customSections: grailsApplication.config.customSections,
                    mandatoryFields: grailsApplication.config.mandatoryFields,
                    userSavedFields: customiseService.getUserSavedFields()
            ])
        } else {
            render (view:'/occurrence/download3', model: [])
        }
    }

    def download3() {
        render (view:'/occurrence/download3')
    }

    private cleanupParams(params) {
        GrailsParameterMap paramsCopy = params.clone()
        paramsCopy.each {
            if (removeParams.contains(it.key)) {
                params.remove(it.key)
            }
        }
    }
}
