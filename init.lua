-- setup paq
require('paq_setup').setup()
local paq=require('paq-nvim').paq

-- valriables
require('user_globals')
local scopes={o=vim.o,b=vim.bo,w=vim.wo}
local isWin32=vim.fn.has('win32')==1 and true or false

-- For setting options that require values
local function opts_with_val(scope,key,value)
    scopes[scope][key]=value
end

-- Create mappings
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then
      options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- For seting options
local function opts(key)
    vim.cmd("set "..key)
end

-- For setting variables of script type
local function opts_script(key,val)
    vim.cmd('let '..key..'='..val)
end


-- Add packages

paq 'nvim-lua/plenary.nvim' -- required by borwe/lspinstall.nvim
paq 'tpope/vim-sleuth' -- for tabbing
paq 'tpope/vim-fugitive'   --for git and info on airline
paq 'neovim/nvim-lspconfig' -- for lsp
paq 'leafgarland/typescript-vim' -- syntax highlighting for vim
-- START FOR COMPLETIONS
paq 'hrsh7th/cmp-nvim-lsp'
paq 'hrsh7th/cmp-buffer'
paq 'hrsh7th/nvim-cmp'
paq 'quangnguyen30192/cmp-nvim-ultisnips' -- for ulti snips completion
-- DONE FOR COMPLETIONS
paq 'junegunn/fzf'
paq 'SirVer/ultisnips' -- for snippets
paq 'mhinz/vim-startify' -- for managing startup and sessions
paq {'tkztmk/vim-vala', depth = -3} --for vala file support
paq {'nanotee/luv-vimdocs', depth = 4} --for luv documentation
paq {'borwe/lspinstall.nvim', depth = -1} --for lsp install support
paq 'wsdjeg/luarefvim' -- for lua 5.1 documentation
paq 'wakatime/vim-wakatime' -- wakatime
paq {'Borwe/code_runner.nvim', branch = 'fix1', depth = -1} -- code runner

-- setup nvim-cmp
require('nvim_cmp_setup').setup()
-- code-runner setup
require('coder_runner_setup').setup()

-- setup some configurations
opts_with_val('o','background','dark') -- Set background
vim.cmd('au BufReadPost * if line("\'\\"") > 1 && line("\'\\"") <= line("$") | exe "normal! g\'\\"" | endif') -- Open file in last location
opts("showcmd")
vim.cmd("colorscheme desert")
--setting up netrw
vim.api.nvim_set_var('netrw_browse_split',4)
vim.api.nvim_set_var('netrw_liststyle',3)
vim.api.nvim_set_var('netrw_altv',1)
vim.api.nvim_set_var('netrw_winsize',25)
vim.api.nvim_set_var('netrw_banner',0)
opts("showmatch")
opts("ignorecase")
opts("incsearch")
opts("number")
opts("relativenumber")
opts("autoindent")
opts("autoread")
opts_with_val('o','encoding','utf-8')
opts("expandtab")
opts("smartindent")
opts_with_val('o','tabstop',4)
opts_with_val('o','softtabstop',4)
opts_with_val('o','shiftwidth',4)
opts_with_val('o','foldmethod','syntax')
opts_with_val('o','path',vim.o.path.."**")
opts("wildmenu")
opts_with_val('o','backspace','2')

-- mappings

nvim_create_command("PTestFile",
"lua require('testing_mod').test_current_file()")
map('n','vrc',
':edit '..vim.fn.stdpath('config')..'/init.lua<CR>')
map('n','pch',':tchdir '..vim.fn.stdpath('data')..'/site/pack/paqs/start<CR>')
map('n','vch',':tchdir '..vim.fn.stdpath('config')..'<CR>')
--setup terminal
if isWin32 then
  map('n','term',
  ':belowright split term://cmd<CR>')
  map('n','vterm',
  ':vsplit term://cmd<CR>')
else
  map('n','term',
  ':belowright split term://bash<CR>')
  map('n','vterm',
  ':vsplit term://bash<CR>')
end
--for exiting insert mode in terminal
map('t','<C-e>','<C-\\><C-N>')

-- for quotes and other double entries
map('i','"','""<C-[>i')
map('i','\'','\'\'<C-[>i')
map('i','{','{}<C-[>i')
map('i','[','[]<C-[>i')
map('i','(','()<C-[>i')

-- for showing fzf
map('n','<C-f>','<cmd>FZF<CR>')

-- for resizing
map('n','rs+','<cmd>vertical resize +5<CR>')
map('n','rs-','<cmd>vertical resize -5<CR>')
map('n','vrs+','<cmd>resize +5<CR>')
map('n','vrs-','<cmd>resize -5<CR>')

-- for nerdtree
map('n','ntree','<cmd>Vexplore<CR>')
-- Set the tab cmd
require('tab_prompt')

-- add command to switch buffers
require('buffer_prompt')

-- add for lsp support
require('lsp_pers_config')

--remap for scrolling
vim.cmd('inoremap <expr> <Tab> pumvisible() ? "\\<C-n>" : "\\<Tab>"')
vim.cmd('inoremap <expr> <S-Tab> pumvisible() ? "\\<C-p>" : "\\<S-Tab>"')

-- Set completeopt
opts_with_val('o','completeopt','menuone,noinsert,noselect')
opts_with_val('o','shortmess',vim.o.shortmess..'c')

-- for nvim-completion remove auto hover
opts_script('g:completion_enable_auto_hover','0')
opts_script('g:completion_enable_auto_popup','0')

vim.cmd('imap <silent> <C-Space> <Plug>(completion_trigger)')

-- for cmake module paths baseide plugin
if isWin32 then
  vim.g.baseide_cmake_gen = "Ninja"
  vim.g.baseide_vcvars= "vcvars64.bat"
end
