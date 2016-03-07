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

class DownloadController {
    def customiseService

    static defaultAction = "download1"

    def download1() {
        render (view:'/occurrence/download1', model: [])
    }

    def download2() {
        render (view:'/occurrence/download2', model: [
                customSections: grailsApplication.config.customSections,
                mandatoryFields: grailsApplication.config.mandatoryFields,
                userSavedFields: customiseService.getUserSavedFields()
        ])
    }

    def download3() {
        render (view:'/occurrence/download3', model: [])
    }
}
