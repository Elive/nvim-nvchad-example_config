local M = {}

M.treesitter = {
  ensure_installed = {
    "bash",
    "c",
    "css",
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
