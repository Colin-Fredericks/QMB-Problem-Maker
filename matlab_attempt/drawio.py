import zlib, base64, urllib, os.path
import HTMLParser
import xml.etree.ElementTree as ET

def main():

    # Get filename
    input_filename = 'XML trees/basics.xml'
    output_filename = '_uncompressed'.join(os.path.splitext(input_filename))

    # Get compressed string from xml file
    tree = ET.parse(input_filename)
    root = tree.getroot()

    # Uncompress
    uncompressed_str = decompress_xml(root.find('./diagram').text)
    root.find('./diagram').text =  uncompressed_str

    # For some reason, this will do escape characters. So do the stupid fix:
    # Convert to string, unescape characters, convert back to etree
    xml_str = ET.tostring(root)
    xml_str = HTMLParser.HTMLParser().unescape(xml_str)

    # Replace root with new one
    newroot = ET.fromstring(xml_str)
    tree._setroot(newroot)

    # write to file
    tree.write(output_filename)

def decompress_xml(str):

    # Step 1: Base64 decode
    str = base64.b64decode(str)

    # Step 2: deflate, no header
    str = zlib.decompress(str, -zlib.MAX_WBITS)

    # Step 3: URL unquote
    str = urllib.unquote(str)

    return str

if __name__ == '__main__':
    main()
