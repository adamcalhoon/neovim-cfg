-- rust_analyzer lsp configuration
local rust_tools_ok, rt = pcall(require, 'rust-tools')
if not rust_tools_ok then return end

rt.setup {
    capabilities = cmpcapabilities,

    tools = {
        autoSetHints = true,
        inlay_hints = {show_parameter_hints = false, parameter_hints_prefix = "", other_hints_prefix = ""}
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = require('coq').lsp_ensure_capabilities{
        on_attach = function(client, buffer)
            require("user.lsp.handlers").on_attach(client, buffer)

            local opts = {buffer = buffer, silent = true}
            local keymap = vim.keymap.set

            keymap('n', '<C-space>', rt.hover_actions.hover_actions, opts)
            keymap('n', '<leader>a', rt.code_action_group.code_action_group, opts)
        end,

        -- capabilities = require("user.lsp.handlers").capabilities,

        settings = {
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {command = "clippy"}
            }
        }
    }
}
