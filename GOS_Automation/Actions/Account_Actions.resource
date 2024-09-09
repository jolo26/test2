*** Comments ***
Please place your login actions here.


*** Settings ***
Resource    ../PageObjects/Login_Page.robot
Resource    ../Actions/Common_Actions.robot
Resource    ../TestData/Common.robot
Resource    ../TestData/Environment.robot
Resource    ../PageObjects/Account_Page_Object.resource
Library     ../Actions/totp.py
Library     RequestsLibrary


*** Keywords ***
Verify Account Page Component
    Element Should Be Visible    ${LABEL_ACCOUNT}
    Element Should Be Visible    ${INPUT_SEARCH_FIELD}
    Element Should Be Visible    ${TABLE_HEADER_USER_ID}
    Element Should Be Visible    ${TABLE_HEADER_COMPANY}
    Element Should Be Visible    ${TABLE_HEADER_STATE}
    Element Should Be Visible    ${TABLE_HEADER_OTP}
    Element Should Be Visible    ${TABLE_HEADER_PACKAGE}
    Element Should Be Visible    ${TABLE_HEADER_DEVICE}
    Element Should Be Visible    ${TABLE_HEADER_PACKAGE_POLICY}
    Element Should Be Visible    ${TABLE_HEADER_DEVICE_POLICY}
    Element Should Be Visible    ${TABLE_HEADER_LAST_LOGIN}
    Element Should Be Visible    ${TABLE_HEADER_ACTIONS}

Verify Account Table
    Element Should Be Visible    ${TABLE_HEADER_USER_ID}
    Element Should Be Visible    ${TABLE_HEADER_COMPANY}
    Element Should Be Visible    ${TABLE_HEADER_STATE}
    Element Should Be Visible    ${TABLE_HEADER_OTP}
    Element Should Be Visible    ${TABLE_HEADER_PACKAGE}
    Element Should Be Visible    ${TABLE_HEADER_DEVICE}
    Element Should Be Visible    ${TABLE_HEADER_PACKAGE_POLICY}
    Element Should Be Visible    ${TABLE_HEADER_DEVICE_POLICY}
    Element Should Be Visible    ${TABLE_HEADER_LAST_LOGIN}
    Element Should Be Visible    ${TABLE_HEADER_ACTIONS}

Get List of Data in the Table
    Sleep    5000
    ${account_list}    Create List    ${EMPTY}
    ${instance_count}    Get Element Count    ${ALL_INSTANCE_SPAN}
    Log To Console    ${instance_count}
    Log To Console    "Hey"
    # FOR    ${counter}    IN RANGE    ${instance_count}
    #    IF    ${counter % 2} != 0
    #    Log To Console    ${counter}
    #    ${name}    Get Text    ${ALL_INSTANCE_SPAN}
    #    Append To List    ${account_list} ${name}
    #    Log To Console    ${account_list}
    #    END

    # END

Verify Search Field User ID In Result Table
    [Arguments]    ${label}    ${value}
    ${row_count}    Get Element Count    ${ROW_RESULT_TABLE}
    IF    "${label}" == "User ID"
        FOR    ${counter}    IN RANGE    ${row_count-1}
            Element Should Be Visible
            ...    ${USER_ID_RESULT_TABLE.replace("count", "${counter + 1}").replace("UPPER","${value.upper()}").replace("lower","${value.lower()}").replace("value","${value.lower()}")}
        END
    ELSE IF    "${label}" == "Compnay"
        FOR    ${counter}    IN RANGE    ${row_count-1}
            Element Should Be Visible
            ...    ${COMPANY_RESULT_TABLE.replace("count", "${counter + 1}").replace("UPPER","${value.upper()}").replace("lower","${value.lower()}").replace("value","${value.lower()}")}
        END
    END

Click Ellipsis
    Wait And Click Element    ${ELIPSIS}

Click Edit Account
    Wait And Click Element    ${ACCOUNT_EDIT_BTN}

Click Reset OTP Account
    Wait And Click Element    ${ACCOUNT_RESET_OTP_BTN}

Click Reset Password Account
    Wait And Click Element    ${ACCOUNT_RESET_PASSWORD_BTN}

Click Lock Unlock No Button
    Wait And Click Element    ${NO_BTN}
    Wait Until Element Is Not Visible    ${progress_bar}

Click Lock Unlock Yes Button
    Wait And Click Element    ${YES_BTN}
    Wait Until Element Is Not Visible    ${progress_bar}

