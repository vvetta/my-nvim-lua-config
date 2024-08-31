vim.cmd [[
call plug#begin('~/.config/nvim/plugged')

Plug 'junegunn/vim-plug'
Plug 'mhinz/vim-startify'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'dstein64/nvim-scrollview'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug '0xstepit/flow.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

call plug#end()
]]



-- Настройка nvim-treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = { "python" },  -- Установить парсер только для Python
  highlight = {
    enable = true,  -- Включить подсветку синтаксиса
    additional_vim_regex_highlighting = false,  -- Отключить старую подсветку (опционально)
  },
  indent = {
    enable = true,  -- Включить автоматическое выравнивание
  },
  -- Опционально: можно добавить другие настройки и языки
}


-- Настройка цветовой схемы
require("flow").setup{
	transparent = true, -- Set transparent background.
    fluo_color = "pink", --  Fluo color: pink, yellow, orange, or green.
    mode = "normal", -- Intensity of the palette: normal, bright, desaturate, or dark. Notice that dark is ugly!
    aggressive_spell = false, -- Display colors for spell check.
}

vim.cmd "colorscheme flow"


-- Настройка лсп сервера
-- Подключение LSP
local lspconfig = require('lspconfig')

-- Настройка pyright для Python
lspconfig.pyright.setup{}

-- Если используете pylsp:
-- lspconfig.pylsp.setup{}

-- Настройка nvim-cmp
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)  -- Для работы со сниппетами
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Подтвердить выбранное предложение
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },  -- Источник автодополнения от LSP
    { name = 'luasnip' },   -- Источник автодополнения для сниппетов
  }, {
    { name = 'buffer' },    -- Источник автодополнения из буфера
  })
})

-- Настройка автодополнения для командной строки и путей файлов
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

