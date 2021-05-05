import vim
from abstract_formatter import AbstractFormatter


class CMakeFormatter(AbstractFormatter):

    def __init__(self):
        super(self.__class__, self).__init__()
        self._cmake_format = self._getAbsPath(self._getRootDir(),
                                              "build/venv/bin/cmake-format")

    def _getFormatCommand(self, formattedFilename, guideFilname):
        style = vim.eval("g:VimFormatterCMakeStyle")
        style = map(lambda ele: "--{}={}".format(ele[0], ele[1]), style.items())
        style = " ".join(style)
        cmd = "{} {} {}".format(self._cmake_format, style, formattedFilename)
        return cmd
