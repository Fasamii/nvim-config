require("Comment").setup({
	padding = true,
	sticky = true,
	ignore = "^$",
	mappings = {
		---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
		basic = false,
		---Extra mapping; `gco`, `gcO`, `gcA`
		extra = false,
	},
	---Function to call before (un)comment
	pre_hook = nil,
	---Function to call after (un)comment
	post_hook = nil,
});

require("keymaps").comment(require("Comment.api"));
