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

class CustomiseService {
    def grailsApplication
    def webService

    final static String NAME_VALUE = grails.util.Metadata.current.'app.name' + '.download_saved_fields'

    def getUserSavedFields(userId) {
        def fields = []

        if (userId && grailsApplication.config.userdetails.baseUrl) {
            try {
                def resp = webService.get(grailsApplication.config.userdetails.baseUrl + '/property/getProperty',
                        [alaId: userId, name: NAME_VALUE])

                if (resp?.resp && resp?.resp[0]?.value) {
                    fields = JSON.parse(resp?.resp[0]?.value)
                }
            } catch (err) {
                //fail with only a log entry
                log.error("failed to get user property ${userId}:${NAME_VALUE} ${err.getMessage()}", err)
            }
        }

        fields
    }

    def setUserSavedFields(userId, List fields) {
        if (userId && grailsApplication.config.userdetails.baseUrl) {
            webService.post(grailsApplication.config.userdetails.baseUrl + '/property/saveProperty', null,
                    [alaId: userId, name: NAME_VALUE, value: (fields as JSON).toString()])
        }
    }
}
