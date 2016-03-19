import sys
inputFile = open(sys.argv[1])
json = "{"
for line in inputFile:
	line = line.split(',')
	json += "\""+line[0]+"\" : {\"latitude\" : "+line[1]+",\"longitude\" : "+line[2]+"}" 
	json += ","
json = json[:-1] + "}"
print json
