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

#hash function that turns an array into a number that can be graded in the EdX LTI
#input: array
#output: integer
def matlabAnswerFun(matlabStr_in):
    matlabStr = str(matlabStr_in)
    matlabStr = matlabStr.replace("["," ")
    matlabStr = matlabStr.replace("]"," ")
    matlabStr = matlabStr.replace(","," ")
    strEls = matlabStr.split()
    sum = 0
    product = 1
    for el in strEls:
        sum = sum + float(el)
        product = product * float(el)
    ans = sum + product + 5
    ans = ans % 500
    return ans

#gets max of a string representation of an array e.g. [[1,2,3],[4,5,6]]
def getMax(matlabStr_in):
    matlabStr = str(matlabStr_in)
    matlabStr = matlabStr.replace("["," ")
    matlabStr = matlabStr.replace("]"," ")
    matlabStr = matlabStr.replace(","," ")
    strEls = matlabStr.split()
    strEls = map(float, strEls)
    return max(strEls)

#gets min of a string representation of an array e.g. [[1,2,3],[4,5,6]]
def getMin(matlabStr_in):
    matlabStr = str(matlabStr_in)
    matlabStr = matlabStr.replace("["," ")
    matlabStr = matlabStr.replace("]"," ")
    matlabStr = matlabStr.replace(","," ")
    strEls = matlabStr.split()
    strEls = map(float, strEls)
    return min(strEls)

#gets mean of a string representation of an array e.g. [[1,2,3],[4,5,6]]
def getMean(matlabStr_in):
    matlabStr = str(matlabStr_in)
    matlabStr = matlabStr.replace("["," ")
    matlabStr = matlabStr.replace("]"," ")
    matlabStr = matlabStr.replace(","," ")
    strEls = matlabStr.split()
    strEls = map(float, strEls)
    return sum(strEls)/len(strEls)

#gets sum of a string representation of an array e.g. [[1,2,3],[4,5,6]]
def getSum(matlabStr_in):
    matlabStr = str(matlabStr_in)
    matlabStr = matlabStr.replace("["," ")
    matlabStr = matlabStr.replace("]"," ")
    matlabStr = matlabStr.replace(","," ")
    strEls = matlabStr.split()
    strEls = map(float, strEls)
    return sum(strEls)





