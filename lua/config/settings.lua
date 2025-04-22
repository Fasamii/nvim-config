local themes = { "solarized-osaka", "mellow", "tokyo", "everforest" }; -- turned off { "lackluster" };

math.randomseed(os.time())

return {

	plugins = true,

	theme = themes[math.random(1, #themes)],

	globalRootDir = "$HOME/workspace",

	smoothScrool = false,

	languages = {
		-- recomended --
		"c",
		"lua",
		"vim",
		"vimdoc",
		"query",
		-- additional --
		"rust",
		"javascript",
		"typescript",
		"python",
		"java",
	},
}
