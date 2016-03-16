package au.org.ala.downloads

import grails.converters.JSON
import grails.plugin.cache.Cacheable
import org.codehaus.groovy.grails.web.json.JSONElement
import org.springframework.web.client.RestClientException

class WebService {

    def grailsApplication

    @Cacheable('longTermCache')
    def getBiocacheFields() {
        def url = grailsApplication.config.indexedFieldsUrl
        JSONElement json = getJsonElements(url)
        json
    }

    /**
     * Perform a HTTP GET for a URL string with Exception handling required
     *
     * @param url
     * @param throwError
     * @return
     */
    private String get(String url, Boolean throwError = true) {
        log.debug "GET on " + url
        URLConnection conn = new URL(url).openConnection()
        try {
            conn.setConnectTimeout(10000)
            conn.setReadTimeout(50000)
//            TODO: check for expected object type that can handle the .text property
//            def content = conn.content
//            log.debug "content instanceof = ${content.class.getName()}"
//            if (content instanceof Object) {
//
//            }
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

    /**
     * Perform HTTP GET on a JSON web service
     *
     * @param url
     * @return
     */
    def JSONElement getJsonElements(String url) {
        log.debug "(internal) getJson URL = " + url
        def conn = new URL(url).openConnection()
        try {
            conn.setConnectTimeout(10000)
            conn.setReadTimeout(50000)
            def json = conn.content.text
            return JSON.parse(json)
        } catch (Exception e) {
            def error = "Failed to get json from web service (${url}). ${e.getClass()} ${e.getMessage()}, ${e}"
            log.error error
            throw new RestClientException(error)
        }
    }
}
