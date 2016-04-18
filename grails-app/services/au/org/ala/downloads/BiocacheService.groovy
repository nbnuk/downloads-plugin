package au.org.ala.downloads

import grails.plugin.cache.Cacheable

class BiocacheService {

    def grailsApplication
    def webService

    @Cacheable('longTermCache')
    def getBiocacheFields() {
        List fields = []
        Map resp = webService.get(grailsApplication.config.indexedFieldsUrl)

        if (resp?.resp) {
            fields = resp.resp
        } else {
            throw new Exception(resp?.error)
        }

        fields
    }
}
