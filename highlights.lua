-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  -- Comment = {
  --   italic = true,  -- put comments in italic mode
  -- },
  -- CopilotSuggestion = { fg = "nord_blue" }, -- change the color of the Copilot text
  -- WinSeparator = { fg = "sun" }, -- windows (splits) separator, in case you feel the default one not good to differentiate with other elements
}

---@type HLTable
M.add = {
  NvimTreeOpenedFolderName = { fg = "green", bold = true },
}

return M