Click Lock Unlock Account
    [arguments]    ${action}
    IF    "${action}" == "LOCK"
        Wait And Click Element    ${ACCOUNT_LOCK_BTN}
    END
    IF    "${action}" == "UNLOCK"
        Wait And Click Element    ${ACCOUNT_UNLOCK_BTN}     
    END

Select Account Authority
    [arguments]    ${module}    ${auth}
    Wait And Click Element    ${AUTH_BTN.replace("value", "${module}")}
    IF    "${auth}" == "Editable"
        Wait And Click Element    ${AUTH_VALUE.replace("selected_value", "${auth}").replace("value", "${module}")}  
    END
    IF    "${auth}" == "Read Only"
        Wait And Click Element    ${AUTH_VALUE.replace("selected_value", "${auth}").replace("value", "${module}")}  
    END
    IF    "${auth}" == "None"
        Wait And Click Element    ${AUTH_VALUE.replace("selected_value", "${auth}").replace("value", "${module}")}  
    END
    RETURN    ${auth}

# Select Package Authority
#     [arguments]    ${package_auth}
#     Wait And Click Element    ${PACKAGE_INFO_AUTH_BTN}
#     IF    "${package_auth}" == "Editable"
#         Wait And Click Element    ${PACKAGE_AUTH.replace("value", "${package_auth}")}  
#     END
#     IF    "${package_auth}" == "Read Only"
#         Wait And Click Element    ${PACKAGE_AUTH.replace("value", "${package_auth}")}  
#     END
#     IF    "${package_auth}" == "None"
#         Wait And Click Element    ${PACKAGE_AUTH.replace("value", "${package_auth}")}  
#     END

# Select Device Authority
#     [arguments]    ${device_auth}
#     Wait And Click Element    ${DEVICE_AUTH_BTN}
#     IF    "${device_auth}" == "Editable"
#         Wait And Click Element    ${DEVICE_AUTH.replace("value", "${device_auth}")}  
#     END
#     IF    "${device_auth}" == "Read Only"
#         Wait And Click Element    ${DEVICE_AUTH.replace("value", "${device_auth}")}  
#     END
#     IF    "${device_auth}" == "None"
#         Wait And Click Element    ${DEVICE_AUTH.replace("value", "${device_auth}")}  
#     END

# Select Device Policy Authority
#     [arguments]    ${device_policy_auth}
#     Wait And Click Element    ${DEVICE_POLICY_AUTH_BTN}
#     IF    "${device_policy_auth}" == "Editable"
#         Wait And Click Element    ${DEVICE_POLICY_AUTH.replace("value", "${device_policy_auth}")}  
#     END
#     IF    "${device_policy_auth}" == "Read Only"
#         Wait And Click Element    ${DEVICE_POLICY_AUTH.replace("value", "${device_policy_auth}")}  
#     END
#     IF    "${device_policy_auth}" == "None"
#         Wait And Click Element    ${DEVICE_POLICY_AUTH.replace("value", "${device_policy_auth}")}  
#     END

# Select Package Policy Authority
#     [arguments]    ${package_policy_auth}
#     Wait And Click Element    ${PACKAGE_POLICY_AUTH_BTN}
#     IF    "${package_policy_auth}" == "Editable"
#         Wait And Click Element    ${PACKAGE_POLICY_AUTH.replace("value", "${package_policy_auth}")}  
#     END
#     IF    "${package_policy_auth}" == "Read Only"
#         Wait And Click Element    ${PACKAGE_POLICY_AUTH.replace("value", "${package_policy_auth}")}  
#     END
#     IF    "${package_policy_auth}" == "None"
#         Wait And Click Element    ${PACKAGE_POLICY_AUTH.replace("value", "${package_policy_auth}")}  
#     END

Verify Account Options
    Element Should Be Visible    ${ACCOUNT_EDIT_BTN}
    Element Should Be Visible    ${ACCOUNT_RESET_OTP_BTN}
    Element Should Be Visible    ${ACCOUNT_RESET_PASSWORD_BTN}
    Element Should Be Visible    ${ACCOUNT_LOCK_BTN}
    Element Should Be Visible    ${ACCOUNT_DELETE_BTN}
    Element Should Be Visible    ${ACCOUNT_EDIT_TXT}
    Element Should Be Visible    ${ACCOUNT_RESET_OTP_TXT}
    Element Should Be Visible    ${ACCOUNT_RESET_PASSWORD_TXT}
    Element Should Be Visible    ${ACCOUNT_LOCK_TXT}
    Element Should Be Visible    ${ACCOUNT_DELETE_TXT}

