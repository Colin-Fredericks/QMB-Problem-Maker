import os, sys, inspect, logging
import copy
import re
import random
import numpy as np
from random import randint
currentdir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
parentdir = os.path.dirname(currentdir)
sys.path.insert(0, parentdir)

from QMB_XML import *
from QMB_utils import *
from parseNum import *
from simplifyNumber import *

#logging.basicConfig(stream=sys.stderr, level=logging.CRITICAL)
logging.basicConfig(stream=sys.stderr, level=logging.DEBUG)

problemFolder = "problems"
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

def getMax(matlabStr_in):
    matlabStr = str(matlabStr_in)
    matlabStr = matlabStr.replace("["," ")
    matlabStr = matlabStr.replace("]"," ")
    matlabStr = matlabStr.replace(","," ")
    strEls = matlabStr.split()
    strEls = map(float, strEls)
    return max(strEls)

def getMin(matlabStr_in):
    matlabStr = str(matlabStr_in)
    matlabStr = matlabStr.replace("["," ")
    matlabStr = matlabStr.replace("]"," ")
    matlabStr = matlabStr.replace(","," ")
    strEls = matlabStr.split()
    strEls = map(float, strEls)
    return min(strEls)

def getMean(matlabStr_in):
    matlabStr = str(matlabStr_in)
    matlabStr = matlabStr.replace("["," ")
    matlabStr = matlabStr.replace("]"," ")
    matlabStr = matlabStr.replace(","," ")
    strEls = matlabStr.split()
    strEls = map(float, strEls)
    return sum(strEls)/len(strEls)
        
    
    


#make and print one question to filename
def makeQuestion(
    fileName,
    questionTitle=False,  
    rawQuestionText=False, #dynamic (has unsubstituted variables)
    labelText='Enter your answer below.',
    descriptionText="",
    solutionText="",
    rawVariables=[],  # dynamic, list of variables (key:value) without substitutions
    rawAnswers=[],  # dynamic ['answer','correctness','knowledgeComponent']
    problemType='Numerical'
    ):
    
    
    #make local copies -- arg.. python passes by reference
    qRawAnswers = copy.deepcopy(rawAnswers)
    qRawQuestionText = copy.copy(rawQuestionText)
    qRawVariables = copy.deepcopy(rawVariables)
    
    variables = []
    for var in qRawVariables:
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
                    
            p = re.compile("answerFun\(([\d\[\]\.\,\s]+)\)") #get matlab function answer
            for m in p.finditer(vval):
                ans = matlabAnswerFun(m.group(1))
                logging.debug("matlabFun presub: " + vval)
                vval = vval.replace(vval[m.start():m.end()], str(ans))
                logging.debug("matlabFun postsub: " + vval)
                madeChange = 1
                
            p = re.compile("ordinal\((\d)\)") # go from 1 to 'first', etc.
            for m in p.finditer(vval):
                ans = ordinalLookup[m.group(1)]
                logging.debug("ordinal presub: " + vval)
                vval = vval.replace(vval[m.start():m.end()], str(ans))
                logging.debug("ordinal postsub: " + vval)
                madeChange = 1
                
            p = re.compile("max\(([\d\[\]\.\,\s]+)\)") # find max
            for m in p.finditer(vval):
                ans = getMax(m.group(1))
                logging.debug("max presub: " + vval)
                vval = vval.replace(vval[m.start():m.end()], str(ans))
                logging.debug("max postsub: " + vval)
                madeChange = 1
                
            p = re.compile("min\(([\d\[\]\.\,\s]+)\)") # find max
            for m in p.finditer(vval):
                ans = getMin(m.group(1))
                logging.debug("min presub: " + vval)
                vval = vval.replace(vval[m.start():m.end()], str(ans))
                logging.debug("min postsub: " + vval)
                madeChange = 1
            
            p = re.compile("mean\(([\d\[\]\.\,\s]+)\)") # find max
            for m in p.finditer(vval):
                ans = getMean(m.group(1))
                logging.debug("mean presub: " + vval)
                vval = vval.replace(vval[m.start():m.end()], str(ans))
                logging.debug("mean postsub: " + vval)
                madeChange = 1
            
    #       sub rands
            p = re.compile("int\((-?\d+):(-?\d+)\)") #random int
            for m in p.finditer(vval):
                rFrom = m.group(1)
                rTo = m.group(2)
                rand1 = randint(int(rFrom), int(rTo))
                vval = vval.replace(vval[m.start():m.end()], str(rand1))
                madeChange = 1
             
            p = re.compile("double\((-?[\d\.]+):(-?[\d\.]+)\)") #random double
            for m in p.finditer(vval):
                rFrom = float(m.group(1))
                rTo = float(m.group(2))
                rand1 = float("{0:.2f}".format(random.uniform(rFrom,rTo)))
                vval = vval.replace(vval[m.start():m.end()], str(rand1))   
                madeChange = 1  
                
            p = re.compile(r"{([^}]+)}") #choose random string
            for m in p.finditer(vval):
                contents = m.group(1)
                contentEls = contents.split(",")
                rand = randint(0, len(contentEls)-1)
                selVal = contentEls[rand]
                vval = vval.replace(vval[m.start():m.end()], selVal)   
                madeChange = 1
        
        if ('+' in vval or '-' in vval or '*' in vval or '%' in vval):
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

    options = {'problem_type': problemType}
    
    #set 'text' to 'answer' -- needed for multiple choice
    for answer in qRawAnswers:
        answer['text'] = answer['answer']
    
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
    write_problem_file(the_xml, fileName)
    print "writing " + fileName
    return 1
	
