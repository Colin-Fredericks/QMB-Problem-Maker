import os, sys, inspect, logging
import copy
import re
import random
import string
import numpy as np
import sys, argparse
from random import randint
currentdir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
parentdir = os.path.dirname(currentdir)
sys.path.insert(0, parentdir)

from QMB_XML import *
from QMB_utils import *
from parseNum import *
from simplifyNumber import *
from matlab2python import *
from makeXMLQuestions import *

#Define arguments. The filename is a positional argument, i.e. required
parser = argparse.ArgumentParser()
parser.add_argument("fileName", help = "The name of the question description text file")
parser.add_argument("-nd","--numDynamicQuestions",type=int,
	help="Number of dynamic questions to make")
parser.add_argument("-od","--outputDir",
	help="Directory to save XML problem files")
parser.add_argument("-sf","--shuffleAnswers", action="store_true",
	help="Shuffles the order of checkbox answers")


#Parse arguments
args = parser.parse_args()
questionDescriptionFileName = args.fileName
if args.numDynamicQuestions > 0:
	defaultNumDynamicQuestions = args.numDynamicQuestions
else:
	defaultNumDynamicQuestions = 20
if args.outputDir is None:
	problemFolder = "problems"
else:
	problemFolder = args.outputDir
if args.shuffleAnswers:
	shuffleAnswers = True
else:
	shuffleAnswers = False

logging.basicConfig(stream=sys.stderr, level=logging.CRITICAL)
#logging.basicConfig(stream=sys.stderr, level=logging.DEBUG)
#logging.basicConfig(stream=sys.stderr, level=logging.INFO)

webLocRoot = "https://courses.edx.org/xblock/block-v1:HarvardX+QMB1+2T2017+type@problem+block@"
myArray1Dat = load_matlab_matrix("myArray1")
myArray1Dat = load_matlab_matrix("myArray1")
myArray2Dat = load_matlab_matrix("myArray2")
dataArrays = {'myArray1':myArray1Dat,'myArray2':myArray2Dat}

ordinalLookup = {'1':"first",
                 '2':"second",
                 '3':"third",
                 '4':"fourth",
                 '5':"fifth",
                 '6':"sixth",
                 '7':"seventh",
                 '8':"eighth",
                 '9':"ninth",
                 '10':"tenth"}

nsp = NumericStringParser()

infile = open(questionDescriptionFileName, "r")
lines = infile.readlines()
lineCount = 0 #line count
problemName = ""
questionText = ""
labelText = ""#"Enter your answer below."
descriptionText = ""
solutionText = ""
problemType = "Numerical"
answerText = ""
rawVariables = []
answers = []
dynamic = 'FALSE'
problemDifficulty = 0
problemContentGrouping = ""
problemMaxGrade = ""
problemOptions = {}
problemFeedback = ""

readQuestionCount = 0
problemNames = {} #all question names must be unique as read in from the descriptions
problemIDs = {} #generate random problem ids -- must be unique as well
problemTitles = {} #generate titles for each problem if they don't have one. These are unique as well

CGIlookup = {}
with open('CGlookup.txt','r') as f:
    for line in f:
        splitLine = line.split("\t")
        CGIlookup[splitLine[0]] = splitLine[1]

detailFile = os.path.basename(__file__)+'.details.txt'
dd = open(detailFile,'w')

while (lineCount < len(lines)):

	#Read in line without newline
    line = lines[lineCount].rstrip("\n")
    if (line.rstrip() == ""):
        lineCount += 1
        continue
    if (line.startswith("#")):
        lineCount += 1
        continue
    lineEls = line.replace('\\r','\r').split("\t")
    if (lineEls[0] != ""):
        logging.info("questionText is " + questionText + " and dynamic is " + dynamic)
        if (questionText != ""):
            readQuestionCount += 1
            makeQuestions(
                problemName = problemName,
                questionText = questionText,
                labelText = labelText,
                descriptionText = descriptionText,
                solutionText = solutionText,
                problemType = problemType,
                answerText = answerText,
                rawVariables = rawVariables,
                answers = answers,
                dynamic = dynamic,
                problemDifficulty = problemDifficulty,
                problemContentGrouping = problemContentGrouping,
                problemMaxGrade = problemMaxGrade,
                problemOptions = problemOptions,
                problemFeedback = problemFeedback,
                CGIlookup = CGIlookup
                )


#            sys.exit("printed first")
        # reset variables
        if (lineEls[0] in problemNames):
            sys.exit('Problem with name "'+lineEls[0]+'" already exists (line '+str(lineCount)+'). Problem names must be unique.')
        problemNames[lineEls[0]] = 1
        problemName = lineEls[0]
        questionText = ""
        labelText = ""
        descriptionText = ""
        solutionText = ""
        problemType = "Numerical"
        rawVariables = []
        dynamic = 'FALSE'
        difficulty = 1
        problemDifficulty = 0
        problemContentGrouping = ""
        problemMaxGrade = ""
        problemFeedback = ""
        problemOptions = {}
        answers = []
        numDynamicQuestions = defaultNumDynamicQuestions

    if (lineEls[1] == "questionText"):
        questionText = lineEls[2]
    elif (lineEls[1] == "variable"):
        if (len(lineEls)<4):
            sys.exit("line "+str(lineCount)+":'"+line+"' specifies variable but only has " + str(len(lineEls)) + "elements")
        varName = lineEls[2]
        varValue = lineEls[3]
        rawVariables.append([varName,varValue])
    elif (lineEls[1] == "answer"):

		#Add empty hint if it was left out
		if len(lineEls) < 6:
			lineEls.append("")
		answers.append({'answer':lineEls[2],
                        'knowledgeComponent':lineEls[3],
                        'correctness':lineEls[4],
                        'hint':lineEls[5]})
    elif (lineEls[1] == "problemType"):
        problemType = lineEls[2]
    elif (lineEls[1] == "dynamic"):
        dynamic = lineEls[2]
        if dynamic == 'TRUE':
            if (len(lineEls) > 3 and lineEls[3] != ""):
                numDynamicQuestions = int(lineEls[3])
        else:
            numDynamicQuestions = 1
    elif (lineEls[1] == "difficulty"):
        problemDifficulty = lineEls[2]
    elif (lineEls[1] == "contentGrouping"):
        problemContentGrouping = lineEls[2]
    elif (lineEls[1] == "solutionText"):
        solutionText = lineEls[2]
    elif (lineEls[1] == "maxGrade"):
        problemMaxGrade = lineEls[2]
    elif (lineEls[1] == "feedback"):
        problemFeedback = lineEls[2]
    elif (lineEls[1] == "options"):
        optionsEls = lineEls[2].split(":")
        problemOptions[optionsEls[0]] = optionsEls[1]
    elif (lineEls[1] == ""):
        pass
    else:
        print('Unset option in description of problem '+problemName+': lineEls[1] is "'+lineEls[1] + '"')
    lineCount += 1

#finish last question if there is one
if (questionText != ""):
    readQuestionCount += 1
    makeQuestions(
                problemName = problemName,
                questionText = questionText,
                labelText = labelText,
                descriptionText = descriptionText,
                solutionText = solutionText,
                problemType = problemType,
                answerText = answerText,
                rawVariables = rawVariables,
                answers = answers,
                dynamic = dynamic,
                problemDifficulty = problemDifficulty,
                problemContentGrouping = problemContentGrouping,
                problemMaxGrade = problemMaxGrade,
                problemOptions = problemOptions,
                problemFeedback = problemFeedback
                )
print "Read " + str(lineCount) + " lines and " + str(readQuestionCount) + " questions"
