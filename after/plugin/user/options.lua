-- Plugins mess with colorcolumn; this ensures it is set after they have loaded.

-- Show wrap column
vim.cmd [[set colorcolumn=120]]
vim.cmd [[highlight ColorColumn ctermbg=black guibg=#3C0C41]]
