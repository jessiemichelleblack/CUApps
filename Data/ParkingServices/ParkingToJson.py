#!/usr/bin/env python

import json
import csv

csvFile = open('ParkingData.csv')
header = csvFile.readline().split(',')
csvReader = csv.reader(csvFile)
csvData = list(csvReader)

parkingPlaces = dict()

jsonFile = open('ParkingLocations.json', 'w')

for row in csvData:
	parkingPlaces[row[0]] = row[1:]

json.dump(parkingPlaces, jsonFile)

csvFile.close()
jsonFile.close()
