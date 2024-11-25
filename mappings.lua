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

M.gp = {
  plugin = true,
  -- Visual Mode mappings
  v = {
    ["<C-g><C-t>"] = { ":<C-u>'<,'>GpChatNew tabnew<cr>", "ChatNew tabnew" },
    ["<C-g><C-v>"] = { ":<C-u>'<,'>GpChatNew vsplit<cr>", "ChatNew vsplit" },
    ["<C-g><C-x>"] = { ":<C-u>'<,'>GpChatNew split<cr>", "ChatNew split" },
    ["<C-g>a"] = { ":<C-u>'<,'>GpAppend<cr>", "Visual Append (after)" },
    ["<C-g>b"] = { ":<C-u>'<,'>GpPrepend<cr>", "Visual Prepend (before)" },
    ["<C-g>c"] = { ":<C-u>'<,'>GpChatNew<cr>", "Visual Chat New" },
    -- ["<C-g>g"] = { group = "generate into new .." },
    ["<C-g>ge"] = { ":<C-u>'<,'>GpEnew<cr>", "Visual GpEnew" },
    ["<C-g>gn"] = { ":<C-u>'<,'>GpNew<cr>", "Visual GpNew" },
    ["<C-g>gp"] = { ":<C-u>'<,'>GpPopup<cr>", "Visual Popup" },
    ["<C-g>gt"] = { ":<C-u>'<,'>GpTabnew<cr>", "Visual GpTabnew" },
    ["<C-g>gv"] = { ":<C-u>'<,'>GpVnew<cr>", "Visual GpVnew" },
    ["<C-g>i"] = { ":<C-u>'<,'>GpImplement<cr>", "Implement selection" },
    ["<C-g>n"] = { "<cmd>GpNextAgent<cr>", "Next Agent" },
    ["<C-g>p"] = { ":<C-u>'<,'>GpChatPaste<cr>", "Visual Chat Paste" },
    ["<C-g>r"] = { ":<C-u>'<,'>GpRewrite<cr>", "Visual Rewrite" },
    ["<C-g>s"] = { "<cmd>GpStop<cr>", "GpStop" },
    ["<C-g>t"] = { ":<C-u>'<,'>GpChatToggle<cr>", "Visual Toggle Chat" },
    -- ["<C-g>w"] = { group = "Whisper" },
    ["<C-g>wa"] = { ":<C-u>'<,'>GpWhisperAppend<cr>", "Whisper Append" },
    ["<C-g>wb"] = { ":<C-u>'<,'>GpWhisperPrepend<cr>", "Whisper Prepend" },
    ["<C-g>we"] = { ":<C-u>'<,'>GpWhisperEnew<cr>", "Whisper Enew" },
    ["<C-g>wn"] = { ":<C-u>'<,'>GpWhisperNew<cr>", "Whisper New" },
    ["<C-g>wp"] = { ":<C-u>'<,'>GpWhisperPopup<cr>", "Whisper Popup" },
    ["<C-g>wr"] = { ":<C-u>'<,'>GpWhisperRewrite<cr>", "Whisper Rewrite" },
    ["<C-g>wt"] = { ":<C-u>'<,'>GpWhisperTabnew<cr>", "Whisper Tabnew" },
    ["<C-g>wv"] = { ":<C-u>'<,'>GpWhisperVnew<cr>", "Whisper Vnew" },
    ["<C-g>ww"] = { ":<C-u>'<,'>GpWhisper<cr>", "Whisper" },
    ["<C-g>x"] = { ":<C-u>'<,'>GpContext<cr>", "Visual GpContext" },
  },
  --
  -- -- Normal Mode mappings
  n = {
    ["<C-g><C-t>"] = { "<cmd>GpChatNew tabnew<cr>", "New Chat tabnew" },
    ["<C-g><C-v>"] = { "<cmd>GpChatNew vsplit<cr>", "New Chat vsplit" },
    ["<C-g><C-x>"] = { "<cmd>GpChatNew split<cr>", "New Chat split" },
    ["<C-g>a"] = { "<cmd>GpAppend<cr>", "Append (after)" },
    ["<C-g>b"] = { "<cmd>GpPrepend<cr>", "Prepend (before)" },
    ["<C-g>c"] = { "<cmd>GpChatNew<cr>", "New Chat" },
    ["<C-g>f"] = { "<cmd>GpChatFinder<cr>", "Chat Finder" },
    -- ["<C-g>g"] = { group = "generate into new .." },
    ["<C-g>ge"] = { "<cmd>GpEnew<cr>", "GpEnew" },
    ["<C-g>gn"] = { "<cmd>GpNew<cr>", "GpNew" },
    ["<C-g>gp"] = { "<cmd>GpPopup<cr>", "Popup" },
    ["<C-g>gt"] = { "<cmd>GpTabnew<cr>", "GpTabnew" },
    ["<C-g>gv"] = { "<cmd>GpVnew<cr>", "GpVnew" },
    ["<C-g>n"] = { "<cmd>GpNextAgent<cr>", "Next Agent" },
    ["<C-g>r"] = { "<cmd>GpRewrite<cr>", "Inline Rewrite" },
    ["<C-g>s"] = { "<cmd>GpStop<cr>", "GpStop" },
    ["<C-g>t"] = { "<cmd>GpChatToggle<cr>", "Toggle Chat" },
    -- ["<C-g>w"] = { group = "Whisper" },
    ["<C-g>wa"] = { "<cmd>GpWhisperAppend<cr>", "Whisper Append (after)" },
    ["<C-g>wb"] = { "<cmd>GpWhisperPrepend<cr>", "Whisper Prepend (before)" },
    ["<C-g>we"] = { "<cmd>GpWhisperEnew<cr>", "Whisper Enew" },
    ["<C-g>wn"] = { "<cmd>GpWhisperNew<cr>", "Whisper New" },
    ["<C-g>wp"] = { "<cmd>GpWhisperPopup<cr>", "Whisper Popup" },
    ["<C-g>wr"] = { "<cmd>GpWhisperRewrite<cr>", "Whisper Inline Rewrite" },
    ["<C-g>wt"] = { "<cmd>GpWhisperTabnew<cr>", "Whisper Tabnew" },
    ["<C-g>wv"] = { "<cmd>GpWhisperVnew<cr>", "Whisper Vnew" },
    ["<C-g>ww"] = { "<cmd>GpWhisper<cr>", "Whisper" },
    ["<C-g>x"] = { "<cmd>GpContext<cr>", "Toggle GpContext" },
  },
  --
  -- -- Insert Mode mappings
  -- -- Insert mode mappings (continued)
  i = {
    ["<C-g><C-t>"] = { "<cmd>GpChatNew tabnew<cr>", "New Chat tabnew" },
    ["<C-g><C-v>"] = { "<cmd>GpChatNew vsplit<cr>", "New Chat vsplit" },
    ["<C-g><C-x>"] = { "<cmd>GpChatNew split<cr>", "New Chat split" },
    ["<C-g>a"] = { "<cmd>GpAppend<cr>", "Append (after)" },
    ["<C-g>b"] = { "<cmd>GpPrepend<cr>", "Prepend (before)" },
    ["<C-g>c"] = { "<cmd>GpChatNew<cr>", "New Chat" },
    ["<C-g>f"] = { "<cmd>GpChatFinder<cr>", "Chat Finder" },
    -- ["<C-g>g"] = { group = "generate into new .." },
    ["<C-g>ge"] = { "<cmd>GpEnew<cr>", "GpEnew" },
    ["<C-g>gn"] = { "<cmd>GpNew<cr>", "GpNew" },
    ["<C-g>gp"] = { "<cmd>GpPopup<cr>", "Popup" },
    ["<C-g>gt"] = { "<cmd>GpTabnew<cr>", "GpTabnew" },
    ["<C-g>gv"] = { "<cmd>GpVnew<cr>", "GpVnew" },
    ["<C-g>n"] = { "<cmd>GpNextAgent<cr>", "Next Agent" },
    ["<C-g>r"] = { "<cmd>GpRewrite<cr>", "Inline Rewrite" },
    ["<C-g>s"] = { "<cmd>GpStop<cr>", "GpStop" },
    ["<C-g>t"] = { "<cmd>GpChatToggle<cr>", "Toggle Chat" },
    -- ["<C-g>w"] = { group = "Whisper" },
    ["<C-g>wa"] = { "<cmd>GpWhisperAppend<cr>", "Whisper Append (after)" },
    ["<C-g>wb"] = { "<cmd>GpWhisperPrepend<cr>", "Whisper Prepend (before)" },
    ["<C-g>we"] = { "<cmd>GpWhisperEnew<cr>", "Whisper Enew" },
    ["<C-g>wn"] = { "<cmd>GpWhisperNew<cr>", "Whisper New" },
    ["<C-g>wp"] = { "<cmd>GpWhisperPopup<cr>", "Whisper Popup" },
    ["<C-g>wr"] = { "<cmd>GpWhisperRewrite<cr>", "Whisper Inline Rewrite" },
    ["<C-g>wt"] = { "<cmd>GpWhisperTabnew<cr>", "Whisper Tabnew" },
    ["<C-g>wv"] = { "<cmd>GpWhisperVnew<cr>", "Whisper Vnew" },
    ["<C-g>ww"] = { "<cmd>GpWhisper<cr>", "Whisper" },
    ["<C-g>x"] = { "<cmd>GpContext<cr>", "Toggle GpContext" },
  },

}
-- more keybinds!


return M
