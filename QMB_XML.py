# import XML libraries
import xml.etree.ElementTree as ET
import xml.dom.minidom as minidom
import HTMLParser

# Function to create an XML structure
def make_problem_XML(
    problem_title='Missing title',
    problem_text=False,
    label_text='Enter your answer below.',
    description_text=False,
    answers=[{'correctness': 'true', 'text': 'Answers are missing'}],
    solution_text = '<p>Missing solution</p>',
    options = {'problem_type': 'MC'}):

    """
    make_problem_XML: a function to create an XML object for an edX problem.
        The actual work is done by other functions below,
        make_choice_problem_XML() and make_line_problem_XML(),
        which use the arguments as listed below.

    Arguments:

    - problem_title: The title of the problem. Required.

    - problem_text: The extended text for the problem, including paragraph tags and other HTML.
      This argument is genuinely optional.

    - label_text: The action statement for the problem. Should be a single line of text.
      This is the instruction for the student and is required.

    - description_text: Additional info, like "check all that apply" for those kinds of problems.
      This argument is genuinely optional.

    - answers: A list of dictionaries as follows:
      For Numerical and Text problems:
      [{'answer': a correct answer}, {'answer': another correct answer}, {etc}]
      For MC and Checkbox problems, each item in the list will become an answer choice:
      [{'correctness': 'true' or 'false', 'answer': 'the text for this option'}, {etc}, {etc}]
      The text for MC and Checkbox can include LaTeX and images. No hints currently included.

    - solution_text: The extended text for the problem, including paragraph tags and other HTML.

    - options: A dictionary of options.
      Currently accepts "problem_type", which can be...
        "MC": Multiple-choice problems
        "Checkbox": Select-all-that-apply
        "Numerical": Numerical problems, with a 5% tolerance
        "Text": Text-entry problem
        "AnyText": A custom-grader problem that marks any text entered as correct
      And accepts "showanswer", "weight", "rerandomize", and "max_attempts",
        which take the typical values for those arguments in edX.
      Later this may include other problem types, partial credit info, etc.

    The default values for these arguments are used for troubleshooting.

    Return: an XML element tree.

    """

    # Create the tree object with its root element
    problem_tag = ET.Element('problem')
    problem_tag.set('display_name', problem_title)
    problem_tree = ET.ElementTree(problem_tag)

    # Add the script tag so our problems can communicate properly.
    script_tag = ET.SubElement(problem_tag, 'script')
    script_tag.set('src', '/static/EveryProblemScript.js')
    script_tag.set('type', 'text/javascript')

    # Set other problem options. For partial documentation see:
    # https://edx.readthedocs.io/projects/edx-open-learning-xml/en/latest/components/problem-components.html
    if 'showanswer' in options:
        problem_tag.set('showanswer', options['showanswer'])
    if 'weight' in options:
        problem_tag.set('weight', options['weight'])
    if 'rerandomize' in options:
        problem_tag.set('rerandomize', options['rerandomize'])
    if 'max_attempts' in options:
        problem_tag.set('max_attempts', options['max_attempts'])

    # Add the problem text
    if problem_text is not False:
        problem_tag.text = problem_text

    # Pass the tree to functions that build the rest of the problem XML.
    if options['problem_type'] == 'Numerical' or options['problem_type'] == 'Text':
        return  make_line_problem_XML(
            problem_tree, problem_tag, problem_text, label_text, description_text,
            answers, solution_text, options
        )
    elif options['problem_type'] == 'MC' or options['problem_type'] == 'Checkbox':
        return  make_choice_problem_XML(
            problem_tree, problem_tag, problem_text, label_text, description_text,
            answers, solution_text, options
        )
    elif options['problem_type'] == 'AnyText':
        return  make_anytext_problem_XML(
            problem_tree, problem_tag, problem_text, label_text, description_text,
            answers, solution_text, options
        )
    else:
        # Leaving out error messages until we decide which version of Python we're using.
        # print 'The ' + str(options['problem_type']) + ' problem type is not currently supported.'
        return False


