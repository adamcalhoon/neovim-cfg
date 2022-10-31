local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then return end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
    local signs = {
        {name = "DiagnosticSignError", text = ""}, {name = "DiagnosticSignWarn", text = ""},
        {name = "DiagnosticSignHint", text = "?"}, {name = "DiagnosticSignInfo", text = ""}
    }

    for _, sign in ipairs(signs) do vim.fn.sign_define(sign.name, {texthl = sign.name, text = sign.text, numhl = ""}) end

    local config = {
        virtual_text = false, -- disable virtual text
        signs = {
            active = signs -- show signs
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {focusable = true, style = "minimal", border = "rounded", source = "always", header = "", prefix = ""}
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"})

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"})
end

local function lsp_options(bufnr)
    local set_buf_opt = function(opt, value)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    end

    set_buf_opt('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local function lsp_keymaps(bufnr)
    local opts = {noremap = true, silent = true}
    local keymap = vim.api.nvim_buf_set_keymap

    keymap(bufnr, 'n', 'go', ':lua vim.diagnostic.open_float()<CR>', opts)
    keymap(bufnr, 'n', 'g[', ':lua vim.diagnostic.goto_prev{buffer = 0}<CR>', opts)
    keymap(bufnr, 'n', 'g]', ':lua vim.diagnostic.goto_next{buffer = 0}<CR>', opts)

    keymap(bufnr, 'n', '<C-]>', ':lua vim.lsp.buf.definition()<CR>', opts)
    keymap(bufnr, 'n', '<leader>la', ':lua vim.lsp.buf.code_action()<CR>', opts)
    keymap(bufnr, 'n', '<leader>ld', ':lua vim.lsp.buf.definition()<CR>', opts)
    keymap(bufnr, 'n', '<leader>lD', ':lua vim.lsp.buf.declaration()<CR>', opts)
    keymap(bufnr, 'n', '<leader>lf', ':lua vim.lsp.buf.format{ async = true }<CR>', opts)
    keymap(bufnr, 'n', '<leader>lh', ':lua vim.lsp.buf.hover()<CR>', opts)
    keymap(bufnr, 'n', '<leader>li', ':lua vim.lsp.buf.implementation()<CR>', opts)
    keymap(bufnr, 'n', '<leader>lo', ':lua vim.diagnostic.open_float()<CR>', opts)
    keymap(bufnr, 'n', '<leader>lq', ':lua vim.diagnostic.setloclist()<CR>', opts)
    keymap(bufnr, 'n', '<leader>lr', ':lua vim.lsp.buf.references()<CR>', opts)
    keymap(bufnr, 'n', '<leader>lrn', ':lua vim.lsp.buf.rename()<CR>', opts)
    keymap(bufnr, 'n', '<leader>ls', ':lua vim.lsp.buf.signature_help()<CR>', opts)
    keymap(bufnr, 'n', '<leader>lS', ':lua vim.lsp.buf.document_symbol()<CR>', opts)
    keymap(bufnr, 'n', '<leader>ltd', ':lua vim.lsp.buf.type_definition()<CR>', opts)
    keymap(bufnr, 'n', '<leader>lW', ':lua vim.lsp.buf.workspace_symbol()<CR>', opts)
end

M.on_attach = function(client, bufnr)
    if client.name == "tsserver" then
        -- Disable the formatting provider in tsserver
        client.server_capabilities.documentFormattingProvider = false
	end

    lsp_options(bufnr)
    lsp_keymaps(bufnr)

    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then return end
    illuminate.on_attach(client)
end

return M
