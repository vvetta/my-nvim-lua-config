-- Настройка горячих клавиш в Neovim с Lua
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Настройка горячей клавиши Ctrl+n для открытия NERDTree
map('n', '<C-n>', ':NERDTreeToggle<CR>', opts)

