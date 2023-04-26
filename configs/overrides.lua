local M = {}

M.treesitter = {
  ensure_installed = {
    "bash",
    "c",
    "css",
    "html",
    "javascript",
    "json5",
    "lua",
    "markdown",
    "markdown_inline",
    "perl",
    "php",
    "ruby",
    "scss",
    "tsx",
    "typescript",
    "vim",
    "vue",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",

  -- Note: to install new ones, run :MasonInstallAll

    -- bash lsp
    "bash-language-server",
    "shellcheck", -- note: it consumes some cpu
    -- -- extras:
    -- -- shellharden: apply suggested changes by shellcheck
    -- -- "shellharden", -- depends on Cargo

    -- PHP
    -- note: make sure you have composer and php-8 or higher installed
    -- "phpactor",
    -- "intelephense",  -- closed source, requires a license (but you can use the free version)

    -- -- python
    -- "flake8",
    -- "autopep8",
    -- "isort",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
