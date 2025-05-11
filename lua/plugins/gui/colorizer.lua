return {
	"norcalli/nvim-colorizer.lua",
	lazy = false,
	priority = 10,
	config = function ()
		require("colorizer").setup({
			html = {
				mode = "background",
				rgb_fn = true,
				names = true,
			},
			css = {
				mode = "background",
				rgb_fn = true,
				names = true,
			},
		})
	end,
}
