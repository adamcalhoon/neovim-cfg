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

    -- Project management
    use "ahmedkhalf/project.nvim"

    -- NVIM Utilities
    use 'nvim-lua/plenary.nvim'
    use 'lewis6991/impatient.nvim'

    -- Colorschemes
    use 'lifepillar/vim-solarized8'
    use 'olimorris/onedarkpro.nvim'
    use 'EdenEast/nightfox.nvim'

    -- Visualization
    use 'rrethy/vim-illuminate' -- illuminate word under cursor
    use 'lukas-reineke/indent-blankline.nvim' -- add indent guidelines
    use 'nvim-treesitter/nvim-treesitter' -- improved syntax highlights
    use 'kyazdani42/nvim-web-devicons' -- fancy icons
    use 'microsoft/vscode-codicons' -- more fancy icons
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- Formatting
    use 'junegunn/vim-easy-align'
    use 'windwp/nvim-autopairs'
    use 'tpope/vim-surround'
    use "jose-elias-alvarez/null-ls.nvim"

    -- Tree view
    use 'nvim-tree/nvim-tree.lua'

    -- Terminals
    use {'akinsho/toggleterm.nvim', tag = '*'}

    -- Git
    use 'tpope/vim-fugitive'

    -- Searching
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'},
                     {'BurntSushi/ripgrep'} }
    }
    use 'justinmk/vim-sneak'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/lsp_extensions.nvim'

    -- Completion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use {
        'petertriho/cmp-git',
        requires = 'nvim-lua/plenary.nvim',
        config = function() require('cmp_git').setup() end
    }

    use {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
    }

    -- Snippets
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'rafamadriz/friendly-snippets'

    -- C/C++
    use 'p00f/clangd_extensions.nvim'

    -- Rust
    use 'rust-lang/rust.vim'
    use 'simrat39/rust-tools.nvim'

    -- Haskell
    use 'MrcJkb/haskell-tools.nvim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then require("packer").sync() end
end)
