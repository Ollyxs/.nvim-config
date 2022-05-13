" Mostrar números de líneas
set number

" Habilitar uso del mouse
set mouse=a

" Deshabilitar version de venom vim para usar la lua
lua << EOF
--vim.g.venom_loaded = 1
EOF

" Cargar plugins
so ~/.config/nvim/plugins.vim

" Habilitar resaltado de sintaxis
syntax on

" Configurar tecla espacio como <leader> shortcut
nnoremap <Space> <Nop>
let mapleader = " " 

" Usar colores GUI
set termguicolors

" Divisiones
set splitbelow
set splitright
  
" Navegacion entre divisiones
" Ctrl+J bajar
nnoremap <C-J> <C-W><C-J>
" Ctrl+K subir
nnoremap <C-K> <C-W><C-K>
" Ctrl+L derecha
nnoremap <C-L> <C-W><C-L>
" Ctrl+H izquierda
nnoremap <C-H> <C-W><C-H>
  
" Cambiar el tamaño de las divisiones
map <leader>> <C-w>10>
map <leader>< <C-w>10<
map <leader>+ <C-w>5+
map <leader>- <C-w>5-
  
" Salvado rápido
nmap <leader>s :w<CR>

" Salir
nmap <leader>qq :qa<CR>

" Copiar al portapapeles
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Pegar desde portapapeles
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Resaltar los resultados de la búsqueda
set hlsearch

" Dejar de resaltar los resultados de la busqueda
nmap <silent> ,/ :nohlsearch<CR>

" Reducir tiempo de actualización
set updatetime=100

" No mostrar una línea en varias lineas si es demasiado larga
set nowrap

" Modo Terminal-Normal
tnoremap <Esc><Esc> <C-\><C-n>

" Rsaltado de sintaxis de lua dentro de archivos .vim
let g:vimsyn_embed = 'l'

" Identación de 2 espacios para html
au FileType html setl sw=2 sts=2 et

" Identación de 2 espacios para htmldjango
au FileType htmldjango setl sw=2 sts=2 et

" Identación de 2 espacios para lua
au FileType lua setl sw=4 sts=4 et
"-----------------------------------------------------------------------
"-----------------------------------------------------------------Fzf-lua
" Dependencias opcionales:
" https://github.com/sharkdp/fd (Mejor rendimiento en busqueda)
" https://github.com/sharkdp/bat (Vistas previas con resaltado de sintaxis a color)
" https://github.com/BurntSushi/Ripgrep (mejores busquedas tipo grep)

lua << EOF
local actions = require 'fzf-lua.actions'
require'fzf-lua'.setup{
files = {
	cmd = [[fd --color never --type f --hidden ]] ..
	[[--exclude .git --exclude node_modules --exclude '*.pyc' --exclude Games]]
},
grep_visual = { cmd = "--regexp --column --line-number --no-heading --color=always --smart-case"}
	
--window_on_create = function()
--  vim.cmd("set winhl=Normal:Normal")  -- popup bg to match normal windows
--vim.api.nvim_buf_set_keymap(0, "t", "<Esc>", "<C-c>", { nowait = true, silent = true })
--end
}
EOF

" Atajos de teclado
" Abrir buscador de archivos
nnoremap <leader>ff <cmd>lua require('fzf-lua').files()<CR>
" Abrir buscador de archivos para repos git ocultado archivos de .gitignore
nnoremap <leader>fg <cmd>lua require('fzf-lua').git_files()<CR>
" Abrir buscador de buffers
nnoremap <leader>fb <cmd>lua require('fzf-lua').buffers()<CR>
" Abrir buscador de palabras 
nnoremap <leader>fr <cmd>lua require('fzf-lua').live_grep()<CR>
" Abrir buscador de man pages
nnoremap <leader>fm <cmd>lua require('fzf-lua').man_pages()<CR>
" Abrir historial de archivos
nnoremap <leader>fh <cmd>lua require('fzf-lua').oldfiles()<CR>
" Abrir elegir tema de color
nnoremap <leader>fc <cmd>lua require('fzf-lua').colorschemes()<CR>

