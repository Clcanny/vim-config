import vim
from abstract_formatter import AbstractFormatter


class SwiftFormatter(AbstractFormatter):

    def __init__(self):
        super(self.__class__, self).__init__()

    def _getFormatCommand(self, formattedFilename, guideFilename):
        style = vim.eval("g:VimFormatterSwiftStyle")
        style = map(lambda ele: "--{} {}".format(ele[0], ele[1]), style.items())
        style = " ".join(style)
        return "swiftformat {} {} && cat {}".format(style, formattedFilename,
                                                    formattedFilename)
