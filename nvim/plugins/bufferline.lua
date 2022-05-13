local options = {
    numbers = function(opts)
        return string.format('%s.%s', opts.ordinal, opts.lower(opts.id))
    end,
    diagnostics = "nvim_lsp",
    --	diagnostics_indicator = function(count, level, diagnostics_dict, context)
        --  		local icon = level:match("error") and " " or " "
        --  		return " " .. icon .. count
        --	end,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
        if context.buffer:current() then
            return ''
        end
        local s = " "
        for e, n in pairs(diagnostics_dict) do
            local sym = e == "error" and " "
            or (e == "warning" and " " or "" )
            s = s .. n ..sym
        end
        return s
    end,
    middle_mouse_command = "sbuffer %d",
    right_mouse_command = "vertical sbuffer %d",
    separator_style = "thin",
    offsets = {
        {
            filetype = "CHADTree",
            text = "Explorador de archivos",
            highlight = "Directory",
            text_align = "center"
        },
        {
            filetype = "NvimTree",
            text = "Explorador de archivos",
            highlight = "Directory",
            text_align = "center"
        }
    },
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
--[[
local custom_areas = {
    left = function()
        return{
            { text = 'holaaaaaaaa' .. (vim.cmd.toggleterm), guibg="#000000", guifg="#ffffff"},
        }
        end
    }
 ]]
 
 --[[ local groups = {
  options = {
    toggle_hidden_on_enter = true -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
  },
  items = {
    {
      name = "Tests", -- Mandatory
      highlight = {gui = "underline", guisp = "blue"}, -- Optional
      priority = 2, -- determines where it will appear relative to other groups (Optional)
      icon = "", -- Optional
      matcher = function(buf) -- Mandatory
        return buf.filename:match('%_test') or buf.filename:match('%_spec')
      end,
    }
    {
      name = "Docs"
      highlight = {gui = "undercurl", guisp = "green"},
      auto_close = false,  -- whether or not close this group if it doesn't contain the current buffer
      matcher = function(buf)
        return buf.filename:match('%.md') or buf.filename:match('%.txt')
      end,
      separator = { -- Optional
        style = require('bufferline.groups').separator.tab
      },
    }
  }
} ]]


require("bufferline").setup{
    options = options,
    highlights = highlights,
    -- groups = groups
    -- custom_areas = custom_areas
}
