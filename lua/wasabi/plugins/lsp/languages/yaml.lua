return {
	yamlls = {
		settings = {
			yaml = {
				schemaStore = {
					enable = false,
					url = "",
				},
				schemas = require("schemastore").yaml.schemas(),
				validate = true,
				format = { enable = true },
				hover = true,
				completion = true,
				customTags = {
					"!fn",
					"!And",
					"!If",
					"!Not",
					"!Equals",
					"!Or",
					"!FindInMap sequence",
				},
			},
		},
	},
}
