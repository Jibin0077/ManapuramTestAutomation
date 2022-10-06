#-----------------------------------------Login and text Validation----------------------------------------#

el_Username = 'xpath://*[@id="username"]'
el_password = 'xpath://*[@id="password"]'
el_Login = 'xpath://*[@id="txt_login"]'
el_Login_error = '//*[contains(text(),"Sorry! you have tried to enter invalid credentials")]'
el_text_validation = '//div[contains(text(),"Welcome To Manappuram Finance Limited Customer eService Portal")]'
#-----------------------------------------------------------------------------------------------------------#

el_quickpay = '//*[@id="expresspay"]'
el_email = '//*[@id="modal"]//*[@id="Img1"]'
el_user_validation = 'xpath://*[@id="lbl_user_id"]'
el_signout = '//*[@class="top-links"]//*[contains(text(),"Sign Out")]'
el_payTm = '//*[@class="d-flex flex-row justify-content-center my-5"]//*[@class="card mx-4 card-design"][2]'

#-----------------------Payment Processing and KYC Validations-----------------------------------#
el_mak_paymt = '//*[contains(text(),"Make Payment")]'
el_acc_table = '//table[@id="ContentPlaceHolder1_gv_homedata"]//tbody/tr/td[1]'
el_custmr_profile = '//*[contains(text(),"Customer Profile")]'
el_doc_ID = '//*[@id="ContentPlaceHolder1_doc_no"]'
el_ovd_no = '//*[@id="ContentPlaceHolder1_ovd_no"]'

#--------------------------Making Payment--------------------------------#
el_part_paymt = '//*[@id="txt_PartAmount"]'
el_pay_btn = '//*[@class="spl table"]//*[@id="btn_paypart"]'
el_Debit_card = '//*[@id="ContentPlaceHolder1_DBCDTEST"]'
el_rupay_card = '//*[@id="ContentPlaceHolder1_RPAY"]'
el_payU_img = '//*[@class="rc ui-tabs-tab ui-state-default ui-tab ui-corner-left"]//*[@id="Img8"]'
el_proceed_btn = '//*[@id="ContentPlaceHolder1_btn_paynow1"]'

#-------------------------Download Pawn Ticket-----------------------#
el_downld_pawn_tickt = '//*[contains(text(),"Download Pawn Ticket")]'
el_downld_acc_no = '//table[@id="ContentPlaceHolder1_gv_homedata"]/tbody/tr/td[1]'
el_OTP_request = '//*[@class="account table"]//*[contains(text(),"OTP")]'
el_otp_field = '//*[@id="qp_txt1"]'
el_otp_submit = '//*[@id="modal"]/div[4]/img'
el_language_english = '//*[@id="ContentPlaceHolder1_rd_english"]'
el_download = '//*[@id="ContentPlaceHolder1_btn_download"]'
el_otp_err = '//*[@class="modal"]//*[contains(text(),"Invalid OTP Entered...")]'

#--------------------Card Payment--------------------#
el_card_type = '//*[@id="payment-box"]//*[@id="debit_card_select"]'
el_card_number = '//*[@class="dc-form"]//*[@id="dcard_number"]'
el_card_name = '//*[@class="dc-form"]//*[@id="dname_on_card"]'
el_card_cvv = '//*[@class="dc-form"]//*[@id="dcvv_number"]'
el_card_month = '//*[@id="dexpiry_date_month"]'
el_card_year = '//*[@id="dexpiry_date_year"]'
el_make_paymnt = '//*[@class="payment-buttons append-bottom"]//*[@id="pay_button"]'
el_payment_otp = '//*[@id="password"]'
