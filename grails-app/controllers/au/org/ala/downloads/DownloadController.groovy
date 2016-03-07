package au.org.ala.downloads

class DownloadController {
    static defaultAction = "download1"

    def download1() {
        render (view:'/occurrence/download1', model: [])
    }


}