" autocmd FileType fzf set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2
"-----------------------------------------------------------------------
" lua << EOF
" vim.o.hidden = true
" EOF
" tnoremap <Esc><Esc> <C-w>N
so ~/.config/nvim/plugins/toggleterm.lua
"------------------------------------------------------------------Dashboard
" Default value is clap
let g:dashboard_default_executive = "lua require('fzf-lua')"

let g:dashboard_disable_statusline = 1
autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2
autocmd BufEnter * if &filetype == "dashboard" | set showtabline=0 | else | set showtabline=2 | endif
au BufEnter term :wincmd j
"-----------------------------------------------------------------------
"------------------------------------------------------------------CHADtree

" Para poder usar la papelera instalar trash-cli
" pip3 install trash-cli
" Después de la instalación agregue esta linea a su .bashrc o .zshrc
" export PATH=~/.local/bin:"$PATH"

" Abrir/Cerrar CHADopen
nnoremap <F3> :CHADopen<CR>

" Configuraciones
let g:chadtree_settings = {
			\'theme': {'text_colour_set': "env"},
			\'ignore': {'name_exact': []},
			\'keymap': {'toggle_hidden': ["¿"]}
\}

"autocmd BufEnter * if bufname('#') =~# "CHADTree" && winnr('$') > 1 | b# | endif

autocmd BufEnter * if (winnr("$") == 1 && &filetype == "CHADTree") | q | endif
autocmd BufEnter * if (winnr("$") == 1 && &filetype == "CHADTree") | b# | endif

"-----------------------------------------------------------------------
"------------------------------------------------------------------NvimTree

lua << EOF
require'nvim-tree'.setup{
	--auto_close = false,
	hijack_cursor = true,
	hijack_directories = {
		enable = true,
		auto_open = true,
		},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		},
}
EOF
nnoremap <F2> :NvimTreeToggle<CR>
let g:nvim_tree_width = 40
let g:nvim_tree_indent_markers = 1
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
"-----------------------------------------------------------------------
"-----------------------------------------------------------------Dev-Icons

set encoding=UTF-8
let s:red = "AE403F"
let s:blue = "689FB6"

let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsDefaultFolderSymbolColor = s:red
let g:WebDevIconsDefaultOpenFolderSymbolColor= s:blue

lua << EOF
require("nvim-web-devicons").setup{}
EOF

"-----------------------------------------------------------------------
"------------------------------------------------------------------Rainbow
lua << EOF
require'nvim-treesitter.configs'.setup {
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    termcolors = {'brown', 'darkblue', 'darkgray', 'darkgreen',
    'darkcyan', 'darkred', 'darkmagenta', 'grey', 'black',
    'darkmagenta', 'darkblue', 'darkgreen', 'darkcyan', 'darkred', 'red'}
  }
}
EOF
"-----------------------------------------------------------------------
"----------------------------------------------------------------Auto Pairs

lua << EOF
require('nvim-autopairs').setup{}
EOF
"-----------------------------------------------------------------------
"----------------------------------------------------------------Bufferline

so ~/.config/nvim/plugins/bufferline.lua

nnoremap <leader>bb :BufferLinePick<CR>
nnoremap <Tab> :BufferLineCycleNext<CR>
nnoremap <S-Tab> :BufferLineCyclePrev<CR>

nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>


"-----------------------------------------------------------------------
"------------------------------------------------------------Colorscheme
"let g:dracula_colorterm = 0
colorscheme kanagawa

"-----------------------------------------------------------------------
"-------------------------------------------------------------Git-gutter
" Mostrar siempre la columna de signos
set signcolumn=yes
" Corregir el problema de contraste de la columna de git-gutter con el 
" tema oscuro de solarized
highlight clear SignColumn

lua << EOF
require('gitsigns').setup()
EOF

"-----------------------------------------------------------------------
"-----------------------------------------------------------------Feline

so ~/.config/nvim/plugins/feline.lua

"-----------------------------------------------------------------------
"-----------------------------------------------------------------Wilder

call wilder#setup({
      \ 'modes': [':', '/', '?'],
      \ 'enable_cmdline_enter': 0,
      \ })

call wilder#set_option('renderer', wilder#popupmenu_renderer({
      \ 'highlighter': wilder#basic_highlighter(),
      \ 'left': [
      \   ' ', wilder#popupmenu_devicons(),
      \ ],
      \ 'right': [
      \   ' ', wilder#popupmenu_scrollbar(),
      \ ],
      \ }))

