*** Settings ***
Resource    ../PageObjects/Login_Page.robot
Resource    ../Actions/Common_Actions.robot
Resource    ../TestData/Common.robot
Resource    ../TestData/Environment.robot
Resource    ../PageObjects/History_Package_Page_Object.robot
Resource    ../PageObjects/Common_Page_Object.robot
Library     ../Actions/totp.py


*** Keywords ***
Click Searched Package - Hstory
    [Arguments]    ${package_name}
            Wait and Click Element    ${package_first_result_table.replace("value","${package_name}")}

Verify Hstory Package Category in Result Table
    [Arguments]    ${category}
    ${row_count}    Get Element Count    ${row_result_table}
    FOR    ${counter}    IN RANGE    ${row_count}
        Wait Until Element Is Visible    ${category_result_table_history.replace("count", "${counter + 1}").replace("value","${category}")}
    END

Verify Hstory Search Field in Result Table
    [Arguments]    ${label}    ${value}    ${is_case_sensitive}=${True}
    ${row_count}    Get Element Count    ${row_result_table}
    IF    "${label}" == "Title"
            FOR    ${counter}    IN RANGE    ${row_count-1}
                Wait Until Element Is Visible    ${title_result_table_history.replace("count", "${counter + 1}").replace("UPPER","${value.upper()}").replace("lower","${value.lower()}").replace("value","${value.lower()}")}
        
            END
    ELSE IF    "${label}" == "Package Name"
            FOR    ${counter}    IN RANGE    ${row_count-1}
                IF    ~${is_case_sensitive}
                    Wait Until Element Is Visible    ${package_name_case_sensitive_result_table_history.replace("count", "${counter + 1}").replace("UPPER","${value.upper()}").replace("lower","${value.lower()}").replace("value","${value.lower()}")}
                ELSE
                    Wait Until Element Is Visible    ${package_name_result_table_history.replace("count", "${counter + 1}").replace("value","${value}")}
                END    
            END
    END

    

Verify Package Hstory Details Page Component
    Wait Until Element Is Visible     ${details_title.replace('title', 'Package Information')}
    Wait Until Element Is Visible     ${btn_list_history}
    # Wait Until Element Is Visible     ${btn_edit}
    Wait Until Element Is Visible     ${details_label_with_label.replace('field_label', 'Category')}
    Wait Until Element Is Visible     ${details_label_with_label.replace('field_label', 'Package Name')}
    Wait Until Element Is Visible     ${details_label_with_label.replace('field_label', 'Developer')}
    Wait Until Element Is Visible     ${details_label_with_label.replace('field_label', 'Created')}
    Wait Until Element Is Visible     ${details_label_with_label.replace('field_label', 'Game Title')}
    Wait Until Element Is Visible     ${details_label_with_label.replace('field_label', 'Store')}
    Wait Until Element Is Visible     ${details_label_with_label.replace('field_label', 'Updated')}
    Wait Until Element Is Visible     ${details_title.replace('title', 'Update History')}
    Wait Until Element Is Visible     ${details_history_column.replace('column', 'Updated')}
    Wait Until Element Is Visible     ${details_history_column.replace('column', 'Author')}
    Wait Until Element Is Visible     ${details_history_column.replace('column', 'Action')}
    Wait Until Element Is Visible     ${details_history_column.replace('column', 'Updated Items')}
    Wait Until Element Is Visible     ${details_history_column.replace('column', 'History Comment')}


Verify Package Hstory Page Component
    Wait Until Element Is Visible    ${page_header.replace('value', 'History / Package')}
    Wait Until Element Is Visible    ${label_category}
    Wait Until Element Is Visible    ${label_action}
    Wait Until Element Is Visible    ${label_search_field}
    Wait Until Element Is Visible    ${btn_case_sensitive}
    Wait Until Element Is Visible    ${header_category}
    Wait Until Element Is Visible    ${header_title}
    Wait Until Element Is Visible    ${header_package}
    Wait Until Element Is Visible    ${header_developer}
    Wait Until Element Is Visible    ${header_store}
    Wait Until Element Is Visible    ${header_updated}
    Wait Until Element Is Visible    ${header_created}
*** Comments ***
Please place your login actions here.