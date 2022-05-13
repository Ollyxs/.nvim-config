require('toggleterm').setup{
    open_mapping = [[<F12>]],
    shade_terminals = true,
    shading_factor = 2,
    direction = 'horizontal',
    -- float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        -- | 'shadow' | 'curved' | ... other options supported by win open
        -- border = 'curved',
        --width = <value>,
        --height = <value>,
        --[[ winblend = 5,
        highlights = {
            border = "Normal",
            background = "Normal",
        }
    } ]]
}


local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
    float_opts = {
        border = "curved",
        background = "Pmenu",
    },
    -- function to run on opening the terminal
    on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
    end,
    -- function to run on closing the terminal
    --[[ on_close = function(term)
        vim.cmd("Closing terminal")
    end, ]]
})

function _lazygit_toggle()
    lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})

local buffer_to_string = function()
    local content = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
    return table.concat(content, "\n")
end


local fn = vim.fn
local bo = vim.bo
local api = vim.api

local function get_current_filenames()
    local listed_buffers = vim.tbl_filter(
        function(bufnr)
            return bo[bufnr].buflisted and api.nvim_buf_is_loaded(bufnr)
        end,
        api.nvim_list_bufs()
    )

    return vim.tbl_map(api.nvim_buf_get_name, listed_buffers)
end

-- Get unique name for the current buffer
local function get_unique_filename(filename, shorten)
    local filenames = vim.tbl_filter(
        function(filename_other)
            return filename_other ~= filename
        end,
        get_current_filenames()
    )

    if shorten then
        filename = fn.pathshorten(filename)
        filenames = vim.tbl_map(fn.pathshorten, filenames)
    end

    -- Reverse filenames in order to compare their names
    filename = string.reverse(filename)
    filenames = vim.tbl_map(string.reverse, filenames)

    local index

    -- For every other filename, compare it with the name of the current file char-by-char to
    -- find the minimum index `i` where the i-th character is different for the two filenames
    -- After doing it for every filename, get the maximum value of `i`
    if next(filenames) then
        index = math.max(unpack(vim.tbl_map(
            function(filename_other)
                for i = 1, #filename do
                    -- Compare i-th character of both names until they aren't equal
                    if filename:sub(i, i) ~= filename_other:sub(i, i) then
                        return i
                    end
                end
                return 1
            end,
            filenames
        )))
    else
        index = 1
    end

    -- Iterate backwards (since filename is reversed) until a "/" is found
    -- in order to show a valid file path
    while index <= #filename do
        if filename:sub(index, index) == "/" then
            index = index - 1
            break
        end

        index = index + 1
    end

    return string.reverse(string.sub(filename, 1, index))
end


--[[
local lizard = Terminal:new({
    cmd = string.gsub("lizard -C200 -L50 -a4 name", "name", function(x)
        x = function(winid)
            local filename = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(winid))
                --filename = vim.fn.fnamemodify(filename, ':t')
                --filename = vim.fn.pathshorten(filename)
                --filename = vim.fn.fnamemodify(filename, ":~:.")
                --filename = vim.fn.pathshorten(fn.fnamemodify(filename, ":~:."))
                --filename = get_unique_filename(filename)
                --filename = get_unique_filename(filename, true)
                filename = vim.fn.fnamemodify(filename, ':T')
            return filename
        end
        return x()
    end),
    direction = "float",
    close_on_exit = false,
    float_opts = {
        border = "curved",
        background = "Pmenu",
    },

    on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
    end,
})

function _lizard_toggle()
    lizard:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>x", "<cmd>lua _lizard_toggle()<CR>", {noremap = true, silent = true})
]]--
