vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- custom settings:
vim.opt.clipboard = 'unnamedplus'

require('telescope').setup{
  defaults = {
    file_ignore_patterns = {"doc", "node_modules", ".git", "dist", "build"}
  }
}
 require("nvim-tree").setup({
    view = {
      width = 60,
    }
  })      
local set_keymap = vim.api.nvim_set_keymap

-- Create a custom function to open terminal in a vertical split with half screen width
function OpenHalfWidthTerminal()
  vim.cmd('vsplit')                      -- Open vertical split
  vim.cmd('wincmd L')                    -- Move to the new split
  vim.cmd('resize ' .. math.floor(vim.o.columns / 2))  -- Resize to half width
  vim.cmd('term')                        -- Open terminal
end

-- Map <leader>h to the custom function
set_keymap('n', '<leader>h', ':lua OpenHalfWidthTerminal()<CR>', { noremap = true, silent = true })
