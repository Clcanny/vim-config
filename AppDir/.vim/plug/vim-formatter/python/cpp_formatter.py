import vim
from abstract_formatter import AbstractFormatter


class CppFormatter(AbstractFormatter):

    def __init__(self):
        super(self.__class__, self).__init__()

    def _getFormatCommand(self, formattedFilename, guideFilename):
        style = vim.eval("g:VimFormatterCppStyle")
        style = map(lambda ele: "{}: {}".format(ele[0], ele[1]), style.items())
        style = "{" + ", ".join(style) + "}"
        cmd = 'docker run --rm -i unibeautify/clang-format < {} "-style={}"'.format(
            formattedFilename, style)
        return cmd
