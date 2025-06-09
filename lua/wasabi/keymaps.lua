-- TODO: consider adding which-key .add() foo to every binding
local M = {};
local opts = { nil };

---- NVIM ----

-- visual
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yank",
	group = vim.api.nvim_create_augroup("Kickstart-highlihgt-yank", { clear = true, }),
	callback = function()
		vim.highlight.on_yank();
	end
});

-- cursor centering
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" });
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" });

vim.keymap.set("n", "n", "nzzzv", { desc = "next search and center" });
vim.keymap.set("n", "N", "Nzzzv", { desc = "prev search and center" });

-- prevent highlight drop
vim.keymap.set("v", ">", ">gv", { desc = "indent right without removing highlight" });
vim.keymap.set("v", "<", "<gv", { desc = "indent left without removing highlight" });

vim.keymap.set("v", "<leader>gc", "<leader>gcgv", { desc = "toogle comment" });

-- quality of life
vim.keymap.set("v", "K", ":m '<-2<CR>gv-gv", { desc = "moves lines down in visual mode" });
vim.keymap.set("v", "J", ":m '>+1<CR>gv-gv", { desc = "moves lines down in visual mode" });

-- simplifying
vim.keymap.set("n", "<leader>p", "\"+p", { desc = "paste from system clipboard" });
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "copy to system clipboard" });

vim.keymap.set("n", "<leader>dl", "0D", { desc = "delete line without new line char" });

vim.keymap.set("n", "<leader>br", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word cursor is on globally" });

-- tabs
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "create new tab" });
vim.keymap.set("n", "<leader>td", "<cmd>tabclose<CR>", { desc = "close current tab" });
vim.keymap.set("n", "<leader>tl", "<cmd>tabn<CR>", { desc = "next tab" });
vim.keymap.set("n", "<leader>th", "<cmd>tabp<CR>", { desc = "prev tab" });

-- split
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "split window vertically" });
vim.keymap.set("n", "<leader>sp", "<C-w>s", { desc = "split window horizontaly" });
vim.keymap.set("n", "<leader>sd", "<cmd>close<CR>", { desc = "close current split" });
vim.keymap.set("n", "<leader>sh", "<C-w>h", { desc = "split window horizontaly" });
vim.keymap.set("n", "<leader>sj", "<C-w>j", { desc = "close current split" });
vim.keymap.set("n", "<leader>sk", "<C-w>k", { desc = "split window horizontaly" });
vim.keymap.set("n", "<leader>sl", "<C-w>l", { desc = "close current split" });

vim.keymap.set("n", "<leader>srh", "<C-w>>", { desc = "resize split window (left)" });
vim.keymap.set("n", "<leader>srl", "<C-w><", { desc = "resize split window (right)" });
vim.keymap.set("n", "<leader>srk", "<C-w>+", { desc = "resize split window (up)" });
vim.keymap.set("n", "<leader>srj", "<C-w>-", { desc = "resize split window (down)" });
vim.keymap.set("n", "<leader>sr=", "<C-w>=", { desc = "resize split window (left)" });

vim.keymap.set("n", "<leader>fo", vim.cmd.Ex, { desc = "open file explorer" });
vim.keymap.set("n", "<leader>fs", "<cmd>Lexplore<CR>", { desc = "open side version of netrw" });

vim.keymap.set("n", "<leader>gp", function()
	local filePath = vim.fn.expand("%:~");
	vim.fn.setreg("+", filePath);
	vim.fn.setreg("\"", filePath);
end, { desc = "copies file path to clipboard" });

---- PLUGINS ----

-- TODO: change mappings of lsp foo's
function M.lsp(_, bufnr)
	opts = vim.tbl_deep_extend("force", opts, { buffer = bufnr });

	vim.keymap.set("n", "<leader>ge", vim.diagnostic.open_float,
		vim.tbl_deep_extend("force", opts, { desc = "open lsp diagnostics" }));
	vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format,
		vim.tbl_deep_extend("force", opts, { desc = "format current buffer" }));
	vim.keymap.set("n", "<leader>bd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "go to definition" }))
	vim.keymap.set("n", "<leader>br", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "show references" }))
	vim.keymap.set("n", "<leader>bD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "go to declaration" }))
	vim.keymap.set("n", "<leader>bI", vim.lsp.buf.implementation,
		vim.tbl_extend("force", opts, { desc = "go to implementation" }))
	vim.keymap.set("n", "<leader>gi", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "show hover info" }))
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "rename symbol" }))
	-- TODO: learn what are code actions
	-- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "code actions" }))
