" r: https://github.com/christoomey/vim-tmux-navigator
function! s:TmuxOrTmateExecutable()
    return 'tmux'
endfunction

function! s:TmuxSocket()
    " The socket path is the first value in the comma-separated list of $TMUX.
    return split($TMUX, ',')[0]
endfunction

function! s:TmuxCommand(args)
  let cmd = s:TmuxOrTmateExecutable() . ' -S ' . s:TmuxSocket() . ' ' . a:args
  return system(cmd)
endfunction

function! TmuxAwareNavigate()
    let currentWindow = winnr()
    let windowCount = winnr('$')
    let currentPane = system('tmux display -p "#{pane_index}"')
    let paneCount = system('tmux display-message -p "#{window_panes}"')
    " if currentWindow == windowCount && currentPane != paneCount
    if currentWindow == windowCount
        execute '1 wincmd w'
        call s:TmuxCommand("select-pane -t :.+")
    else
        " r: https://vi.stackexchange.com/questions/2928/how-to-execute-a-command-in-an-inactive-window
        execute 'wincmd w'
    endif
endfunction

nnoremap <silent> <c-w> :call TmuxAwareNavigate()<cr>
