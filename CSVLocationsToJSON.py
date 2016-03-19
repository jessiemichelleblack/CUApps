'''
NEEDED

Strip out any quotes
Split line based on last two commas
	This allows building names to have commas in the name

'''


import sys
inputFile = open(sys.argv[1])
inputFile.readline()
json = "{"
for line in inputFile:
	line = line.split(',')
	json += "\""+line[0]+"\" : {\"latitude\" : "+line[1]+",\"longitude\" : "+line[2]+"}" 
	json += ","
json = json[:-1] + "}"
print json
