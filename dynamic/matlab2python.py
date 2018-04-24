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
