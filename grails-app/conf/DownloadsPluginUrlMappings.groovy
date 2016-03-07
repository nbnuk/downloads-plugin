class DownloadsPluginUrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/occurrences/download1"(controller: "download", action:"")
        "/occurrences/download2"(view:"/occurrence/download2")
        "/occurrences/download3"(view:"/occurrence/download3")
        "500"(view:'/error')
	}
}
