*** Settings ***
Resource    ../PageObjects/Login_Page.robot
Resource    ../Actions/Common_Actions.robot
Resource    ../TestData/Common.robot
Resource    ../TestData/Environment.robot
Resource    ../PageObjects/History_Device_Policy_Page_Object.robot
Resource    ../PageObjects/Device_Policy_Page_Object.robot
Resource    ../PageObjects/Common_Page_Object.robot
Library     ../Actions/totp.py


*** Keywords ***

Verify Device Group of Device Policy in Result Table
    [Arguments]    ${device_group}
    ${row_count}    Get Element Count    ${row_result_table}
    Log To Console    message + ${row_count}
        FOR    ${counter}    IN RANGE    ${row_count}
            Element Should Be Visible    ${device_group_result_table.replace("count", "${counter + 1}").replace("UPPER","${device_group.upper()}").replace("lower","${device_group.lower()}").replace("value","${device_group}")}
        END

Verify No Result in Result Table
    Element Should Be Visible    ${no_result}
 

Verify Device Policy Page Component
    Element Should Be Visible    ${label_main}
    Element Should Be Visible    ${btn_delete}
    Element Should Be Visible    ${btn_bulk_delete}
    Element Should Be Visible    ${btn_duplicate}
    Element Should Be Visible    ${btn_add_json}
    Element Should Be Visible    ${btn_Add}
    Element Should Be Visible    ${btn_Settings}
    Element Should Be Visible    ${header_device_group}
    Element Should Be Visible    ${header_devices}
    Element Should Be Visible    ${header_packages}
    Element Should Be Visible    ${header_updated}

Verify Device Policy Hstory Page Component
    Element Should Be Visible    ${label_main}
    Element Should Be Visible    ${btn_Settings}
    Element Should Be Visible    ${header_history_device_group_name}
    Element Should Be Visible    ${header_history_devices}
    Element Should Be Visible    ${header_history_packages}
    Element Should Be Visible    ${header_history_history_comment}
    Element Should Be Visible    ${header_history_updated}  
    Element Should Be Visible    ${header_history_created}  


Click Searched Device Policy
    [Arguments]    ${device_name}
            Wait and Click Element    ${device_group_first_result_table.replace("value","${device_name}")}


Verify Device Policy Details Page Component
    Wait Until Element Is Visible     ${btn_enable_copying}
    Wait Until Element Is Visible     ${btn_duplicate}
    Wait Until Element Is Visible     ${btn_edit}
    Wait Until Element Is Visible     ${btn_list}
    Wait Until Element Is Visible     ${details_title.replace('title', 'Basic Information')}
    Wait Until Element Is Visible     ${details_label_with_label.replace('field_label', 'Device Group Name')}
    Wait Until Element Is Visible     ${details_label_with_label.replace('field_label', 'Device(s)')}
    Wait Until Element Is Visible     ${details_label_with_label.replace('field_label', 'Package(s)')}
    Wait Until Element Is Visible     ${details_label_with_label.replace('field_label', 'Created')}
    Wait Until Element Is Visible     ${details_label_with_label.replace('field_label', 'Updated')}
    Wait Until Element Is Visible     ${details_title.replace('title', 'Setup Items')}
    Wait Until Element Is Visible     ${details_history_column_0.replace('column', 'Updated')}
    Wait Until Element Is Visible     ${details_history_column_1.replace('column', 'Author')}
    Wait Until Element Is Visible     ${details_history_column_2.replace('column', 'Updated Items')}
    Wait Until Element Is Visible     ${details_history_column_3.replace('column', 'History Comment')}
     
*** Comments ***
Please place your login actions here.