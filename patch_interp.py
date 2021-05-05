#!/usr/bin/python3

import sys
import lief

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: {} <binary>.".format(sys.argv[0]))
        exit(-1)
    p = sys.argv[1]
    b = lief.parse(p)
    if not b.has_interpreter:
        print("{} doesn't has an interpret.".format(p))
        exit(-1)
    # b.interpreter = "/lib/x86_64-linux-gnu/ld-2.31.so"
    b.interpreter = "/appimage/ld-2.31.so"
    b.write(p)
