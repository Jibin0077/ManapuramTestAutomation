*** Settings ***
Documentation       Template robot main suite.
Library             RPA.Browser.Selenium
Library             RPA.core.notebook
Library             Collections
Library             MyLibrary.py
Resource            keywords.robot
Variables           MyVariables.py
#Library             Functions.py
Library             RPA.Excel.Files
Resource            Filtering.robot
Library             Data.py
# Library             variables.py
Variables           Selectors.py

     
*** Keywords ***
Data Collection
    ${data}     Create Dict
    # Log To Console    ${data}
    Set Global Variable    ${details}   ${data} 
    &{out_config}=  Create Dictionary
    Open Workbook  ${CONFIG_FILE}
    Log To Console   Reading worksheet: ${CONFIG_SHEET}
    ${table}=  Read Worksheet As Table    ${CONFIG_SHEET}  header=${True}
    FOR    ${row}    IN    @{table}
        IF    "${row['Name']}" != "${null}"
            Set To Dictionary    ${out_config}  ${row['Name']}  ${row['Value']}
        END
    END
    Set Global Variable    ${CONFIG}    ${out_config}
    Close Workbook


*** Keywords *** 
#------------- launching URL successfully in the Edge browser with a label as "Welcome To Manappuram Finance Limited Customer eService Portal"---------#
Portal Launching
    [Arguments]        ${TestCase_Id}
    
    ${Browser}  Set Variable    ${CONFIG}[Browser]
    IF     '${Browser}' == 'Chrome'
        ${path}    Chromedriver_diectory
        Open Browser         ${CONFIG}[URL]       browser=${Browser}      executable_path=${path}   
    ELSE
        ${path}    Edgedriver_diectory
        Open Browser         ${CONFIG}[URL]       browser=${Browser}      executable_path=${path}   
    END  
    Maximize Browser Window
    Sleep  2s
    ${Text_Vis}        RPA.Browser.Selenium.Is Element Visible    ${el_text_validation}
    IF    ${Text_Vis}
        Return From Keyword        pass
    ELSE 
        Return From Keyword        fail
    END

Portal Login
#-------------logging in with the provided user id and  password-----------------#
    [Arguments]        ${TestCase_Id}

    ${UserName}=  Set Variable    ${details}[${TestCase_Id}][username]
    ${Password}=  Set Variable    ${details}[${TestCase_Id}][password]
    Wait Until Keyword Succeeds    3x   5     Wait Until Element Is Visible        ${el_Username}
    Input Text        ${el_Username}                ${UserName}
    Wait Until Keyword Succeeds    3x   5     Wait Until Element Is Visible        ${el_password}
    Input Password    ${el_password}                ${Password}
    Click Element If Visible    ${el_Login}
    Sleep    2s

    ${Login_err}     RPA.Browser.Selenium.Is Element Visible     ${el_Login_error}
    IF  ${Login_err}
        Return From Keyword        fail
    ELSE
        Return From Keyword        pass
    END

Quick Pay in Portal
#----------- launched successfully in the Edge browser with a button as "QUICK PAY"--------------#
    [Arguments]        ${TestCase_Id}
   
    ${Bttn_Vis}     RPA.Browser.Selenium.Is Element Visible     ${el_quickpay}
    IF  ${Bttn_Vis}
        Return From Keyword        pass
    END

Portal Login with Email Notification
#---------Email notification is prompted-----------#
    [Arguments]        ${TestCase_Id}
    
    ${Email_Vis}     RPA.Browser.Selenium.Is Element Visible      ${el_email}
    IF  ${Email_Vis}
        # Sleep  ${Delay}
        Click Element When Visible           ${el_email}
        Return From Keyword        pass
    ELSE
        Return From Keyword        fail
    END

Portal login with menus validation
#------------Checking for the main menus as 'Make Payment','Online Gold Disbursal','Support','Customer Profile','Download Pawn Ticket','FAQ'--------------#
   [Arguments]        ${TestCase_Id}
    Sleep    3s
    @{Menu_list}    Create List    Make Payment    Customer Profile    Online Gold Loan Disbursal    Support    Download Pawn Ticket
    FOR    ${element}    IN    @{Menu_list}
        ${Menu_Vis}     RPA.Browser.Selenium.Is Element Visible     //*[contains(text(),"${element}")]
        IF  ${Menu_Vis}
            ${status}    Set Variable    pass
        ELSE 
            Return From Keyword          fail
        END
    END
    Return From Keyword        ${status}

Portal Login with the user verification
    [Arguments]        ${TestCase_Id}
#----------------Verifying the user name------------------#
    
    ${User}=      Set Variable    ${details}[${TestCase_Id}][username]
    Wait Until Element Is Visible        ${el_user_validation}
    ${User_name}     RPA.Browser.Selenium.Get Text            ${el_user_validation}
    IF    '${User_name}' == '${User}'
        Return From Keyword        pass
    ELSE 
        Return From Keyword        fail
    END
    
Portal sign out
#-----------------Signing out of the portal---------------#
    [Arguments]        ${TestCase_Id}
    
    Wait Until Keyword Succeeds    3x   5     Wait Until Page Contains Element    ${el_signout}
    Click Element            ${el_signout}
    
    Return From Keyword        pass

PayTM Login
#------------------launching Paytm on click the Paytm button on the portal---------------#
    [Arguments]        ${TestCase_Id}

    Wait Until Keyword Succeeds    3x   5     Wait Until Page contains Element     ${el_payTm}
    Click Element        ${el_payTm}
    Sleep    3s
    Close All Browsers
    Return From Keyword        pass
 


    