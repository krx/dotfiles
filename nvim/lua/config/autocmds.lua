-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  callback = function(args)
    local l = vim.fn.getline(1)
    if l:match("^#!") or l:match("/bin/") then
      vim.fn.execute("!chmod +x " .. args.file, "silent")
      vim.fn.execute("e", "silent")
    end
  end,
})

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.sh",
  callback = function()
    vim.cmd('0put =\\"#!/usr/bin/env bash\\<nl>\\"|$')
  end,
})

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.py",
  callback = function()
    vim.cmd('0put =\\"#!/usr/bin/env python\\<nl>\\"|$')
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.textwidth = 80
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.opt_local.formatoptions:remove('r')
    vim.opt_local.formatoptions:remove('o')
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  callback = function()
    if require("nvim-treesitter.parsers").has_parser() then
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    else
      vim.opt.foldmethod = "syntax"
    end
  end,
})
