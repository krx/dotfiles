-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- bit faster
vim.keymap.set({ "n", "v" }, ";", ":")

-- quicker jump to matching paren
vim.keymap.set({ "n", "v" }, "<tab>", "%")

-- make regex behave normally
vim.keymap.set({ "n", "v" }, "/", "/\\v")
vim.keymap.set("c", "s/", "s/\\v")
vim.keymap.set("c", "%s/", "%s/\\v")

-- mash to esc
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("i", "kj", "<esc>")

-- fast movement
vim.keymap.set({ "n", "v" }, "H", "0")
vim.keymap.set({ "n", "v" }, "L", "$")
-- vim.keymap.set({ "n", "v" }, "J", "5j")
-- vim.keymap.set({ "n", "v" }, "K", "5k")
vim.keymap.set({ "n", "v" }, "<S-down>", "5j")
vim.keymap.set({ "n", "v" }, "<S-up>", "5k")

-- literally never use F1
vim.keymap.set("!", "<F1>", "<esc>")

-- delete a line from insert
vim.keymap.set("i", "<C-x>", "<C-o>dd")

-- sudo helpers
vim.keymap.set("c", "E", "SudaRead")
vim.keymap.set("c", "W", "SudaWrite")

-- bufline helpers
--   abs number - keys (1..0) -> bufs (1..10)
local bl = require("bufferline")
for i = 1, 10 do
  vim.keymap.set("n", string.format("<leader>%d", i % 10), function()
    bl.go_to(i, true)
  end)
end

--  prev/next
vim.keymap.set("n", "<leader>`", function()
  bl.cycle(-1)
end)
vim.keymap.set("n", "<leader>-", function()
  bl.cycle(1)
end)
