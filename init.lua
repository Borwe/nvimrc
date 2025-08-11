-- setup paq
local bootstrap = require('paq_setup').bootstrap
-- Add packages
bootstrap {
    'nvim-lua/plenary.nvim',   -- required by telescope
    'tpope/vim-sleuth',        -- for tabbing
    'nvim-lualine/lualine.nvim', -- lualine
    'nvim-tree/nvim-web-devicons',
    'tpope/vim-fugitive',      --for git and info on airline
    'neovim/nvim-lspconfig',   -- for lsp
    'leafgarland/typescript-vim', -- syntax highlighting for vim
    'kyazdani42/nvim-tree.lua', -- for nvim-tree
    -- START FOR COMPLETIONS
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/nvim-cmp',
    {'Borwe/codeium.nvim', branch = "windows-io-fix"},
    --'Exafunction/codeium.nvim', -- codeium ai
    'quangnguyen30192/cmp-nvim-ultisnips', -- for ulti snips completion
    -- DONE FOR COMPLETIONS
    -- START LspInstall
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    -- DONE LspInstall
    'SirVer/ultisnips',                               -- for snippets
    'mhinz/vim-startify',                             -- for managing startup and sessions
    { 'nanotee/luv-vimdocs' },                        --for luv documentation
    'wsdjeg/luarefvim',                               -- for lua 5.1 documentation
    'wakatime/vim-wakatime',                          -- wakatime
    'ellisonleao/gruvbox.nvim',
    -- { 'Borwe/code_runner.nvim' },                     -- code runner
    { 'nvim-telescope/telescope.nvim',  branch = '0.1.x' }, -- get telescope
    { 'nvim-treesitter/nvim-treesitter' },             -- setup treesitter

    -- Avante AI
    -- required dependencies
    -- 'nvim-lua/plenary.nvim',
    -- 'MunifTanjim/nui.nvim',
    -- 'MeanderingProgrammer/render-markdown.nvim',
    -- 'nvim-tree/nvim-web-devicons',
    --'hrsh7th/nvim-cmp',
    --{'yetone/avante.nvim', build = "make"}
    -- Done Avante AI
}
require('gui_setup').setup()
require("tree_sitter_setup").setup()

-- valriables
local scopes = { o = vim.o, b = vim.bo, w = vim.wo }

-- For setting options that require values
local function opts_with_val(scope, key, value)
    scopes[scope][key] = value
end

vim.g.zig_fmt_autosave = 0

-- Create mappings
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- For seting options
local function opts(key)
    vim.cmd("set " .. key)
end

--setup mason
require('mason').setup()
-- setup nvim-cmp
require('nvim_cmp_setup').setup()
-- code-runner setup
--require('coder_runner_setup').setup()
--setup nvim-tree
require('nvim-tree').setup({
    update_cwd = true
})
-- setup telescope commands
require('telescope_setup').setup()
-- add for ai
--require('avante').setup()

vim.cmd('au BufReadPost * if line("\'\\"") > 1 && line("\'\\"") <= line("$") | exe "normal! g\'\\"" | endif') -- Open file in last location
opts("showcmd")
-- setup lualine
require('lualine').setup()
vim.o.laststatus = 3
-- setup the background theme
vim.o.background = "dark"
vim.cmd("colorscheme gruvbox")
opts("showmatch")
opts("ignorecase")
opts("incsearch")
opts("number")
opts("relativenumber")
opts("autoindent")
opts("autoread")
opts("expandtab")
opts("smartindent")
opts("wildmenu")
vim.api.nvim_set_option_value('encoding', 'utf-8', {})
vim.api.nvim_set_option_value('tabstop', 4, {})
vim.api.nvim_set_option_value('softtabstop', 4, {})
vim.api.nvim_set_option_value('shiftwidth', 4, {})
vim.api.nvim_set_option_value('foldmethod', 'syntax', {})
vim.api.nvim_set_option_value('backspace', '2', {})
vim.api.nvim_set_option_value('path', vim.o.path .. "**", {})

-- mappings

vim.api.nvim_create_user_command("PTestFile", require('testing_mod').test_current_file, { ['bang'] = true })
map('n', 'vrc',
    ':edit ' .. vim.fn.stdpath('config') .. '/init.lua<CR>')
map('n', 'pch', ':tchdir ' .. vim.fn.stdpath('data') .. '/site/pack/paqs/start<CR>')
map('n', 'vch', ':tchdir ' .. vim.fn.stdpath('config') .. '<CR>')
--setup terminal
require("term_handler").setup()

-- for quotes and other double entries
map('i', '"', '""<C-[>i')
map('i', '\'', '\'\'<C-[>i')
map('i', '{', '{}<C-[>i')
map('i', '[', '[]<C-[>i')
map('i', '(', '()<C-[>i')

-- for resizing
map('n', 'rs+', '<cmd>vertical resize +5<CR>')
map('n', 'rs-', '<cmd>vertical resize -5<CR>')
map('n', 'vrs+', '<cmd>resize +5<CR>')
map('n', 'vrs-', '<cmd>resize -5<CR>')

-- for nerdtree
map('n', 'ntree', '<cmd>NvimTreeToggle<CR>')
-- Set the tab cmd
require('tab_prompt')

-- add command to switch buffers
require('buffer_prompt')


-- Set completeopt
opts_with_val('o', 'completeopt', 'menuone,noinsert,noselect')
opts_with_val('o', 'shortmess', vim.o.shortmess .. 'c')

-- make file with .sol be detected as solidity filetype
vim.cmd("autocmd BufRead *.sol exec 'set filetype=solidity'")