"-----------------------------------------------------------------------
"----------------------------------------------------------------Minimap
" Para poder usar minimap debe instalar code-minimap
" (https://github.com/wfxr/code-minimap/), esto se hace a traves de cargo,
" para instalar cargo ejecute en la terminal:
" curl https://sh.rustup.rs -sSf | sh
" Esto descargará un script e iniciará la instalación.
" Si todo va bien, veras esto:
" Rust is installed now. Great!
" Ahora podra instalar code-minimap ejecutando en la terminal:
" cargo install --locked code-minimap

" Deshabilitar el minimapa para tipos de archivos específicos
let g:minimap_block_filetypes = ['fugitive', 'nerdtree', 'tagbar', 'ChadTree']

" Deshabilitar el minimapa para tipos de buffers específicos
let g:minimap_block_buftypes = ['nofile', 'nowrite', 'quickfix', 'terminal', 'prompt', 'fzf', 'pymode']

" Cerrar minimapa para tipos de archivos especificos
let g:minimap_close_filetypes = ['starify', 'netrw', 'vim-plug', 'vim-blunde']

" Resaltar el rango de lineas visibles
let g:minimap_highlight_range = 1

autocmd BufEnter * if bufname('#') =~# "minimap" && winnr('$') > 1 | q | endif

" Atajos de teclado
" Abrir/Cerrar Minimap
nnoremap <leader>m :MinimapToggle<CR>
" Cerrar Minimap
nnoremap <leader>mq :MinimapClose<CR>
" Refrescar Minimap
nnoremap <leader>mr :MinimapRefresh<CR>

"-----------------------------------------------------------------------
"----------------------------------------------------------------Py-mode
" Comprobación/Resaltado de sintaxis
let python_highlight_all=1
  
"Mostrar la documentación de la palabra actual mediante pydoc
let g:pymode_doc = 1 
 
" Omitir errores y advertencias de python linea muy larga
let g:pymode_lint_ignore=["E501",]

"-----------------------------------------------------------------------
"------------------------------------------------------------------Venom
lua << EOF
--require('venom').setup()
EOF

let g:venom_use_tools = 1
let g:venom_tools = {
			\'poetry': 'poetry env info -p',
			\'pipenv': 'pipenv --venv'
			\}
"-----------------------------------------------------------------------
"--------------------------------------------------------------LSPconfig

so ~/.config/nvim/plugins/lsp_config.lua

"-----------------------------------------------------------------------
"-------------------------------------------------------Indent-Blankline
" Atajo de teclado
nnoremap <leader>i :IndentBlanklineToggle<CR>
so /home/ollyxs/.config/nvim/plugins/indent-blankline.lua

let g:indent_blankline_filetype_exclude = ['dashboard']
let g:indent_blankline_buftype_exclude = ['terminal']
"----------------------------------------------------------------------
"--------------------------------------------------------------------Coc

" Usar <tab> para completar y navegar
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

"-----------------------------------------------------------------------
"-------------------------------------------------------------hexokinase
" Para poder usar este complemento se necesita tener instalado go
" https://golang.org/doc/install

" Metodo para resaltar:
"  Opciones = 
"  'virtual', 'sign_column', 'background', 'backgroundfull',
"' foreground', 'foregroundfull'
let g:Hexokinase_highlighters = [ 'virtual' ]

" Habilitar/Deshabilitar resaltado de colores 
nnoremap <leader>h :HexokinaseToggle<CR>

"-----------------------------------------------------------------------
"------------------------------------------------------------------Shade

lua << EOF
require'shade'.setup()
EOF
"-----------------------------------------------------------------------
"------------------------------------------------------------Preview UML
let g:previm_open_cmd = 'open -a Firefox'
"-----------------------------------------------------------------------
"------------------------------------------------------------Preview UML
" Establecer la URL del servidor plantuml
let g:preview_uml_url='http://localhost:8888'

nnoremap <F7> :silent update<Bar>silent !firefox %:p &<CR>

"-----------------------------------------------------------------------
"-------------------------------------------------------------Treesitter
lua <<EOF

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

lua << EOF
require('nvim-gps').setup{
	auto_preview = True}
EOF

