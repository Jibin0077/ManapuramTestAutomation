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
Library             RPA.RobotLogListener
Library             Language.py
Variables           Selectors.py
Resource            Subflow.robot
Resource            DesktopAuto.robot
Library             Card_details_Filtr.py
Library             RPA.Desktop.Windows
Library             RPA.Dialogs

*** Keywords ***
   
Make payment option
#--------------Makeing Payment for payment menu option------------#
    [Arguments]          ${TestCase_Id}
    Portal Launching     ${TestCase_Id}
    Portal Login         ${TestCase_Id}
    Wait Until Keyword Succeeds    3x    5    Wait Until Element Is Visible        ${el_mak_paymt}
    ${Make_paymt_Vis}     RPA.Browser.Selenium.Is Element Visible     ${el_mak_paymt}
    IF  ${Make_paymt_Vis}
        Portal sign out        ${TestCase_Id}
        Sleep    2s
        Close All Browsers
        Return From Keyword        PASS
    END

Part payment option
    #--------------Makeing Payment for a particular Account  number------------#
    [Arguments]          ${TestCase_Id}
    ${Acc_no}=  Set Variable    ${details}[${TestCase_Id}][Acc_no]
    ${Mini_amt}=  Set Variable    ${details}[${TestCase_Id}][Mini_amt]
    ${card_Details}=  Set Variable    ${details}[${TestCase_Id}][card_Details]
    ${card_no}      ${card_name}     ${card_cvv}    ${Ex_month}      ${Ex_year}     Card_Detail_Extrat    ${card_Details}
    Portal Launching     ${TestCase_Id}
    Portal Login         ${TestCase_Id}
    Wait Until Keyword Succeeds    3x    5    Wait Until Element Is Visible        ${el_mak_paymt}
    Click Element When Visible        ${el_mak_paymt}
    Sleep   5s
    ${Acc_No_Count}       Get Element Count             ${el_acc_table}
    # ${Count}     Set Variable    2
    FOR         ${Count}        IN RANGE         ${Acc_No_Count}
        ${Extracted_AccNo}      RPA.Browser.Selenium.Get Text              //table[@id="ContentPlaceHolder1_gv_homedata"]//tbody/tr[${Count+2}]/td[1]
        IF    '${Extracted_AccNo}' == '${Acc_no}'
            Wait Until Keyword Succeeds    5x    5    Wait Until Element Is Visible     //table[@id="ContentPlaceHolder1_gv_homedata"]//tbody/tr[${Count+2}]/td[1]
            Click Element    //table[@id="ContentPlaceHolder1_gv_homedata"]//tbody/tr[${Count+2}]/td[1]
            Wait Until Keyword Succeeds    5x    5    Wait Until Element Is Visible    ${el_part_paymt}
            Input Text    ${el_part_paymt}    ${Mini_amt}
            Sleep    2s
            Wait Until Keyword Succeeds    5x    5    Wait Until Element Is Visible    ${el_pay_btn}
            Click Element    ${el_pay_btn}
            Sleep    2s
            # Click Element    ${el_pay_btn}
            Run Keyword And Ignore Error    Handle Alert     ACCEPT
            ${payment_option_Vis}     RPA.Browser.Selenium.Is Element Visible     ${el_Debit_card}
            IF  ${payment_option_Vis}
                Wait Until Element Is Visible    ${el_Debit_card}
                Click Element    ${el_Debit_card}
                Wait Until Element Is Visible    ${el_rupay_card}
                Click Element    ${el_rupay_card}
                Wait Until Element Is Visible    ${el_payU_img}
                Click Element    ${el_payU_img}
                Wait Until Keyword Succeeds    3x    5    Wait Until Element Is Visible    ${el_proceed_btn}
                Click Element    ${el_proceed_btn}
                Sleep    2s
                Run Keyword And Ignore Error    Handle Alert     ACCEPT
                #---------------------------------------------
                Wait Until Keyword Succeeds    5x    5    Wait Until Element Is Visible    ${el_card_type}
                Select From List By Label            ${el_card_type}        RuPay Debit Cards
                Sleep    2s
                Wait Until Keyword Succeeds    5x    5    Wait Until Element Is Visible    ${el_card_number}
                Sleep   2s
                # Input Text    ${el_card_number}      5123 4567 8901 2346 
                
                #--------------------------------Acc no Testing------------------------------------
                Execute Javascript      document.getElementById("dcard_number").value='5123 4567 8901 2346'
                Sleep    2s
                Wait Until Element Is Visible        ${el_card_name}
                Execute Javascript      document.getElementById("dname_on_card").value='${card_name}'
                Sleep    1s
                Wait Until Element Is Visible        ${el_card_cvv}
                Execute Javascript      document.getElementById("dcvv_number").value='${card_cvv}'
                Sleep    3s
                
                #--------------------------------------------------------------------
                Wait Until Element Is Visible        ${el_card_month}
                Select From List By Label            ${el_card_month}        ${Ex_month}
               
                Sleep    3s
                Wait Until Element Is Visible        ${el_card_year}
                Select From List By Label            ${el_card_year}         ${Ex_year}
                
                Sleep    5s
            
                Wait Until Keyword Succeeds    3x    5    Wait Until Element Is Visible        ${el_make_paymnt}
                Click Element    ${el_make_paymnt}
                Wait Until Keyword Succeeds    3x    5    Wait Until Element Is Visible        ${el_payment_otp}
                # Type Into    ${el_payment_otp}    123456
                Execute Javascript      document.getElementById("password").value='123456'
                Sleep    3s
                Wait Until Element Is Visible    id:submitBtn
                Click Element    id:submitBtn
                Sleep    5s
                #-----------------------------------------------
                ${Transaction_result}        RPA.Browser.Selenium.Get Text               //*[@id="ContentPlaceHolder1_dv_success"]
                ${paymnt_Sucess_Vis}         RPA.Browser.Selenium.Is Element Visible     //*[contains(text(),"Success")]
                IF  ${paymnt_Sucess_Vis}
                #------------------------------------------------------------
                    Portal sign out        ${TestCase_Id}
                    Close All Browsers
                    Return From Keyword    PASS
                ELSE 
                    Portal sign out        ${TestCase_Id}
                    Close All Browsers
                    Return From Keyword    FAIL
                END
            END

        END
    END

    # Portal sign out        ${TestCase_Id}
    # Close All Browsers
    # Return From Keyword        PASS

