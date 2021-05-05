import sys
import xml.dom.minidom as xmldom

if __name__ == "__main__":
    if len(sys.argv) != 3:
        raise RuntimeError(
            "Please call {} with arugments: indent and filename.".format(
                sys.argv[0]))
    indent = int(sys.argv[1])
    filename = sys.argv[2]
    with open(filename, "r") as infile:
        content = infile.read()
        xml = xmldom.parseString(content)
        content = xml.toprettyxml(indent=" " * indent)
        # remove empty lines
        content = content.split("\n")
        content = "\n".join(filter(lambda x: len(x.rstrip()) != 0, content))
        content = content.replace("&quot;", "")
        print(content)