#assign values to variables and perform calculations
#returns EdX xml and the list of answers (to test for uniqueness of answers)
def makeQuestion(
    questionTitle="",
    rawQuestionText=False, #dynamic (has unsubstituted variables)
    labelText='',
    descriptionText="",
    solutionText="",
    rawVariables=[],  # dynamic, list of variables (key:value) without substitutions
    rawAnswers=[],  # dynamic ['answer','correctness','knowledgeComponent','hint']
    problemType='Numerical',
    options=[]
    ):


    #make local copies -- arg.. python passes by reference
    qRawAnswers = copy.deepcopy(rawAnswers)
    qRawQuestionText = copy.copy(rawQuestionText)
    qRawVariables = copy.deepcopy(rawVariables)

    variables = []
    for var in qRawVariables:
        logging.debug("working on var " + var[0])
        vname = var[0]
        vval = var[1]
        for otherVar in variables:
            vval = vval.replace(otherVar[0], otherVar[1])

        madeChange = 1
        while (madeChange == 1): #keep doing substitutions while we can..
            madeChange = 0
            logging.debug("vvar top: "  + vval)

    #       sub data (e.g. myArray)
            for arrName in dataArrays:
                p = re.compile(arrName+"\((\d+)\)") #linear indexing
                for m in p.finditer(vval):
                    rind = m.group(1)
                    #transoform matrix
                    matrix = dataArrays[arrName]
                    matrixT = map(list, zip(*matrix))
                    flatMatrix = [item for sublist in matrixT for item in sublist]
                    ans = flatMatrix[int(rind)-1]
                    vval = vval.replace(vval[m.start():m.end()], str(ans))
                    madeChange = 1

                p = re.compile(arrName+"\(([\d:]+),([\d:]+)\)") #row/column indexing
                for m in p.finditer(vval):
                    startR = m.group(1) #row start index
                    endR = m.group(1) # row end index
                    incR = 1 #row increment
                    rEls = m.group(1).split(":")
                    if (len(rEls) == 2):
                        startR = rEls[0]
                        endR = rEls[1]
                    elif (len(rEls) == 3):
                        startR = rEls[0]
                        incR = rEls[1]
                        endR = rEls[2]

                    startC = m.group(2) #column start index
                    endC = m.group(2) #column end index
                    incC = 1 #column increment
                    cEls = m.group(2).split(":")
                    if (len(cEls) == 2):
                        startC = cEls[0]
                        endC = cEls[1]
                    elif (len(cEls) == 3):
                        startC = cEls[0]
                        incC = cEls[1]
                        endC = cEls[2]

                    #matlab is zerobased (so decriment start) but extends to bound of end (don't decriment end)
                    mySlice = [dataArrays[arrName][i][slice(int(startC)-1,int(endC),int(incC))]
                               for i in range(int(startR)-1,int(endR),int(incR))]
                    if (len(mySlice) == 1 and len(mySlice[0]) == 1):
                        mySlice = mySlice[0][0]
                    ans = mySlice
                    vval = vval.replace(vval[m.start():m.end()], str(ans))
                    madeChange = 1

                p = re.compile("dim\("+arrName+",\s*(\d+)\)") #get dimension
                for m in p.finditer(vval):
                    dim = m.group(1)
                    ans = len(dataArrays[arrName])
                    if (dim == 2):
                        ans = len(dataArrays[arrName][0])
                    logging.debug("dim presub: " + vval)
                    vval = vval.replace(vval[m.start():m.end()], str(ans))
                    logging.debug("dim postsub: " + vval)
                    madeChange = 1

            #sub values from vectors
            #vectors behave like matlab -- they're 1-based
            p = re.compile("#([\d\.,]+)#\((\d+)\)")
            for m in p.finditer(vval):
                arr = m.group(1).split(",")
                ans = arr[int(m.group(2))-1]
                logging.debug("vectorEval presub: " + vval)
                vval = vval.replace(vval[m.start():m.end()], str(ans))
                logging.debug("vectorEval postsub: " + vval)
                madeChange = 1
                break

            #sub values from arrays
            #arrays behave like matlab -- they're 1-based
            p = re.compile("#([\d\.;,]+)#\((\d+),(\d+)\)")
            for m in p.finditer(vval):
                arr = [[int(n) for n in row.split(",")] for row in m.group(1).split(";")]
                ans = arr[int(m.group(2))-1][int(m.group(3))-1]
                logging.debug("arrayEval presub: " + vval + " replacing "+ str(m.start())+ "to" + str(m.end()) + " with " + str(ans))
                vval = vval.replace(vval[m.start():m.end()], str(ans))
                logging.debug("arrayEval postsub: " + vval)
                madeChange = 1
                break

            p = re.compile("answerFun\(([\d\[\]\.\,\s]+)\)") #get matlab function answer
            for m in p.finditer(vval):
                ans = matlabAnswerFun(m.group(1))
                logging.debug("matlabFun presub: " + vval)
                vval = vval.replace(vval[m.start():m.end()], str(ans))
                logging.debug("matlabFun postsub: " + vval)
                madeChange = 1
                break

            p = re.compile("ordinal\((\d+)\)") # go from 1 to 'first', etc.
            for m in p.finditer(vval):
                ans = ordinalLookup[m.group(1)]
                logging.debug("ordinal presub: " + vval)
                vval = vval.replace(vval[m.start():m.end()], str(ans))
                logging.debug("ordinal postsub: " + vval)
                madeChange = 1
                break

            p = re.compile("max\(([-\d\[\]\.\,\s]+)\)") # find max
            for m in p.finditer(vval):
                ans = getMax(m.group(1))
                logging.debug("max presub: " + vval)
                vval = vval.replace(vval[m.start():m.end()], str(ans))
                logging.debug("max postsub: " + vval)
                madeChange = 1
                break

            p = re.compile("min\(([-\d\[\]\.\,\s]+)\)") # find max
            for m in p.finditer(vval):
                ans = getMin(m.group(1))
                logging.debug("min presub: " + vval)
                vval = vval.replace(vval[m.start():m.end()], str(ans))
                logging.debug("min postsub: " + vval)
                madeChange = 1
                break

            p = re.compile("mean\(([-\d\[\]\.\,\s]+)\)") # find max
            for m in p.finditer(vval):
                ans = getMean(m.group(1))
                logging.debug("mean presub: " + vval)
                vval = vval.replace(vval[m.start():m.end()], str(ans))
                logging.debug("mean postsub: " + vval)
                madeChange = 1
                break

            p = re.compile("sum\(([-\d\[\]\.\,\s]+)\)") # find sum
            for m in p.finditer(vval):
                ans = getSum(m.group(1))
                logging.debug("sum presub: " + vval)
                vval = vval.replace(vval[m.start():m.end()], str(ans))
                logging.debug("sum postsub: " + vval)
                madeChange = 1
                break

    #       sub rands
            p = re.compile("int\((-?\d+):(-?\d+)\)") #random int
            for m in p.finditer(vval):
                rFrom = m.group(1)
                rTo = m.group(2)
                if (int(rTo) < int(rFrom)):
                    logging.ERROR('Asking for randint from ' + rFrom + ' to ' + rTo)
                    rFrom = rTo
                rand1 = randint(int(rFrom), int(rTo))
                vval = vval.replace(vval[m.start():m.end()], str(rand1))
                madeChange = 1
                break

            p = re.compile("double\((-?[\d\.]+):(-?[\d\.]+)\)") #random double
            for m in p.finditer(vval):
                rFrom = float(m.group(1))
                rTo = float(m.group(2))
                rand1 = float("{0:.2f}".format(random.uniform(rFrom,rTo)))
                vval = vval.replace(vval[m.start():m.end()], str(rand1))
                madeChange = 1
                break

            p = re.compile(r"{([^}]+)}") #choose random string
            for m in p.finditer(vval):
                contents = m.group(1)
                contentEls = contents.split(",")
                rand = randint(0, len(contentEls)-1)
                selVal = contentEls[rand]
                vval = vval.replace(vval[m.start():m.end()], selVal)
                madeChange = 1
                break

            p = re.compile("toInt\((-?[\d\.]+)\)") #toInt (for array indexing, etc)
            for m in p.finditer(vval):
                num = int(round(float(m.group(1))))
                vval = vval.replace(vval[m.start():m.end()], str(num))
                madeChange = 1
                break

        if (('+' in vval or '-' in vval or '*' in vval or '/' in vval or '^' in vval)
                and (vval not in ('+','-','*','/','^'))):
