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

def html_table2(listOfLists, formatting=[]):
  retStr = "<table>"
  for sublist in listOfLists:
    retStr = retStr+ '  <tr><td>[</td>'
    for x in sublist:
        retStr += '<td>'+str(x)+'</td>'
    retStr = retStr + "<td>]</td></tr>\n"
  retStr = retStr + '</table>'
  return retStr