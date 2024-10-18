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
    adaptive_size = true
  },
  update_focused_file = {
    enable = true,   -- Enable NvimTree to update the focused file
    update_cwd = true,  -- Update the current working directory to match the file
  },
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  actions = {
    open_file = {
      resize_window = true,
    },
  },
})      
-- Automatically change to the project root based on certain files (.git)
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = "*",
  callback = function()
    local root_dir = vim.fn.finddir(".git", ".;")
    if root_dir ~= "" then
      -- This ensures the root directory is the parent of .git
      local project_root = vim.fn.fnamemodify(root_dir, ":p:h:h")
      vim.cmd("cd " .. project_root)
    end
  end,
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


require('telescope').setup {
  defaults = {
    -- other settings
  },
  pickers = {
    find_files = {
      hidden = true,  -- Include hidden files by default
    },
  },
}
-- open terminal without line numbers
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.wo.number = false    -- Disable line numbers
    vim.wo.relativenumber = false  -- Disable relative line numbers
  end,
})

-- open buffers with relative line numbers
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.wo.relativenumber = true    -- Enable relative line numbers
    vim.wo.number = true            -- Also keep absolute number on the current line
  end,
})

-- set slim file types
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.slim" },
  command = "set ft=slim",
})

-- Set fileformat to unix for all files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*",
  command = "set fileformat=unix",
})

vim.o.foldmethod = 'indent'  -- Or 'syntax', 'expr' for Treesitter
vim.o.foldlevel = 99
vim.o.foldenable = true

