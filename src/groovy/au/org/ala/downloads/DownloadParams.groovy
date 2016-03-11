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

import grails.validation.Validateable
import groovy.util.logging.Log4j
import org.codehaus.groovy.grails.web.util.WebUtils

/**
 * Form backing bean for triggerDownload params
 *
 * @author "Nick dos Remedios <Nick.dosRemedios@csiro.au>"
 */
@Validateable
@Log4j
class DownloadParams {
    String searchParams
    String targetUri
    String downloadType
    String downloadFormat
    String reasonTypeId
    String extra = "dataResourceUid,dataResourceName.p,occurrenceStatus.p"
    String file = "data"
    String email

    @Override
    public String toString() {
        Map paramsMap = [:]
        List excludeParams = ["class","constraints","errors","ValidationErrors","action","controller"]
        this.properties.each { prop, val ->
            if (val && !excludeParams.contains(prop)) {
                paramsMap.put(prop, val)
            }
        }
        log.debug "paramsMap = ${paramsMap}"

        WebUtils.toQueryString(paramsMap)
    }
}
