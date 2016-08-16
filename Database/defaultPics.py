#!/usr/bin/env python

import json

jsonFile = open('default.json', 'r')
jsonData = json.load(jsonFile)

places = jsonData["places"]

for item in places:
	#places[item] = newArray
	print item

jsonFile.close()
