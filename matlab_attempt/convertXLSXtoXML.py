import os, sys, argparse
import string, random, openpyxl

#Add above directory for QMB_xml
sys.path.append('..')
from QMB_XML import *

#Define input arguments. The filename is a positional argument, i.e. required
parser = argparse.ArgumentParser()
parser.add_argument('inputDir', help = 'The folder containing the filled in excel files')
parser.add_argument('-od','--outputDir',
	help='Directory to save XML problem files')
parser.add_argument('-sf','--shuffleAnswers', action='store_true',
	help='Shuffles the order of checkbox answers')

#Parse arguments
args = parser.parse_args()
inputDir = args.inputDir
if args.outputDir is None:
	outputDir = 'XML problem files'
else:
	outputDir = args.outputDir
if args.shuffleAnswers:
	shuffleAnswers = True
else:
	shuffleAnswers = False

#Create output dir if it doesn't exist
if not os.path.isdir(outputDir):
	os.makedirs(outputDir)

#Lookup table for content grouping (CG)
CGIlookup = {}
with open('CGlookup.txt','r') as f:
    for line in f:
        splitLine = line.split("\t")
        CGIlookup[splitLine[0]] = splitLine[1]

#Default description text (different for each type of problem)
description_texts = {'MC':'Select the most correct answer',
	'Checkbox':'Select all that apply',
	'Numerical':'Enter your answer below',
	'Text':'Enter your answer below',
	'AnyText':'Enter your answer below'}

#Get list of files to read
files = [f for f in os.listdir(inputDir) if os.path.isfile(os.path.join(inputDir, f))]

#Iterate through files, converting to QMB_XML
problem_count = 0;
for file in files:

	#Open Excel file. Assume only one worksheet
	workBook = openpyxl.load_workbook(os.path.join(inputDir,file))
	workSheet = workBook.active

	#Default values for problem info
	problem_title = ''
	problem_text = ''
	label_text = ''
	description_text = ''
	answers = []
	solution_text = ''
	options = {}
	dynamic = 'FALSE'
	difficulty = 1

	#Iterate through rows in worksheet
	rows = tuple(workSheet.rows)
	for row in workSheet.iter_rows():

		#Assign single values
		if row[1].value == 'questionText': problem_text = row[2].value
		if row[1].value == 'dynamic': str_is_dynamic = str(row[2].value)
		if row[1].value == 'difficult': difficult = row[2].value
		if row[1].value == 'contentGrouping': content_group = row[2].value
		if row[1].value == 'labelText': label_text = row[2].value
		if row[1].value == 'solutionText': solution_text = row[2].value

		#Assign options dictionary values
		if row[1].value == 'problemType': options['problem_type'] = row[2].value
		if row[1].value == 'feedback': options['feedback'] = row[2].value
		if row[1].value == 'showanswer': options['showanswer'] = row[2].value
		if row[1].value == 'rerandomize': options['rerandomize'] = row[2].value
		if row[1].value == 'weight': options['weight'] = row[2].value
		if row[1].value == 'max_attempts': options['max_attempts'] = row[2].value
		if row[1].value == 'tolerance': options['tolerance'] = row[2].value

		# Create answer dictionary. Add hint if exists
		if row[1].value == 'answer':
			answerDict = {
				'answer':str(row[2].value),
       			'knowledgeComponent':row[3].value,
       			'correctness':str(row[4].value)}
			if len(row) > 5: answerDict['hint'] = row[5].value
			answers.append(answerDict)

	# Look up label text based on problem type
	description_text = description_texts[options['problem_type']]

	# Create random problem title based on content group
	idLen = 2
	problem_title =  CGIlookup[content_group] + ' #' + \
		''.join(random.sample(string.digits,idLen)) + \
		''.join(random.sample(string.uppercase,1))

	# Shuffle answers if desired
	if (shuffleAnswers):
		random.shuffle(answers)

	# Make the xml
	xml_problem = make_problem_XML(
	    problem_title = problem_title,
	    problem_text = problem_text,
	    label_text = label_text,
		description_text = description_text,
	    answers = answers,
	    solution_text = solution_text,
	    options = options)

	#Use same filename as excel file
	output_filename = os.path.splitext(file)[0] + '.xml'
	write_problem_file(xml_problem,os.path.join(outputDir,output_filename))
	problem_count += 1

	# TODO Add code for TutorGen maybe?


print 'Finished writing ' + str(problem_count) + ' problems'
