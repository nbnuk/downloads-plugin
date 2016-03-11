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

/**
 * Service to perform the triggerDownload (marshalls to appropriate web service)
 */
class DownloadService {
    // http://biocache.ala.org.au/ws/occurrences/index/download?q=state%3A%22Australian+Capital+Territory%22&fq=-raw_taxon_name%3A*&fq=multimedia%3A%22Image%22&email=nick.dosremedios@csiro.au&sourceTypeId=0&reasonTypeId=10&file=legacy&extra=dataResourceUid,dataResourceName.p,occurrenceStatus.p
    def grailsApplication

    def triggerDownload(DownloadParams downloadParams) throws Exception {
        if (downloadParams.downloadType == "basic-dwc") {
            triggerOfflineDownload(downloadParams)
        } else {
            log.warn "Other download types not yet implemented"
        }
    }

    def triggerOfflineDownload(DownloadParams downloadParams) {
        String url = grailsApplication.config.indexedDownloadUrl + downloadParams.toString()
        log.debug "Doing GET on ${url}"
        def json = get(url)
        json
    }

    private  get(String url){
        get(url,true)
    }

    private String get(String url, boolean throwError) {
        log.debug "GET on " + url
        URLConnection conn = new URL(url).openConnection()
        try {
            conn.setConnectTimeout(10000)
            conn.setReadTimeout(50000)
            def content = conn.content
            log.debug "content instanceof = ${content.class.getName()}"
            if (content instanceof Object) {

            }
            return conn.content.text
        } catch (SocketTimeoutException e) {
            if(throwError)
                throw e
            else{
                def error = [error: "Timed out calling web service. URL= ${url}."]
                println error.error
                return new groovy.json.JsonBuilder( error ).toString()
            }
        } catch (Exception e) {
            if(throwError)
                throw e;
            else{
                def error = [error: "Failed calling web service. ${e.getClass()} ${e.getMessage()} URL= ${url}."]
                println error.error
                return new groovy.json.JsonBuilder( error ).toString()
            }
        }
    }
}
