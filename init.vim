runtime! debian.vim

" Get OS
let s:OS_win32=has('win32')

" set the runtime path to include Vundle and initialize
call plug#begin()

" let Vundle manage Vundle, required
Plug 'scrooloose/nerdtree'
Plug 'Yggdroot/duoduo'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'   "for git and info on airline
Plug 'skielbasa/vim-material-monokai'
Plug 'neovim/nvim-lspconfig' " for lsp
Plug 'nvim-lua/completion-nvim' " for completions
Plug 'steelsojka/completion-buffers' " for completions with buffers
Plug 'morhetz/gruvbox'
Plug 'leafgarland/typescript-vim' " syntax highlighting for vim
Plug 'junegunn/fzf'
Plug 'vim-scripts/taglist.vim'
Plug 'Borwe/vim-ide-file' " own ide plugin, (WIP)
Plug 'Borwe/vim-vimrc-refresher' "For automatically refreshing vim
Plug 'SirVer/ultisnips' "for snippets
Plug 'vim-test/vim-test' "for running tests
Plug 'mhinz/vim-startify' "for managing startup and sessions

call plug#end()


filetype plugin indent on    " required


" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
colorscheme gruvbox
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" Setup the font for when using gvim
if s:OS_win32
    set guifont=Consolas:h10:cANSI:qDRAFT
else
    set guifont=Noto\ Mono:h10:cANSI:qDRAFT
endif



" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set cmdheight=2 " the size of the command line at bottom 
set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)
set number		" Set numbering
set relativenumber "show numbering relative to position
set autoindent
set autoread "make vim autoreload files
set mouse=a "enable using mouse in vim/neovim
set encoding=utf-8 " set the encodings to be utf8
set expandtab
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set foldmethod=syntax   " for folding code based on syntax
set path+=**	" Search down the subfolders
set wildmenu 	" Display all matching files when we tab complete
set backspace=2 " for allowing deletion with backspace

"set AirLine theme
let g:airline_theme='gruvbox'

"for opening ~/.vimrc
nnoremap vrc :execute 'edit '.stdpath('config').'/init.vim'<CR>

"for opening up terminal
if s:OS_win32
    nnoremap term :belowright split term://powershell<CR>
    nnoremap vterm :vsplit term://powershell<CR>
else
    nnoremap term :belowright split term://bash<CR>
    nnoremap vterm :vsplit term://bash<CR>
endif

"for exiting insert mode on terminal on vim
tnoremap <C-e> <C-\><C-N>

"for coupled brackets and quatations
inoremap " ""<C-[>i
inoremap ' ''<C-[>i
inoremap { {}<C-[>i
inoremap [ []<C-[>i
inoremap ( ()<C-[>i

" setup for ultisnips
let g:UltiSnipsExpandTrigger="<c-b>"
" let g:UltiSnipsListSnippets="J"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"group for setting filetypes
augroup set_file_types
    "reset to null if exists before
    autocmd!
    "set filetypes
    autocmd BufEnter,BufNewFile *.ts :setlocal filetype=typescript "set ts files to typescript
    autocmd BufEnter,BufNewFile *vimrc :setlocal filetype=vim "set all files with postfix of 'vimrc' to be detected as vim files
augroup END

"Command for showing fzf
nnoremap <C-f> :<C-u>FZF<CR>

"Command for resizing by 5 horizontally
nnoremap rs+ :vertical resize +5<CR>
nnoremap rs- :vertical resize -5<CR>

"Command for resizing by 5 vertically
nnoremap vrs+ :resize +5<CR>
nnoremap vrs- :resize -5<CR>

"Command to show nerdree
nnoremap ntree :NERDTree<CR>

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif


"hand displaying/hiding taglist
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Show_One_File = 1 "set tags to only show based on current viewed buffer/file
function! TagListToggle()
    :TlistToggle
endfunction
:nnoremap tag <Esc>:call TagListToggle()<CR>

" for setting up java tool options, appended to the default system ones, but
" with lombok support
"let $JAVA_TOOL_OPTIONS=$JAVA_TOOL_OPTIONS.' -javaagent:/home/brian/vim-setup/vimrc/lombok.jar '
let $JAVA_TOOL_OPTIONS=$JAVA_TOOL_OPTIONS

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" add command to switch tabs
function! SelectTabs()
    :tabs
    :let tabNum=input("Select Tab Number: ")
    :echo "\nMoving to tab ".tabNum
    :exec "tabn" tabNum
endfunction
command! Tab call SelectTabs() 

" add command to switch buffers
function! SelectBuffer()
    :ls
    :let buffNum=input("Select BUffer Number: ")
    :echo "\nMoving to Buffer ".buffNum
    :exec "buffer " buffNum
endfunction
command! Buff call SelectBuffer()

lua require('ultisnips_pops')
inoremap <C-s> <cmd>UltiSnipsPopUp<CR>

lua require('lsp_pers_config')

"for prompting completions
" remap for scrolling
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c
" for nvim-completion remove auto hover
let g:completion_enable_auto_hover = 0
let g:completion_enable_auto_popup = 0
imap <silent> <C-Space> <Plug>(completion_trigger)

