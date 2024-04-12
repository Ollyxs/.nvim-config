-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- Fuzzy Finder
  use { "ibhagwan/fzf-lua",
  -- optional for icon support
    requires = { "nvim-tree/nvim-web-devicons" }
  }
  use { "junegunn/fzf", run = "./install --bin" }
  -- Colorscheme
  use "rebelot/kanagawa.nvim"
  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
    }
  }
  -- Tabline
  use {'akinsho/bufferline.nvim', tag = "v4.3.0", requires = 'nvim-tree/nvim-web-devicons'}
  -- WinBar
  use({
    "utilyre/barbecue.nvim",
    tag = "*",
    requires = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    after = "nvim-web-devicons", -- keep this if you're using NvChad
    config = function()
      require("barbecue").setup()
    end,
  })
  -- Statusline
  use {
    'freddiehaddad/feline.nvim',
    requires = {
      "nvim-tree/nvim-web-devicons",
      "lewis6991/gitsigns.nvim"
    }
  }
  -- File Explorer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
  }
  -- File Explorer Plugins
  use {
    'antosha417/nvim-lsp-file-operations',
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-tree.lua",
    }
  }
  -- Undotree
  use 'mbbill/undotree'
  -- Indent
  use "lukas-reineke/indent-blankline.nvim"
  use "nmac427/guess-indent.nvim"
  -- Key Bindings
  use "folke/which-key.nvim"
  -- Wakatime
  use 'wakatime/vim-wakatime'
  -- Python Enviroment
  use 'AckslD/swenv.nvim'
  -- Command Line
  use 'gelguy/wilder.nvim'
  -- Dim Inactive windows
  -- use 'sunjon/shade.nvim'
  -- Color
  use 'NvChad/nvim-colorizer.lua'
  -- Comment
  use 'numToStr/Comment.nvim'
end)
