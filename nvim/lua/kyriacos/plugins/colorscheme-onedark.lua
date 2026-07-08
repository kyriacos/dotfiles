return {
	"navarasu/onedark.nvim",
	name = "onedark",
	lazy = true,
	opts = {
		style = "deep",
		transparent = false,
		term_colors = true,
		ending_tildes = false,
		cmp_itemkind_reverse = false,
		toggle_style_key = "<leader>Cs",
		toggle_style_list = { "deep", "light" },
		code_style = {
			comments = "italic",
			keywords = "none",
			functions = "none",
			strings = "none",
			variables = "none",
		},
		lualine = {
			transparent = false,
		},
		colors = {},
		highlights = {},
		diagnostics = {
			darker = true,
			undercurl = true,
			background = true,
		},
	},
}
