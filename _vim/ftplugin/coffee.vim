" https://github.com/kchmck/vim-coffee-script#compile-to-javascript

autocmd BufWrite *.coffee :call DeleteTrailingWS()
autocmd BufWritePost *.coffee make!
autocmd QuickFixCmdPost * nested cwindow | redraw!
autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent
autocmd BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

let coffee_compile_vert = 1
setl scrollbind

