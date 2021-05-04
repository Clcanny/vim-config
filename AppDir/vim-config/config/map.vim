" convert the current word to uppercase
" U in visual mode will uppercase the selection.
inoremap <c-u> <esc>viwUi

" surround the word in double quotes
" viw: visually select the current word
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
" surround the word in single quotes
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lev
" wrap whatever text you have visually selected in double quotes
" `<: To the first line or character of the last selected
" Visual area in the current buffer.
vnoremap <leader>" <esc>`<i"<esc>`>a"<esc>
vnoremap <leader>' <esc>`<i'<esc>`>a'<esc>

" change/delete content in next parentheses
onoremap n( :<c-u>normal! f(vi(<cr>
" change/delete content in last parentheses
onoremap l( :<c-u>normal! F(vi(<cr>
" change/delete conttent in next double quotation marks
onoremap n" :<c-u>normal! f"vi"<cr>
" change/delete conttent in last double quotation marks
onoremap l" :<c-u>normal! F"vi"<cr>

" edit vimrc
nnoremap <leader>ev :vsplit $CONFIG_COMMON_HOME/vimrc<cr>
" source vimrc
nnoremap <leader>sv :source $CONFIG_COMMON_HOME/vimrc<cr>

" go to the beginning of the current line
" stronger H
nnoremap H _
" nop means no operation
nnoremap 0 <nop>
" go to the end of the current line
" stronger L $
nnoremap L g_
nnoremap $ <nop>

" exit insert mode
inoremap jk <esc>
" r: https://github.com/johndgiese/dotvim/issues/4
" Fix paste bug triggered by the above inoremaps
set t_BE=
inoremap <esc> <nop>

" r: http://vim.wikia.com/wiki/Undo_and_Redo
nnoremap -r :redo<cr>
nnoremap <c-r> <nop>

" don't use arrow-up, down, left and right
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

noremap <c-j> <cr>
