require("fzf-lua").setup({
  previewers = {
    builtin = {
      extensions = {
        ["png"] = { "viu", "-b" },
        ["jpg"] = { "viu", "-b" },
        ["gif"] = { "viu", "-b" },
      }
    }
  },
})

local map = vim.keymap.set

map("n", "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
map("n", "<leader>fg", "<cmd>lua require('fzf-lua').git_files()<CR>", { silent = true })
map("n", "<leader>fb", "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })
map("n", "<leader>fr", "<cmd>lua require('fzf-lua').live_grep()<CR>", { silent = true })
map("n", "<leader>fm", "<cmd>lua require('fzf-lua').man_pages()<CR>", { silent = true })
map("n", "<leader>fh", "<cmd>lua require('fzf-lua').oldfiles()<CR>", { silent = true })
map("n", "<leader>fc", "<cmd>lua require('fzf-lua').colorschemes()<CR>", { silent = true })
