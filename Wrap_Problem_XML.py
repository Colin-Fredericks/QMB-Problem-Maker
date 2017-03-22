# import XML libraries
import xml.etree.ElementTree as ET
import xml.dom.minidom as minidom
import HTMLParser
import sys
import os


instructions = """
To use:
Put all your problem XML files into a single folder.
Run this on that folder: python Wrap_Problem_XML.py foldername
Take the resulting all_the_problems.xml file
Put it into the 'conditional' folder in your course, replacing the one that's already there.
Rezip and upload the course.
"""


# Get directory from command line argument
try:
    directory = sys.argv[1]
except IndexError:
    # No directory listed
    sys.exit(instructions)

# Open the selected folder and make a list of all the problems' filenames
all_files = os.listdir(directory)

# Make a "conditional" tag as the top level
# https://edx.readthedocs.io/projects/edx-open-learning-xml/en/latest/problem-xml/conditional_module.html
conditional_tag = ET.Element('conditional')
conditional_tag.set('sources', 'i4x://HarvardX/QMB1/problem/88aa6c33d4ab46139177fb1b56237a2b')
conditional_tag.set('correct', 'True')
conditional_tag.set('message', 'This space intentionally left blank.')

# If there are any characters in the filename that would normally get escaped, we'll unescape them.
parser = HTMLParser.HTMLParser()

# Make a "problem" tag for each problem inside the conditional, with url_name equal to filename
for filename in all_files:
    if filename[0] is not '.':    # Skipping hidden files
        filename = filename.replace('.xml','')
        problem_tag = ET.SubElement(conditional_tag, 'problem')
        problem_tag.set('url_name', filename)

# Output the conditional XML file in the parent folder for the selected one.
xml_tree = ET.ElementTree(conditional_tag)
xml_string = minidom.parseString(ET.tostring(xml_tree.getroot())).toprettyxml(indent="    ")
xml_string = parser.unescape(xml_string)
with open('all_the_problems.xml', "w") as f:
    # We start from character 23 because the XML declaration is an unwanted 22 characters (counting \r).
    # I should do this better, but this works for now.
    f.writelines(xml_string[23:])
