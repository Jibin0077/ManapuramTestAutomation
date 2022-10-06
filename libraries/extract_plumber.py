import pdfplumber
from googletrans import Translator

''' engine: pdfplumber
    get all readable text from pdf file and store it to a dictionary variable,[ key= page-number : value=page-content ]

    pg_total:       used to find the total number of pages
    current_page:   to get the details from each page one by one
    text:           store the extracted text from each page   '''


def Document_lang(file_input):
    data_dictionary = {}
    pdf = pdfplumber.open(file_input)
    pg_total = len(pdf.pages)
    current_page = pdf.pages[0]
    text = current_page.extract_text()
    # print(text)
    #------------------------------------------
    # malayalam_words = ['വാർഷിക പലിശ ','വിലാസം']
    #-------------------------------------------------
    if (text.__contains__('വിലാസം')):
        print("Malayalam")
        return True
    else:
        print("English")
        return False
    #------------------------------------------------------------
    
print(Document_lang('C:/Users/Q0041/Downloads/Malayalam_invoice.pdf'))
