local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd" }
-- local servers = { "html", "cssls", "tsserver", "clangd", "intelliphense", "volar" }  -- enable if you want to use intelliphense PHP lsp, and "volar" for JS/Vuejs

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,

  }
end


-- -- PHP lsp: intelephense
-- require('lspconfig').intelephense.setup({
--   on_attach = on_attach,
--   settings = {
--     intelephense = {
--       environment = {
--         includePaths = {
--           util.find_node_modules_ancestor(vim.fn.expand("%:p"))
--           "~/WEBDEV/yourproject/",
--           "~/WEBDEV/yourproject/Modules/",
--           "~/WEBDEV/yourproject/packages/NSGI/Core/src/",
--         }
--       }
--     }
--   },
--   -- Set license key here, if you have
--   -- licenceKey = '',  -- your license key, there's also a free version if you don't have
--   capabilities = capabilities,
-- })

-- -- Vue, Javascript, TypeScript
-- require('lspconfig').volar.setup({
--   -- Enable "Take Over Mode" where volar will provide all JS/TS LSP services
--   -- This drastically improves the responsiveness of diagnostic updates on change
--   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json', },
--   capabilities = capabilities,
-- })

-- Vue, Javascript, TypeScript
-- require('lspconfig').jsonls.setup({
--   capabilities = capabilities,
--   settings = {
--     json = {
--       schemas = require('schemastore').json.schemas(),
--     },
--   },
-- })





-- lspconfig.pyright.setup { blabla}
