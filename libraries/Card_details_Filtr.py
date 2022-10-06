import re
  
def Card_Detail_Extrat(test_string):
    
    words = test_string.split()
    # print(words)
    card_no = (words)[3]
    # print(card_no)
    card_name = (words)[7]
    # print(card_name)
    card_cvv = (words)[11]
    # print(card_cvv)
    Ex_month = (words)[15]+" "+(words)[16]
    # print(Ex_month)
    Ex_year = (words)[18]
    # print(Ex_year)
    return card_no,card_name,card_cvv,Ex_month,Ex_year

# print(Card_Detail_Extrat("Card Number : 5123456789012346 Card Name : Test CVV Number : 123 Expiry Date : Sep (9) , 2022"))