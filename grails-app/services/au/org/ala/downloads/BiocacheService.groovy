package au.org.ala.downloads

import grails.plugin.cache.Cacheable

/**
 * Service to access data from biocache-service
 */
class BiocacheService {

    def grailsApplication
    def webService

    /**
     * Get fields info from http://biocache.ala.org.au/ws/index/fields.
     * Example record:
     *
     * {
     *   dwcTerm: "basisOfRecord",
     *   downloadDescription: "Basis Of Record - processed",
     *   indexed: true,
     *   stored: true,
     *   downloadName: "basisOfRecord.p",
     *   multivalue: false,
     *   classs: "Record",
     *   description: "Basis Of Record - processed",
     *   dataType: "string",
     *   name: "basis_of_record"
     * }
     *
     * @return fields (List)
     */
    @Cacheable('longTermCache')
    def getBiocacheFields() {
        List fields
        Map resp = webService.get(grailsApplication.config.downloads.indexedFieldsUrl)

        if (resp?.resp) {
            fields = resp.resp
        } else {
            throw new Exception(resp?.error)
        }

        fields
    }

    @Cacheable('longTermCache')
    List getFieldsForDwcClass(String classsName) {
        if (!classsName) {
            throw new IllegalArgumentException("classsName argument not provided")
        }

        List fields = []
        Map fieldsMap = getFieldsMap()

        if (fieldsMap.containsKey(classsName)) {
            fields = fieldsMap.get(classsName)
        }

        fields
    }

    @Cacheable('longTermCache')
    Map getFieldsMap() {
        List fields = getBiocacheFields()
        Map fieldsByClassMap = [:]
        Map classLookup = grailsApplication.config.downloads.classMappings

        fields.each { field ->

            if (field && field?.dwcTerm && !field.dwcTerm.contains("_raw")) {
                String classsName = field?.classs ?: "Misc"
                String key = classLookup.get(classsName) ?: "Misc"
                List fieldsList = fieldsByClassMap.get(key) ?: []
                fieldsList.add(field?.downloadName)
                fieldsByClassMap.put(key, fieldsList) // overwrites with new list
            }
        }

        fieldsByClassMap
    }

    @Cacheable('longTermCache')
    String getDwCFields() {
        List fields = []
        Map fieldsMap = getFieldsMap()

        fieldsMap.keySet().each {
            log.debug "getDwCFields - ${it} = ${fieldsMap.get(it)}"
            fields.addAll(fieldsMap.get(it))
        }

        fields.join(",")
    }

    @Cacheable('longTermCache')
    String getDwCDescriptionForField(String field) {
        List fields = getBiocacheFields()

        Map entry = fields.find { it.dwcTerm == field }
        entry?.containsKey("downloadDescription") ? entry.get("downloadDescription") : ""
    }
}
