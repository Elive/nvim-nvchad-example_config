---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
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
    -- -- do not enable this one or it will make c-e not working
    -- ["<A-]>"] = {
    --   "<Nop>",
    --   "Copilot suggestion next",
    -- },
    -- ["<A-[>"] = {
    --   "<Nop>",
    --   "Copilot suggestion prev",
    -- },
    -- ["<C-y>"] = {
    --   "<Nop>",
    --   "Copilot accept",
    -- },
    -- ["<C-e>"] = {
    --   "<Nop>",
    --   "Copilot cancel",
    -- },
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
