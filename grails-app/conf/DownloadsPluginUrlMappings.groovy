class DownloadsPluginUrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/occurrences/download1"(controller: "download", action:"download1")
        "/occurrences/download2"(controller: "download", action:"download2")
        "/occurrences/download3"(controller: "download", action:"download3")
        "500"(view:'/error')
	}
}
