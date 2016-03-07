package au.org.ala.downloads

class DownloadController {
    static defaultAction = "download1"

    def download1() {
        render (view:'/occurrence/download1', model: [])
    }

    def download2() {
        render (view:'/occurrence/download2', model: [
                darwinCoreGroups: grailsApplication.config.darwinCoreGroups,
                speciesTraitsGroup: grailsApplication.config.speciesTraitsGroup,
                spatialIntersectionsGroup: grailsApplication.config.spatialIntersectionsGroup,
                qualityGroup: grailsApplication.config.qualityGroup
        ])
    }

    def download3() {
        render (view:'/occurrence/download3', model: [])
    }
}