"-----------------------------------------------------------------------
"-----------------------------------------------------------------Hlargs
lua << EOF
require('hlargs').setup()
EOF
"-----------------------------------------------------------------------
"--------------------------------------------------------------Dashboard
let g:dashboard_custom_section={
\ 'a': {'description': [' Find file                             SPC f f'], 'command': "FzfLua files"},
\ 'b': {'description': [' Recently opened files                 SPC f h'], 'command': "FzfLua oldfiles"},
\ 'c': {'description': [' Find word                             SPC f r'], 'command': "FzfLua live_grep"},
\ 'd': {'description': [' New file                              SPC c n'], 'command': "enew"},
\ 'e': {'description': [' Jump to bookmarks                     SPC f b'], 'command': ""},
\ 'f': {'description': [' Change colorscheme                    SPC f c'], 'command': "FzfLua colorschemes"},
\ 'g': {'description': [' Configuration                         SPC s l'], 'command': "edit ~/.config/nvim/init.vim"},
\}


let g:dashboard_custom_header = [
\ '							  ',
\ '							  ',
\ '							  ',
\ '							  ',
\ '							  ',
\ '							  ',
\ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
\ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
\ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
\ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
\ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
\ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
\]

" ¸ ██████   █████                   █████   █████  ███                 
" ¸░░██████ ░░███                   ░░███   ░░███  ░░░                  
" ¸ ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████  
" ¸ ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███ 
" ¸ ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███ 
" ¸ ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███ 
" ¸ █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████
" ¸░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░   

" .                                        
" .                  ,///.                 
" .     #############///////#############. 
" .       ##########//////////#########    
" .          #########.///////#########    
" .      .#.///*######### ////#########    
" .     *,#### //,########## /#########    
" .   ///,####### // ################## /  
" .    //,#########//// ###############    
" .       #########///////#############    
" .      .#########///////// ##########    
" .      .#########//////////// #######    
" .     #############////////     #####    
" .                  /////


" ⠸⣷⣦⠤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⠀⠀⠀
" ⠀⠙⣿⡄⠈⠑⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠔⠊⠉⣿⡿⠁⠀⠀⠀
" ⠀⠀⠈⠣⡀⠀⠀⠑⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠊⠁⠀⠀⣰⠟⠀⠀⠀⣀⣀
" ⠀⠀⠀⠀⠈⠢⣄⠀⡈⠒⠊⠉⠁⠀⠈⠉⠑⠚⠀⠀⣀⠔⢊⣠⠤⠒⠊⠉⠀⡜
" ⠀⠀⠀⠀⠀⠀⠀⡽⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠩⡔⠊⠁⠀⠀⠀⠀⠀⠀⠇
" ⠀⠀⠀⠀⠀⠀⠀⡇⢠⡤⢄⠀⠀⠀⠀⠀⡠⢤⣄⠀⡇⠀⠀⠀⠀⠀⠀⠀⢰⠀
" ⠀⠀⠀⠀⠀⠀⢀⠇⠹⠿⠟⠀⠀⠤⠀⠀⠻⠿⠟⠀⣇⠀⠀⡀⠠⠄⠒⠊⠁⠀
" ⠀⠀⠀⠀⠀⠀⢸⣿⣿⡆⠀⠰⠤⠖⠦⠴⠀⢀⣶⣿⣿⠀⠙⢄⠀⠀⠀⠀⠀⠀
" ⠀⠀⠀⠀⠀⠀⠀⢻⣿⠃⠀⠀⠀⠀⠀⠀⠀⠈⠿⡿⠛⢄⠀⠀⠱⣄⠀⠀⠀⠀
" ⠀⠀⠀⠀⠀⠀⠀⢸⠈⠓⠦⠀⣀⣀⣀⠀⡠⠴⠊⠹⡞⣁⠤⠒⠉⠀⠀⠀⠀⠀
" ⠀⠀⠀⠀⠀⠀⣠⠃⠀⠀⠀⠀⡌⠉⠉⡤⠀⠀⠀⠀⢻⠿⠆⠀⠀⠀⠀⠀⠀⠀
" ⠀⠀⠀⠀⠀⠰⠁⡀⠀⠀⠀⠀⢸⠀⢰⠃⠀⠀⠀⢠⠀⢣⠀⠀⠀⠀⠀⠀⠀⠀
" ⠀⠀⠀⢶⣗⠧⡀⢳⠀⠀⠀⠀⢸⣀⣸⠀⠀⠀⢀⡜⠀⣸⢤⣶⠀⠀⠀⠀⠀⠀
" ⠀⠀⠀⠈⠻⣿⣦⣈⣧⡀⠀⠀⢸⣿⣿⠀⠀⢀⣼⡀⣨⣿⡿⠁⠀⠀⠀⠀⠀⠀
" ⠀⠀⠀⠀⠀⠈⠻⠿⠿⠓⠄⠤⠘⠉⠙⠤⢀⠾⠿⣿⠟⠋


" ⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
" ⠄⠄⠄⠄⠄⠄⣀⣀⣤⣤⣴⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣦⣤⣤⣄⣀⡀⠄⠄⠄⠄⠄
" ⠄⠄⠄⠄⣴⣿⣿⡿⣿⢿⣟⣿⣻⣟⡿⣟⣿⣟⡿⣟⣿⣻⣟⣿⣻⢿⣻⡿⣿⢿⣷⣆⠄⠄⠄
" ⠄⠄⠄⢘⣿⢯⣷⡿⡿⡿⢿⢿⣷⣯⡿⣽⣞⣷⣻⢯⣷⣻⣾⡿⡿⢿⢿⢿⢯⣟⣞⡮⡀⠄⠄
" ⠄⠄⠄⢸⢞⠟⠃⣉⢉⠉⠉⠓⠫⢿⣿⣷⢷⣻⣞⣿⣾⡟⠽⠚⠊⠉⠉⠉⠙⠻⣞⢵⠂⠄⠄
" ⠄⠄⠄⢜⢯⣺⢿⣻⣿⣿⣷⣔⡄⠄⠈⠛⣿⣿⡾⠋⠁⠄⠄⣄⣶⣾⣿⡿⣿⡳⡌⡗⡅⠄⠄
" ⠄⠄⠄⢽⢱⢳⢹⡪⡞⠮⠯⢯⡻⡬⡐⢨⢿⣿⣿⢀⠐⡥⣻⡻⠯⡳⢳⢹⢜⢜⢜⢎⠆⠄⠄
" ⠄⠄⠠⣻⢌⠘⠌⡂⠈⠁⠉⠁⠘⠑⢧⣕⣿⣿⣿⢤⡪⠚⠂⠈⠁⠁⠁⠂⡑⠡⡈⢮⠅⠄⠄
" ⠄⠄⠠⣳⣿⣿⣽⣭⣶⣶⣶⣶⣶⣺⣟⣾⣻⣿⣯⢯⢿⣳⣶⣶⣶⣖⣶⣮⣭⣷⣽⣗⠍⠄⠄
" ⠄⠄⢀⢻⡿⡿⣟⣿⣻⣽⣟⣿⢯⣟⣞⡷⣿⣿⣯⢿⢽⢯⣿⣻⣟⣿⣻⣟⣿⣻⢿⣿⢀⠄⠄
" ⠄⠄⠄⡑⡏⠯⡯⡳⡯⣗⢯⢟⡽⣗⣯⣟⣿⣿⣾⣫⢿⣽⠾⡽⣺⢳⡫⡞⡗⡝⢕⠕⠄⠄⠄
" ⠄⠄⠄⢂⡎⠅⡃⢇⠇⠇⣃⣧⡺⡻⡳⡫⣿⡿⣟⠞⠽⠯⢧⣅⣃⠣⠱⡑⡑⠨⢐⢌⠂⠄⠄
" ⠄⠄⠄⠐⠼⣦⢀⠄⣶⣿⢿⣿⣧⣄⡌⠂⠢⠩⠂⠑⣁⣅⣾⢿⣟⣷⠦⠄⠄⡤⡇⡪⠄⠄⠄
" ⠄⠄⠄⠄⠨⢻⣧⡅⡈⠛⠿⠿⠿⠛⠁⠄⢀⡀⠄⠄⠘⠻⠿⠿⠯⠓⠁⢠⣱⡿⢑⠄⠄⠄⠄
" ⠄⠄⠄⠄⠈⢌⢿⣷⡐⠤⣀⣀⣂⣀⢀⢀⡓⠝⡂⡀⢀⢀⢀⣀⣀⠤⢊⣼⡟⡡⡁⠄⠄⠄⠄
" ⠄⠄⠄⠄⠄⠈⢢⠚⣿⣄⠈⠉⠛⠛⠟⠿⠿⠟⠿⠻⠻⠛⠛⠉⠄⣠⠾⢑⠰⠈⠄⠄⠄⠄⠄
" ⠄⠄⠄⠄⠄⠄⠄⠑⢌⠿⣦⡡⣱⣸⣸⣆⠄⠄⠄⣰⣕⢔⢔⠡⣼⠞⡡⠁⠁⠄⠄⠄⠄⠄⠄
" ⠄⠄⠄⠄⠄⠄⠄⠄⠄⠑⢝⢷⣕⡷⣿⡿⠄⠄⠠⣿⣯⣯⡳⡽⡋⠌⠄⠄⠄⠄⠄⠄⠄⠄⠄
" ⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠙⢮⣿⣽⣯⠄⠄⢨⣿⣿⡷⡫⠃⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
" ⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠘⠙⠝⠂⠄⢘⠋⠃⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
" ⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠀⠀⠀⠀⠀⠀⠀




