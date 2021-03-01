" Set environment variables.
let rootDir = "~/vim-config"
let configDir = rootDir."/config"
let plugDir = rootDir."/plug"

" set vim runtime path
exec "set rtp+=".rootDir
let mapleader = "`"

" Without this setting, you can't use arrow-up ... key in edit mode.
set nocompatible

" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
" curl -fLo ~/Vim/autoload/plug.vim --create-dirs \
" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin(plugDir)

Plug 'altercation/vim-colors-solarized'
set t_Co=16
let g:solarized_termcolors=256
syntax enable
set background=dark

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
" r: https://github.com/vim-airline/vim-airline/issues/1121
let g:airline#extensions#tabline#buffer_nr_show = 1

Plug 'easymotion/vim-easymotion'
let g:EasyMotion_smartcase = 1
" r: https://github.com/easymotion/vim-easymotion/blob/master/doc/easymotion.txt
" Smartsign, Matching signs target keys by smartcase like.
" E.g. type '1' and it matches both '1' and '!' in Find motion.
let g:EasyMotion_use_smartsign_us = 1
nmap <space><space>j <Plug>(easymotion-j)
nmap <space><space>k <Plug>(easymotion-k)
nmap <space><space>h <Plug>(easymotion-linebackward)
nmap <space><space>l <Plug>(easymotion-lineforward)
nmap <space><space>b <Plug>(easymotion-bd-w)
nmap <space><space>e <Plug>(easymotion-bd-e)
nmap <space><space>f <Plug>(easymotion-bd-f)
" Don't use <space> when in insert mode,
" beacuse <space>s are commonly used as input characters.
" r: https://github.com/easymotion/vim-easymotion/issues/329
imap <leader>f <c-\><c-o><Plug>(easymotion-bd-f)
imap <leader>b <c-\><c-o><Plug>(easymotion-bd-w)
imap <leader>e <c-\><c-o><Plug>(easymotion-bd-e)

" " Plug 'scrooloose/syntastic'
" let g:syntastic_cpp_cpplint_exec = "/apsarapangu/disk9/demonsruan/OdpsSourceCode/lambda_odps_src/bin/cpplint.py"
" let g:syntastic_cpp_checkers = ['cpplint']
" let g:syntastic_cpp_cpplint_args = "--verbose=0"
" let g:syntastic_cpp_cpplint_thres = 1
" " let g:syntastic_sh_shellcheck_exec = "$SOFTWARE_COMMON_HOME/ShellCheck/shellcheck-stable/shellcheck"
" " let g:syntastic_sh_shellcheck_args = "-x"
" let g:syntastic_aggregate_errors = 1
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 1
" " let g:syntastic_disabled_filetypes=['cpp']

Plug 'dense-analysis/ale'
let g:ale_linters_explicit = 0
let g:ale_linters = {
\   'cpp': ['cpplint'],
\   'python': ['flake8'],
\}

Plug 'vim-scripts/a.vim'

Plug 'octol/vim-cpp-enhanced-highlight'
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

Plug 'tpope/vim-commentary'
" r: https://github.com/tpope/vim-commentary
autocmd FileType cpp setlocal commentstring=//\ %s

" Press % to jump to the correspondent bracket
Plug 'https://github.com/adelarsq/vim-matchit'
" r: https://stackoverflow.com/questions/9184397/how-do-i-configure-matchit-vim-to-use-tab-instead-of
nnoremap <silent> { :normal %<CR>

Plug 'Yggdroot/LeaderF'
" press (ctrl + p) to search files in current directory
" press (ctrl + f) to search functions of current file
"   There is search mode and browse mode (default) in LeaderF.
"   press (i) to switch from browse mode to search mode
"   press (tab) to switch from search mode to browse mode
" press (esc) to exit from search mode
let g:Lf_ShortcutF = '<c-p>'
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
nnoremap <c-f> :LeaderfFunction!<cr>
nnoremap <c-p> :Leaderf file<cr>

Plug 'davidhalter/jedi-vim'

" Plug 'Valloric/YouCompleteMe'
" let g:ycm_always_populate_location_list = 1
" let g:ycm_open_loclist_on_ycm_diags = 0
" let g:ycm_min_num_of_chars_for_completion = 100
" let g:ycm_min_num_identifier_candidate_chars = 0
" let g:ycm_auto_trigger = 1
" let g:ycm_error_symbol = '>>'
" let g:ycm_warning_symbol = '>>'
" let g:ycm_enable_diagnostic_signs = 0
" let g:ycm_enable_diagnostic_highlighting = 1
" let g:ycm_echo_current_diagnostic = 0
" let g:ycm_allow_changing_updatetime = 1
" let g:ycm_complete_in_comments = 1
" let g:ycm_complete_in_strings = 1
" let g:ycm_collect_identifiers_from_comments_and_strings = 1
" let g:ycm_collect_identifiers_from_tags_files = 0
" let g:ycm_seed_identifiers_with_syntax = 0
" let g:ycm_auto_start_csharp_server = 0
" let g:ycm_auto_stop_csharp_server = 0
" let g:ycm_csharp_server_port = 0
" let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_show_diagnostics_ui = 1
" let g:ycm_filetype_whitelist = {"cpp": 1}
" autocmd FileType cpp nnoremap f :YcmCompleter GoToDeclaration<CR>

" Plug 'Yilin-Yang/vim-markbar'
" r: https://vi.stackexchange.com/questions/9546/why-does-nmap-work-but-nnoremap-not-work-to-set-up-vim-easy-align-shortcut
" nmap <c-t> <Plug>ToggleMarkbar

" r: https://stackoverflow.com/questions/5585129/pasting-code-into-terminal-window-into-vim-on-mac-os-x
" Vim 8 includes native support for Bracketed Paste Mode.
" r: https://github.com/ConradIrwin/vim-bracketed-paste/issues/37

" Plug 'christoomey/vim-conflicted'
" git config --global alias.conflicted '!vim +Conflicted'
" git conflicted

Plug 'benmills/vimux'
cnoreabbrev Command VimuxPromptCommand
augroup vimux
    au!
    autocmd VimLeave * call VimuxCloseRunner()
augroup end

Plug 'ronakg/quickr-preview.vim'
nmap <leader>p <plug>(quickr_preview)
let g:quickr_preview_position = 'above'

Plug 'skywind3000/vim-preview'
nmap K :PreviewScroll -1<cr>
nmap J :PreviewScroll +1<cr>

" TODO: use system fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
" r: https://stackoverflow.com/questions/3878692/aliasing-a-command-in-vim
cnoreabbrev Edit Files

Plug 'mileszs/ack.vim'
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack

Plug 'airblade/vim-gitgutter'
let g:gitgutter_highlight_lines = 1
let g:gitgutter_map_keys = 0
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
exec "let g:UltiSnipsSnippetDirectories = ['".configDir."/snippets']"
let g:UltiSnipsEditSplit="vertical"

Plug 'Clcanny/vim-formatter', { 'do': 'make check' }
Plug 'junegunn/vim-easy-align'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }

" Initialize plugin system
call plug#end()

" for vim-colors-solarized
" colorscheme must be after plug#end()
" Please uncomment it after install
colorscheme solarized

exec "source ".configDir."/common.vim"
exec "source ".configDir."/map.vim"
" exec "source ".configDir."/abbreviate.vim"
exec "source ".configDir."/buf.vim"
" exec "source ".configDir."/gtags.vim"
exec "source ".configDir."/tmux.vim"
