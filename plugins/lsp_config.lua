-- Mostrar diagnósticos de línea automáticamente en la ventana flotante
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focusable=false})]]

-- Personalizar cómo se muestran los diagnósticos
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
})

-- Cambiar los símbolos de diagnóstico en la columna de señales
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


require("nvim-lsp-installer").setup{
	automatic_installation = true
}

local servers = {"pyright", "vimls"} 
local lpsconfig = require('lspconfig')
for _, server in ipairs(servers) do
	lpsconfig[server].setup{}
end
--[[
-- PYTHON

require'lspconfig'.pyright.setup{}

-- HTML, CSS, JAVASCRIP

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
  capabilities = capabilities,
}

-- aspnetcorerazor, astro, astro-markdown, blade, django-html, edge, eelixir, ejs, erb, eruby, gohtml, haml,
-- handlebars, hbs, html, html-eex, jade, leaf, liquid, markdown, mdx, mustache, njk, nunjucks, php, razor,
-- slim, twig, css, less, postcss, sass, scss, stylus, sugarss, javascript, javascriptreact, reason, rescript,
-- typescript, typescriptreact, vue, svelte
require'lspconfig'.tailwindcss.setup{}

-- BashScript
require'lspconfig'.bashls.setup{}

-- VimSript
require'lspconfig'.vimls.setup{}

-- LUA

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = "/home/ollyxs/.config/nvim/language_servers/lua-language-server"
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
]]--
