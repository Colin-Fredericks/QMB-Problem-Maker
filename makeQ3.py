#filename: 
from QMB_XML import *
from QBM_utils import *
from random import randint
from random import shuffle
import random


maxMatrixSize = 10

for questionCount in range(10):
    matrixCols = randint(1,maxMatrixSize)
    matrixRows = randint(1,maxMatrixSize)
    
    vals = random.sample(range(100), matrixCols*matrixRows)   # sampling without replacement
    matrix = [vals[i:i+matrixCols] for i in range(0, len(vals), matrixCols)]
#    matrix = [[0, 5, 10, 15, 20], 
#          [1, 6, 11, 16, 21], 
#          [2, 7, 12, 17, 22], 
#          [3, 8, 13, 18, 23], 
#          [4, 9, 14, 19, 24]]

    matrixT = map(list, zip(*matrix))

    flatMatrix = [item for sublist in matrixT for item in sublist]
    
    rand1 = randint(1, matrixRows)
    rand2 = randint(1, matrixCols)
    val = matrix[rand1-1][rand2-1]
    
    formatting = [["" for _ in range(matrixCols)] for _ in range(matrixRows)]
    formatting[rand1-1][rand2-1] = 'strong'

    text = '<p>Given the following table called MyArray</p>' + html_table(matrix,formatting)
# generate label dynamically



    label = 'What command would yield the value ' + str(val) + ' highlighted in MyArray?'
    
    numAnswers = 4
    answers = []
    while len(answers) < numAnswers:
        test1 = randint(1,maxMatrixSize)
        test2 = randint(1,maxMatrixSize)
        if test1 == rand1 and test2 == rand2:
            continue
        answers.append({'text': "MyArray("+str(test1)+","+str(test2)+")", 'correctness': 'false'})
    #red herrings
    answers.append({'text': "MyArray["+str(rand1)+","+str(rand2)+"]",'correctness':'false'})
    
    #correct answer
    answers.append({'text': "MyArray("+str(rand1)+","+str(rand2)+")",'correctness':'false'})
    
    shuffle(answers)
    
    solution = '<p>In Matlab, linear indexing orders ...</p>'
    options = {'problem_type': 'MC'}

    the_xml = make_problem_XML(
        problem_text = text,
        label_text = label,
        answers = answers,
        solution_text = solution,
        options = options)
    write_problem_file(the_xml, __file__+ 'array_index_problem_'+str(questionCount)+'.xml')
    questionCount += 1
    
    

