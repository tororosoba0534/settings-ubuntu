source ~/.local/share/nvim/site/autoload/plug.vim
call plug#begin()
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-fugitive'
call plug#end()


let g:vimwiki_autowriteall = 1
set cmdheight=3 

function GitStatusWithSmallVerticalWindow()
	let parent_win_width = 70
	below vertical Git
	vertical resize 70
endfunction
function! ToggleGStatus()
	if buflisted(bufname('fugitive:///*/.git/'))
		execute ":bdelete" bufname('fugitive:///*/.git/')
	else
		call GitStatusWithSmallVerticalWindow()
	endif
endfunction
nnoremap <A-g> :call ToggleGStatus()<CR>
command! Sv :source $MYVIMRC
command! St :!tmux source-file ~/settings-ubuntu/.tmux.conf


