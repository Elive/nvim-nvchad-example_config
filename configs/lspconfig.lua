local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
-- local servers = { "html", "cssls", "tsserver", "clangd", }
local servers = { "html", "cssls", "tsserver", "clangd", "bashls", }
-- -- enable the LSPs you want to have, make sure to install them first from the :Mason panel
-- local servers = { "html", "cssls", "tsserver", "clangd", "bashls", "intelephense", "volar" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end


-- -- PHP lsp: intelephense
-- Install: dependencies: php8*, intelephense
--
-- local util = require 'lspconfig.util'
--
-- require('lspconfig').intelephense.setup({
--   on_attach = on_attach,
--   filetypes = {"php"};
--   root_dir = function (pattern)
--     local cwd  = vim.loop.cwd();
--     local root = util.root_pattern("composer.json", ".git")(pattern);
--
--     -- prefer cwd if root is a descendant
--     return util.path.is_descendant(cwd, root) and cwd or root;
--   end;
--   settings = {
--     intelephense = {
--       -- Add wordpress to the list of stubs
--       stubs = {
--         "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype", "curl", "date",
--         "dba", "dom", "enchant", "exif", "FFI", "fileinfo", "filter", "fpm", "ftp", "gd", "gettext",
--         "gmp", "hash", "iconv", "imap", "intl", "json", "ldap", "libxml", "mbstring", "meta", "mysqli",
--         "oci8", "odbc", "openssl", "pcntl", "pcre", "PDO", "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql",
--         "Phar", "posix", "pspell", "readline", "Reflection", "session", "shmop", "SimpleXML", "snmp", "soap",
--         "sockets", "sodium", "SPL", "sqlite3", "standard", "superglobals", "sysvmsg", "sysvsem", "sysvshm", "tidy",
--         "tokenizer", "xml", "xmlreader", "xmlrpc", "xmlwriter", "xsl", "Zend OPcache", "zip", "zlib",
--         "wordpress", "phpunit",
--       },
--       diagnostics = {
--         enable = true,
--       },
--       Lua = {
--         diagnostics = {
--           globals = { "vim" }, -- Gets rid of "Global variable not found" error message
--         },
--       },
--       json = {
--         schemas = {
--           {
--             description = "NPM configuration file",
--             fileMatch = {
--               "package.json",
--             },
--             url = "https://json.schemastore.org/package.json",
--           },
--         },
--       },
--       files = {
--         maxSize = 1000000;
--       },
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
-- })
--
-- -- Vue, Javascript, TypeScript
-- require('lspconfig').volar.setup({
--   -- Enable "Take Over Mode" where volar will provide all JS/TS LSP services
--   -- This drastically improves the responsiveness of diagnostic updates on change
--   filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json', },
-- })

-- Vue, Javascript, TypeScript
-- require('lspconfig').jsonls.setup({
--   settings = {
--     json = {
--       schemas = require('schemastore').json.schemas(),
--     },
--   },
-- })

-- -- De clutter the editor by only showing diagnostic messages when the cursor is over the error
-- vim.diagnostic.config({
--     virtual_text = false, -- Do not show the text in front of the error
--     float = {
--         border = "rounded",
--     },
-- })




-- lspconfig.pyright.setup { blabla}
