class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/"(controller:"menu")
		"/controllerList"(view:"/controllerList")
		"500"(view:'/error')
	}
}
