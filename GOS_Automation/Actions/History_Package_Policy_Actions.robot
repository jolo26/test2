*** Settings ***
Resource    ../PageObjects/Login_Page.robot
Resource    ../Actions/Common_Actions.robot
Resource    ../TestData/Common.robot
Resource    ../TestData/Environment.robot
Resource    ../PageObjects/History_Package_Policy_Page_Object.robot
Resource    ../PageObjects/Common_Page_Object.robot
Library     ../Actions/totp.py


*** Keywords ***

Select Package Name or Device Group
    [Arguments]    ${selected}
    Click Element    ${select}
    IF    '${selected}' == 'Package Name'
        Click Element    ${selected_value.replace('value', '${selected}')}  
    END
    IF    '${selected}' == 'Device Group Name'
        Click Element    ${selected_value.replace('value', '${selected}')}  
    END

Verify Equals and Case Insensitive Package Policy in Result Table in hstory
    [Arguments]    ${package_name}
    sleep    2s
    ${row_count}    Get Element Count    ${row_result_table}
        FOR    ${counter}    IN RANGE    ${row_count}
            Element Should Be Visible    ${package_case_sensitive_equal_result_table.replace("count", "${counter + 1}").replace("value","${package_name}")}
            ${print}    Get Text    ${package_case_sensitive_equal_result_table.replace("count", "${counter + 1}").replace("value","${package_name}")}
            Log To Console    ${print}
        END

Verify Begin with and Case Sensitive Package Policy in Result Table
    [Arguments]    ${package_name}
    ${row_count}    Get Element Count    ${row_result_table}
        FOR    ${counter}    IN RANGE    ${row_count}
            Element Should Be Visible    ${package_name_case_sensitive_begins_result_table.replace("count", "${counter + 1}").replace("value","${package_name}")}
        END

Verify Device Group of Package Policy in Result Table
    [Arguments]    ${device_group}
    ${row_count}    Get Element Count    ${row_result_table}
        FOR    ${counter}    IN RANGE    ${row_count}
            Element Should Be Visible    ${device_group_case_result_table.replace("count", "${counter + 1}").replace("UPPER","${device_group.upper()}").replace("lower","${device_group.lower()}").replace("value","${device_group}")}
        END

Verify Device Group AND Package of Package Policy in Result Table
    [Arguments]    ${package_name}    ${device_group}
    ${row_count}    Get Element Count    ${row_result_table}
        FOR    ${counter}    IN RANGE    ${row_count}
            Element Should Be Visible    ${device_group_case_insensitive_result_table.replace("count", "${counter + 1}").replace("UPPER","${device_group.upper()}").replace("lower","${device_group.lower()}").replace("value","${device_group}")}
            Element Should Be Visible    ${package_name_case_insensitive_result_table.replace("count", "${counter + 1}").replace("UPPER","${package_name.upper()}").replace("lower","${package_name.lower()}").replace("value","${package_name}")}
        END

Verify Device Group OR Package of Package Policy in Result Table
    [Arguments]    ${package_name}    ${device_group}
    ${row_count}    Get Element Count    ${row_result_table}
        FOR    ${counter}    IN RANGE    ${row_count}
            Element Should Be Visible    ${device_group_case_insensitive_result_table.replace("count", "${counter + 1}").replace("UPPER","${device_group.upper()}").replace("lower","${device_group.lower()}").replace("value","${device_group}")}
            ${device_group_text}    Get Text    ${device_group_case_result_table.replace("count", "${counter + 1}")}
            IF    '${device_group_text}' != '${device_group}'
                Element Should Be Visible    ${package_name_case_insensitive_result_table.replace("count", "${counter + 1}").replace("UPPER","${package_name.upper()}").replace("lower","${package_name.lower()}").replace("value","${package_name}")}
            END
        END


Verify No Result in Result Table
    Element Should Be Visible    ${no_result}

Verify Package Policy Hstory Page Component
    Element Should Be Visible    ${label_package_policy_history}
    Element Should Be Visible    ${btn_Settings}
    Element Should Be Visible    ${input_field}             
    Element Should Be Visible    ${header_history_title}               
    Element Should Be Visible    ${header_history_package}             
    Element Should Be Visible    ${header_history_device_group_name}   
    Element Should Be Visible    ${header_history_history_comment}     
    Element Should Be Visible    ${header_history_updated}             
    Element Should Be Visible    ${header_history_created}


Click Searched Package Policy
    [Arguments]    ${package_name}
            Wait and Click Element    ${package_first_result_table.replace("value","${package_name}")}

Verify Package Policy Hstory Details Page Component
    Wait Until Element Is Visible     ${btn_list}
    Wait Until Element Is Visible     ${details_title.replace('title', 'Basic Information')}
    Wait Until Element Is Visible     ${details_title.replace('title', 'Setup Items')}
    Wait Until Element Is Visible     ${details_title.replace('title', 'History Details')}
    Wait Until Element Is Visible     ${details_label_with_label.replace('field_label', 'Package Name')}
    Wait Until Element Is Visible     ${details_label_with_label.replace('field_label', 'Device Group Name')}
    Wait Until Element Is Visible     ${details_label_with_label.replace('field_label', 'Created')}
    Wait Until Element Is Visible     ${details_label_with_label.replace('field_label', 'Updated')}       
    




*** Comments ***
Please place your login actions here.