Verify Data Table Settings Component in Account Page
    Element Should Be Visible    ${able_settings_header}
    Element Should Be Visible    ${table_settings_toggle}
    Element Should Be Visible    ${table_settings_cancel_btn}
    Element Should Be Visible    ${table_settings_save_btn}
    Element Should Be Visible    ${table_settings_cancel_txt}
    Element Should Be Visible    ${table_settings_save_txt}

Verify Account Edit Modal
    [Arguments]    ${user_id}
    Element Should Be Visible    ${EDIT_HEADER.replace("value", "${user_id}")}
    Element Should Be Visible    ${EDIT_COMPANY}
    Element Should Be Visible    ${EDIT_USER_TYPE}
    Element Should Be Visible    ${EDIT_PACKAGE_INFO}
    Element Should Be Visible    ${EDIT_DEVICE_INFO}
    Element Should Be Visible    ${EDIT_DEVICE_POLICY}
    Element Should Be Visible    ${EDIT_PACKAGE_POLICY}
    Element Should Be Visible    ${account_cancel_btn}
    Element Should Be Visible    ${account_save_btn}

Verify Account Reset OTP Modal
    Element Should Be Visible    ${WARNING_HEADER}
    Element Should Be Visible    ${OTP_MESSAGE}
    Element Should Be Visible    ${account_cancel_btn}
    Element Should Be Visible    ${account_reset_btn}

Verify Lock Unlock Modal
    Element Should Be Visible    ${WARNING_HEADER}
    Element Should Be Visible    ${LOCK_ACCOUNT}
    Element Should Be Visible    ${YES_BTN}
    Element Should Be Visible    ${NO_BTN}

Verify Account Reset Password Modal
    Element Should Be Visible    ${RESET_PASS_HEADER}
    Element Should Be Visible    ${RESET_PASS_PASS_LABEL}
    Element Should Be Visible    ${RESET_PASS_CONFIRM_PASS_LABEL}
    Element Should Be Visible    ${RESET_PASS_PASS_REQUIRED}
    Element Should Be Visible    ${RESET_PASS_CONFIRM_PASS_REQUIRED}
    Element Should Be Visible    ${RESET_PASS_PASS_INPUT}
    Element Should Be Visible    ${RESET_PASS_CONFIRM_PASS_INPUT}
    Element Should Be Visible    ${btn_cancel}
    Element Should Be Visible    ${RESET_PASS_SAVE_BTN}

Verify Locked Account
    Element Should Be Visible    ${ACCOUNT_UNLOCK_BTN}

Verify Unlocked Account
    Element Should Be Visible    ${ACCOUNT_LOCK_BTN}
    
Verify Admin User Type
    [Arguments]    ${user_id}
    Element Should Be Visible    ${ADMIN_ICON}
    Element Should Be Visible
    ...    ${USER_ID_RESULT_TABLE.replace("count", "1").replace("UPPER","${user_id.upper()}").replace("lower","${user_id.lower()}").replace("value","${user_id.lower()}")}

Verify User User Type
    [Arguments]    ${user_id}
    Element Should Not Be Visible    ${ADMIN_ICON}
    Element Should Be Visible
    ...    ${USER_ID_RESULT_TABLE.replace("count", "1").replace("UPPER","${user_id.upper()}").replace("lower","${user_id.lower()}").replace("value","${user_id.lower()}")}

    
Verify Saved Authority
    [Arguments]    ${user_id}    ${package_auth}    ${device_auth}    ${device_policy_auth}    ${package_policy_auth}
    Element Should Be Visible
    ...    ${USER_ID_RESULT_TABLE.replace("count", "1").replace("UPPER","${user_id.upper()}").replace("lower","${user_id.lower()}").replace("value","${user_id.lower()}")}
    ...    
    Element Should Be Visible    ${PACKAGE_RESULT_TABLE.replace("value", "${package_auth}")}
    Element Should Be Visible    ${DEVICE_RESULT_TABLE.replace("value", "${device_auth}")}
    Element Should Be Visible    ${PACKAGE_POLICY_RESULT_TABLE.replace("value", "${package_policy_auth}")}
    Element Should Be Visible    ${DEVICE_POLICY_RESULT_TABLE.replace("value", "${device_policy_auth}")}

Verify Successful Toaster
    [Arguments]    ${user_id}
    Sleep    2s
    Element Should Be Visible    ${SAVE_SUCCESS_TOASTER.replace("value", "${user_id}")}

Verify OTP has Changed
    [Arguments]    ${otp}
    Element Text Should Not Be    ${OTP_RESULT_TABLE}    ${otp}

