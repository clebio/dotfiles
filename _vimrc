filetype off                  " required

:let mapleader = ","
let NERDTreeQuitOnOpen = 1
set colorcolumn=80

" Line numbers
nmap <C-N><C-N> :set invnumber<CR>
set number

map <C-b> :NERDTreeToggle<CR>
map gb :bn<CR>
map gf :bp<CR>
nmap s :w<CR>
nmap <C-c> :bprevious<CR>:bdelete #<CR>
nmap <leader>q :qall<CR>

nnoremap <C-V> <C-W>v
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

filetype plugin on
set omnifunc=syntaxcomplete#Complete

" http://stackoverflow.com/a/21323445
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Use filetype detection and file-based automatic indenting.
    filetype plugin indent on

    " Use actual tab chars in Makefiles.
    autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
endif

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
" alternatively, pass a path where Vundle should install bundles
"let path = '~/some/path/here'
"call vundle#rc(path)

" let Vundle manage Vundle, required
Bundle 'gmarik/vundle'

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

let g:ctrlp_map = '<C-o>'
let g:ctrlp_cmd = 'CtrlP'

" Don't show docstring window via jedi-vim
autocmd FileType python setlocal completeopt-=preview

" Cycle jedi-vim top-down
let g:SuperTabDefaultCompletionType = "<c-n>"

" Don't auto-suggest method signatures
let g:jedi#show_call_signatures = 0

" Don't show docstring window via jedi-vim
autocmd FileType python setlocal completeopt-=preview

" Cycle jedi-vim top-down
let g:SuperTabDefaultCompletionType = "<c-n>"

" Don't auto-suggest method signatures
let g:jedi#show_call_signatures = 0

syntax enable
set t_Co=16
set background=light
let g:solarized_termcolors=256
colorscheme solarized

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
autocmd BufWritePre     *.py :call TrimWhiteSpace()
autocmd FileType python setlocal completeopt-=preview
au BufRead,BufNewFile *.md set filetype=markdown
