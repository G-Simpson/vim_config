local M = {}

M.ui = {
	theme = "github_dark",
	hl_override = {
      ["kyazdani42/nvim-tree.lua"] = {
         view = {
            width = 200,  
         },
      },
   },
  statusline = {
    theme = "minimal",
    separator_style = "round",
    overriden_modules = nil,
  },
}

return M
