vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_TreeNodeShape = ' '
vim.g.undotree_TreeVertShape = ' 󰁝 '
vim.g.undotree_TreeSplitShape = '󰁜 '
vim.g.undotree_TreeReturnShape = '  󰁛 '
vim.g.undotree_SplitWidth = 40

-- add persistent undo
vim.cmd[[
if has("persistent_undo")
   let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif
]]

vim.cmd[[autocmd BufEnter * if bufname("#") =~ "undotree_2" && bufname("%") !~ "undotree_2" | b# | endif]]
