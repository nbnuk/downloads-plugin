class DownloadsPluginUrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/occurrences/download"(view:"/occurrence/download1")
        "500"(view:'/error')
	}
}
