local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "kyriacos.plugins" }, { import = "kyriacos.plugins.lsp" } }, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})

local function apply_theme()
	require("kyriacos.theme").apply()
end

vim.api.nvim_create_autocmd("User", {
	pattern = "LazyDone",
	once = true,
	callback = apply_theme,
})

-- Fallback when LazyDone already fired (e.g. headless sync)
vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.defer_fn(function()
			if vim.g.colors_name == nil then
				apply_theme()
			end
		end, 100)
	end,
})
