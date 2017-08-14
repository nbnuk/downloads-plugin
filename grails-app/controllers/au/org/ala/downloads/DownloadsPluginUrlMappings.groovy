package au.org.ala.downloads

class DownloadsPluginUrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/download/"(controller: "download")
        "/fields"(controller: "download", action:"fields") // so CAS doesn't intercept

	}
}
