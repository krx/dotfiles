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
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.g.autoformat = false
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"

if vim.fn.has("gui_macvim") then
  vim.g.fu = true
end

-- searching
vim.o.ignorecase = true
vim.o.smartcase = true

local function paste()
vim.o.ignorecase = true
  return {
    vim.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

if vim.env.SSH_TTY then
  vim.o.clipboard = "unnamedplus"
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = paste,
      ["*"] = paste,
    },
  }
end
