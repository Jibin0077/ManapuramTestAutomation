import re
  
def Otp_Extrat(test_string):
    
    # m = re.search('Online Gold Loan is (\d+)', test_string, re.IGNORECASE)
    # return m.group(1)

    m = re.search('Online Gold Loan is (\d+)', test_string, re.IGNORECASE)
    if m == None:
        return 000000
    else:
        return m.group(1)
# print(Otp_Extrat("Dear Customer, One Time Password(OTP) for your Online Gold Loan is 235432"))
