class DownloadsPluginUrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/download/"(controller: "download")
//        "/download/options2"(controller: "download", action:"options2")
//        "/download/confirm"(controller: "download", action:"download3")
        "500"(view:'/error')
	}
}