Select User Type
    [Arguments]    ${user_type}
    Wait And Click Element    ${USER_TYPES.replace("data", "${user_type}")}

Click Account Save
    Wait And Click Element    ${account_save_btn}

Click Account Reset
    Wait And Click Element    ${account_reset_btn}
    Wait Until Element Is Not Visible    ${progress_bar}

Click Reset Password Save
    Wait And Click Element    ${RESET_PASS_SAVE_BTN}
    Wait Until Element Is Not Visible    ${progress_bar}

Click Account Cancel
    Wait And Click Element    ${account_cancel_btn}

Get Account OTP
    ${otp}    Get Text    ${OTP_RESULT_TABLE}
    RETURN    ${otp}

Input Account Password
    [Arguments]    ${password}
    Wait And Input Password    ${RESET_PASS_PASS_INPUT}    ${password}

Input Account Confirm Password
    [Arguments]    ${confirm_password}
    Wait And Input Password    ${RESET_PASS_CONFIRM_PASS_INPUT}    ${confirm_password}

Verify Reset Password Success Toaster
    Element Should Be Visible    ${RESET_PASS_SUCCESS_TOASTER}

Verify Reset Password Unsuccess Toaster
    Element Should Be Visible    ${RESET_PASS_UNSUCCESS_TOASTER}



# Search By Category
#    [Arguments]    ${category}
#    Wait And Click Element    ${CATEGORY_DROP_DOWN}
#    Wait And Click Element    ${CATEGORY_DROP_DOWN_OPTIONS.replace("value", "${category}")}
#    Wait Until Element Is Not Visible    ${PROGRESS_BAR}

# Search By Store
#    [Arguments]    ${store}
#    Wait And Click Element    ${STORE_DROP_DOWN}
#    Wait And Click Element    ${STORE_DROP_DOWN_OPTIONS.replace("value", "${store}")}
#    Wait Until Element Is Not Visible    ${PROGRESS_BAR}

# Select Search Field In Package Info
#    [Arguments]    ${search_field}

#    Wait And Click Element    ${SEARCH_FIELD_DROP_DOWN}
#    Wait And Click Element    ${SEARCH_FIELD_DROP_DOWN_OPTIONS.replace("value", "${search_field}")}

# Select Case Sensitivity
#    [Arguments]    ${is_case_sensitive}=${True}
#    IF    ~${is_case_sensitive}
#    Wait And Click Element    ${CASE_SENSITIVE_BTN}
#    END

# Input Data In Seach Field In Package Info
#    [Arguments]    ${value}
#    Press Keys    ${INPUT_FIELD}    CTRL+A    BACKSPACE
#    Wait And Input Text    ${INPUT_FIELD}    ${value}

# Verify Category In Result Table
#    [Arguments]    ${label}
#    ${row_count}    Get Element Count    ${ROW_RESULT_TABLE}
#    FOR    ${counter}    IN RANGE    ${row_count-1}
#    Element Should Be Visible
#    ...    ${CATEGORY_RESULT_TABLE.replace("count", "${counter + 1}").replace("value","${label}")}
#    END

# Verify Store In Result Table
#    [Arguments]    ${label}
#    ${row_count}    Get Element Count    ${ROW_RESULT_TABLE}
#    FOR    ${counter}    IN RANGE    ${row_count}
#    Element Should Be Visible
#    ...    ${STORE_RESULT_TABLE.replace("count", "${counter + 1}").replace("value","${label}")}
#    END

# Verify Search Field In Result Table
#    [Arguments]    ${label}    ${value}    ${is_case_sensitive}=${True}
#    ${row_count}    Get Element Count    ${ROW_RESULT_TABLE}
#    IF    "${label}" == "Title"
#    FOR    ${counter}    IN RANGE    ${row_count-1}
#    Element Should Be Visible
#    ...    ${TITLE_RESULT_TABLE.replace("count", "${counter + 1}").replace("UPPER","${value.upper()}").replace("lower","${value.lower()}").replace("value","${value.lower()}")}
#    END
#    ELSE IF    "${label}" == "Package Name"
#    FOR    ${counter}    IN RANGE    ${row_count-1}
#    IF    ~${is_case_sensitive}
#    Element Should Be Visible
#    ...    ${PACKAGE_NAME_CASE_SENSITIVE_RESULT_TABLE.replace("count", "${counter + 1}").replace("UPPER","${value.upper()}").replace("lower","${value.lower()}").replace("value","${value.lower()}")}
#    ELSE
#    Element Should Be Visible
#    ...    ${PACKAGE_NAME_RESULT_TABLE.replace("count", "${counter + 1}").replace("value","${value}")}
#    END
#    END
#    END

