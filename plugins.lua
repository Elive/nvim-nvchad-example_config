local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  -- Null-ls is a plugin that allows neovim to act as a language server client without the need for a language server. It can complement extra features for languages like formatting, linting, and more.
  -- you may probably don't need this if you don't know how to use it
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
    -- this solves a bug where gives warning messages: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428 , especially when using with copilot
    on_init = function(new_client, _)
      new_client.offset_encoding = 'utf-16'  -- this fixes a bug about the offset encoding, there's another reference to possibly this issue:  https://www.lazyvim.org/configuration/recipes#fix-clangd-offset-encoding
    end,
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

  -- Overwrite CMP menu default behaviours, if you want to
  -- nvim-cmp user overwrites (disable autocompletion, for example) {{{
  -- {
  --   "hrsh7th/nvim-cmp",
  --   opts = {
  --     completion = {
  --       autocomplete = false, -- elivim: copilot: uncomment to not show the cmp autocompletion menu automatically while typing
  --     },
        -- require("core.utils").load_mappings "cmp"
  --   },
  -- },
  -- }}}

  --[[ Copilot
  -- uncomment the entire commented block if you want to enable Copilot
  -- TIP: search for the "elivim" keywords to see special settings, like disabling the automatic showing up of the CMP autocompletion menu that is obtrusive with the copilot results
  -- copilot.lua {{{
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    init = function()
      -- load special mappings that also shows up on which-key
      require("core.utils").load_mappings "copilot"
    end,
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
            -- accept = "<M-l>",
            accept = "<C-y>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            --dismiss = "<C-]>",
            dismiss = "<C-e>", -- make it compatible / same with Cmp menu
          },
        },
        filetypes = {
          yaml = true,
          markdown = true,
          asciidoc = true,
          help = false,
          gitcommit = true,
          gitrebase = true,
          hgcommit = false,
          svn = false,
          cvs = false,
          javascript = true, -- allow specific filetype
          typescript = true, -- allow specific filetype
          ["."] = false,

          -- Note: if you set all other filetypes to false to skip NeoVim features (plugins) contents to be parsed on Copilot, you can use this list:
          --["*"] = false, -- disable for all other filetypes and ignore default `filetypes`
          -- asciidoc = true, automake = true, awk = true, bash = true, c = true, cfg = true, cmake = true, cpp = true, css = true, d = true, debcontrol = true, desktop = true, diff = true, doxygen = true, erlang = true, eruby = true, gitcommit = true, gitconfig = true, go = true, gtkrc = true, html = true, htmlchetah = true, htmldjango = true, htmlm4 = true, java = true, javacc = true, javascript = true, javascriptreact = true, js = true, json = true, lisp = true, lua = true, m4 = true, make = true, markdown = true, meson = true, msql = true, muttrc = true, mysql = true, neomuttrc = true, netrc = true, ninja = true, ocaml = true, perl = true, perl6 = true, php = true, phtml = true, plqsl = true, po = true, procmail = true, python = true, r = true, ruby = true, rust = true, samba = true, scala = true, scheme = true, sh = true, slang = true, splint = true, sysctl = true, systemd = true, tcl = true, tcsh = true, text = true, tmux = true, typescript = true, udevrules = true, valgrind = true, vim = true, vue = true, wdiff = true, xdefaults = true, xf86conf = true, xhtml = true, xml = true, xmodmap = true, xslt = true, yacc = true, yaml = true, zsh = true,

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
    init = function()
      -- load special mappings that also shows up on which-key
      require("core.utils").load_mappings "cmp"
    end,
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
        { name = 'nvim_lsp_signature_help', priority = 700, max_item_count = 3, },
      },
    -- Hide copilot suggestion when cmp popup is open, Elivim: useful if you open it automatically with TAB but not when it shows all the time:
      -- TODO: make it to be only enabled when the variable of 'opts.completion.autocomplete' is set to true:
      --
      -- require("cmp").event:on("menu_opened", function()
      --   vim.b.copilot_suggestion_hidden = true
      -- end),
      -- require("cmp").event:on("menu_closed", function()
      --   vim.b.copilot_suggestion_hidden = false
      -- end),
    },
  },
  -- }}}
--]] -- Copilot



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
