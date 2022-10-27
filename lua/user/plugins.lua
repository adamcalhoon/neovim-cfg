local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then return end

-- Have packer use a popup window
packer.init({display = {open_fn = function() return require("packer.util").float({border = "rounded"}) end}})

-- Install your plugins here
return packer.startup(function(use)
    -- Package management
    use 'wbthomason/packer.nvim'

    -- NVIM Utilities
    use 'nvim-lua/plenary.nvim'
    use 'lewis6991/impatient.nvim'

    -- Colorschemes
    use 'lifepillar/vim-solarized8'
    use 'olimorris/onedarkpro.nvim'

    -- Visualization
    use 'rrethy/vim-illuminate'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'nvim-treesitter/nvim-treesitter'

    -- Formatting
    use 'junegunn/vim-easy-align'
    use 'rhysd/vim-clang-format'
    use {'averms/black-nvim', run = ':UpdateRemotePlugins'}
    use 'windwp/nvim-autopairs'

    -- Tree view
    use 'preservim/nerdtree'

    -- Terminals
    use {'akinsho/toggleterm.nvim', tag = '*'}

    -- Git
    use 'tpope/vim-fugitive'

    -- FZF
    use {'junegunn/fzf', run = ':call fzf#install()'}
    use 'junegunn/fzf.vim'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/lsp_extensions.nvim'

    -- cmp
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'

    -- Snippets
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'rafamadriz/friendly-snippets'

    -- Rust
    use 'rust-lang/rust.vim'
    use 'simrat39/rust-tools.nvim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then require("packer").sync() end
end)
