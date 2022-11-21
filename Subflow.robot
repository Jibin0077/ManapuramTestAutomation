*** Settings ***
Documentation       Template robot main suite.
Library             RPA.Browser.Selenium
Library             RPA.core.notebook
Library             Collections
Library             MyLibrary
Resource            keywords.robot
Variables           variables.py
Variables           MyVariables.py
Library             RPA.Excel.Files
Library             RPA.FileSystem
Library             Data.py
Variables           selectors.py
Library             Excel_Activity.py
Library             RPA.HTTP
Library             RPA.Tables
  

*** Keywords ***
Config Data Collection
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
#------------- launching Internet Archive URL successfully ---------#
Portal Launching
    Config Data Collection
    ${URL}        Set Variable    ${CONFIG}[URL]
    create_csv
    Open Available Browser         ${URL}      maximized=${True}
    Sleep  10s
    Ad Donation Banner Closing
    Wait Until keyword Succeeds     5x        5sec         Wait Until Element Is Visible   ${el_img_count}
    #----------------------------------
    # ${Srch_count}      Set Variable        2
    # FOR    ${i}    IN RANGE   ${Srch_count}
    #     Execute Javascript     window.scrollTo(0,document.body.scrollHeight)
    #     Sleep  5s
    # END
    #-------------------------------------
    
    #--------------Total count of images in starting page--------------------
    ${Count}     Get Element Count       ${el_img_count}
    Notebook Print    ${Count}
    #---------------------------------------------------------------
    # ${Count}     Set Variable    ${Count}
    # create_csv
    # ${i}     Set Variable        1
    FOR    ${i}    IN RANGE   0  ${Count}  2

        Wait Until keyword Succeeds     5x        5sec         Click Element    //*[@id="ikind-titleSorter"]/div/div[${i*1+2}]/div[2]/div[1]/a/div[1]/img  CTRL
        Sleep  1s
        Switch Window     New
        Ad Donation Banner Closing
        Book Details Extraction
        # Write table to CSV    ${table}     Archeive_output.csv    delimiter=|
        Close Window
        Sleep   1s
        Switch Window    main
        
    END
    

*** Keywords ***
Ad Donation Banner Closing
    #----------------Closing the Donation Banner------------------
    ${Donation_Vis}        Is Element Visible    ${el_donation_Vis}
    IF    ${Donation_Vis}
        Click Element When Visible    ${el_donation_Vis}   
    END
    #---------------------------------------------------------------

*** Keywords ***
#---------Collecting "Title, Author, Publication date, Publisher, Collection, Contributor, Identifier, Copyright, Image file name" from Web---------------
Book Details Extraction
    # ${path}       current_diectory     
    ${Ext_Title}          Get Text      ${el_title}
    ${Ext_Author}         Get Text      ${el_Author}
    #------------------------------------------------------
    ${publ_date_Vis}      Is Element Visible         ${el_Publication_date}
    IF    ${publ_date_Vis}
        ${Ext_Publ_date}          Get Text           ${el_Publication_date}
    ELSE
        ${Ext_Publ_date}          Set Variable    0
    END
    #------------------------------------------------
    ${publisher_Vis}      Is Element Visible         ${el_Publisher}
    IF    ${publisher_Vis}
        ${Ext_Publisher}          Get Text           ${el_Publisher}
    ELSE
        ${Ext_Publisher}          Set Variable    0
    END
    #-------------------------------------------------
    ${Collection_Vis}      Is Element Visible        ${el_Collection}
    IF    ${Collection_Vis}
        ${Ext_Collection}         Get Text           ${el_Collection}
    ELSE
        ${Ext_Collection}         Set Variable    0
    END
    #----------------------------------------------
    ${Contributor_Vis}      Is Element Visible       ${el_Contributor}
    IF    ${Contributor_Vis}
        ${Ext_Contributor}        Get Text           ${el_Contributor}
    ELSE
        ${Ext_Contributor}        Set Variable    0
    END
    #------------------------------------------------
    ${Identifier_Vis}      Is Element Visible        ${el_Identifier}
    IF    ${Identifier_Vis}
        ${Ext_Identifier}         Get Text           ${el_Identifier}
    ELSE
        ${Ext_Identifier}         Set Variable    0
    END
    #----------------Copyright------------------
    ${Ext_Copyright}        Set Variable        0
    #---------------Extracting pdf Name--------------------------------
    ${pdf_link}=       Get Element Attribute       //*[@class="format-group"]//*[contains(text(),"PDF")]     href  
    ${Ext_pdf_name}     pdf_name        ${pdf_link} 
    ${DOWNLOAD_DIR}     Set Variable    ${CONFIG}[Down_dir]
    # Download       ${pdf_link}        target_file=${DOWNLOAD_DIR}
    
    
    ${header_list}      Create List     Title     Author    Publication date    Publisher    Collection    Contributor    Identifier    Copyright    image file name
    # ${table}=     Create Table      columns=${header_list} 
    # append_to_csv    out.csv        ${data_list}
    ${data_list}    Create List     ${Ext_Title}    ${Ext_Author}     ${Ext_Publ_date}     ${Ext_Publisher}     ${Ext_Collection}     ${Ext_Contributor}     ${Ext_Identifier}     ${Ext_Copyright}     ${Ext_pdf_name}
    append_to_csv    Internet_Archive_out.csv        ${data_list}
    # Add Table Row     ${table}      ${data_list}
    # ${out_data}=	Catenate	SEPARATOR=|    ${Ext_Title}    ${Ext_Author}     ${Ext_Publ_date}     ${Ext_Publisher}     ${Ext_Collection}     ${Ext_Contributor}     ${Ext_Identifier}     ${Ext_Copyright}    ${Ext_pdf_name} 
    # Write table to CSV    ${table}     Archeive_output.csv    delimiter=|
    # Append To File        Archeive_output.csv    ${out_data}
    # Return From Keyword     ${table}
    # append_to_csv       out.csv 


