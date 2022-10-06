import os
import PyPDF2
from googletrans import Translator
from pathlib import Path

# def down():
#     downloads_path = str(Path.home() / "Downloads")
#     print(downloads_path)
# print(down())


def Document_Language():
    downloads_path = str(Path.home() / "Downloads")
    # print(downloads_path)
    pdfFileObj = open(downloads_path + "\\0115170730013108.pdf",'rb')
    print(pdfFileObj)
    pdfReader = PyPDF2.PdfFileReader(pdfFileObj)
    pageObj = pdfReader.getPage(0) 
    Ext_txt = pageObj.extractText()
    #------------------------------------
    with open('Lecture Note.txt', 'w') as f:
        f.write(Ext_txt)
   
    # print(Ext_txt)
    
    #------------------------------------------
    detector = Translator()
    dec_lan = detector.detect({Ext_txt})
    print(dec_lan)

    if dec_lan.lang == "en" or dec_lan.confidence == 1:
        print('Yes! it is')
        return True
    else:
        print('No! it is not')
        return False
# print(Document_Language())


