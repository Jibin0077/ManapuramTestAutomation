*** Settings ***
Documentation        Template robot main suite.
# Library            RPA.Desktop.Windows
Library              RPA.Windows
Library              RPA.core.notebook
Library              Otp_notifi.py
Library             RPA.Browser.Selenium

*** Keywords ***
Phone Link Application
    Windows Search    Phone Link
    Sleep    7s
    Click    id:_MaximizeButton
    Sleep    3s
    Click    id:PreviewTextUnread
    Sleep    3s
    # ${otpdata}=    Get Text    id:PreviewTextRead  
    ${otpout}=      RPA.Windows.Get Element    id:PreviewTextRead
    Log To Console    ${otpout}
    ${otp}   Otp_Extrat    "${otpout}"
    Log To Console   ${otp}
    Click    id:_CloseButton
    Return From Keyword    ${otp}
    

# *** Tasks ***
# Flow
#     Phone Link Application