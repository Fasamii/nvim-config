local languages = "en_us,pl";
local spell_dir = vim.fn.stdpath("config") .. "/lua/wasabi/spell";

vim.fn.mkdir(spell_dir, "p");
vim.opt.spellfile = spell_dir .. "/spellfile.utf-8.add";

local function enable_spell()
	vim.opt.spell = true;
	vim.opt.spelllang = languages;
end;
local function disable_spell()
	vim.opt.spell = false;
end;
function SpellingToggle()
	if vim.opt.spell:get() then
		disable_spell();
	else
		enable_spell();
	end;
end;

local tl = {
	pickers = require('telescope.pickers'),
	finders = require('telescope.finders'),
	actions = require('telescope.actions'),
	action_state = require('telescope.actions.state'),
	conf = require('telescope.config').values,
};

-- TODO: make sure telescope sorter put most similar names nearer
-- TODO: make telescope replace word with searched word on enter if no result matches searched word
--	    make it add good word if entered with that method
-- TODO: review that foo (it was written by llm)
function GetSuggestion()
	-- Get current cursor position first
	local cursor_pos = vim.api.nvim_win_get_cursor(0)
	local row = cursor_pos[1] - 1 -- Convert to 0-indexed
	local col = cursor_pos[2]

	-- Get the current line
	local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
	if not line then return end

	-- Find word boundaries around cursor position
	local word_start = col
	local word_end = col

	-- If cursor is on a non-word character, try to find nearest word
	if not line:sub(col + 1, col + 1):match("%w") then
		-- Look forward first for a word character (more intuitive for coding)
		local found_word = false
		for i = col + 1, #line do
			if line:sub(i, i):match("%w") then
				col = i - 1 -- Adjust to 0-indexed position within word
				word_start = col
				word_end = col
				found_word = true
				break
			end
		end
		-- If no word found forward, look backwards
		if not found_word then
			for i = col, 1, -1 do
				if line:sub(i, i):match("%w") then
					col = i - 1 -- Adjust to 0-indexed position within word
					word_start = col
					word_end = col
					found_word = true
					break
				end
			end
		end
		if not found_word then return end
	end

	-- Find start of word (move backwards from cursor)
	while word_start > 0 and line:sub(word_start, word_start):match("%w") do
		word_start = word_start - 1
	end
	-- Adjust if we went too far back
	if word_start == 0 then
		if line:sub(1, 1):match("%w") then
			word_start = 1
		else
			word_start = word_start + 1
		end
	else
		word_start = word_start + 1
	end

	-- Find end of word (move forwards from cursor)
	while word_end < #line and line:sub(word_end + 1, word_end + 1):match("%w") do
		word_end = word_end + 1
	end

	-- Extract the actual word
	local word = line:sub(word_start, word_end)

	-- Get spell suggestions for the detected word
	local suggestions = vim.fn.spellsuggest(word, 20)

	if #suggestions == 0 then
		print("No spelling suggestions found for: " .. word)
		return
	end

	tl.pickers.new({}, {
		prompt_title = "Spell suggestions: " .. word,
		finder = tl.finders.new_table(suggestions),
		sorter = tl.conf.generic_sorter({}),
		attach_mappings = function(prompt_bufnr)
			tl.actions.select_default:replace(function()
				local selection = tl.action_state.get_selected_entry()
				tl.actions.close(prompt_bufnr)
				if selection == nil then return end

				-- Replace the word using nvim_buf_set_text (0-indexed for API)
				vim.api.nvim_buf_set_text(0, row, word_start - 1, row, word_end, { selection[1] })

				-- Position cursor at the end of the replaced word
				vim.api.nvim_win_set_cursor(0, { row + 1, word_start - 1 + #selection[1] })
			end)
			return true
		end,
	}):find()
end;

vim.keymap.set("n", "zt", SpellingToggle, { noremap = true, silent = true, desc = "Toggle spell checking" });
vim.keymap.set("n", "zn", function() vim.cmd("normal! ]s") end,
	{ noremap = true, silent = true, desc = "Next misspelled word" });
vim.keymap.set("n", "zp", function() vim.cmd("normal! [s") end,
	{ noremap = true, silent = true, desc = "Previous misspelled word" });
vim.keymap.set("n", "zg", function() vim.cmd("normal! zg") end,
	{ noremap = true, silent = true, desc = "Add word to dictionary" });
vim.keymap.set("n", "zw", function() vim.cmd("normal! zw") end,
	{ noremap = true, silent = true, desc = "Mark word as incorrect" });
vim.keymap.set("n", "zs", GetSuggestion,
	{ noremap = true, silent = true, nowait = true, desc = "Show spelling suggestions" });

enable_spell();
