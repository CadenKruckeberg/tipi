return {
	{
		"shaunsingh/nord.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.nord_disable_background = true
		end,
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "nord",
		},
	},
}