# Function to create the XML structure for MC and checkbox problems
# Parameters are described under make_problem_XML() above.
def make_choice_problem_XML(
    problem_tree,
    problem_tag,
    problem_text=False,
    label_text='Enter your answer below.',
    description_text=False,
    answers=[{'correctness': 'true', 'answer': 'Answers are missing'}],
    solution_text = '<p>Missing solution</p>',
    options = {'problem_type': 'MC'}):

    # Create the structure for the problem.
    if options['problem_type'] == 'MC':
        type_tag = ET.SubElement(problem_tag, 'multiplechoiceresponse')
        type_tag.set('type','MultipleChoice')
    elif options['problem_type'] == 'Checkbox':
        type_tag = ET.SubElement(problem_tag, 'choiceresponse')

    # Needs some expansion for various extra credit options.
    if 'extra_credit' in options:
        type_tag.set('extra_credit', options['extra_credit'])

    label_tag = ET.SubElement(type_tag, 'label')
    label_tag.text = label_text

    if options['problem_type'] == 'Checkbox' and description_text is False:
        description_text = 'Check all that apply.'
    if description_text is not False:
        description_tag = ET.SubElement(type_tag, 'description')
        description_tag.text = description_text

    if options['problem_type'] == 'MC':
        choicegroup_tag = ET.SubElement(type_tag, 'choicegroup')
    elif options['problem_type'] == 'Checkbox':
        choicegroup_tag = ET.SubElement(type_tag, 'checkboxgroup')

    # Iterate over the choices and add them one by one.
    for item in answers:
        item_tag = ET.SubElement(choicegroup_tag, 'choice')
        item_tag.set('correct', item['correctness'])
        item_tag.text = item['answer']

    # Create the structure for the solution
    solution_tag = ET.SubElement(type_tag, 'solution')
    solution_div_tag = ET.SubElement(solution_tag, 'div')
    solution_div_tag.set('class', 'detailed-solution')
    explanation_p_tag = ET.SubElement(solution_div_tag, 'p')
    explanation_p_tag.text = 'Explanation'
    explanation_p_tag.tail = solution_text

    return problem_tree


# Function to create the XML structure for numerical or text problems.
# Parameters are described under make_problem_XML() above.
def make_line_problem_XML(
    problem_tree,
    problem_tag,
    problem_text=False,
    label_text='Enter your answer below.',
    description_text=False,
    answers=[{'answer': '-1'}],
    solution_text = '<p>Missing solution</p>',
    options = {'problem_type': 'Text'}):

    # Create the structure for the problem.
    if options['problem_type'] == 'Numerical':
        type_tag = ET.SubElement(problem_tag, 'numericalresponse')
    else:
        type_tag = ET.SubElement(problem_tag, 'stringresponse')
        type_tag.set('type', 'ci')   # case-insensitive by default.

    # Needs some expansion for various extra credit options.
#     if 'extra_credit' in options:
#         type_tag.set('extra_credit', options['extra_credit'])

    type_tag.set('answer', answers[0]['answer'])

    label_tag = ET.SubElement(type_tag, 'label')
    label_tag.text = label_text

    if description_text is not False:
        description_tag = ET.SubElement(type_tag, 'description')
        description_tag.text = description_text

    # Add additional answers if they exist.
    if len(answers) > 1:
        for item in answers:
            additional_answer_tag = ET.SubElement(type_tag, 'additional_answer')
            additional_answer_tag.set('answer', item['answer'])


    if options['problem_type'] == 'Numerical':
        input_tag = ET.SubElement(type_tag, 'formulaequationinput')
        tolerance_tag = ET.SubElement(type_tag, 'responseparam')
        tolerance_tag.set('type', 'tolerance')
        tolerance_tag.set('default', '5%')  # 5% tolerance on all problems right now.
    else:
        input_tag = ET.SubElement(type_tag, 'textline')
        input_tag.set('size', '30')



    # Create the structure for the solution
    solution_tag = ET.SubElement(type_tag, 'solution')
    solution_div_tag = ET.SubElement(solution_tag, 'div')
    solution_div_tag.set('class', 'detailed-solution')
    explanation_p_tag = ET.SubElement(solution_div_tag, 'p')
    explanation_p_tag.text = 'Explanation'
    explanation_p_tag.tail = solution_text

    return problem_tree


