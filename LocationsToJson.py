import json
import csv

csvFile = open('Locations.csv')
header = csvFile.readline().split(',') #Disregard the header
csvReader = csv.reader(csvFile)
csvData = list(csvReader)

locations = dict()

jsonFile = open('Locations.json', 'w')

for row in csvData:
	locations[row[0]] = row[1:]

json.dump(locations, jsonFile)

csvFile.close()
jsonFile.close()