# Click Searched Package
#    [Arguments]    ${package_name}
#    Wait And Click Element    ${PACKAGE_NAME_FIRST_RESULT_TABLE.replace("value","${package_name}")}
#    Wait Until Element Is Not Visible    ${PROGRESS_BAR}

# Click Checkbox For Package
#    Wait And Click Element    ${CHECKBOX_PACKAGE}

# Click Move
#    Wait And Click Element    ${BTN_MOVE}

# Click Move In Modal
#    Wait And Click Element    ${BTN_MOVE_MODAL}

# Select Category For Move
#    [Arguments]    ${selected_value}
#    Wait And Click Element    ${MOVE_CATEGORY.replace('selected', '${selected_value.upper()}').replace(' ', '_')}

# Verify Package Details Page Component
#    Element Should Be Visible    ${DETAILS_TITLE.replace('title', 'Package Information')}
#    Element Should Be Visible    ${DETAILS_LABEL.replace('field_label', 'Category')}
#    Element Should Be Visible    ${DETAILS_LABEL.replace('field_label', 'Package Name')}
#    Element Should Be Visible    ${DETAILS_LABEL.replace('field_label', 'Developer')}
#    Element Should Be Visible    ${DETAILS_LABEL.replace('field_label', 'Created')}
#    Element Should Be Visible    ${DETAILS_LABEL.replace('field_label', 'Game Title')}
#    Element Should Be Visible    ${DETAILS_LABEL.replace('field_label', 'Store')}
#    Element Should Be Visible    ${DETAILS_LABEL.replace('field_label', 'Updated')}
#    Element Should Be Visible    ${DETAILS_TITLE.replace('title', 'Update History')}
#    Element Should Be Visible    ${DETAILS_HISTORY_COLUMN_0.replace('column', 'Update Date')}
#    Element Should Be Visible    ${DETAILS_HISTORY_COLUMN_1.replace('column', 'Author')}
#    Element Should Be Visible    ${DETAILS_HISTORY_COLUMN_2.replace('column', 'Action')}
#    Element Should Be Visible    ${DETAILS_HISTORY_COLUMN_3.replace('column', 'Updated Items')}
#    Element Should Be Visible    ${DETAILS_HISTORY_COLUMN_4.replace('column', 'History Comment')}

# Verify Error Message Field
#    [Arguments]    ${error}
#    Element Should Be Visible    ${ERROR_REQUIRED_FIELD.replace('error_message', '${error}')}

# Verify Toast Error Message
#    [Arguments]    ${error}
#    Element Should Be Visible    ${MODAL_ERROR_MESSAGE.replace('error', '${error}')}

# Click Package Name In Add Package
#    Wait And Click Element    ${INPUT_PACKAGE_NAME_ADD}

# Click Title In Add Package
#    Wait And Click Element    ${INPUT_TITLE_ADD}

# Click Developer In Add Package
#    Wait And Click Element    ${INPUT_DEVELOPER_ADD}

# Click History Comment In Add Package
#    Wait And Click Element    ${INPUT_COMMENT_ADD}

# Input Package Name In Add Package
#    [Arguments]    ${package_name}
#    Wait And Input Text    ${INPUT_PACKAGE_NAME_ADD}    ${package_name}

# Input Developer In Add Package
#    [Arguments]    ${developer}
#    Wait And Input Text    ${INPUT_DEVELOPER_ADD}    ${developer}

# Input History Comment In Add Package
#    [Arguments]    ${comment}
#    Wait And Input Text    ${INPUT_COMMENT_ADD}    ${comment}

# Input History Comment In Move Package
#    [Arguments]    ${comment}
#    Wait And Input Text    ${INPUT_COMMENT_MOVE}    ${comment}

# Input Game Title In Add Package
#    [Arguments]    ${title}
#    Wait And Input Text    ${INPUT_TITLE_ADD}    ${title}

# Select Store In Add Package
#    [Arguments]    ${store}
#    Wait And Select From List    ${INPUT_STORE_ADD}    ${store}

# Select Package Category
#    [Arguments]    ${category}
#    Wait And Click Element    ${RADIO_CATEGORY.replace('category', '${category}')}

# Clear Field Value
#    [Arguments]    ${field}
#    IF    '${field}' == 'title'
#    Press Keys    ${INPUT_TITLE_ADD}    CTRL+A    BACKSPACE
#    END
#    IF    '${field}' == 'developer'
#    Press Keys    ${INPUT_DEVELOPER_ADD}    CTRL+A    BACKSPACE
#    END
