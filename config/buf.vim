" r: https://stackoverflow.com/questions/7207697/vim-split-buffer-and-have-it-open-at-the-bottom
set splitbelow

" r: https://stackoverflow.com/questions/3213657/vim-how-to-pass-arguments-to-functions-from-user-commands
" r: https://stackoverflow.com/questions/4571494/open-a-buffer-as-a-vertical-split-in-vim
function VerticallySplitBuffer(buffer)
    execute "vert belowright sb" a:buffer
endfunction
command -nargs=1 Vbuf call VerticallySplitBuffer(<f-args>)

function HorizontallySplitBuffer(buffer)
    execute "belowright sb" a:buffer
endfunction
command -nargs=1 Hbuf call HorizontallySplitBuffer(<f-args>)

python << end
import vim

def closeUnneccsaryBuffers():
    bufferNumbers = []
    for window in vim.windows:
        bufferNumbers.append(window.buffer.number)
    for buf in vim.buffers:
        if buf.valid and (buf.number not in bufferNumbers):
            try:
                vim.command("bwipeout {}".format(buf.number))
            except Exception as e:
                print(e)
end
command Cbuf :python closeUnneccsaryBuffers()
