#!/usr/bin/env python

from bs4 import BeautifulSoup
import requests

parkingWebsiteURL = "http://www.colorado.edu/pts/maps"

response = requests.get(parkingWebsiteURL)
data = response.text
soup = BeautifulSoup(data, "html.parser")

for tag in soup.findAll('a'):
	print tag
