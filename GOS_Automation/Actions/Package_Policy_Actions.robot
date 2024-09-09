*** Settings ***
Resource    ../PageObjects/Login_Page.robot
Resource    ../Actions/Common_Actions.robot
Resource    ../TestData/Common.robot
Resource    ../TestData/Environment.robot
Resource    ../PageObjects/Package_Policy_Page_Object.robot
Resource    ../PageObjects/History_Package_Policy_Page_Object.robot
Resource    ../PageObjects/Common_Page_Object.robot
Library     ../Actions/totp.py


*** Keywords ***

Select AND OR Operation
    [Arguments]    ${operation}='AND'
    IF    '${operation}'=='AND'
        Wait And Click Element    ${btn_and}    
    ELSE
        Wait And Click Element    ${btn_or}
    END


Verify Equals and Case Sensitive Package Policy in Result Table
    [Arguments]    ${package_name}
    ${row_count}    Get Element Count    ${row_result_table}
        FOR    ${counter}    IN RANGE    ${row_count}
            Is Element Visible    ${package_name_case_sensitive_equal_result_table.replace("count", "${counter + 1}").replace("value","${package_name}")}
        END

Verify Begin with and Case Sensitive Package Policy in Result Table
    [Arguments]    ${package_name}
    ${row_count}    Get Element Count    ${row_result_table}
        FOR    ${counter}    IN RANGE    ${row_count}
            Is Element Visible    ${package_name_case_sensitive_begins_result_table.replace("count", "${counter + 1}").replace("value","${package_name}")}
        END

Verify Device Group of Package Policy in Result Table
    [Arguments]    ${device_group}
    ${row_count}    Get Element Count    ${row_result_table}
        FOR    ${counter}    IN RANGE    ${row_count}
            Is Element Visible    ${device_group_case_insensitive_result_table.replace("count", "${counter + 1}").replace("UPPER","${device_group.upper()}").replace("lower","${device_group.lower()}").replace("value","${device_group}")}
        END

Verify Device Group AND Package of Package Policy in Result Table
    [Arguments]    ${package_name}    ${device_group}
    ${row_count}    Get Element Count    ${row_result_table}
        FOR    ${counter}    IN RANGE    ${row_count}
            Is Element Visible    ${device_group_case_insensitive_result_table.replace("count", "${counter + 1}").replace("UPPER","${device_group.upper()}").replace("lower","${device_group.lower()}").replace("value","${device_group}")}
            Is Element Visible    ${package_name_case_insensitive_result_table.replace("count", "${counter + 1}").replace("UPPER","${package_name.upper()}").replace("lower","${package_name.lower()}").replace("value","${package_name}")}
        END

Verify Device Group OR Package of Package Policy in Result Table
    [Arguments]    ${package_name}    ${device_group}
    ${row_count}    Get Element Count    ${row_result_table}
        FOR    ${counter}    IN RANGE    ${row_count}
            Is Element Visible    ${device_group_case_insensitive_result_table.replace("count", "${counter + 1}").replace("UPPER","${device_group.upper()}").replace("lower","${device_group.lower()}").replace("value","${device_group}")}
            ${device_group_text}    Get Text    ${device_group_case_result_table.replace("count", "${counter + 1}")}
            IF    '${device_group_text}' != '${device_group}'
                Is Element Visible    ${package_name_case_insensitive_result_table.replace("count", "${counter + 1}").replace("UPPER","${package_name.upper()}").replace("lower","${package_name.lower()}").replace("value","${package_name}")}
            END
        END
 

Verify Package Policy Page Component
    Is Element Visible    ${label_main}
    Is Element Visible    ${label_package_name}
    Is Element Visible    ${label_device_group}
    Is Element Visible    ${btn_case_sensitive}
    Is Element Visible    ${btn_delete}
    Is Element Visible    ${btn_bulk_delete}
    Is Element Visible    ${btn_duplicate}
    Is Element Visible    ${btn_add_json}
    Is Element Visible    ${btn_Add}
    Is Element Visible    ${btn_Settings}
    Is Element Visible    ${header_package}
    Is Element Visible    ${header_title}
    Is Element Visible    ${header_device_group_name}
    Is Element Visible    ${header_spa}
    Is Element Visible    ${header_resolution}
    Is Element Visible    ${header_updated}
    Is Element Visible    ${header_framebooster}

Click Searched Package Policy
    [Arguments]    ${package_name}
            Wait and Click Element    ${package_first_result_table.replace("value","${package_name}")}


Verify Package Policy Details Page Component
    Wait Until Element Is Visible     ${btn_duplicate}
    Wait Until Element Is Visible     ${btn_edit}
    Wait Until Element Is Visible     ${btn_list}
    Wait Until Element Is Visible     ${details_title.replace('title', 'Basic Information')}
    Wait Until Element Is Visible     ${details_label_with_label.replace('field_label', 'Package Name')}
    Wait Until Element Is Visible     ${details_label_with_label.replace('field_label', 'Device Group Name')}
    Wait Until Element Is Visible     ${details_label_with_label.replace('field_label', 'Created')}
    Wait Until Element Is Visible     ${details_label_with_label.replace('field_label', 'Updated')}
    Wait Until Element Is Visible     ${details_title.replace('title', 'Setup Items')}
    Wait Until Element Is Visible     ${details_history_column_0.replace('column', 'Updated')}
    Wait Until Element Is Visible     ${details_history_column_1.replace('column', 'Author')}
    Wait Until Element Is Visible     ${details_history_column_2.replace('column', 'Updated Items')}
    Wait Until Element Is Visible     ${details_history_column_3.replace('column', 'History Comment')}
         
    
*** Comments ***
Please place your login actions here.