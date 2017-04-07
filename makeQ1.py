#linear indexing
from QMB_XML import *
from QMB_utils import *
from random import randint
import random




maxMatrixSize = 10
for questionCount in range(10):
    matrixCols = randint(1,maxMatrixSize)
    matrixRows = randint(1,maxMatrixSize)
    temp = randint(0,1)
    if temp > 0:
        matrix = [[random.randrange(1,101,1) for _ in range (matrixCols)] for _ in range(matrixRows)]
    else:
        matrix = [[float("{0:.2f}".format(random.uniform(1,101))) for _ in range (matrixCols)] for _ in range(matrixRows)]
#    matrix = [[0, 5, 10, 15, 20], 
#          [1, 6, 11, 16, 21], 
#          [2, 7, 12, 17, 22], 
#          [3, 8, 13, 18, 23], 
#          [4, 9, 14, 19, 24]]

    matrixT = map(list, zip(*matrix))

    flatMatrix = [item for sublist in matrixT for item in sublist]


    text = '<p>Given the following table called MyArray</p>'+ html_table(matrix)
#generate label dynamically
    rand1 = randint(1,len(flatMatrix)) #in matlab space (1-based)

    label = 'What would MyArray('+str(rand1)+') return'
    answer = flatMatrix[rand1-1]
    answers = [{'answer': str(answer)}]
    solution = '<p>In Matlab, linear indexing orders ...</p>'
    options = {'problem_type': 'Text'}

    
    the_xml = make_problem_XML(
        problem_text = text,
        label_text = label,
        answers = answers,
        solution_text = solution,
        options = options)
    write_problem_file(the_xml, 'array_problem_'+str(questionCount)+'.xml')
    
    

