#!/usr/bin/env python

from bs4 import BeautifulSoup
from pdfminer.pdfinterp import PDFResourceManager, PDFPageInterpreter
from pdfminer.converter import TextConverter
from pdfminer.layout import LAParams
from pdfminer.pdfpage import PDFPage
from cStringIO import StringIO
import requests
import urllib
import re


def convert_pdf_to_txt(path):
    rsrcmgr = PDFResourceManager()
    retstr = StringIO()
    codec = 'utf-8'
    laparams = LAParams()
    device = TextConverter(rsrcmgr, retstr, codec=codec, laparams=laparams)
    fp = file(path, 'rb')
    interpreter = PDFPageInterpreter(rsrcmgr, device)
    password = ""
    maxpages = 0
    caching = True
    pagenos=set()

    for page in PDFPage.get_pages(fp, pagenos, maxpages=maxpages, password=password,caching=caching, check_extractable=True):
        interpreter.process_page(page)

    text = retstr.getvalue()

    fp.close()
    device.close()
    retstr.close()
    return text

def main():
	menuUrl = "https://housing.colorado.edu/dining/menus"

	response = requests.get(menuUrl)
	data = response.text

	soup = BeautifulSoup(data, "html.parser")

	menuNameList = []
	for tag in soup.findAll('a'):
		try:
			href = tag["href"]
			if ".pdf" in href:
				fileName = href[href.rfind('/')+1:]
				urllib.URLopener().retrieve(href,fileName)
				menuNameList.append(fileName)
		except:
			x = 0

	for file in menuNameList:
		#print file
		fileContents = (re.sub("\n\n","",convert_pdf_to_txt(file))).split('\n')
		for line in fileContents:
			#print repr(line)
			print line
main()
