-------------------
-- vim-specific  --
-------------------
-- cursor centering
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" });
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" });

vim.keymap.set("n", "n", "nzzzv", { desc = "next search and center" });
vim.keymap.set("n", "N", "Nzzzv", { desc = "prev search and center" });

-- prevent highlight drop
vim.keymap.set("v", ">", ">gv", { desc = "indent right without removing highlight" });
vim.keymap.set("v", "<", "<gv", { desc = "indent left without removing highlight" });

-- quality of life
vim.keymap.set("v", "K", ":m '<-2<CR>gv-gv", { desc = "moves lines down in visual mode" });
vim.keymap.set("v", "J", ":m '>+1<CR>gv-gv", { desc = "moves lines down in visual mode" });

vim.keymap.set("n", "<leader>p", "\"+p", { desc = "paste from system clipboard" });
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "copy to system clipboard" });

vim.keymap.set("n", "<leader>dl", "0D", { desc = "delete line without new line char" });

vim.keymap.set("n", "<leader>br", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word cursor is on globally" });

vim.keymap.set("n", "<leader>gp", function()
	local filePath = vim.fn.expand("%:~");
	vim.fn.setreg("+", filePath);
	vim.fn.setreg("\"", filePath);
end, { desc = "copies file path to clipboard" });

-- tabs
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "create new tab" });
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "close current tab" });
vim.keymap.set("n", "<leader>tl", "<cmd>tabn<CR>", { desc = "next tab" });
vim.keymap.set("n", "<leader>th", "<cmd>tabp<CR>", { desc = "prev tab" });
-- split
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "split window vertically" });
vim.keymap.set("n", "<leader>sp", "<C-w>s", { desc = "split window horizontaly" });
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "close current split" });
vim.keymap.set("n", "<leader>sh", "<C-w>h", { desc = "split window horizontaly" });
vim.keymap.set("n", "<leader>sj", "<C-w>j", { desc = "close current split" });
vim.keymap.set("n", "<leader>sk", "<C-w>k", { desc = "split window horizontaly" });
vim.keymap.set("n", "<leader>sl", "<C-w>l", { desc = "close current split" });

-- visual
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yank",
	group = vim.api.nvim_create_augroup("Kickstart-highlihgt-yank", { clear = true; }),
	callback = function()
		vim.highlight.on_yank();
	end
});

-- open
vim.keymap.set("n", "<leader>fo", vim.cmd.Ex, { desc = "open file explorer" });

--------------------------
-- lsp-specific (lsp.lua) --
--------------------------
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "open lsp diagnostics" });
vim.keymap.set("n", "<leader>bf", vim.lsp.buf.format);

--------------------------
-- todo-comments (tags.lua) --
--------------------------
vim.keymap.set("n", "<leader>ll", "<cmd>TodoTelescope<cr>", { desc = "sohow list of all tags" });
vim.keymap.set("n", "<leader>ltl", "<cmd>TodoTelescope keywords=TODO<cr>", { desc = "sohow list of all tags" });
vim.keymap.set("n", "<leader>lfl", "<cmd>TodoTelescope keywords=FIXME<cr>", { desc = "sohow list of all tags" });

vim.keymap.set("n", "<leader>ln", function()
  require("todo-comments").jump_next()
end, { desc = "Next tag comment" })

vim.keymap.set("n", "<leader>lp", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous tag comment" })

vim.keymap.set("n", "<leader>ltn", function()
  require("todo-comments").jump_next({keywords = { "TODO" }})
end, { desc = "Next TODO comment" })

vim.keymap.set("n", "<leader>ltp", function()
  require("todo-comments").jump_next({keywords = { "TODO" }})
end, { desc = "Next TODO comment" })

vim.keymap.set("n", "<leader>lfn", function()
  require("todo-comments").jump_next({keywords = { "FIXME" }})
end, { desc = "Next FIXME comment" })

vim.keymap.set("n", "<leader>lfp", function()
  require("todo-comments").jump_next({keywords = { "FIXME" }})
end, { desc = "Next FIXME comment" })
