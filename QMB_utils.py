import os.path
def html_table(listOfLists, formatting=[]):
  retStr = "<table>"
  for i in range(len(listOfLists)):
    retStr = retStr+ '  <tr><td>[</td>'
    for j in range(len(listOfLists[0])):
        formatStart = ""
        formatEnd = ""
        if formatting and formatting[i][j]:
            formatStart = "<"+formatting[i][j]+">"
            formatEnd = "</"+formatting[i][j]+">"
        retStr += '<td>'+formatStart+str(listOfLists[i][j])+formatEnd+'</td>'
    retStr = retStr + "<td>]</td></tr>\n"
  retStr = retStr + '</table>'
  return retStr

def html_table_matlab(listOfLists, formatting=[]):
  retStr = "myArray=[<table>"
  for i in range(len(listOfLists)):
    retStr = retStr+ '  <tr><td></td>'
    for j in range(len(listOfLists[0])):
        formatStart = ""
        formatEnd = ""
        if formatting and formatting[i][j]:
            formatStart = "<"+formatting[i][j]+">"
            formatEnd = "</"+formatting[i][j]+">"
        retStr += '<td>'+formatStart+str(listOfLists[i][j])+formatEnd+'</td>'
    retStr = retStr + "<td></td></tr>\n"
  retStr = retStr + '</table>];'
  return retStr

def load_matlab_matrix(matrixName):
    #dlmwrite('myArray3.txt',myArray3)
    #pathToFiles = 'C:/Users/Kendell/Documents/MATLAB/'
    pathToFiles = 'matlabArrays/'
    fileSuffix = ".txt"
    fileLoc = pathToFiles+matrixName+fileSuffix
    print('opening '+fileLoc)
    if (not os.path.isfile(fileLoc)):
        return ""

    ins = open(fileLoc,"r")
    data = [[int(n) for n in line.split(",")] for line in ins]
    return data
    
