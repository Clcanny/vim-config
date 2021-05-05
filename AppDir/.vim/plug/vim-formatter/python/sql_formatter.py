import vim
from abstract_formatter import AbstractFormatter


class SqlFormatter(AbstractFormatter):

    def __init__(self):
        super(self.__class__, self).__init__()
        self._sqlformat = self._getAbsPath(self._getRootDir(),
                                           "build/venv/bin/sqlformat")

    def _getFormatCommand(self, formattedFilename, guideFilename):
        style = vim.eval("g:VimFormatterSqlStyle")
        style = map(lambda ele: "--{} {}".format(ele[0], ele[1]), style.items())
        style = " ".join(style)
        cmd = '{} {} "{}"'.format(self._sqlformat, style, formattedFilename)
        return cmd
