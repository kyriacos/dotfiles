return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  keys = {
    {
      "<leader>fa",
      function()
        -- require("telescope.builtin").find_files({ cwd = require("telescope.utils").buffer_dir() })
        require("telescope.builtin").find_files({ hidden = true })
      end,
      desc = "Fuzzy find all files in cbd",
    },
    {

      "<leader>ff",
      function()
        local utils = require("telescope.utils")
        local builtin = require("telescope.builtin")
        _G.project_files = function()
          local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })
          if ret == 0 then
            builtin.git_files({ hidden = true })
          else
            require("telescope.builtin").find_files({ hidden = true })
          end
        end
        project_files()
      end,
      mode = "n",
      desc = "Fuzzy find git files in cbd",
    },
    {

      "<leader>fba",
      function()
        require("telescope.builtin").find_files({ cwd = require("telescope.utils").buffer_dir() })
      end,
      mode = "n",
      desc = "Fuzzy find files in cwb",
    },
    {
      "<leader>fbb",
      "<cmd>Telescope buffers<cr>",
      mode = "n",
      desc = "Fuzzy find open buffers",
    },
    {

      "<leader>fr",
      "<cmd>Telescope oldfiles<cr>",
      mode = "n",
      desc = "Fuzzy find recently opened files",
    },
    {
      "<leader>fg",
      "<cmd>Telescope live_grep<cr>",
      mode = "n",
      desc = "Find text in current working directory (grep)",
    },
    {
      "<leader>fh",
      "<cmd>Telescope help_tags<cr>",
      mode = "n",
      desc = "Search help documentation",
    },
    {
      "<leader>ft",
      "<cmd>TodoTelescope<cr>",
      mode = "n",
      desc = "Find todos",
    },
    -- keymap.set("n", "<leader>fs", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local transform_mod = require("telescope.actions.mt").transform_mod

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")

    -- or create your custom action
    local custom_actions = transform_mod({
      open_trouble_qflist = function()
        trouble.toggle("quickfix")
      end,
    })

    telescope.setup({
      defaults = {
        -- path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-t>"] = trouble_telescope.open,
          },
        },
      },
    })

    telescope.load_extension("fzf")
  end,
}
