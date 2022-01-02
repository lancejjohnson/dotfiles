-- This file can be loaded by calling `lua require('plugins')` from your init.vim

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'vim-test/vim-test'
  use 'jremmen/vim-ripgrep'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'junegunn/vim-easy-align'
  use 'kana/vim-smartinput'
  use 'ludovicchabant/vim-gutentags'
  use 'ntpeters/vim-better-whitespace'
  use 'pbrisbin/vim-mkdir'
  use 'tommcdo/vim-exchange' -- direction commands for exchanging text places
  use 'tpope/vim-characterize'
  use 'tpope/vim-commentary'
  use 'tpope/vim-cucumber'
  use 'tpope/vim-dispatch'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-projectionist'
  use 'tpope/vim-ragtag'
  use 'tpope/vim-repeat'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-vinegar'
  use 'andymass/vim-matchup'

  -- Colors
  use {'arcticicestudio/nord-vim', opt = true}
  use {'cocopon/iceberg.vim', opt = true}
  use {'jeffkreeftmeijer/vim-dim', opt = true}
  use {'lifepillar/vim-solarized8', opt = true}
  use {'morhetz/gruvbox', opt = true}
  use {'nightsense/snow', opt = true}

  -- Completion
  use {'hrsh7th/nvim-cmp'}
  use {'hrsh7th/cmp-buffer'}
  use {'hrsh7th/cmp-cmdline'}
  use {'hrsh7th/cmp-nvim-lsp'}
  use {'hrsh7th/cmp-nvim-lsp-document-symbol'}
  use {'hrsh7th/cmp-nvim-lua'}
  use {'hrsh7th/cmp-path'}
  use {'saadparwaiz1/cmp_luasnip'}
  use {'Saecki/crates.nvim'}

  -- Custom textobjects
  use {'kana/vim-textobj-user'} -- Must precede other textobj plugins
  use {'kana/vim-textobj-entire'}
  use {'kana/vim-textobj-indent'}
  use {'nelstrom/vim-textobj-rubyblock'}
  use {'b4winckler/vim-angry'}

  -- Elixir
  use 'avdgaag/vim-phoenix'
  use 'elixir-lang/vim-elixir'
  use 'mhinz/vim-mix-format'

  -- HTML
  use {'mattn/emmet-vim'}

  -- JavaScript
  use {'elzr/vim-json'}
  use {'mxw/vim-jsx'}
  use {'pangloss/vim-javascript'}
  use {'prettier/vim-prettier'}

  -- Language Server Protocol
  use {'neovim/nvim-lspconfig'}
  use {'williamboman/nvim-lsp-installer'}

  -- Ruby
  use {'tpope/vim-bundler'}
  use {'tpope/vim-endwise'}
  use {'tpope/vim-liquid'}
  use {'tpope/vim-rails'}
  use {'tpope/vim-rake'}
  use {'vim-ruby/vim-ruby'}
  use {'slim-template/vim-slim'}
  use {'ngmy/vim-rubocop'}

  -- Rust
  use {'rust-lang/rust.vim'}

  -- Snippets
  use {'L3MON4D3/LuaSnip'}
end)
