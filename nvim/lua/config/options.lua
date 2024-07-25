-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- general settigns
vim.o.shell = "/bin/zsh"
vim.o.ww = "b,s,h,l,<,>,[,]"
vim.o.copyindent = true
vim.o.visualbell = true
vim.o.termguicolors = true
vim.o.mouse = "a"
vim.o.foldmethod = "marker"
vim.g.autoformat = false

-- disable comments going to next line
vim.o.formatoptions = vim.o.formatoptions:gsub("[crv]", "")

if vim.fn.has("gui_macvim") then
  vim.g.fu = true
end

-- searching
vim.o.ignorecase = true
vim.o.smartcase = true
--
-- vim.g.lazyvim_python_ruff = "ruff_lsp"
-- vim.g.lazyvim_python_lsp = ""
