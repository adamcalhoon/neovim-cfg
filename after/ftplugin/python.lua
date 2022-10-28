local keymap = vim.api.nvim_set_keymap

local opts = {noremap = true, silent = true}

-- Overriding <leader>lf does not work because it is mapped later by lsp on_attach.
keymap('n', '<leader>f', ':call Black()<CR>', opts)
