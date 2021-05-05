import os.path
import shutil
import subprocess
import tempfile

import vim


class AbstractFormatter(object):

    def __init__(self):
        self._vimBuffer = vim.current.buffer
        self._tmpDir = None
        self._row = None
        self._col = None

    def run(self):
        try:
            if not self._isVimBufferSave():
                raise RuntimeError("Please save buffer before formatting.")
            self._createTmpDir()
            formattedFilename = self._createFormattedFile()
            guideFilename = self._copyGuideFile()
            command = self._getFormatCommand(formattedFilename, guideFilename)
            content = self._execute(command)
            if content is None:
                raise RuntimeError("content is empty.")
            self._writeToVimBuffer(content)
        finally:
            self._delTmpDir()

    def _isVimBufferSave(self):
        return int(vim.eval("&modified")) == 0

    def _createTmpDir(self):
        self._tmpDir = tempfile.mkdtemp()

    def _createFormattedFile(self):
        content = "\n".join(self._vimBuffer[:])
        formattedFilename = self._vimBuffer.name.split("/")[-1]
        formattedFilename = self._getAbsPath(self._tmpDir, formattedFilename)
        outfile = open(formattedFilename, "w+")
        outfile.write(content)
        outfile.close()
        return formattedFilename

    def _copyGuideFile(self):
        originGuideFilename = self._getGuideFilename()
        if originGuideFilename is None:
            return None
        tmpGuideFilename = originGuideFilename.split("/")[-1]
        tmpGuideFilename = self._getAbsPath(self._tmpDir, tmpGuideFilename)
        shutil.copy(originGuideFilename, tmpGuideFilename)
        return tmpGuideFilename

    def _getGuideFilename(self):
        return None

    def _getFormatCommand(self, formattedFilename, guideFilename):
        raise RuntimeError("Call pure virtual function.")

    def _execute(self, command):
        try:
            process = subprocess.Popen(command,
                                       stdout=subprocess.PIPE,
                                       shell=True,
                                       stderr=subprocess.PIPE)
            (output, error) = process.communicate()
            if process.returncode != 0:
                raise RuntimeError(error)
            output = output.splitlines()
            if output[-1] is None or len(output[-1]) == 0:
                del output[-1]
            return output
        except subprocess.CalledProcessError as e:
            raise RuntimeError(e.output)

    def _writeToVimBuffer(self, content):
        self._storeCursorPosition()
        self._vimBuffer[:] = content
        self._restoreCursorPosition()

    def _storeCursorPosition(self):
        self._col = int(vim.eval('col(".")'))
        self._row = int(vim.eval('line(".")'))

    def _restoreCursorPosition(self):
        # Index of vim buffer starts at 1.
        maxRow = len(self._vimBuffer[:]) + 1
        row = self._row if self._row < maxRow else maxRow
        # Index of vim buffer starts at 1.
        maxCol = len(self._vimBuffer[row - 1]) + 1
        col = self._col if self._col < maxCol else maxCol
        vim.command("call cursor({}, {})".format(row, col))

    def _delTmpDir(self):
        # TODO(junbin.rjb) Remove other tmp dirs.
        if self._tmpDir is not None:
            shutil.rmtree(self._tmpDir)

    def _getCurrentDir(self):
        return self._getAbsPath(__file__, "..")

    def _getRootDir(self):
        return self._getAbsPath(self._getCurrentDir(), "..")

    def _getConfigDir(self):
        return self._getAbsPath(self._getRootDir(), "config")

    def _getAbsPath(self, *args):
        return os.path.normpath(os.path.join(*args))
