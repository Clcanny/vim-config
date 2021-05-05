import vim
from abstract_formatter import AbstractFormatter


class BashFormatter(AbstractFormatter):

    def __init__(self):
        super(self.__class__, self).__init__()
        self._beautysh = self._getAbsPath(self._getRootDir(),
                                          "build/venv/bin/beautysh")

    def _getFormatCommand(self, formattedFilename, guideFilename):
        indent = vim.eval("g:VimFormatterBashIndent")
        functionStyle = vim.eval("g:VimFormatterBashFuncStyle")
        return '{} --indent-size {} --force-function-style {} "{}" && cat "{}"'.format(
            self._beautysh, indent, functionStyle, formattedFilename,
            formattedFilename)
