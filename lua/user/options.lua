local options = {
    backup = false, -- creates a backup file
    clipboard = 'unnamedplus', -- allows neovim to access the system clipboard
    completeopt = {'menu', 'menuone', 'noselect'}, -- mostly just for cmp
    conceallevel = 0, -- so that `` is visible in markdown files
    cursorline = true, -- highlight the current line
    diffopt = {'filler', 'internal', 'algorithm:histogram', 'indent-heuristic'}, -- better default diff options
    expandtab = true, -- convert tabs to spaces
    expandtab = true, -- expand tabs to spaces
    fileencoding = 'utf-8', -- the encoding written to a file
    guifont = 'monospace:h17', -- the font used in graphical neovim applications
    hidden = true, -- allow hidden buffers with modifications
    hlsearch = false, -- disable highlight matches on previous search pattern
    ignorecase = true, -- ignore case in search patterns
    linebreak = true, -- companion to wrap, don't split words
    mouse = 'a', -- allow the mouse to be used in neovim
    number = true, -- set numbered lines
    numberwidth = 2, -- set number column width to 2 {default 4}
    pumheight = 10, -- pop up menu height
    relativenumber = true, -- set relative numbered lines
    ruler = true, -- set relative numbered lines
    scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor
    shell = 'bash', -- prefer bash
    shiftwidth = 4, -- insert 4 spaces for a tab
    sidescrolloff = 8, -- minimal number of screen columns either side of cursor if wrap is `false`
    signcolumn = 'yes', -- always show the sign column, otherwise it would shift the text each time
    smartcase = true, -- smart case
    smartindent = true, -- make indenting smarter again
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = false, -- creates a swapfile
    tabstop = 4, -- insert 4 spaces for a tab
    termguicolors = true, -- set term gui colors (most terminals support this)
    textwidth = 120, -- line wrap happens in column 120
    timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
    undofile = true, -- enable persistent undo
    updatetime = 300, -- faster completion (4000ms default)
    wrap = true, -- display lines as one long line
    writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

vim.opt.shortmess:append 'c'

for k, v in pairs(options) do vim.opt[k] = v end

vim.cmd 'set whichwrap+=<,>,[,],h,l'
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set path+=**]]
vim.cmd [[let g:python3_host_prog = $HOME . '/.local/venv/nvim/bin/python']]
