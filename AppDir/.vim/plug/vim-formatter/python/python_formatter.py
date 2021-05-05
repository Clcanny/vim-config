import vim
from abstract_formatter import AbstractFormatter


class PythonFormatter(AbstractFormatter):

    def __init__(self):
        super(self.__class__, self).__init__()

    def _getFormatCommand(self, formattedFilename, guideFilename):
        guideFilename = vim.eval("g:VimFormatterPythonStyle")
        cmd = '$APPDIR/usr/bin/python3 -m isort --stdout "{}" | $APPDIR/usr/bin/python3 -m yapf --style="{}"'.format(
            formattedFilename, guideFilename)
        return cmd
