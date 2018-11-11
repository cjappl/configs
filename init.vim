"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CJAPPL .vimrc 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        .OO
"                       .OOOO
"                      .OOOO'
"                      OOOO'          .-~~~~-.
"                      OOO'          /   (o)(o)
"              .OOOOOO `O .OOOOOOO. /      .. |
"          .OOOOOOOOOOOO OOOOOOOOOO/\    \____/
"        .OOOOOOOOOOOOOOOOOOOOOOOO/ \\   ,\_/
"       .OOOOOOO%%OOOOOOOOOOOOO(#/\     /.
"      .OOOOOO%%%OOOOOOOOOOOOOOO\ \\  \/OO.
"     .OOOOO%%%%OOOOOOOOOOOOOOOOO\   \/OOOO.
"     OOOOO%%%%OOOOOOOOOOOOOOOOOOO\_\/\OOOOO
"     OOOOO%%%OOOOOOOOOOOOOOOOOOOOO\###)OOOO
"     OOOOOO%%OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
"     OOOOOOO%OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
"     `OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO'
"   .-~~\OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO'
"  / _/  `\(#\OOOOOOOOOOOOOOOOOOOOOOOOOOOO'
" / / \  / `~~\OOOOOOOOOOOOOOOOOOOOOOOOOO'
"|/'  `\//  \\ \OOOOOOOOOOOOOOOOOOOOOOOO'
"       `-.__\_,\OOOOOOOOOOOOOOOOOOOOO'
"           `OO\#)OOOOOOOOOOOOOOOOOOO'
"             `OOOOOOOOO''OOOOOOOOO'
"               `""""""'  `""""""'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shell=bash
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins
Plugin 'VundleVim/Vundle.vim' " Bundler
"Plugin 'scrooloose/syntastic' " auto syntax checking
Plugin 'w0rp/ale' " auto syntax checking
Plugin 'ctrlpvim/ctrlp.vim' " fuzzy search file finding
Plugin 'roxma/python-support.nvim'
Plugin 'jremmen/vim-ripgrep' " recursive grep 
Plugin 'roxma/nvim-completion-manager'
Plugin 'gfontenot/vim-xcode'

" End configuration, makes the plugins available
call vundle#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => nvim completion manager 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'roxma/ncm-clang'

" necessary to install python completion
let g:python_support_python2_require = 0  " don't need python2 for now, since we're using 3
let g:python_support_python3_requirements = extend(get(g:,'python_support_python3_requirements',[]), ['flake8','cmakelint','autopep8','rstcheck','pydocstyle','jedi','vint'])

" tab completion for complete menu
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" When the <Enter> key is pressed while the popup menu is visible, it only hides
" the menu. Use this mapping to hide the menu and also start a new line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" libclang for c++ completion
let g:clang_library_path = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'

" ALE (linter)
" NOTE: ALE currently doesn't work on C++ header files: https://github.com/w0rp/ale/issues/782
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_statusline_format =[' %d E ', ' %d W ', '']
let g:ale_lint_on_text_changed = 'never'  " run lint in normal mode only
let g:ale_lint_on_insert_leave = 1  " run lint when leaving insert mode(good when ale_lint_on_text_changed is 'normal')
" suggested linters:
"     pip-install: cmakelint, flake8, autopep8, rstcheck, pydocstyle
"     brew install: shellcheck(takes forever to install)
"     npm install: prettier (for javascript, css, json, markdown, more)
let g:ale_virtualenv_dir_names = [
            \ '.env', 'env', 've-py3', 've', 'virtualenv', 'venv',
            \ $HOME.'/.local/share/nvim/plugged/python-support.nvim/autoload/nvim_py3'
            \ ]
let g:ale_python_flake8_options = '--ignore=E501'
let g:ale_fixers = {'python': ['remove_trailing_lines', 'trim_whitespace'],
            \ 'json': ['prettier'],
            \ 'javascript': ['prettier'],
            \ 'css': ['prettier'],
            \ 'cpp': ['remove_trailing_lines']
            \ }

let g:ale_linters = {'cpp': []}

" Fix on save
let g:ale_fix_on_save = 1

" use C-k/C-j to jump from error to error
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Map Ctrl-C to Escape, mainly to trigger autocmd for ALE when exiting insert mode
inoremap <C-c> <Esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set line numbers
set number

" Sets how many lines of history VIM has to remember
set history=100

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Disabling auto commenting 
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ctrlp 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" disable search of certain folders
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/](log|__pycache__|\.git|\.hg|\.svn|.+\.egg-info)$',
    \ 'file': '\v\.(so|swp|zip|gz|tar|png|jpg|pyc)$'
    \ }
let g:ctrlp_cmd = 'CtrlP'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=3

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.log
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*,.tox\*,.build\*,.dist\*
endif

"Always show current position
set ruler

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases, case ignored until caps typed
set smartcase

" Highlight search results
set hlsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
"set magic

" split and automatically move to new pane
set splitright  

" Show matching brackets when text indicator is over them
set showmatch 

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable 

try
    colorscheme desert
catch
endtry

set background=dark

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use unix as the standard file type
set ffs=unix

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>tc :tabclose<cr>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" Splits
map <leader>v :vs<cr>

map <F5> :cp<ENTER>
map <F6> :cn<ENTER>


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Simplify pasting and copying to system clipboard
map <leader>y "*y
map <leader>Y "*e
map <leader>p "*p
map <leader>P "*P

set clipboard=unnamed 

map <leader>d oimport pdb<ENTER>pdb.set_trace()<ESC>

" set colon to semicolon
nnoremap ; :

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Enable per project nvimrc
set exrc
set secure
