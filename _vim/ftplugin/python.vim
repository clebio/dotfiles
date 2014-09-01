"" Run Python code in ipython
"" http://stackoverflow.com/questions/18948491/running-python-code-in-vim
" autocmd Filetype Python nnoremap <buffer> <leader>z :!ipython %<CR>

autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWritePre     *.py :call TrimWhiteSpace()
autocmd FileType python setlocal completeopt-=preview
