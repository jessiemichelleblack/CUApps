#!/usr/bin/env python

import json
import os
import re

currentDirectory = os.getcwd() #Full directory without a slash at the end

for dirpath, dirnames, filenames in os.walk('.'):
	for filename in filenames:
		if filename[:9] == "places%2F":
			os.rename(filename, filename[9:])
	#x = 0
#print filenames

jsonFile = open('cuapp-5d360-export.json', 'r')
jsonData = json.load(jsonFile)

places = jsonData["places"]

for item in places:
	try:
		if places[item][0] != "default":
			newitem = item
			newitem = re.sub('\(', '', newitem)
			newitem = re.sub('\)', '', newitem)
			newitem = re.sub('\'', '', newitem)
			newitem = re.sub(',', '', newitem)
			newitem = re.sub('\.', '', newitem)
			newitem = re.sub(' ', '-', newitem)
			newitem = newitem.lower()
			newitemName = newitem + ".png"
			olditemName = places[item][0] + ".png"
			#print olditemName, newitemName
			os.rename(olditemName, newitemName)
			places[item][0] = newitem
			print places[item][0]
	except Exception as Error:
		x = 0
jsonFile.close()
jsonFile = open('cuapp-5d360-export.json', 'w')
jsonData["places"] = places
json.dump(jsonData, jsonFile)
jsonFile.close()

