set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set backspace=indent,eol,start

augroup changeTabToSpace
    au!
    autocmd BufWritePre * retab
augroup end

" trim whitespace
autocmd BufWritePost * :%s/\s\+$//e

" auto set paste and set nopaste
" r: https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <esc>[200~ XTermPasteBegin()

" make split windows have equal height or width when resize vim
" For example: open a new tmux pane
" r: https://vi.stackexchange.com/questions/201/make-panes-resize-when-host-window-is-resized
autocmd VimResized * wincmd =

" use Chinese
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

set nu

" save cursor postion
autocmd BufReadPost *
\ if line("'\"")>0&&line("'\"")<=line("$") |
\ exe "normal g'\"" |
\ endif

" Without this setting, when pressing left/right cursor keys, Vim will not
" move to the previous/next line after reaching first/last character in the
" line. < > are the cursor keys used in normal and visual mode, and [ ] are
" the cursor keys in insert mod.
" set whichwrap+=<,>,h,l,[,]

" undo after exit
" check if your vim version supports it
if has('persistent_undo')
  " turn on the feature
  set undofile
  " directory where the undo files will be stored
  set undodir=/home/admin/demonsruan/Software/install/vim/undo
endif

" save more lines when copy paste between files
" r: https://stackoverflow.com/questions/3676855/vim-limited-line-memory
set viminfo='100,<1000,s100

" r: https://stackoverflow.com/questions/7912060/vim-how-can-i-open-a-file-at-right-side-as-vsplit-from-a-left-side-nerdtree-pan
" open new file vertically at right
set splitright

set colorcolumn=79

" r: https://vim.fandom.com/wiki/Folding
set foldmethod=syntax
" zo: open, zc: close, zO, zC
" zR: open all folds in file