#        then solve math
            try:
                vval = nsp.eval(vval)
            except Exception as exc:
                sys.exit("Could not parse variable vval to number'" + vval + "'\n" + str(exc))
            logging.debug('var after nsp is '+str(vval))
        try:
            float(vval)
            vval = simplifyNumber(str(vval))
        except:
            pass
        logging.debug('var ' + vname + ' after simplify is '+str(vval))
        variables.append([vname,str(vval)])

    for otherVar in variables:
        qRawQuestionText = qRawQuestionText.replace(otherVar[0], otherVar[1])
        for answer in qRawAnswers:
			answer['answer'] = answer['answer'].replace(otherVar[0], otherVar[1])




    #set 'text' to 'answer' -- needed for multiple choice
#    for answer in qRawAnswers:
#        answer['text'] = answer['answer']

    logging.info("problem_title=" + questionTitle + "\n" +
        "problem_text=" + qRawQuestionText + "\n" +
        "label_text=" + labelText + "\n" +
        "answers=" + str(qRawAnswers) + "\n" +
        "solution_text=" + solutionText + "\n" +
        "options=" + str(options) + "\n")

    the_xml = make_problem_XML(
	    problem_title=questionTitle,
	    problem_text=qRawQuestionText,
	    label_text=labelText,
	    answers=qRawAnswers,
	    solution_text=solutionText,
	    options=options)
    return the_xml, qRawAnswers

