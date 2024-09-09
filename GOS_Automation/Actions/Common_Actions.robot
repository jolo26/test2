*** Settings ***
Library    SeleniumLibrary
Resource    ../PageObjects/Login_Page.robot
Resource    ../PageObjects/Common_Page_Object.robot
Resource    ExtendSeleniumActions.robot

*** Keywords ***
Logout User
    Wait And Click Element   ${logout_btn}
    Close Browser

Cancel Action
    Click Button  Cancel

Navigate to Module
    [Arguments]    ${component}
    IF    "${component}" == "Package"
        Wait And Click Element    ${module.replace('hrefloc',"/packages")}  
    END
    IF    "${component}" == "Package Policy"
        Wait And Click Element    ${module.replace('hrefloc',"/package-policy")}  
    END
    IF    "${component}" == "Device Manager"
        Wait And Click Element    ${module_device}
        Wait And Click Element    ${module.replace('hrefloc',"/devices/device-manager")}  
    END
    IF    "${component}" == "Device Group Manager"
        Wait And Click Element    ${module_device}
        Wait And Click Element    ${module.replace('hrefloc',"/devices/device-group-manager")}  
    END
    IF    "${component}" == "Product Manager"
        Wait And Click Element    ${module_device}
        Wait And Click Element    ${module.replace('hrefloc',"/devices/product-manager")}  
    END
    IF    "${component}" == "Device Group Policy"
        Wait And Click Element    ${module.replace('hrefloc',"/device-group-policy")}  
    END
    IF    "${component}" == "Account"
        Wait And Click Element    ${module.replace('hrefloc',"/account/accounts")}  
    END
    IF    "${component}" == "History-Package"
        Wait And Click Element    ${module_history}
        Wait And Click Element    ${module.replace('hrefloc',"/history/package-info-history")}  
    END
    IF    "${component}" == "History-Package Policy"
        Wait And Click Element    ${module_history}
        Wait And Click Element    ${module.replace('hrefloc',"/history/package-policy-history")}  
    END
    IF    "${component}" == "History-Device Manager"
        Wait And Click Element    ${module_history}
        Wait And Click Element    ${module.replace('hrefloc',"/history/device-manager-history")}  
    END
    IF    "${component}" == "History-Device Group Manager"
        Wait And Click Element    ${module_history}
        Wait And Click Element    ${module.replace('hrefloc',"/history/device-group-manager-history")}  
    END
    IF    "${component}" == "History-Product Manager"
        Wait And Click Element    ${module_history}
        Wait And Click Element    ${module.replace('hrefloc',"/history/product-manager-history")}  
    END
    IF    "${component}" == "History-Device Group Policy"
        Wait And Click Element    ${module_history}
        Wait And Click Element    ${module.replace('hrefloc',"/history/device-group-history")}  
    END
    Wait Until Element Is Not Visible    ${progress_bar}

Click Search
    Wait And Click Element    ${search_btn}
    Wait Until Element Is Not Visible    ${progress_bar}
    
Click Edit
    Wait And Click Element    ${btn_edit}
    Wait Until Element Is Not Visible    ${progress_bar}

Click Data Table Settings
    Wait And Click Element    ${table_settings_btn}
    Wait Until Element Is Not Visible    ${progress_bar}

Input Device Group
    [Arguments]    ${device_group}
    Press Keys    ${input_field}    CTRL+A    BACKSPACE
    Wait And Input Text    ${input_field}    ${device_group}

Select Case Sensitive or Case Insensitive
    [Arguments]    ${case_sensitivity}='Case Sensitive'
    ${title}    Get Element Attribute    ${case}    title
    Log To Console    ${title}
    IF    '${case_sensitivity}' == 'Case Sensitive'
        IF    '${title}' == 'Match case inactive'
            Wait And Click Element    ${case_insensitive_btn}     
        END
    ELSE IF    '${case_sensitivity}' == 'Case Insensitive'
            IF    '${title}' == 'Match case active'
                Wait And Click Element    ${case_sensitive_btn}     
            END
    END

Input Package Name
    [Arguments]    ${package_name}
    Press Keys    ${input_field}    CTRL+A    BACKSPACE
    Wait And Input Text    ${input_field}   ${package_name}

Input Package Name in Package Policy
    [Arguments]    ${package_name}
    Press Keys    ${input_package_name}    CTRL+A    BACKSPACE
    Wait And Input Text    ${input_package_name}   ${package_name}
Input Title
    [Arguments]    ${title}
    Press Keys    ${input_field}    CTRL+A    BACKSPACE
    Wait And Input Text    ${input_field}   ${title}

Input User ID
    [Arguments]    ${user_id}
    Press Keys    ${input_field}    CTRL+A    BACKSPACE
    Wait And Input Text    ${input_field}   ${user_id}
    RETURN    ${user_id}

Select Package Name or Title
    [Arguments]    ${selected}
    Wait And Click Element    ${select}
    Wait And Click Element    ${selected_value.replace('value', '${selected}')}


Select Equals or Begin with
    [Arguments]    ${is_begin_with}='Begin with'
    IF    '${is_begin_with}' == 'Begin with'
        Wait And Click Element    ${equals_begins}
        Set Selenium Implicit Wait    2s
        Wait And Click Element    ${begin_with}
    ELSE
        Wait And Click Element    ${equals_begins}
        Set Selenium Implicit Wait    2s
        Wait And Click Element    ${equals}
    END

Click Add Button
    Wait And Click Element    ${btn_add}

Click Save Button
    Wait And Click Element    ${btn_save}
    Wait Until Element Is Not Visible    ${progress_bar}


Click Cancel Button
    Wait And Click Element    ${btn_cancel}

Click Cancel Data Table Button
    Wait And Click Element    ${table_settings_cancel_btn}

Click List Button
    Wait And Click Element    ${btn_list}

Click List Button In Hstory
    Wait And Click Element    ${btn_list_history}

Select Package Using Category
    [Arguments]    ${category}
    Wait And Click Element    ${category_all}
    Wait And Click Element    ${selected_value.replace('value','${category}')}

Verify Package Category in Result Table
    [Arguments]    ${label}
    ${row_count}    Get Element Count    ${row_result_table}
    FOR    ${counter}    IN RANGE    ${row_count}
        Wait Until Element Is Visible    ${category_result_table.replace("count", "${counter}").replace("value","${label}")}
        
    END

Search Package
    [Arguments]    ${search_field}    ${package_name}
    Select Package Name or Title    ${search_field}
    Input Package Name     ${package_name}
    Click Search

Verify No Result in Result Table
    Element Should Be Visible    ${no_result}
    Element Should Be Visible    ${no_result_img}  

*** Comments ***
Please place your common actions here