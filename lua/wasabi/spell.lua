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

-- FIXME: replacing word while cursor is on the last char doubles the insert
-- FIXME: make telescope sorter put most similar names nearer
-- FIXME: make telescope replace word with searched word on enter if no result matches searched word
--	    make it add good word if entered with that method
function GetSuggestion()
	local word = vim.fn.expand("<cword>");
	local suggestions = vim.fn.spellsuggest(word, 20);
	tl.pickers.new({}, {
		prompt_title = "Spell suggestions: " .. word,
		finder = tl.finders.new_table(suggestions),
		sorter = tl.conf.generic_sorter({}),
		attach_mappings = function(prompt_bufnr)
			tl.actions.select_default:replace(function()
				local selection = tl.action_state.get_selected_entry()
				tl.actions.close(prompt_bufnr)
				if selection == nil then return end
				vim.cmd("normal! ciw" .. selection[1])
			end)
			return true
		end,
	}):find()
end;

vim.keymap.set("n", "zt", SpellingToggle, { noremap = true, silent = true, desc = "Toggle spell checking" });
vim.keymap.set("n", "zn", function() vim.cmd("normal! ]s") end, { noremap = true, silent = true, desc = "Next misspelled word" });
vim.keymap.set("n", "zp", function() vim.cmd("normal! [s") end, { noremap = true, silent = true, desc = "Previous misspelled word" });
vim.keymap.set("n", "zg", function() vim.cmd("normal! zg") end, { noremap = true, silent = true, desc = "Add word to dictionary" });
vim.keymap.set("n", "zw", function() vim.cmd("normal! zw") end, { noremap = true, silent = true, desc = "Mark word as incorrect" });
vim.keymap.set("n", "zs", GetSuggestion, { noremap = true, silent = true, nowait = true, desc = "Show spelling suggestions" });

enable_spell();
