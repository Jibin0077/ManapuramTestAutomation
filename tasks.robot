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
Resource            Subflow.robot
Resource            Payment_Flow.robot


*** Keywords ***
MAIN FLOW
    ${File}     current_diectory
    Data Collection

    # Log To Console    ${CONFIG}[URL]

    ${data}     Filtering Data
    FOR    ${element}    IN    @{data}
        Log To Console    ${element}[TestName]
        ${TestCase_Id}       Set Variable        ${element}[TestCase_Id]
        ${Delay}      get_delay        ${element}[TestName]
        Sleep    ${Delay}
        ${status}   ${Reason}  Run Keyword And Ignore Error          ${element}[TestName]      ${TestCase_Id}
        IF     '${status}' == 'PASS'
            # Notebook Print       ${TestCase_Id} 
            update_excel_value    ${File}    TEST CASE ID    ${TestCase_Id}    Status    ${status}
        ELSE 
            Close All Browsers
            update_excel_value    ${File}    TEST CASE ID    ${TestCase_Id}    Status    FAIL
        END
    END
    Sleep    2s
    Close All Browsers
    
# *** Tasks ***
# Debugging process
#     MAIN FLOW