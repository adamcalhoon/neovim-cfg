local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then return end

require("user.lsp.handlers").setup()

-- LSP servers with standard configuration
local servers = {'pyright', 'tsserver'}

local opts = {}
for _, server in pairs(servers) do
    opts = {
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities
    }

    server = vim.split(server, "@")[1]

    local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
    if require_ok then opts = vim.tbl_deep_extend("force", conf_opts, opts) end

    lspconfig[server].setup(opts)
end

-- LSP servers with supplemental configuration
require("user.lsp.clangd_extensions")
require("user.lsp.rust-tools")
require("user.lsp.null-ls")