#calls 'makeQuestion' to create a number of dynamic questions and writes them to files.
#uses variables parsed from the questionDescriptions
def makeQuestions(
                problemName = "",
                questionText = "",
                labelText = "",
                descriptionText = "",
                solutionText = "",
                problemType = "Numerical",
                answerText = "",
                rawVariables = [],
                answers = [],
                dynamic = 'FALSE',
                problemDifficulty = 0,
                problemContentGrouping = "",
                problemMaxGrade = "",
                problemOptions = {},
                problemFeedback = ""

                  ):
    for questionCount in range(numDynamicQuestions):
        fileName = problemFolder + "/" + os.path.basename(__file__) + '.'+problemName+'.' + str(questionCount) + '.xml'
        problemOptions['problem_type'] = problemType
        if (problemFeedback != ""):
            problemOptions['feedback'] = problemFeedback

        #set question title
        sNums=string.digits
        sLetters = string.uppercase

        CGname = CGIlookup[problemContentGrouping]
        idLen = 2
        nameStr = CGname+' #' + ''.join(random.sample(sNums,idLen)) + ''.join(random.sample(sLetters,1))
        attemptCount = 0
        while(nameStr in problemTitles.keys()):
            nameStr = CGname+' #' + ''.join(random.sample(sNums,idLen)) + ''.join(random.sample(sLetters,1))
            attemptCount += 1
            if (attemptCount > 1000):
                idLen += 1
                attemptCount = 0
        questionTitle = nameStr


        answersAreUnique = False
        xml = ""
        qanswers = ""
        if (shuffleAnswers):
            random.shuffle(answers)

        if(dynamic == 'FALSE'):
            xml = make_problem_XML(
                problem_title=questionTitle,
                problem_text=questionText,
                label_text=labelText,
                answers=answers,
                solution_text=solutionText,
                options=problemOptions)
            write_problem_file(xml,fileName)
            qanswers = answers
        else:
            makeQuestionAttemptCount = 0
            while not answersAreUnique:
                xml,qanswers = makeQuestion(
                         questionTitle=questionTitle,
                         rawQuestionText=questionText,
                         labelText=labelText,
                         descriptionText=descriptionText,
                         solutionText=solutionText,
                         rawVariables=rawVariables,
                         rawAnswers=answers,
                         problemType=problemType,
                         options=problemOptions
                         )
                seenAnswers = {}
                theseAnswersUnique = True
                for answer in qanswers:
                    if answer["answer"] in seenAnswers:
                        theseAnswersUnique = False
                        break
                    seenAnswers[answer["answer"]] = 1
                if theseAnswersUnique:
                    answersAreUnique = True
                makeQuestionAttemptCount += 1
                if makeQuestionAttemptCount > 100:
                    sys.exit("Cannot create unique answers for question. Line " + str(lineCount) + ": " + line)
            write_problem_file(xml, fileName)

        KCs = {}
        for answer in qanswers:
            answerKCs = answer["knowledgeComponent"].split(";")
            for answerKC in answerKCs:
                answerKC = answerKC.strip()
                if answerKC == "":
                    continue
                KCs[answerKC] = 1
        problemKCString = ','.join(KCs.keys())

        #write question info to log for tutorgen
        s=string.lowercase+string.digits+string.uppercase
        problemIDString = 'QMB'+''.join(random.sample(s,10))
        while (problemIDString in problemIDs):
            problemIDString = 'QMB'+''.join(random.sample(s,10))
        problemWebLoc = webLocRoot + os.path.basename(__file__) + '.'+problemName+'.' + str(questionCount)
        #problem_id    difficulty    content_grouping    KCs (comma separated)    max grade    type    options
        tutorGenOptions = ""
        dd.write(problemIDString+"\t"+problemDifficulty+"\t"+problemContentGrouping+"\t"+
                 problemKCString+"\t"+problemMaxGrade+"\t"+problemType+"\t"+tutorGenOptions+"\t"+problemWebLoc+"\t"+questionTitle+"\n")

##MAIN

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
    line = lines[lineCount]
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
                problemFeedback = problemFeedback
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
