import vim
from abstract_formatter import AbstractFormatter


class XmlFormatter(AbstractFormatter):

    def __init__(self):
        super(self.__class__, self).__init__()

    def _getFormatCommand(self, formattedFilename, guideFilename):
        indent = vim.eval("g:VimFormatterXmlIndent")
        return "python3 {} {} {}".format(
            "{}/format_xml.py".format(self._getCurrentDir()), indent,
            formattedFilename)
