local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')
local gps = require('nvim-gps')

local b = vim.b
local o = vim.o
local bo = vim.bo

--[[ local colors = {
    bg = '#3a3a3a',
    black = '#3a3a3a',
    yellow = '#d8a657',
    cyan = '#89b482',
    grey = '#4e4e4e',
    grey2 = '#6c6c6c',
    grey3 = '#444444',
    oceanblue = '#45707a',
    green = '#009966',
    orange = '#e78a4e',
    violet = '#875faf',
    violet2 = 'd75df7',
    hotpink = '#ff5faf',
    white = '#ffffff',
    white2 = '#bcbcbc',
    white3 = '#eeeeee',
    fg = '#a89984',
    skyblue = '#7daea3',
    red = '#dB6d75',
    red2 = '#5f0000'
} ]]

local colors = {
    bg = '#16161d',
    black = '#000000',
    yellow = '#dca561',
    cyan = '#7fb4ca',
    grey = '#717c7c',
    grey2 = '#444444',
    grey3 = '#444444',
    oceanblue = '#2d4f67',
    green = '#76946a',
    orange = '#ffa066',
    violet = '#54546d',
    violet2 = '#957fb8',
    hotpink = '#d27e99',
    white = '#ffffff',
    white2 = '#dcd7ba',
    white3 = '#c8c093',
    fg = '#a89984',
    skyblue = '#a3d5d5',
    red = '#e46876',
    red2 = '#ff5d62'
}

local vi_mode_colors = {
    NORMAL = colors.violet,
    OP = colors.green,
    INSERT = colors.green,
    VISUAL = cyan,
    BLOCK = cyan,
    REPLACE = colors.violet,
    ['V-REPLACE'] = colors.violet,
    ENTER = colors.oceanblue,
    MORE = colors.oceanblue,
    SELECT = colors.orange,
    COMMAND = colors.green,
    SHELL = colors.green,
    TERM = colors.green,
    NONE = colors.yellow
}

local icons = {
    linux = ' ',
    macos = ' ',
    windows = ' ',
}

-- provider filetype
local function filetype()
    return bo.filetype:lower()
end

-- provider file_osinfo
local function file_osinfo()
    local os = vim.bo.fileformat:upper()
    local icon
    if os == 'UNIX' then
        icon = icons.linux
    elseif os == 'MAC' then
        icon = icons.macos
    else
        icon = icons.windows
    end
    return icon
end

-- provider encoding
local function encoding()
    local enc = (bo.fenc ~= '' and bo.fenc) or o.enc
    return enc:lower()
end

-- location
local function location()
    return ":%l:%-2c"
end

-- Returns true if 1/2 window width is greater than cols
local has_width_gt = function(cols, winid)
  winid = winid or 0
  return vim.api.nvim_win_get_width(winid) / 2 > cols
end

local force_inactive = {
    filetypes = {
        'NvimTree',
        'dbui',
        'packer',
        'startify',
        'fugitive',
        'fugitiveblame',
        'CHADTree',
        'minimap',
        'outline',
        'fzf'
    },
    buftypes = {
        'terminal',
        'fzf',
    },
    bufnames = {
        'OUTLINE'
    }
}

local disable = {
    filetypes = {
        'dashboard'
    },
    buftypes = {},
    bufnames = {}
}

