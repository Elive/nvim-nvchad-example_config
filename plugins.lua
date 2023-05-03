local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },


  --[[ Copilot:
  -- uncomment the entire commented block if you want to enable Copilot
  -- TIP: search for the "elivim" keywords to see special settings, like disabling the automatic showing up of the CMP autocompletion menu that is obtrusive with the copilot results
  -- copilot.lua {{{
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = false,  -- Elivim: enable or disable the copilot panel feature, this is a floating window that displays the current copilot suggestion
          auto_refresh = true,
          keymap = {
            jump_prev = "<c-p>",
            jump_next = "<c-n>",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>"
          },
          layout = {
            position = "right", -- | top | left | right
            ratio = 0.4
          },
        },
        suggestion = {
          enabled = true,
          --auto_trigger = false, -- Elivim: if the cmp autocomplete menu is not showing by default automatically while you type, setting this to true is recommended
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            --dismiss = "<C-]>",
            dismiss = "<C-e>", -- make it compatible / same with Cmp menu
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          javascript = true, -- allow specific filetype
          typescript = true, -- allow specific filetype
          ["."] = false,
          --["*"] = false, -- disable for all other filetypes and ignore default `filetypes`
          sh = function ()
            if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
              -- disable for .env files
              return false
            end
            return true
          end,
        },
        copilot_node_command = 'node', -- Node.js version must be > 16.x
        server_opts_overrides = {
          trace = "verbose",
          settings = {
            advanced = {
              listCount = 6, -- #completions for panel
              inlineSuggestCount = 5, -- #completions for getCompletions
            }
          },
        },
      })
    end,
  },
  -- }}}
  -- copilot-cmp (integrated in cmp menu) {{{
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function ()
      require("copilot_cmp").setup({
        formatters = {
          -- The label field corresponds to the function returning the label of the entry in nvim-cmp, insert_text corresponds to the actual text that is inserted, and preview corresponds to the text shown in the documentation window when hovering the completion.
          label = require("copilot_cmp.format").format_label_text,
          -- insert_text = require("copilot_cmp.format").format_insert_text, -- default conf
          insert_text = require("copilot_cmp.format").remove_existing, -- There is an experimental method for attempting to remove extraneous characters such as extra ending parenthesis that appears to work fairly well. If you wish to use it, simply place the following in your setup function:
          preview = require("copilot_cmp.format").deindent,
        },
      })
    end
  },
  -- }}}
  -- nvim-cmp (main conf needs overwrite special settings for copilot) {{{
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
    opts = {
      completion = {
        -- autocomplete = false, -- elivim: copilot: uncomment to not show the cmp autocompletion menu automatically while typing
      },
      sources = {
        -- NOTE: important to keep the same list and values as the original conf (+copilot entry) if you want to use the same features, so this is not a merge but a replacement
        { name = "nvim_lsp", priority = 700 },
        { name = "luasnip", priority = 500 },
        {
          name = "buffer",
          priority = 1000,
          max_item_count = 5,  -- show a maximum of 2 result for "buffer" items
          option = {
            get_bufnrs = function() return vim.api.nvim_list_bufs() end,
          },
        },
        { name = "nvim_lua", priority = 500 },
        { name = "path", priority = 1000, max_item_count = 3, },
        {
          name = "copilot", -- show up the copilot entry
          priority = 800,
          max_item_count = 3,
        },
      },
    },
  },
  -- }}}
-- ]]



  -- --
  -- Suggested plugins:
  -- --
  -- Minimap: https://github.com/wfxr/minimap.vim - but the Tagbar feature (F6) is a better option to go to specific places of the code


  -- Install a plugin
  --{
    --"max397574/better-escape.nvim",
    --event = "InsertEnter",
    --config = function()
      --require("better_escape").setup()
    --end,
  --},

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

}

return plugins

-- vim: set foldmethod=marker :
