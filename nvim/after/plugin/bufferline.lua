local options = {
  numbers = function (opts)
    return string.format('%s.%s', opts.ordinal, opts.lower(opts.id))
  end,
  hover = {
    enabled = true,
    delay = 50,
    reveal = {'close'}
  },
  offsets = {
    {
      filetype = "NvimTree",
      text = "File Explorer",
      highlight = "Directory",
      text_align = "center"
    },
    {
      filetype = "undotree",
      text = "UndoTree",
      highlight = "Directory",
      text_align = "center"
    }
  }
}

local highlights = {
  fill = {
    guibg = '#1b1c20'
  },
  background = {
    --guifg = '<color-value-here>',
    guibg = '#1E1F29',
  },
  close_button = {
    guibg = '#1E1F29',
  },
  diagnostic = {
    guibg = '#1E1F29',
  },
  info = {
    guibg = '#1E1F29',
  },
  info_diagnostic = {
    guibg = '#1E1F29',
  },
  warning = {
    guibg = '#1E1F29',
  },
  warning_diagnostic = {
    guibg = '#1E1F29',
  },
  error = {
    guibg = '#1E1F29',
  },
  error_diagnostic = {
    guibg = '#1E1F29',
  },
  modified = {
    guibg = '#1E1F29',
  },
  duplicate = {
    guibg = '#1E1F29',
  },
  separator = {
    guibg = '#1E1F29',
  },
  pick = {
    guibg = '#1E1F29',
  },
}

require("bufferline").setup({
  options = options,
  highlights = highlights,
})

vim.keymap.set("n", "<leader>bb", ":BufferLinePick<CR>")
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>")

vim.keymap.set("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { silent = true })
vim.keymap.set("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { silent = true })
vim.keymap.set("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { silent = true })
vim.keymap.set("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", { silent = true })
vim.keymap.set("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", { silent = true })
vim.keymap.set("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", { silent = true })
vim.keymap.set("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", { silent = true })
vim.keymap.set("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", { silent = true })
vim.keymap.set("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", { silent = true })
