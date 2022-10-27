local function diffmode()
    return vim.api.nvim_win_get_option(0, "diff")
end

function _SETUP_DIFF()
    if diffmode() then
        vim.opt['readonly'] = false
        vim.keymap.set('', 'Q', ':cquit<CR>', {silent = true})
    end
end

_SETUP_DIFF()

-- Change settings if diff mode is enabled after vim is open
vim.cmd [[
    autocmd OptionSet diff lua _SETUP_DIFF()
]]
