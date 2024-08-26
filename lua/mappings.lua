require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

vim.api.nvim_del_keymap('n', '<leader>v')
vim.api.nvim_del_keymap('n', '<leader>h')
-- Split screen horizontally and open a terminal
map("n", "<leader>h", ":split | terminal<CR> | i", { noremap = true, silent = true })

-- Split screen vertically and open a terminal
map("n", "<leader>v", ":vsplit | terminal<CR> | i", { noremap = true, silent = true })
