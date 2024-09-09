*** Settings ***
Resource    ../PageObjects/Login_Page.robot
Resource    ../Actions/Common_Actions.robot
Resource    ../TestData/Common.robot
Resource    ../TestData/Environment.robot
Resource    ../PageObjects/Device_Page_Object.robot
Resource    ../PageObjects/Common_Page_Object.robot
Library     ../Actions/totp.py


*** Keywords ***

Verify Device Manager Page Component
    Is Element Visible    ${label_device}
    Is Element Visible    ${input_search_field}
    Is Element Visible    ${search_field_dropdown}
    Is Element Visible    ${btn_Add}
    Is Element Visible    ${header_device_name}
    Is Element Visible    ${header_product_name}
    Is Element Visible    ${header_device_group_name}
    Is Element Visible    ${header_model_name}
    Is Element Visible    ${header_created}
    Is Element Visible    ${header_updated}
    Is Element Visible    ${header_created}


Search Device using search field
    [Arguments]    ${label}    ${value}
    Wait And Click Element    ${search_field_drop_down.replace("test_id","select-searchField")}
    Wait And Click Element    ${search_field_drop_down.replace("value", "${label}").replace("test_id","select-searchField")}
    Press Keys    ${input_field}    CTRL+A    BACKSPACE
    Wait And Input Text    ${input_field}    ${value}
    Wait And Click Element    ${search_btn}


Verify Search Field in Result Table
    [Arguments]    ${label}    ${value}
    ${row_count}    Get Element Count    ${row_result_table}
    IF    "${label}" == "Device Name"
            FOR    ${counter}    IN RANGE    ${row_count}
                Is Element Visible    ${device_name_result_table.replace("count", "${counter + 1}").replace("UPPER","${value.upper()}").replace("lower","${value.lower()}").replace("value","${value}")}
        
            END
    ELSE IF    "${label}" == "Product Name"
            FOR    ${counter}    IN RANGE    ${row_count}
                    Is Element Visible    ${product_name_result_table.replace("count", "${counter + 1}").replace("UPPER","${value.upper()}").replace("lower","${value.lower()}").replace("value","${value}")}
            END

    ELSE IF    "${label}" == "Device Group Name"
            FOR    ${counter}    IN RANGE    ${row_count}
                    Is Element Visible    ${device_group_name_result_table.replace("count", "${counter + 1}").replace("UPPER","${value.upper()}").replace("lower","${value.lower()}").replace("value","${value}")}
            END

    ELSE IF    "${label}" == "Device Model Name"
            FOR    ${counter}    IN RANGE    ${row_count}
                    Is Element Visible    ${device_model_name_result_table.replace("count", "${counter + 1}").replace("UPPER","${value.upper()}").replace("lower","${value.lower()}").replace("value","${value}")}
            END
    END


Click Searched Device
    [Arguments]    ${device_name}
            Wait and Click Element    ${device_first_result_table.replace("value","${device_name}")}

Verify Device Manager Details Page Component
    Wait Until Element Is Visible     ${details_title.replace('title', 'Device Manager')}
    Wait Until Element Is Visible     ${details_label.replace('field_label', 'Device Name')}
    Wait Until Element Is Visible     ${details_label.replace('field_label', 'Model Mapping')}
    Wait Until Element Is Visible     ${details_label.replace('field_label', 'Created')}
    Wait Until Element Is Visible     ${details_label.replace('field_label', 'Updated')}
    Wait Until Element Is Visible     ${details_title.replace('title', 'Update History')}
    Wait Until Element Is Visible     ${details_history_column_0.replace('column', 'Update Date')}
    Wait Until Element Is Visible     ${details_history_column_1.replace('column', 'Author')}
    Wait Until Element Is Visible     ${details_history_column_2.replace('column', 'Action')}
    Wait Until Element Is Visible     ${details_history_column_3.replace('column', 'Updated Items')}
    Wait Until Element Is Visible     ${details_history_column_4.replace('column', 'History Comment')}

*** Comments ***
Please place your login actions here.