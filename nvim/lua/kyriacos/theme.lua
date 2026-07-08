local M = {}

local spec_path = vim.fn.expand("~/.dotfiles/theme/generated/nvim.lua")

local default_spec = {
	family = "catppuccin",
	variant = "macchiato",
	mode = "dark",
	lualine = "catppuccin",
	accent = "#f5a97f",
}

function M.load_spec()
	if vim.fn.filereadable(spec_path) == 0 then
		return default_spec
	end
	return vim.deepcopy(dofile(spec_path))
end

function M.apply_lualine(spec)
	local ok, lualine = pcall(require, "lualine")
	if not ok then
		return
	end
	local lazy_status = require("lazy.status")
	lualine.setup({
		options = {
			theme = spec.lualine,
		},
		sections = {
			lualine_x = {
				{
					lazy_status.updates,
					cond = lazy_status.has_updates,
					color = { fg = spec.accent },
				},
				{ "encoding" },
				{ "fileformat" },
				{ "filetype" },
			},
		},
	})
end

function M.apply_catppuccin(spec)
	require("catppuccin").setup({
		flavour = spec.variant,
		transparent_background = false,
		term_colors = true,
		integrations = {
			cmp = true,
			gitsigns = true,
			nvimtree = true,
			telescope = true,
			treesitter = true,
			notify = false,
			mini = { enabled = true, indentscope_color = "" },
			native_lsp = { enabled = true },
		},
	})
	vim.cmd.colorscheme("catppuccin-" .. spec.variant)
end

function M.apply_rose_pine(spec)
	require("rose-pine").setup({
		variant = spec.variant,
		dim_inactive_windows = false,
		extend_background_behind_borders = true,
		enable = {
			terminal = true,
			legacy_highlights = true,
			migrations = true,
		},
		styles = {
			bold = true,
			italic = true,
			transparency = false,
		},
	})
	local colorscheme = spec.variant == "main" and "rose-pine" or ("rose-pine-" .. spec.variant)
	vim.cmd.colorscheme(colorscheme)
end

function M.apply()
	local spec = M.load_spec()
	vim.o.background = spec.mode

	if spec.family == "catppuccin" then
		M.apply_catppuccin(spec)
	elseif spec.family == "rose-pine" then
		M.apply_rose_pine(spec)
	else
		vim.notify("Unknown theme family: " .. spec.family, vim.log.levels.ERROR)
		return
	end

	M.apply_lualine(spec)
end

return M
