---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
}

M.cmp = {
  plugin = true,
  [''] = {
    -- Menu cmp
    ["<leader>tm"] = {
      "<cmd> lua require('cmp').setup.buffer { enabled = true }<CR>",
      "Menu suggestions (cmp) enable",
    },
    ["<leader>tM"] = {
      "<cmd> lua require('cmp').setup.buffer { enabled = false }<CR>",
      "Menu suggestions (cmp) disable",
    },
  },
}

M.copilot = {
    plugin = true,
  [''] = {
    -- Copilot
    ["<leader>tc"] = {
      "<cmd> lua require('copilot.suggestion').toggle_auto_trigger()<CR><cmd>Copilot status<CR>",
      "Copilot toggle suggestions",
    },
    ["<leader>tC"] = {
      "<cmd>Copilot disable<CR>",
      "Copilot disable",
    },
    -- toggles
    -- multiple copilot options, autosuggests / enable / disable, but normally with the previous one we should have enough
    -- ["<leader>tcs"] = {
    --   "<cmd> lua require('copilot.suggestion').toggle_auto_trigger()<CR><cmd>Copilot status<CR>",
    --   "toggle Copilot suggestions",
    --   { silent = true },
    -- },
    -- ["<leader>tcd"] = {
    --   "<cmd>Copilot disable<CR>",
    --   "toggle Copilot (disable)",
    --   { silent = true },
    -- },
    -- ["<leader>tce"] = {
    --   "<cmd>Copilot enable<CR>",
    --   "toggle Copilot (enable)",
    --   { silent = true },
    -- -- },
  },
}

-- more keybinds!


return M