# Function to create the XML structure for "anything is correct" problems.
# Parameters are described under make_problem_XML() above.
def make_anytext_problem_XML(
    problem_tree,
    problem_tag,
    problem_text=False,
    label_text='Enter your answer below.',
    description_text=False,
    answers=[{'correctness': 'true', 'answer': 'Answers are missing'}],
    solution_text = '<p>Missing solution</p>',
    options = {'problem_type': 'AnyText', 'feedback':'Thank you for your response.'}):
    
    print options['feedback']
    
    # Insert the python grading script
    pythonscript = """
<![CDATA[
def test_text(expect, ans):
  if ans:
    return True

def hint_fn(answer_ids, student_answers, new_cmap, old_cmap):
  aid = answer_ids[0]
  hint = ''
  hint = '"""  + options['feedback'] + """'.format(hint)
  new_cmap.set_hint_and_mode(aid,hint,'always')
]]>
"""
    script_tag = ET.SubElement(problem_tag, 'script')
    script_tag.set('type','loncapa/python')
    script_tag.text = pythonscript
    
    # Make the customresponse tag and its sub-tags
    type_tag = ET.SubElement(problem_tag, 'customresponse')
    type_tag.set('cfn', 'test_text')
    type_tag.set('expect', 'anything')
    textline_tag = ET.SubElement(type_tag, 'textline')
    textline_tag.set('size', '40')
    textline_tag.set('correct_answer', 'anything')
    textline_tag.set('label', 'Your response')
    hintgroup_tag = ET.SubElement(type_tag, 'hintgroup')
    hintgroup_tag.set('hintfn', 'hint_fn')
    
    # Create the structure for the solution
    solution_tag = ET.SubElement(type_tag, 'solution')
    solution_div_tag = ET.SubElement(solution_tag, 'div')
    solution_div_tag.set('class', 'detailed-solution')
    explanation_p_tag = ET.SubElement(solution_div_tag, 'p')
    explanation_p_tag.text = 'Explanation'
    explanation_p_tag.tail = solution_text

    return problem_tree


def write_problem_file(problem_XML, problem_filename):
    """
    write_problem_file: write a complete edX problem XML structure to disk.

    Arguments:

    - problem_XML: The ElementTree object for the problem.
    - problem_filename: The filename.

    Return: True if successful, False if not.

    Outputs: A pretty-printed XML file at 4 spaces per indent

    """

    # HTML entities in the problem text get encoded during the XML-writing step, so we need to decode them here.
    parser = HTMLParser.HTMLParser()
    xml_string = minidom.parseString(ET.tostring(problem_XML.getroot())).toprettyxml(indent="    ")
    xml_string = parser.unescape(xml_string)
    with open(problem_filename, "w") as f:
        # We start from character 23 because the XML declaration is an unwanted 22 characters (counting \r).
        # I should do this better, but this works for now.
        f.writelines(xml_string[23:])


#################
# Testing code
#################

"""
# Make an MC problem
title = 'Sample MC Problem'
text = '<p>test text</p>'
label = 'test label'
answers = [{'answer': 'wrong one', 'correctness': 'false'}, {'answer': 'right one', 'correctness': 'true'}]
solution = '<p>blank solution</p>'
options = {'problem_type': 'MC'}

the_xml = make_problem_XML(
    problem_title = title,
    problem_text = text,
    label_text = label,
    answers = answers,
    solution_text = solution,
    options = options)
write_problem_file(the_xml, 'test_MC_problem.xml')

# Make a checkbox problem
title = 'Sample Checkbox Problem'
text = '<p>test text</p>'
label = 'test label'
answers = [{'answer': 'wrong one', 'correctness': 'false'}, {'answer': 'right one', 'correctness': 'true'}]
solution = '<p>blank solution</p>'
options = {'problem_type': 'Checkbox'}

the_xml = make_problem_XML(
    problem_title = title,
    problem_text = text,
    label_text = label,
    answers = answers,
    solution_text = solution,
    options = options)
write_problem_file(the_xml, 'test_check_problem.xml')

# Make a numerical problem
title = 'Sample Numerical Problem'
text = '<p>The answer is 50</p>'
label = 'test label'
answers = [{'answer': '50'}]
solution = '<p>blank solution</p>'
options = {'problem_type': 'Numerical'}

the_xml = make_problem_XML(
    problem_title = title,
    problem_text = text,
    label_text = label,
    answers = answers,
    solution_text = solution,
    options = options)
write_problem_file(the_xml, 'test_numerical_problem.xml')

# Make a text problem
title = 'Sample Text Problem'
text = '<p>The answer is "kaboom"</p>'
label = 'test label'
answers = [{'answer': 'kaboom'}]
solution = '<p>blank solution</p>'
options = {'problem_type': 'Text'}

the_xml = make_problem_XML(
    problem_title = title,
    problem_text = text,
    label_text = label,
    answers = answers,
    solution_text = solution,
    options = options)
write_problem_file(the_xml, 'test_text_problem.xml')

# Make an AnyText problem
title = 'Sample AnyText Problem'
text = '<p>Any answer should work</p>'
label = 'test label'
answers = [{'answer': 'this should never appear'}]
solution = '<p>blank solution</p>'
options = {'problem_type': 'AnyText', 'feedback':'Thank you for your response.'}

the_xml = make_problem_XML(
    problem_title = title,
    problem_text = text,
    label_text = label,
    answers = answers,
    solution_text = solution,
    options = options)
write_problem_file(the_xml, 'test_anytext_problem.xml')
"""