local components = {
    active = {},
    inactive = {}
}
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.inactive, {})
-- LEFT
-- vi-mode
table.insert(components.active[1], {
    provider = 'vi_mode',
    hl = function()
        return {
            fg = 'white',
            bg = vi_mode_utils.get_mode_color(),
            name = vi_mode_utils.get_mode_highlight_name(),
            style = 'bold'
        }
    end,
    left_sep ='block',
    right_sep = function()
    local val = {str = '█',}
        val.fg = vi_mode_utils.get_mode_color()
        val.bg = colors.black
        return val
    end,
    icon = ''
    })
    -- git branch
    table.insert(components.active[1], {
        provider = 'git_branch',
        enabled = function() return has_width_gt(40) end,
        hl = {
            fg = colors.hotpink,
            bg = colors.grey2,
            style = 'bold'
        },
        icon = '  ',
        left_sep = function()
            local val = {hl = {fg = colors.bg, bg = colors.grey2}}
                if b.gitsigns_status_dict then val.str = '' else val.str = '' end
            return val
        end,
        right_sep = function()
            local val = {hl = {fg = colors.grey2, bg = colors.grey2}}
            -- if not has_width_gt(40) then val.str = ' '
            if b.gitsigns_status_dict and not has_width_gt(40) then val.str = '' else val.str = ' ' end
            return val
        end,
    })
    table.insert(components.active[1], {
        -- git diff add
        provider = 'git_diff_added',
        enabled = function() return has_width_gt(50) end,
        hl = {
            fg = colors.green,
            bg = colors.grey2
        },
    })
    -- git diff changed
    table.insert(components.active[1], {
        provider = 'git_diff_changed',
        enabled = function() return has_width_gt(50) end,
        hl = {
            fg = colors.orange,
            bg = colors.grey2
        },
    })
    -- git diff remove
    table.insert(components.active[1], {
        provider = 'git_diff_removed',
        enabled = function() return has_width_gt(50) end,
        hl = {
            fg = colors.red,
            bg = colors.grey2
        },
        --[[ right_sep = function()
            local val = {hl = {fg = 'grey', bg = 'black'}}
            if b.gitsigns_status_dict and not has_width_gt(50) then val.str = '' else val.str = '█' end
            return val
        end, ]]
    })
    -- filename
    table.insert(components.active[1], {
        provider = 'file_info',
        hl = {
            fg = 'white2',
            bg = colors.bg,
            style = 'bold',
        },
        type = 'unique',
        left_sep = function()
            local val = {hl = {fg = colors.grey2, bg = colors.bg}}
            if b.gitsigns_status_dict and has_width_gt(40) then val.str = '█' else val.str = ' ' end
            return val
        end,
        right_sep = '',
        icon = '',
    })
    -- gps
    table.insert(components.active[1], {
        provider = function()
            return gps.get_location()
        end,
        enabled = function()
            if has_width_gt(80) then
            return gps.is_available()
        end
        end
    })

    -- RIGHT
    -- errors
    table.insert(components.active[2], {
        provider = 'diagnostic_errors',
        enabled = function() if has_width_gt(50) then return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR) end end,
        hl = { fg = colors.red },
    })
    -- warnings
    table.insert(components.active[2], {
        provider = 'diagnostic_warnings',
        enabled = function() if has_width_gt(50) then return lsp.diagnostics_exist(vim.diagnostic.severity.WARN) end end,
        hl = { fg = colors.yellow },
    })
    -- hints
    table.insert(components.active[2], {
        provider = 'diagnostic_hints',
        enabled = function() if has_width_gt(50) then return lsp.diagnostics_exist(vim.diagnostic.severity.HINT) end end,
        hl = { fg = 'cyan' },
    })
    -- info
    table.insert(components.active[2], {
      --  enabled = function() return has_width_gt(45) end,
        provider = 'diagnostic_info',
        enabled = function() if has_width_gt(50) then return lsp.diagnostics_exist(vim.diagnostic.severity.INFO) end end,
        hl = { fg = colors.skyblue },
    })
    -- fileType
    table.insert(components.active[2], {
        provider = filetype,
        hl = function()
            local val = {}
            local filename = vim.fn.expand('%:t')
            local extension = vim.fn.expand('%:e')
            local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
            if icon ~= nil then
                val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
            else
                val.fg = 'white'
            end
            val.bg = 'black'
            return val
        end,
        left_sep = {' ', {str = '█', hl = {bg = colors.bg, fg = 'black'}}},
        right_sep = {{str = '█', hl = {fg = 'black'}}}
    })
    -- file icon
    table.insert(components.active[2], {
        provider = function()
            local filename = vim.fn.expand('%:t')
            local extension = vim.fn.expand('%:e')
            local icon  = require'nvim-web-devicons'.get_icon(filename, extension)
            if icon == nil then
                icon = ''
            end
            return icon
        end,
        hl = function()
            local val = {}
            local filename = vim.fn.expand('%:t')
            local extension = vim.fn.expand('%:e')
            local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
            if icon ~= nil then
                val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
            else
                val.fg = 'white'
            end
            val.bg = 'black'
            val.style = 'bold'
            return val
        end,
        --right_sep = {str = '', hl = {fg = 'grey', bg = 'grey3'}},
        right_sep = function()
            local val = {hl = {fg = 'grey', bg = 'black'}}
            if not has_width_gt(45) then val.str = ' ' else val.str = ' ' end
            return val
        end,
    })
    -- python venv
    table.insert(components.active[2], {
        provider = function()
            local name_with_path = os.getenv('VIRTUAL_ENV')
            local venv = {};
            for match in (name_with_path.."/"):gmatch("(.-)".."/") do
                table.insert(venv, match);
            end
            return venv[#venv]
        end,
        hl = { fg = 'cyan', bg = 'black'},
        enabled = function() return has_width_gt(60) and os.getenv('VIRTUAL_ENV') ~= nil end,
        left_sep = {str = '(', hl = { fg = 'cyan', bg = 'black'}},
        right_sep = {str = ')', hl = { fg = 'cyan', bg = 'black'}},
    })
    -- server lps name
    table.insert(components.active[2], {
        provider = 'lsp_client_names',
        enabled = function() return has_width_gt(55) end,
        hl = {
            fg = colors.yellow,
            bg = 'black'
        },
        icon = ' ',
        left_sep = {str = ' ', hl = {bg = 'black'}},
        right_sep = {str = ' ', hl = {bg = 'black'}},
        --[[ right_sep = function()
            local val = {hl = {fg = 'grey', bg = 'grey3'}}
            if not has_width_gt(50) then val.str = ' ' else val.str = ' ' end
            return val
        end, ]]
    })
    -- file_encoding
    table.insert(components.active[2], {
        provider = encoding,
        enabled = function() return has_width_gt(45) end,
        hl = {
            fg = 'white3',
            bg = colors.grey2
        },
        left_sep = {{str = '█', hl = {bg = 'black', fg = colors.grey2}}},
        right_sep = {{str = 'block', hl = {fg = colors.grey2}}},
    })
    -- os info
    table.insert(components.active[2], {
        provider = file_osinfo,
        enabled = function() return has_width_gt(45) end,
        hl = {
            fg = 'white3',
            bg = colors.grey2
        },
        --right_sep = {{str = ' ', hl = {bg = 'grey2'}}},
    })
    -- position
    table.insert(components.active[2], {
        provider = location,
        hl = {
            fg = 'white',
            bg = colors.violet
        },
        left_sep = {{str = '█', hl = {bg = colors.grey2, fg = colors.violet}}},
    })
    -- percentage
    table.insert(components.active[2], {
        provider = 'line_percentage',
        hl = {
            fg = 'white',
            bg = colors.violet
        },
        left_sep = {{str = 'block', hl = {fg = colors.violet}}, {str = 'left', hl = {fg = 'white2', bg = colors.violet}}, {str = ' ', hl = {bg = colors.violet}}},
        right_sep = {{str = ' ', hl = {bg = colors.violet}}},
    })
    -- scroll_bar
    table.insert(components.active[2], {
        provider = 'scroll_bar',
        hl = {
            fg = colors.orange,
            bg = colors.violet
        }
    })

    -- INACTIVE

    -- LEFT
    -- file icon
    table.insert(components.inactive[1], {
        provider = function()
            local filename = vim.fn.expand('%:t')
            local extension = vim.fn.expand('%:e')
            local icon  = require'nvim-web-devicons'.get_icon(filename, extension)
            if icon == nil then
                icon = ''
            end
            return icon
        end,
        hl = function()
            local val = {}
            local filename = vim.fn.expand('%:t')
            local extension = vim.fn.expand('%:e')
            local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
            if icon ~= nil then
                val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
            else
                val.fg = 'white'
            end
            val.bg = colors.violet
            val.style = 'bold'
            return val
        end,
        left_sep = {str = ' ', hl = {bg = colors.violet}},
        right_sep = {str = ' ', hl = {bg = colors.violet}},
    })
    -- filename
    table.insert(components.inactive[1], {
        provider = 'file_type',
        hl = {
            fg = 'white',
            bg = colors.violet,
            style = 'bold'
        },
        --left_sep = {'block', {hl = {fg = 'violet'}}},
        right_sep = {'█', {hl = {fg = colors.violet, bg = colors.bg}}}
    })
    -- filename
    table.insert(components.inactive[1], {
        provider = 'file_info',
        hl = {
            fg = 'white2',
            bg = colors.bg,
            style = 'bold',
        },
        type = 'unique',
        left_sep = ' ',
        right_sep = '',
        icon = '',
    })

    require('feline').setup({
        colors = colors,
        bg = 'black',
        fg = colors.fg,
        components = components,
        force_inactive = force_inactive,
        disable = disable,
        vi_mode_colors = vi_mode_colors
    })

    require('feline').add_theme('colors', colors)
    require('feline').use_theme('colors')
