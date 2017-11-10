package au.org.ala.downloads

import grails.transaction.Transactional
import org.grails.web.json.JSONObject

class DoiService {

    def grailsApplication
    def webService

    def listDownloadsDoi(String userId, String sortColumn = "dateMinted", String order = "DESC", String offset = 0, String max = 10) {
        def result = webService.get(grailsApplication.config.doiService.baseUrl + "/api/doi?userId=${userId}&sort=${sortColumn}&order=${order}&offset=${offset}&max=${max}")
        (result.resp.list as ArrayList).each {
            Map map = (it as Map)
            map.put("searchQuery", URLDecoder.decode(map.applicationMetadata?.searchUrl, "UTF-8"))
            map.put("occurrencesCount", map.applicationMetadata?.occurrences)
            map.put("datasetCounts", map.applicationMetadata?.datasets.size())
            map.put("displayDate", new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(map.dateMinted))
        }
        return result
    }

    def getDoi(String doi = null) {
        Map result = [:]
        if (doi) {
            result = webService.get(grailsApplication.config.doiService.baseUrl + "/api/doi/${doi}")
        }
        return result
    }

}
