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