end

function M.labels()
	vim.keymap.set("n", "<leader>ll", "<cmd>TodoTelescope<cr>", { desc = "list all labels" });
	vim.keymap.set("n", "<leader>lfl", "<cmd>TodoTelescope keywords=FIX,FIXME,BUG,FIXIT,ISSUE,ERR<cr>",
		{ desc = "list all FIXME labels" });
	vim.keymap.set("n", "<leader>ltl", "<cmd>TodoTelescope keywords=TODO<cr>", { desc = "list all TODO labels" });
	vim.keymap.set("n", "<leader>lwl", "<cmd>TodoTelescope keywords=WARN,WARNING,XXX<cr>",
		{ desc = "list all WARN labels" });
	vim.keymap.set("n", "<leader>lil", "<cmd>TodoTelescope keywords=NOTE,INFO<cr>", { desc = "list all NOTE labels" });
	vim.keymap.set("n", "<leader>lol", "<cmd>TodoTelescope keywords=PERF,OPTIM,PERFORMANCE,OPTIMIZE<cr>",
		{ desc = "list all PERF labels" });
	vim.keymap.set("n", "<leader>lel", "<cmd>TodoTelescope keywords=TEST,TESTING,PASSED,FAILED<cr>",
		{ desc = "list all TEST labels" });

	vim.keymap.set("n", "<leader>ln", function() require("todo-comments").jump_next() end, { desc = "Next label" })
	vim.keymap.set("n", "<leader>lp", function() require("todo-comments").jump_prev() end, { desc = "Previous label" })

	vim.keymap.set("n", "<leader>lfn",
		function() require("todo-comments").jump_next({ keywords = { "FIX", "FIXME", "BUG", "FIXIT", "ISSUE", "ERR" } }) end,
		{ desc = "Next FIXME label" })
	vim.keymap.set("n", "<leader>lfp",
		function() require("todo-comments").jump_prev({ keywords = { "FIX", "FIXME", "BUG", "FIXIT", "ISSUE", "ERR" } }) end,
		{ desc = "Prev FIXME label" })

	vim.keymap.set("n", "<leader>ltn", function() require("todo-comments").jump_next({ keywords = { "TODO" } }) end,
		{ desc = "Next TODO label" })
	vim.keymap.set("n", "<leader>ltp", function() require("todo-comments").jump_prev({ keywords = { "TODO" } }) end,
		{ desc = "Prev TODO label" })

	vim.keymap.set("n", "<leader>lwn",
		function() require("todo-comments").jump_next({ keywords = { "WARN", "WARNING", "XXX" } }) end,
		{ desc = "Next WARN label" })
	vim.keymap.set("n", "<leader>lwp",
		function() require("todo-comments").jump_prev({ keywords = { "WARN", "WARNING", "XXX" } }) end,
		{ desc = "Prev WARN label" })

	vim.keymap.set("n", "<leader>lin",
		function() require("todo-comments").jump_next({ keywords = { "NOTE", "INFO" } }) end,
		{ desc = "Next NOTE label" })
	vim.keymap.set("n", "<leader>lip",
		function() require("todo-comments").jump_prev({ keywords = { "NOTE", "INFO" } }) end,
		{ desc = "Prev NOTE label" })

	vim.keymap.set("n", "<leader>lon",
		function() require("todo-comments").jump_next({ keywords = { "PERF", "OPTIM", "PERFORMANCE", "OPTIMIZE" } }) end,
		{ desc = "Next PERF label" })
	vim.keymap.set("n", "<leader>lop",
		function() require("todo-comments").jump_prev({ keywords = { "PERF", "OPTIM", "PERFORMANCE", "OPTIMIZE" } }) end,
		{ desc = "Prev PERF label" })

	vim.keymap.set("n", "<leader>len",
		function() require("todo-comments").jump_next({ keywords = { "TEST", "TESTING", "PASSED", "FAILED" } }) end,
		{ desc = "Next TEST label" })
	vim.keymap.set("n", "<leader>lep",
		function() require("todo-comments").jump_prev({ keywords = { "TEST", "TESTING", "PASSED", "FAILED" } }) end,
		{ desc = "Prev TEST label" })
end

return M;
