import zlib, base64, urllib, os.path
import HTMLParser, argparse
import xml.etree.ElementTree as ET

def main():

    #Define input arguments. The filename is required
    parser = argparse.ArgumentParser()
    parser.add_argument('input_filename', help = 'The compress XML files from draw.io')
    args = parser.parse_args()

    # Get filename
    output_filename = ' uncompressed'.join(os.path.splitext(args.input_filename))

    # Get compressed string from xml file
    tree = ET.parse(args.input_filename)
    root = tree.getroot()

    # Uncompress
    uncompressed_str = decompress_xml(root.find('./diagram').text)
    root.find('./diagram').text =  uncompressed_str

    # For some reason, writing this will add escape characters, e.g. &lt
    # So do the stupid fix: convert to string and unescape characters
    xml_str = ET.tostring(root)
    xml_str = HTMLParser.HTMLParser().unescape(xml_str)

    # Convert back to etree and replace root with new one
    newroot = ET.fromstring(xml_str)
    tree._setroot(newroot)

    # write to file
    print 'Writing ' + output_filename + ' to file'
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
