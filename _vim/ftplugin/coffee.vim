" https://github.com/kchmck/vim-coffee-script#compile-to-javascript

autocmd BufWrite *.coffee :call DeleteTrailingWS()
autocmd BufWritePost *.coffee silent make!
autocmd QuickFixCmdPost * nested cwindow | silent redraw!
autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

let coffee_compile_vert = 1

nnoremap <C-W> :CoffeeWatch vert<CR>
nnoremap <C-V> <C-W>v