" ·       ((((((                    ))))))                                iiii                          
" ·     ((::::::(                  )::::::))                             i::::i                         
" ·   ((:::::::(                    ):::::::))                            iiii                          
" ·  (:::::::((                      )):::::::)                                                         
" ·  (::::::(    nnnn  nnnnnnnn        )::::::)vvvvvvv           vvvvvvviiiiiii    mmmmmmm    mmmmmmm   
" ·  (:::::(     n:::nn::::::::nn       ):::::) v:::::v         v:::::v i:::::i  mm:::::::m  m:::::::mm 
" ·  (:::::(     n::::::::::::::nn      ):::::)  v:::::v       v:::::v   i::::i m::::::::::mm::::::::::m
" ·  (:::::(     nn:::::::::::::::n     ):::::)   v:::::v     v:::::v    i::::i m::::::::::::::::::::::m
" ·  (:::::(       n:::::nnnn:::::n     ):::::)    v:::::v   v:::::v     i::::i m:::::mmm::::::mmm:::::m
" ·  (:::::(       n::::n    n::::n     ):::::)     v:::::v v:::::v      i::::i m::::m   m::::m   m::::m
" ·  (:::::(       n::::n    n::::n     ):::::)      v:::::v:::::v       i::::i m::::m   m::::m   m::::m
" ·  (::::::(      n::::n    n::::n    )::::::)       v:::::::::v        i::::i m::::m   m::::m   m::::m
" ·  (:::::::((    n::::n    n::::n  )):::::::)        v:::::::v        i::::::im::::m   m::::m   m::::m
" ·   ((:::::::(   n::::n    n::::n ):::::::))          v:::::v         i::::::im::::m   m::::m   m::::m
" ·     ((::::::(  n::::n    n::::n)::::::)              v:::v          i::::::im::::m   m::::m   m::::m
" ·       ((((((   nnnnnn    nnnnnn ))))))                vvv           iiiiiiiimmmmmm   mmmmmm   mmmmmm

"  ▒█████   ██▓     ██▓    ▓██   ██▓▒██   ██▒  ██████ 
" ▒██▒  ██▒▓██▒    ▓██▒     ▒██  ██▒▒▒ █ █ ▒░▒██    ▒ 
" ▒██░  ██▒▒██░    ▒██░      ▒██ ██░░░  █   ░░ ▓██▄   
" ▒██   ██░▒██░    ▒██░      ░ ▐██▓░ ░ █ █ ▒   ▒   ██▒
" ░ ████▓▒░░██████▒░██████▒  ░ ██▒▓░▒██▒ ▒██▒▒██████▒▒
" ░ ▒░▒░▒░ ░ ▒░▓  ░░ ▒░▓  ░   ██▒▒▒ ▒▒ ░ ░▓ ░▒ ▒▓▒ ▒ ░
"   ░ ▒ ▒░ ░ ░ ▒  ░░ ░ ▒  ░ ▓██ ░▒░ ░░   ░▒ ░░ ░▒  ░ ░
" ░ ░ ░ ▒    ░ ░     ░ ░    ▒ ▒ ░░   ░    ░  ░  ░  ░  
"     ░ ░      ░  ░    ░  ░ ░ ░      ░    ░        ░  

