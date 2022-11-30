-- haskell_analyzer lsp configuration
local haskell_tools_ok, ht = pcall(require, 'haskell-tools')
if not haskell_tools_ok then return end

ht.setup {
    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by haskell-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#haskell_analyzer
    hls = {
        on_attach = function(client, buffer)
            require("user.lsp.handlers").on_attach(client, buffer)

            -- local opts = {buffer = buffer, silent = true}
            -- local keymap = vim.keymap.set
            --
            -- keymap('n', '<C-space>', ht.hover_actions.hover_actions, opts)
            -- keymap('n', '<leader>a', ht.code_action_group.code_action_group, opts)
        end,
    }
}

