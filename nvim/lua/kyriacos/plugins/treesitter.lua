return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    require("nvim-treesitter").setup()

    require("nvim-treesitter").install({
      "json",
      "javascript",
      "typescript",
      "tsx",
      "yaml",
      "html",
      "css",
      "prisma",
      "markdown",
      "markdown_inline",
      "svelte",
      "graphql",
      "bash",
      "lua",
      "vim",
      "dockerfile",
      "gitignore",
      "query",
      "vimdoc",
      "c",
    })

    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        local ft = vim.bo.filetype
        if ft == "" then
          return
        end

        local lang = vim.treesitter.language.get_lang(ft)
        if lang and vim.treesitter.language.add(lang) then
          vim.treesitter.start()
        end
      end,
    })

    -- Built-in treesitter incremental selection (replaces old nvim-treesitter keymaps)
    vim.keymap.set("n", "<C-space>", "van", { desc = "Init treesitter selection" })
    vim.keymap.set("x", "<C-space>", "an", { desc = "Expand treesitter selection" })
    vim.keymap.set("x", "<bs>", "in", { desc = "Shrink treesitter selection" })

    require("nvim-ts-autotag").setup()
  end,
}