nsp = NumericStringParser()



infile = open("questionDescriptions.txt", "r")
lines = infile.readlines()
lineCount = 0 #line count
problemName = ""
questionTitle = ""
questionText = ""
labelText = "Enter your answer below."
descriptionText = ""
solutionText = ""
problemType = "Numerical"
answerText = ""
rawVariables = []
answers = []
dynamic = 0
numDynamicQuestions = 3
difficulty = 0

readQuestionCount = 0


while (lineCount < len(lines)):
    line = lines[lineCount].rstrip()
    if (line == ""):
        lineCount += 1
        continue
    if (line.startswith("#")):
        lineCount += 1
        continue
    lineEls = line.split("\t")
    if (lineEls[0] != ""):
        logging.info("questionText is " + questionText + "and dynamic is " + str(dynamic))
        if (questionText != "" and dynamic):
            readQuestionCount += 1
            for questionCount in range(numDynamicQuestions):
                fileName = problemFolder + "/" + os.path.basename(__file__) + '.'+problemName+'.' + str(questionCount) + '.xml'
                makeQuestion(fileName=fileName,
                             questionTitle=questionTitle,
                             rawQuestionText=questionText,
                             labelText=labelText,
                             descriptionText=descriptionText,
                             solutionText=solutionText,
                             rawVariables=rawVariables,
                             rawAnswers=answers,
                             problemType=problemType
                             )

							    
#            sys.exit("printed first")
        # reset variables
        problemName = lineEls[0]
        questionTitle = ""
        questionText = ""
        labelText = "Enter your answer below."
        descriptionText = ""
        solutionText = ""
        problemType = "Numerical"
        rawVariables = []
        dynamic = 0
        difficulty = 0
        answers = []
        
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
                        'correctness':lineEls[4]})
    elif (lineEls[1] == "problemType"):
        problemType = lineEls[2]
    elif (lineEls[1] == "dynamic"):
        dynamic = lineEls[2]
    elif (lineEls[1] == "difficulty"):
        difficulty = lineEls[2]
    elif (lineEls[1] == ""):
        pass
    else:
        print('Unset option: lineEls[1] is "'+lineEls[1] + '"')
    lineCount += 1

#finish last question if there is one	
if (questionText != "" and dynamic):
    readQuestionCount += 1
    for questionCount in range(numDynamicQuestions):
        fileName = problemFolder + "/" + os.path.basename(__file__) + '.'+problemName+'.' + str(questionCount) + '.xml'
        makeQuestion(fileName=fileName,
                     questionTitle=questionTitle,
                     rawQuestionText=questionText,
                     labelText=labelText,
                     descriptionText=descriptionText,
                     solutionText=solutionText,
                     rawVariables=rawVariables,
                     rawAnswers=answers,
                     problemType=problemType
                     )
print "Read " + str(lineCount) + " lines and " + str(readQuestionCount) + " questions"
	
