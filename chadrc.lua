---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "elive_molokai", -- your default theme
  theme_toggle = { "elive_molokai", "one_light" }, -- your selected both dark and light themes

  --changed_themes = {  -- overwrite theme / colorscheme values here:
      --elive_molokai = {
          --base_16 = {
              --base00 = "#2d263c",  -- your desired background on the editor
          --}
      --}
  --}


  hl_override = highlights.override,
  hl_add = highlights.add,
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
