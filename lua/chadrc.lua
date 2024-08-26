local M = {}

M.ui = {
	theme = "github_dark",
	hl_override = {
      ["kyazdani42/nvim-tree.lua"] = {
         view = {
            width = 200,  -- Set this to your desired width
         },
      },
   },
  -- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

return M
