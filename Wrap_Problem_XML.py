# import XML libraries
import xml.etree.ElementTree as ET
import xml.dom.minidom as minidom
import HTMLParser
import sys
import os

# Get directory from command line argument

try:
    directory = sys.argv[1]
except IndexError:
    # No directory listed
    sys.exit('no directory listed')

# Open the selected folder and make a list of all the problems' filenames
all_files = os.listdir(directory)

# Make a "vertical" tag as the top of an XML tree
vertical_tag = ET.Element('problem')
vertical_tag.set('display_name', 'Every Single Autorandom Problem')
vertical_tree = ET.ElementTree(vertical_tag)


# Add a "conditional" tag inside the vertical
#   https://edx.readthedocs.io/projects/edx-open-learning-xml/en/latest/problem-xml/conditional_module.html
# Make a "problem" tag for each problem inside the conditional, with url_name equal to filename
# Output the vertical XML file in the parent folder for the selected one