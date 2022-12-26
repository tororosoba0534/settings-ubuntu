let s:latexmk = 'latexmk -pv -cd %:h %'
let &l:makeprg = expand(s:latexmk)
" let &l:makeprg = expand('echo "HELLO WORLD!!"')

" This code would go in compiler/tex.vim
" The code code sets Vim's errorformat for compiling LaTeX.
" Important: The errorformat used below works only if the LaTeX source 
" file is compiled with pdflatex's `-file-line-error` option enabled.

" " Match file name
" setlocal errorformat=%-P**%f
" setlocal errorformat+=%-P**\"%f\"
" 
" " Match LaTeX errors
" setlocal errorformat+=%E!\ LaTeX\ %trror:\ %m
" setlocal errorformat+=%E%f:%l:\ %m
" setlocal errorformat+=%E!\ %m
" 
" " More info for undefined control sequences
" setlocal errorformat+=%Z<argument>\ %m
" 
" " More info for some errors
" setlocal errorformat+=%Cl.%l\ %m
" 
" " Catch-all to ignore unmatched lines
" setlocal errorformat+=%-G%.%#
