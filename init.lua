-- valriables

vim.cmd("packadd paq-nvim")
local paq=require('paq-nvim').paq
local scopes={o=vim.o,b=vim.bo,w=vim.wo}
local isWin32=vim.fn.has('win32')

-- Functions

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

paq 'scrooloose/nerdtree'
paq 'vim-airline/vim-airline'
paq 'vim-airline/vim-airline-themes'
paq 'tpope/vim-fugitive'   --for git and info on airline
paq 'neovim/nvim-lspconfig' -- for lsp
paq 'nvim-lua/completion-nvim' -- for completions
paq 'steelsojka/completion-buffers' -- for completions with buffers
paq 'leafgarland/typescript-vim' -- syntax highlighting for vim
paq 'junegunn/fzf'
paq 'vim-scripts/taglist.vim'
paq 'Borwe/vim-vimrc-refresher' -- For automatically refreshing vim
paq 'SirVer/ultisnips' -- for snippets
paq 'vim-test/vim-test' -- for running tests
paq 'mhinz/vim-startify' -- for managing startup and sessions

-- setup some configurations

opts_with_val('o','background','dark') -- Set background
vim.cmd('colorscheme industry') -- Set colorscheme
vim.cmd('au BufReadPost * if line("\'\\"") > 1 && line("\'\\"") <= line("$") | exe "normal! g\'\\"" | endif') -- Open file in last location
opts("showcmd")
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

map('n','vrc',
    ':edit '..vim.fn.stdpath('config')..'/init.lua<CR>')
--setup terminal
if isWin32==1 then
    map('n','term',
    ':belowright split term://powershell<CR>')
    map('n','vterm',
    ':vsplit term://powershell<CR>')
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

-- for ultisnips
opts_script('g:UltiSnipsExpandTrigger','\"<C-e>\"')
opts_script('g:UltiSnipsJumpForwardTrigger','\"<C-j>\"')
opts_script('g:UltiSnipsJumpBackwardTrigger','\"<C-k>\"')

-- for showing fzf
map('n','<C-f>','<cmd>FZF<CR>')

-- for resizing
map('n','rs+','<cmd>vertical resize +5<CR>')
map('n','rs-','<cmd>vertical resize -5<CR>')
map('n','vrs+','<cmd>resize +5<CR>')
map('n','vrs-','<cmd>resize -5<CR>')

-- for nerdtree
map('n','ntree','<cmd>NERDTree<CR>')
-- Set the tab cmd
require('tab_prompt')

-- add command to switch buffers
require('buffer_prompt')

-- add command to support ultisnips
require('ultisnips_pops')
map('i','<C-s>','<cmd>UltiSnipsPopUp<CR>')

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
