---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

-- never show the cursor column
vim.opt.cursorcolumn = false  -- disable cursorcolumn which seems to appear in Mardown files

M.ui = {
  theme = "elive_molokai", -- your default theme
  theme_toggle = { "elive_molokai", "one_light" }, -- your selected both dark and light themes
  -- transparency = true,  -- make the editor transparent

  --changed_themes = {  -- overwrite theme / colorscheme values here:
      --elive_molokai = {
          --base_16 = {
              --base00 = "#1c1726",  -- change your editor background to a one a little more purple-ish
          --},
      --},
  --},


  hl_override = highlights.override,
  hl_add = highlights.add,
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
