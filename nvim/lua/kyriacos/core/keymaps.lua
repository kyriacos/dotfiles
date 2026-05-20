vim.g.mapleader = ","

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
-- map("i", "kk", "<ESC>", { desc = "Exit insert mode with jk" })

map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
-- Clear search with <esc>
map("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })
map("n", "<leader>tk", "<C-w>t<C-w>K") -- change vertical to horizontal
map("n", "<leader>th", "<C-w>t<C-w>H") -- change horizontal to vertical
map("i", "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map("x", "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map("n", "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map("s", "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- window management
map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window
map("n", "<leader>sk", "<C-w>t<C-w>K", { desc = "Change vertical to horizontal" })
map("n", "<leader>sj", "<C-w>t<C-w>H", { desc = "Change horizontal to vertical" })

map("v", ">", ">gv", { noremap = true, silent = true })
map("v", "<", "<gv", { noremap = true, silent = true })
map("i", "<S-Tab>", "<C-d>", { noremap = true, silent = true })
map("i", "<Tab>", "<C-i>", { noremap = true, silent = true })

map("n", "<leader>rc", ":so %<CR>", { desc = "Reload configuration without restarting vim" })

-- map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
-- map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
-- map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
-- map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
-- map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
