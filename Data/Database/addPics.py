#!/usr/bin/env python

import json

jsonFile = open('temp.json', 'r')
jsonData = json.load(jsonFile)

places = jsonData["places"]

for item in places:
	originalArray = places[item]
	newArray = ["default"]
	for originalPiece in originalArray:
		newArray.append(originalPiece)
	places[item] = newArray

jsonData["places"] = places

newJsonFile = open('newStuff.json', 'w')

json.dump(jsonData, newJsonFile)
jsonFile.close()
newJsonFile.close()
