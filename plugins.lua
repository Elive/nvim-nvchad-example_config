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
          hide_during_completion = true,
          debounce = 75,
          keymap = {
            -- accept = "<M-l>",
            accept = "<C-y>",
            accept_word = false,
            -- accept_line = false,
            accept_line = "<C-l>",
            next = "<M-]>",
            prev = "<M-[>",
            --dismiss = "<C-]>",
            dismiss = "<C-e>", -- make it compatible / same with Cmp menu
          },
        },
        filetypes = {
          yaml = true,
          markdown = true,
          help = false,
          gitcommit = true,
          gitrebase = true,
          hgcommit = false,
          svn = false,
          cvs = false,
          javascript = true, -- allow specific filetype
          typescript = true, -- allow specific filetype
          asciidoc = true,
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
              inlineSuggestCount = 12, -- #completions for getCompletions
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
  -- nvim-cmp with Codeium AI {{{
  -- {
  --   "hrsh7th/nvim-cmp",
  --   event = "InsertEnter",
  --   init = function()
  --     -- load special mappings that also shows up on which-key
  --     require("core.utils").load_mappings "cmp"
  --   end,
  --   dependencies = {
  --     {
  --       -- snippet plugin
  --       "L3MON4D3/LuaSnip",
  --       dependencies = "rafamadriz/friendly-snippets",
  --       opts = { history = true, updateevents = "TextChanged,TextChangedI" },
  --       config = function(_, opts)
  --         require("plugins.configs.others").luasnip(opts)
  --       end,
  --     },
  --     -- codeium configuration:
  --     {
  --       "Exafunction/codeium.nvim",
  --       -- TODO: it can autocomplete like Copilot, cmp needs to be configured for that: https://github.com/Exafunction/codeium.vim
  --          build = ":Codeium Auth",
  --       dependencies = {
  --         "nvim-lua/plenary.nvim",
  --         -- "hrsh7th/nvim-cmp",
  --       },
  --       config = function()
  --         require("codeium").setup({
  --         })
  --       end
  --     },
  --     -- cmp sources plugins
  --     {
  --       "saadparwaiz1/cmp_luasnip",
  --       "hrsh7th/cmp-nvim-lua",
  --       "hrsh7th/cmp-nvim-lsp",
  --       "hrsh7th/cmp-buffer",
  --       "hrsh7th/cmp-path",
  --     },
  --   },
  --
  --   opts = function()
  --     return require "plugins.configs.cmp"
  --     -- TODO: add to "sources" entry:
  --     -- { name = "codeium" },
  --   end,
  --   config = function(_, opts)
  --     require("cmp").setup(opts)
  --   end,
  -- },

  -- }}}
  -- nvim-cmp with TabNine code AI {{{
  -- {
  --   "hrsh7th/nvim-cmp",
  --   event = "InsertEnter",
  --   init = function()
  --     -- load special mappings that also shows up on which-key
  --     require("core.utils").load_mappings "cmp"
  --   end,
  --   dependencies = {
  --     {
  --       -- snippet plugin
  --       "L3MON4D3/LuaSnip",
  --       dependencies = "rafamadriz/friendly-snippets",
  --       opts = { history = true, updateevents = "TextChanged,TextChangedI" },
  --       config = function(_, opts)
  --         require("plugins.configs.others").luasnip(opts)
  --       end,
  --     },
  --     -- tabnine configuration:
  --     {
  --       "tzachar/cmp-tabnine",
  --       build = "./install.sh",
  --       config = function()
  --         local tabnine = require "cmp_tabnine.config"
  --         tabnine:setup {
  --           max_lines = 1000,
  --           max_num_results = 20,
  --           sort = true,
  --           run_on_every_keystroke = true,
  --           snippet_placeholder = '..',
  --           show_prediction_strength = false
  --         } -- put your options here
  --       end,
  --     },
  --
  --     -- autopairing of (){}[] etc
  --     -- {
  --     --   "windwp/nvim-autopairs",
  --     --   opts = {
  --     --     fast_wrap = {},
  --     --     disable_filetype = { "TelescopePrompt", "vim" },
  --     --   },
  --     --   config = function(_, opts)
  --     --     require("nvim-autopairs").setup(opts)
  --     --
  --     --     -- setup cmp for autopairs
  --     --     local cmp_autopairs = require "nvim-autopairs.completion.cmp"
  --     --     require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
  --     --   end,
  --     -- },
  --
  --     -- cmp sources plugins
  --     {
  --       "saadparwaiz1/cmp_luasnip",
  --       "hrsh7th/cmp-nvim-lua",
  --       "hrsh7th/cmp-nvim-lsp",
  --       "hrsh7th/cmp-buffer",
  --       "hrsh7th/cmp-path",
  --     },
  --   },
  --
  --   opts = function()
  --     return require "custom.configs.cmp"
  --     -- TODO: add to "sources" entry:
  --     -- { name = "cmp_tabnine" },
  --   end,
  --   config = function(_, opts)
  --     require("cmp").setup(opts)
  --   end,
  -- },

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
          max_item_count = 6,  -- show a maximum of X result for "buffer" items
          option = {
            get_bufnrs = function() return vim.api.nvim_list_bufs() end,
          },
        },
        { name = "nvim_lua", priority = 500 },
        { name = "path", priority = 1000, max_item_count = 3, },
        {
          name = "copilot", -- show up the copilot entry
          priority = 800,
          max_item_count = 5,
        },
        -- { name = 'nvim_lsp_signature_help', priority = 700, max_item_count = 3, },
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

  -- Other copilot related stuff, do not enable these {{{
  -- Copilot official plugin (not lua) {{{
  --[[
   {
     "github/copilot.vim",
     cmd = "Copilot",
     init = function()
       require("core.utils").lazy_load "copilot.vim"
     end,
   },
  --]]
  -- }}}
  -- }}}
--]] -- Copilot
  
  -- Parrot {{{
  -- [[ Parrot
  --{
    --"frankroeder/parrot.nvim",
    --dependencies = {
      --"ibhagwan/fzf-lua",
      --"nvim-lua/plenary.nvim"
    --},
    ---- lazy = false,
    --event = "VeryLazy",
    ---- set this if you want to always pull the latest change
    --version = false,
    --config = function()
        --require("parrot").setup {
            --providers = {
                --anthropic = { api_key = os.getenv "ANTHROPIC_API_KEY" },
                --gemini = { api_key = os.getenv "GEMINI_API_KEY" },
                --groq = { api_key = os.getenv "GROQ_API_KEY" },
                --mistral = { api_key = os.getenv "MISTRAL_API_KEY" },
                --pplx = { api_key = os.getenv "PERPLEXITY_API_KEY" },
                --ollama = {},  -- Empty provider, no API key required
                --openai = { api_key = os.getenv "OPENAI_API_KEY" },
                --github = { api_key = os.getenv "GITHUB_TOKEN" },
                --nvidia = { api_key = os.getenv "NVIDIA_API_KEY" },
                --xai = { api_key = os.getenv "XAI_API_KEY" },
            --},
        --}
    --end,
    ----opts = {}
    ----config = function()
        ----require("parrot").setup()
    ----end,
    ----opts = function()
      ----return require "custom.configs.avante"
    ----end,
    ----config = function(_, opts)
      ----require("avante").setup(opts)
      ------ require("base46").load_all_highlights() -- this is needed in order to avoid the Diff show with wrong colors
    ----end,
  --},
  --]]

    -- }}}
  -- Avante {{{
  -- [[ Avante
  --{
    --"yetone/avante.nvim",
    ---- lazy = false,
    --event = "VeryLazy",
    ---- set this if you want to always pull the latest change
    --version = false,
    --opts = function()
      --return require "custom.configs.avante"
    --end,
    --config = function(_, opts)
      --require("avante").setup(opts)
      ---- require("base46").load_all_highlights() -- this is needed in order to avoid the Diff show with wrong colors
    --end,
    ---- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    --build = "make",
    ---- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    --dependencies = {
      --"nvim-treesitter/nvim-treesitter",
      --"stevearc/dressing.nvim",
      --"nvim-lua/plenary.nvim",
      --"MunifTanjim/nui.nvim",
      ----- The below dependencies are optional,
      --"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      --"zbirenbaum/copilot.lua", -- for providers='copilot'
      --{
        ---- support for image pasting
        --"HakonHarnes/img-clip.nvim",
        --event = "VeryLazy",
        --opts = {
          ---- recommended settings
          --default = {
            --embed_image_as_base64 = false,
            --prompt_for_file_name = false,
            --drag_and_drop = {
              --insert_mode = true,
            --},
            ---- required for Windows users
            --use_absolute_path = true,
          --},
        --},
      --},
      --{
        ---- Make sure to set this up properly if you have lazy=true
        --'MeanderingProgrammer/render-markdown.nvim',
        --opts = {
          --file_types = { "markdown", "Avante" },
        --},
        --ft = { "markdown", "Avante" },
      --},
    --},
  --},
  --]]
  --[[
      Usage:
      Key BindingDescription
      Leader aa show sidebar
      Leader ar refresh sidebar
      Leader af switch sidebar focus
      Leader ae edit selected blocks
      co choose ours
      ct choose theirs
      ca choose all theirs
      c0 choose none
      cb choose both
      cc choose cursor
      ]x move to previous conflict
      [x movemove to next conflict
      [[ conflictjump to previous codeblocks (results window)
      ] ] windowjump to next codeblocks (results windows)
    --]]

    -- }}}
  -- ChatGPT {{{
  --[[ ChatGPT
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
    opts = function()
      return require "custom.configs.chatgpt"
    end,
    config = function(_, opts)
      require("chatgpt").setup(opts)
      require("base46").load_all_highlights() -- this is needed in order to avoid the Diff show with wrong colors
    end,
  },
  --]]
  --[[
      Usage: 
        <C-u> [Both] to submit.
        <C-y> [Both] to copy/yank last answer.
        <C-o> [Both] Toggle settings window.
        <Tab> [Both] Cycle over windows.
        <C-m> [Chat] Cycle over modes (center, stick to right).
        <C-c> [Chat] to close chat window.
        <C-u> [Chat] scroll up chat window.
        <C-d> [Chat] scroll down chat window.
        <C-k> [Chat] to copy/yank code from last answer.
        <C-n> [Chat] Start new session.
        <C-i> [Edit Window] use response as input.
        <C-d> [Edit Window] view the diff between left and right panes and use diff-mode commands
    --]]

    -- }}}

  -- Overwrite CMP menu default behaviours, if you want to
  -- nvim-cmp user overwrites (disable autocompletion, for example) {{{
  -- {
  --   "hrsh7th/nvim-cmp",
  --   enabled = true,  -- turn to false to disable it entirely
  --   opts = {
  --     completion = {
  --       autocomplete = true, -- elivim: copilot: uncomment to not show the cmp autocompletion menu automatically while typing
  --     },
  --       require("core.utils").load_mappings "cmp"
  --   },
  -- },
  -- }}}

  -- UltiSnips snippets system {{{
  -- NOTE: requires "python3-neovim" and the python3 provider not disabled
  --
  -- {
  --   "SirVer/ultisnips",
  --   init = function()
  --     require("core.utils").lazy_load "ultisnips"
  --     -- require("core.utils").load_mappings "ultisnips"
  --     vim.g.UltiSnipsEditSplit = "horizontal"
  --     vim.g.UltiSnipsExpandTrigger = "<c-j>" -- expand snippets using this hotkey
  --     vim.g.UltiSnipsJumpForwardTrigger = "<c-j>"
  --     vim.g.UltiSnipsJumpBackwardTrigger = "<c-k>"  -- backwards jumps
  --     vim.g.UltiSnipsListSnippets = "<c-l>"  -- list available snippets for keyword
  --     -- set the path for your ultisnip snippets
  --     local ultisnips_snippets = vim.fn.expand('$HOME/.vim/UltiSnips')  -- location of your snippets
  --     vim.g.UltiSnipsSnippetDirectories = { ultisnips_snippets, "UltiSnips" }
  --   end,
  -- },
  -- }}}

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
