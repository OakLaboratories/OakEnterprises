#!/usr/bin/python
print 'Content-type:text/html\n'
import random

def grades(fle):
    x = open(fle)
    y = x.read()
    x.close()
    z = y.split('\n')
    d = {}
    while len(z) > 0:
         entry = z.pop()
         string = entry.split(',')
         d[string[0]] = string[1:]
    return d

def avg(lst):
    x = 0
    y  = len(lst)
    while len(lst) > 0:
        x += float(lst.pop())
    return x/y

def averages(d):
    y = d.keys()
    newd = {}
    while len(y) > 0:
        key = y.pop()
        newd[key] = avg(d[key])
    return newd

def fullGrade(test, hw):
    x = averages(test)
    y = averages(hw)
    names = x.keys()
    newd = {}
    while len(names) > 0:
        key = names.pop()
        newd[key] = float(x[key])/100 * 70 + float(y[key]) * 30
    return newd
    
def tableG(d):
    names = d.keys()
    result = '<table border=1><tr><th>Student</th><th colspan=' + str(len(names[random.randrange(len(names))])) + '>Grades</th></tr>'
    while len(names) > 0:
        new = names.pop()
        result += '<tr><td>' + str(new) + '</td>'
        count = 0
        while count < len(d[new]):
            result += '<td>' + str(d[new][count]) + '</td>'
            count += 1
        result += '</tr>'
    result += '</table>'
    return result

def tableA(d):
    names = d.keys()
    result = '<table border=1><tr><th>Student</th><th>Grades</th></tr>'
    while len(names) > 0:
        new = names.pop()
        result += '<tr><td>' + str(new) + '</td><td>' + str(d[new]) + '</td></th>'
    result += '</table>'
    return result 


print tableG(grades('tests.csv'))
print tableG(grades('work.csv'))
print tableA(fullGrade('tests.csv', 'work.csv'))
