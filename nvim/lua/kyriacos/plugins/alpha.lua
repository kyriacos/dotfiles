return {
  "goolord/alpha-nvim",
  -- event = "VimEnter",
  enabled = false,
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
    dashboard.section.header.val = {
      "  _         _          ",
      " | |       | |         ",
      " | | ____ _| | _____   ",
      " | |/ / _` | |/ / __|  ",
      " |   < (_| |   <\\__ \\  ",
      " |_|\\_\\__,_|_|\\_\\___/  ",
      "                       ",
    }

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button("n", "  New file", "<cmd>ene<CR>"),
      dashboard.button("f", "󰱼  Find file", "<cmd>Telescope find_files<CR>"),
      dashboard.button("g", "  Find text", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("r", " " .. " Recent files", "<cmd> Telescope oldfiles <cr>"),
      dashboard.button("s", "󰁯  Restore session", "<cmd>SessionRestore<CR>"),
      dashboard.button("e", "  Explorer", "<cmd>NvimTreeToggle<CR>"),
      dashboard.button("c", " " .. " Config", "<cmd> e $MYVIMRC <cr>"),
      dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
      dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
    }

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
