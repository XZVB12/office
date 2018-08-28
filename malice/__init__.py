# -*- coding: utf-8 -*-
# This file is part of MaliceIO - https://github.com/malice-plugins/pdf
# See the file 'LICENSE' for copying permission.

__description__ = 'Malice Office/OLE/RTF Plugin - office helper util'
__author__ = 'blacktop - <https://github.com/blacktop>'
__version__ = '0.1.0'
__date__ = '2018/08/27'

import datetime
import json
import logging
import re
import tempfile
import time
from io import BytesIO
from os import path

log = logging.getLogger(__name__)


class MalOffice(object):

    def __init__(self, file_path, should_dump=False, dump_path=None):
        self.file = file_path
        self.sha256 = sha256_checksum(self.file)
        self.data = open(file_path, 'rb').read()
        self.dump = None
        self.results = {}

        if not path.exists(self.file):
            raise Exception("file does not exist: {}".format(self.file))
        if should_dump:
            if path.isdir(dump_path):
                self.dump = dump_path
            else:
                log.error("folder does not exist: {}".format(dump_path))
                self.dump = None

    def run(self):

        try:
            0 / 1
        except Exception as e:
            log.exception(e)

        return self.results
