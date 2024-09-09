*** Comments ***
Please place your login page actions here.


*** Variables ***
# Labels
${LABEL_ACCOUNT}                                //h1[text()='Account']

# Search Fields
${INPUT_SEARCH_FIELD}                           (//div/input[@name='query'])[1]

# Result Table
${TABLE_HEADER_USER_ID}                         //th[@data-testid = 'head_cell.0']/span[text() = 'User ID']
${TABLE_HEADER_COMPANY}                         //th[@data-testid = 'head_cell.1']/span[text() = 'Company']
${TABLE_HEADER_STATE}                           //th[@data-testid = 'head_cell.2']/span[text() = 'State']
${TABLE_HEADER_OTP}                             //th[@data-testid = 'head_cell.3']/span[text() = 'OTP']
${TABLE_HEADER_PACKAGE}                         //th[@data-testid = 'head_cell.4']/span[text() = 'Package']
${TABLE_HEADER_DEVICE}                          //th[@data-testid = 'head_cell.5']/span[text() = 'Device']
${TABLE_HEADER_PACKAGE_POLICY}                  //th[@data-testid = 'head_cell.6']/span[text() = 'Package Policy']
${TABLE_HEADER_DEVICE_POLICY}                   //th[@data-testid = 'head_cell.7']/span[text() = 'Device Policy']
${TABLE_HEADER_LAST_LOGIN}                      //th[@data-testid = 'head_cell.8']/span[text() = 'Last login']
${TABLE_HEADER_ACTIONS}                         //th[@data-testid = 'head_cell.9']/span[text() = 'Actions']

# Data in result table

${ALL_INSTANCE_SPAN}                            //tr/td/span/span
${USER_ID_RESULT_TABLE}                         //tr[count]/td[@data-testid='table-body-cell'][1]/span/span[contains(translate(text(), 'UPPER', 'lower'), 'value')]
${COMPANY_RESULT_TABLE}                         //tr[count]/td[@data-testid='table-body-cell'][2][contains(translate(text(), 'UPPER', 'lower'), 'value')]
${OTP_RESULT_TABLE}                             //tr[1]/td[@data-testid='table-body-cell'][4]
${ADMIN_ICON}                                   //span/*[@data-testid = 'SecurityIcon']
${PACKAGE_RESULT_TABLE}                         //tr[1]/td[@data-tooltip-id='68630-4']/span[text()='value']
${DEVICE_RESULT_TABLE}                          //tr[1]/td[@data-tooltip-id='68630-5']/span[text()='value']
${PACKAGE_POLICY_RESULT_TABLE}                  //tr[1]/td[@data-tooltip-id='68630-6']/span[text()='value']
${DEVICE_POLICY_RESULT_TABLE}                   //tr[1]/td[@data-tooltip-id='68630-7']/span[text()='value']

# Account Actions
${ELIPSIS}                                      (//div[@data-testid = 'list-header-action-button']/button)[1]
${ACCOUNT_EDIT_TXT}                             //div[@role='menuitem']/button/div[text()='Edit']
${ACCOUNT_RESET_OTP_TXT}                        //div[@role='menuitem']/button/div[text()='Reset OTP']
${ACCOUNT_RESET_PASSWORD_TXT}                   //div[@role='menuitem']/button/div[text()='Reset password']
${ACCOUNT_LOCK_TXT}                             //div[@role='menuitem']/button/div[text()='Lock']
${ACCOUNT_DELETE_TXT}                           //div[@role='menuitem']/button/div[text()='Delete']
${ACCOUNT_EDIT_BTN}                             //div[@role='menuitem']/button[@data-test='edit-button']
${ACCOUNT_RESET_OTP_BTN}                        //div[@role='menuitem']/button[@data-test='resetOtp-button']
${ACCOUNT_RESET_PASSWORD_BTN}                   //div[@role='menuitem']/button[@data-test='resetPassword-button']
${ACCOUNT_LOCK_BTN}                             //div[@role='menuitem']/button[@data-test='lockAccount-button']
${ACCOUNT_UNLOCK_BTN}                           //div[@role='menuitem']/button[@data-test='unlockAccount-button']
${ACCOUNT_DELETE_BTN}                           //div[@role='menuitem']/button[@data-test='delete-button']

# Edit Account
${EDIT_HEADER}                                  //div[@data-testid='modal-title'][text() = 'Edit value']
${EDIT_COMPANY}                                 //input[@name='companyName']
${EDIT_USER_TYPE}                               //div[@data-testid='userType']
${EDIT_PACKAGE_INFO}                            //div[@data-testid='select-packageInfoPermission']
${EDIT_DEVICE_INFO}                             //div[@data-testid='select-deviceInfoPermission']
${EDIT_DEVICE_POLICY}                           //div[@data-testid='select-devicePolicyPermission']
${EDIT_PACKAGE_POLICY}                          //div[@data-testid='select-packagePolicyPermission']
${SAVE_SUCCESS_TOASTER}                         //p[@data-test = 'toast-body'][text() = 'Account value has been updated']
${AUTH_BTN}                                     //div[@data-testid='select-value']/button
${AUTH_VALUE}                                   //div[@data-testid='select-value']/ul/div/li/span[text()='selected_value']

# Reset OTP
${WARNING_HEADER}                               //div[@data-testid='modal-title'][text() = 'Warning']
${OTP_MESSAGE}                                  //h4[text() = 'Confirm to reset OTP Secret?']

# Reset Password
${RESET_PASS_HEADER}                            //div[@data-testid='modal-title'][text() = 'Password Reset']
${RESET_PASS_PASS_LABEL}                        //div[text()='Password']
${RESET_PASS_CONFIRM_PASS_LABEL}                //div[text() = 'Confirm Password']
${RESET_PASS_PASS_REQUIRED}                     //div[text() = 'Password']/child::strong[text() = ' *']
${RESET_PASS_CONFIRM_PASS_REQUIRED}             //div[text() = 'Confirm Password']/child::strong[text() = ' *']
${RESET_PASS_PASS_INPUT}                        //input[@data-testid='input-password']
${RESET_PASS_CONFIRM_PASS_INPUT}                //input[@data-testid='input-confirmPass']
${RESET_PASS_SAVE_BTN}                          //input[@data-test='reset-pass']
${RESET_PASS_SUCCESS_TOASTER}                   //p[@data-test = 'toast-body'][text() = 'Password was successfully reset.']
${RESET_PASS_UNSUCCESS_TOASTER}                 //p[@data-test = 'toast-body'][text() = 'New password must be different than currently used password']

# Lock Unlock Account
${LOCK_ACCOUNT}                                 //h4[text() = 'Account lock']
${YES_BTN}                                      //div[text()='Yes']/parent::button
${NO_BTN}                                       //div[text()='No']/parent::button

# User Type
${USER_TYPES}                                   //button[@value = 'data']

${CATEGORY_RESULT_TABLE}                        //tr[count]/td[@data-testid='table-body-cell']/span[text() = 'value']
${STORE_RESULT_TABLE}                           //tr[count]/td[@data-testid='table-body-cell']/div[text() = 'value']
${TITLE_RESULT_TABLE}                           //tr[count]/td[@data-testid='table-body-cell'][3][contains(translate(text(), 'UPPER', 'lower'), 'value')]
${TITLE_FIRST_RESULT_TABLE}                     //tr[1]/td[@data-testid='table-body-cell'][3][contains(text(),'value')]
${PACKAGE_NAME_FIRST_RESULT_TABLE}              //tr[1]/td[@data-testid='table-body-cell'][4][contains(text(),'value')]
${PACKAGE_NAME_RESULT_TABLE}                    //tr[count]/td[@data-testid='table-body-cell'][4][contains(text(),'value')]
${PACKAGE_NAME_CASE_SENSITIVE_RESULT_TABLE}     //tr[count]/td[@data-testid='table-body-cell'][4][contains(translate(text(), 'UPPER', 'lower'), 'value')]

${LABEL_PACKAGE}                                //h1[text()='Package']
${INPUT_SEARCH_FIELD}                           //div/input[@name='query']
${BTN_CASE_SENSITIVE}                           //button[@title='Match case active']
${BTN_DELETE}                                   //div[@data-folded='false']//button[@data-test='delete-button']
${BTN_MOVE}                                     //div[@data-folded='false']//button[@data-test='move-button']
${BTN_ADD}                                      //div[@data-folded='false']//button[@data-test='add-button']

# ADD
${INPUT_PACKAGE_NAME_ADD}                       //input[@data-testid = 'input-name']
${INPUT_DEVELOPER_ADD}                          //input[@data-testid = 'input-seller']
${INPUT_COMMENT_ADD}                            //input[@data-testid = 'input-comment']
${INPUT_TITLE_ADD}                              //input[@data-testid = 'input-applicationName']
${INPUT_STORE_ADD}                              //select[@data-testid = 'input-storeField-store']
${RADIO_CATEGORY}                               //input[@id='category']

# MOVE
${MOVE_CATEGORY}                                //label[@for='category_selected']
${INPUT_COMMENT_MOVE}                           //input[@name = 'comment']
${BTN_MOVE_MODAL}                               //button[text()='Move']

# CHECKBOX
${CHECKBOX_PACKAGE}                             //button[@data-testid='table-checkbox']
