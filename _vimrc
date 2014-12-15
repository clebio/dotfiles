set nocompatible
filetype off                  " required
set enc=utf-8

:let mapleader = ","
let NERDTreeQuitOnOpen = 1


map <C-t> :NERDTreeToggle<CR>
""" Per-project Vim config

if filereadable(".vim.custom")
    so .vim.custom
endif

""""""""""""""""
" Colros
"set colorcolumn=80
highlight ColorColumn ctermbg=137 ctermfg=White guibg=#4499ff
hi CursorLine cterm=NONE ctermbg=grey ctermfg=blue guibg=#2c2d27 guifg=white
hi CursorColumn cterm=NONE ctermbg=grey ctermfg=246 guibg=#2c2d27 guifg=white
hi Search cterm=NONE ctermfg=grey ctermbg=blue

" Toggle with ',c'
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
""""""""""""""

" Don't use backups and swap files
set nobackup
set noswapfile " IMPORTANT: comment this line if you are working on a remote host
set wildignore=*.swp,*.bak,*.pyc,*.class

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Don't redraw while executing macros (good performance config)
"set lazyredraw

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"Disable search highlight
map <Leader>/ :nohlsearch<CR>

" line numbers and toggle
nmap <C-N><C-N> :set invnumber<CR>
map <C-b> :NERDTreeToggle<CR>

" Buffer management
map gb :bn<CR>
map gf :bp<CR>
nmap s :w<CR>
nmap <C-c> :bprevious<CR>:bdelete #<CR>
nmap <leader>q :qall<CR>

" Easier Vim splits
nnoremap <C-V> <C-W>v
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set omnifunc=syntaxcomplete#Complete

" For everything else, use a tab width of 4 space chars.
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4.
set softtabstop=4   " Sets the number of columns for a TAB.
set expandtab       " Expand TABs to spaces.

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle, required
Bundle 'gmarik/vundle'
" And other bundles
Bundle 'tpope/vim-fugitive'
Bundle 'kien/ctrlp.vim'
"Bundle 'croaky/vim-colors-github'
Bundle 'nvie/vim-flake8'
Bundle 'rking/ag.vim'
Bundle 'tpope/vim-markdown'
Bundle 'ervandew/supertab'
Bundle 'davidhalter/jedi-vim'
Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'AndrewRadev/vim-eco'
 
" Ctrl-P mappings
let g:ctrlp_map = '<C-o>'
let g:ctrlp_cmd = 'CtrlP'

" Don't show docstring window via jedi-vim
autocmd FileType python setlocal completeopt-=preview
" Cycle jedi-vim top-down
let g:SuperTabDefaultCompletionType = "<c-n>"
" Don't auto-suggest method signatures
let g:jedi#show_call_signatures = 0

syntax enable
set t_Co=256
"set background=light
"let g:solarized_termcolors=256
"colorscheme solarized

" http://stackoverflow.com/a/21323445
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Use filetype detection and file-based automatic indenting.
    filetype plugin indent on

    " Use actual tab chars in Makefiles.
    autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
endif

syntax enable
set t_Co=16
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

""""""""""""""""""""
" Whitespace utilities
"
" Delete trailing white space on save
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

" Trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

au BufRead,BufNewFile *.coffee set filetype=coffee
au BufRead,BufNewFile *.coffee.md set filetype=coffee
au BufRead,BufNewFile *.md set filetype=markdown
