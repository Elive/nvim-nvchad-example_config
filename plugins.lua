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

  -- -- Install your desired PHP LSP:
  -- -- PHPactor
  -- -- Note: you must have at least php8, composer, and the binary of phpactor installed (and define its location on the next lines) - git clone https://github.com/phpactor/phpactor ; cd phpactor ; composer install ; sudo ln -s $(pwd)/bin/phpactor /usr/local/bin/
  -- {
  --   "gbprod/phpactor.nvim",
  --   requires = {
  --     "nvim-lua/plenary.nvim", -- required to update phpactor
  --     "neovim/nvim-lspconfig" -- required to automaticly register lsp serveur
  --   },
  --   ft = 'php',
  --   config = function()
  --     require("phpactor").setup({
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --       install = {
  --         bin = "~/phpactor/bin/phpactor",
  --       },
  --     })
  --   end
  -- },
  -- -- PHPactor (another plugin, without linting feature, better if you want to use togheter with installed)
  -- {
  --   'phpactor/phpactor',
  --   branch = 'master',
  --   ft = 'php',
  --   config = function()
  --     require("phpactor").setup({
  --       install = {
  --         bin = "~/phpactor/bin/phpactor",
  --       },
  --     })
  --   end,
  -- },


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
