import vim
from abstract_formatter import AbstractFormatter


class JsonFormatter(AbstractFormatter):

    def __init__(self):
        super(self.__class__, self).__init__()

    def _getFormatCommand(self, formattedFilename, guideFilename):
        indent = vim.eval("g:VimFormatterJsonIndent")
        return "python3 {} {} {}".format(
            "{}/format_json.py".format(self._getCurrentDir()), indent,
            formattedFilename)
