call plug#begin()

" Manejador de plugins
Plug 'junegunn/vim-plug'

" Soporte para virtualenv python
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
Plug 'rafi/vim-venom', { 'for': 'python' }
"Plug 'rafi/vim-venom'
" Verificador de código
"Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' } 

" Sintaxis
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'm-demare/hlargs.nvim'
Plug 'SmiteshP/nvim-gps'

" Brackes color
Plug 'p00f/nvim-ts-rainbow'

" Brackes auocomplete
"Plug 'jiangmiao/auto-pairs'
Plug 'windwp/nvim-autopairs'

" Soporte git
Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'
Plug 'lewis6991/gitsigns.nvim'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'nvim-lua/plenary.nvim'
Plug 'simrat39/symbols-outline.nvim'
Plug 'folke/lsp-colors.nvim'

" Linea de estado
Plug 'famiu/feline.nvim'

" Line de comando
Plug 'gelguy/wilder.nvim'

" Dashboard
Plug 'glepnir/dashboard-nvim'

" Autocompletado tabnine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Minimapa
Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}

" Identación
Plug 'lukas-reineke/indent-blankline.nvim'

" Servidor html live 
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}

" Buscador difuso
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'ibhagwan/fzf-lua'
Plug 'ibhagwan/nvim-fzf'
"Plug 'vijaymarupudi/nvim-fzf'

" Sintaxis de nerdtree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Tabline
Plug 'akinsho/bufferline.nvim'

" Colorscheme 
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'projekt0n/github-nvim-theme'
Plug 'rebelot/kanagawa.nvim'

" Sintaxis y servidor de plantuml
Plug 'aklt/plantuml-syntax', {'for': 'puml'}
Plug 'weirongxu/plantuml-previewer.vim', {'for': 'puml'}
Plug 'previm/previm'

" Abrir en navegador
Plug 'tyru/open-browser.vim'

" Guardar con sudo
Plug 'lambdalisue/suda.vim'

" Colores
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

" Atenuar ventanas inactivas
Plug 'sunjon/shade.nvim'

" Comentarios
Plug 'b3nj5m1n/kommentary'

" Explorador de archivos
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'kyazdani42/nvim-tree.lua'

" Terminal
Plug 'pianocomposer321/consolation.nvim'
Plug 'akinsho/toggleterm.nvim'

" Iconos
" Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'

call plug#end()
