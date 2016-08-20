#!/usr/bin/env python

import json

jsonFile = open('default.json', 'r')
jsonData = json.load(jsonFile)

places = jsonData["places"]

for item in places:
	if places[item][0] == "default":
		print item

jsonFile.close()