Customer Profile
    #--------------------validating the customer profile KYC ID----------------------#
    [Arguments]          ${TestCase_Id}
    Portal Launching     ${TestCase_Id}
    Portal Login         ${TestCase_Id}
    Wait Until Keyword Succeeds    3x    5    Wait Until Element Is Visible        ${el_custmr_profile}
    Click Element When Visible        ${el_custmr_profile}
    Sleep   3s
    #------------------------Extracting the Document id-------------------------#
    ${Doc_id_Vis}     RPA.Browser.Selenium.Is Element Visible     ${el_doc_ID}
    IF  ${Doc_id_Vis}
        ${Extracted_doc_id}    RPA.Browser.Selenium.Get Text    ${el_doc_ID}
    END
    #-------------------------Extracting the ovd Number-------------------------#
    ${Ovd_no_Vis}     RPA.Browser.Selenium.Is Element Visible     ${el_ovd_no}
    IF  ${Ovd_no_Vis}
        ${Extracted_ovd_no}    RPA.Browser.Selenium.Get Text    ${el_ovd_no}
    END
    IF    '${Extracted_doc_id}' == '${Extracted_ovd_no}'
        Portal sign out        ${TestCase_Id}
        Sleep    2s
        Close All Browsers
        Return From Keyword        PASS
    ELSE
        Portal sign out        ${TestCase_Id}
        Sleep    2s
        Close All Browsers
        Return From Keyword        FAIL
    END
    

Download Pawn Ticket
    #-----------------------------validate the pawn ticket download------------------------------#
    [Arguments]          ${TestCase_Id}
    Portal Launching     ${TestCase_Id}
    Portal Login         ${TestCase_Id}
    ${Acc_no}=  Set Variable    ${details}[${TestCase_Id}][Acc_no]
    Wait Until Keyword Succeeds    3x    5    Wait Until Element Is Visible        ${el_downld_pawn_tickt}
    Click Element When Visible        ${el_downld_pawn_tickt}
    ${Acc_no_Vis}        RPA.Browser.Selenium.Is Element Visible        ${el_downld_acc_no}
    IF    ${Acc_no_Vis}
        ${Ext_Acc_no}    RPA.Browser.Selenium.Get Text    ${el_downld_acc_no}
        IF    '${Ext_Acc_no}' == '${Acc_no}'
            Wait Until Element Is Visible    ${el_downld_acc_no}
            Click Element    ${el_downld_acc_no}
            Wait Until Element Is Visible    ${el_OTP_request}
            Click Element    ${el_OTP_request}
            Sleep    3s
            ${otp}    Phone Link Application
            Wait Until Keyword Succeeds    3x    5    Wait Until Element Is Visible    ${el_otp_field}
            Input Text       ${el_otp_field}        ${otp}
            Click Element When Visible    ${el_otp_submit}
            #-----------------------------------------------------
            ${Otp_error_Vis}        RPA.Browser.Selenium.Is Element Visible        ${el_otp_err}
            IF    ${Otp_error_Vis}
                Sleep    2s
                Failure dialog
                Sleep    15s
                # Return From Keyword     fail
            END
            #---------------------------------------------------------------
            
            Wait Until Keyword Succeeds    3x    5    Wait Until Element Is Visible    ${el_language_english}
            Click Element    ${el_language_english}
            Sleep    2s
            Wait Until Keyword Succeeds    3x    5    Wait Until Element Is Visible    ${el_download}
            Click Element    ${el_download}
            Sleep    5s
            ${Doc_language}    Document_Language
            Close All Browsers
            Return From Keyword     PASS
        
        END
    END

Failure dialog
    Add icon      Failure
    Add heading   There was an OTP error
    Add text      Enter the OTP manually and try again 
    Show dialog    title=Failure
    Sleep    15s
    [Teardown]    Close all dialogs
    