*** Comments ***
Please place your login actions here.


*** Settings ***
Resource    ../PageObjects/Login_Page.robot
Resource    ../Actions/Common_Actions.robot
Resource    ../TestData/Common.robot
Resource    ../TestData/Environment.robot
Resource    ../PageObjects/Package_Page_Object.resource
Resource    ../PageObjects/Common_Page_Object.robot
Library     ../Actions/totp.py
Library     RequestsLibrary


*** Keywords ***
Search By Category
    [Arguments]    ${category}
    Wait And Click Element    ${CATEGORY_DROP_DOWN}
    Wait And Click Element    ${CATEGORY_DROP_DOWN_OPTIONS.replace("value", "${category}")}
    Wait Until Element Is Not Visible    ${PROGRESS_BAR}

Search By Store
    [Arguments]    ${store}
    Wait And Click Element    ${STORE_DROP_DOWN}
    Wait And Click Element    ${STORE_DROP_DOWN_OPTIONS.replace("value", "${store}")}
    Wait Until Element Is Not Visible    ${PROGRESS_BAR}

Select Search Field In Package Info
    [Arguments]    ${search_field}

    Wait And Click Element    ${SEARCH_FIELD_DROP_DOWN}
    Wait And Click Element    ${SEARCH_FIELD_DROP_DOWN_OPTIONS.replace("value", "${search_field}")}

Select Case Sensitivity
    [Arguments]    ${is_case_sensitive}=${True}
    IF    ~${is_case_sensitive}
        Wait And Click Element    ${CASE_SENSITIVE_BTN}
    END

Input Data In Seach Field In Package Info
    [Arguments]    ${value}
    Press Keys    ${INPUT_FIELD}    CTRL+A    BACKSPACE
    Wait And Input Text    ${INPUT_FIELD}    ${value}

Verify Category In Result Table
    [Arguments]    ${label}
    ${row_count}    Get Element Count    ${ROW_RESULT_TABLE}
    FOR    ${counter}    IN RANGE    ${row_count-1}
        Wait Until Element Is Visible
        ...    ${CATEGORY_RESULT_TABLE.replace("count", "${counter + 1}").replace("value","${label}")}
    END

Verify Store In Result Table
    [Arguments]    ${label}
    ${row_count}    Get Element Count    ${ROW_RESULT_TABLE}
    FOR    ${counter}    IN RANGE    ${row_count}
        Wait Until Element Is Visible
        ...    ${STORE_RESULT_TABLE.replace("count", "${counter + 1}").replace("value","${label}")}
    END

Verify Search Field In Result Table
    [Arguments]    ${label}    ${value}    ${is_case_sensitive}=${True}
    ${row_count}    Get Element Count    ${ROW_RESULT_TABLE}
    IF    "${label}" == "Title"
        FOR    ${counter}    IN RANGE    ${row_count-1}
            Wait Until Element Is Visible
            ...    ${TITLE_RESULT_TABLE.replace("count", "${counter + 1}").replace("UPPER","${value.upper()}").replace("lower","${value.lower()}").replace("value","${value.lower()}")}
        END
    ELSE IF    "${label}" == "Package Name"
        FOR    ${counter}    IN RANGE    ${row_count-1}
            IF    ~${is_case_sensitive}
                Wait Until Element Is Visible
                ...    ${PACKAGE_NAME_CASE_SENSITIVE_RESULT_TABLE.replace("count", "${counter + 1}").replace("UPPER","${value.upper()}").replace("lower","${value.lower()}").replace("value","${value.lower()}")}
            ELSE
                Wait Until Element Is Visible
                ...    ${PACKAGE_NAME_RESULT_TABLE.replace("count", "${counter + 1}").replace("value","${value}")}
            END
        END
    END

Verify Package Page Component
    Wait Until Element Is Visible    ${LABEL_PACKAGE}
    Wait Until Element Is Visible    ${LABEL_CATEGORY}
    Wait Until Element Is Visible    ${LABEL_STORE}
    Wait Until Element Is Visible    ${LABEL_SEARCH_FIELD}
    Wait Until Element Is Visible    ${INPUT_SEARCH_FIELD}
    Wait Until Element Is Visible    ${BTN_CASE_SENSITIVE}
    Wait Until Element Is Visible    ${BTN_DELETE}
    Wait Until Element Is Visible    ${BTN_MOVE}
    Wait Until Element Is Visible    ${BTN_ADD}
    Wait Until Element Is Visible    ${HEADER_CATEGORY}
    Wait Until Element Is Visible    ${HEADER_TITLE}
    Wait Until Element Is Visible    ${HEADER_PACKAGE}
    Wait Until Element Is Visible    ${HEADER_DEVELOPER}
    Wait Until Element Is Visible    ${HEADER_STORE}
    Wait Until Element Is Visible    ${HEADER_UPDATED}
    Wait Until Element Is Visible    ${HEADER_CREATED}

Click Searched Package
    [Arguments]    ${package_name}
    Wait And Click Element    ${PACKAGE_NAME_FIRST_RESULT_TABLE.replace("value","${package_name}")}
    Wait Until Element Is Not Visible    ${PROGRESS_BAR}

Click Checkbox For Package
    Wait And Click Element    ${CHECKBOX_PACKAGE}

Click Move
    Wait And Click Element    ${BTN_MOVE}

Click Move In Modal
    Wait And Click Element    ${BTN_MOVE_MODAL}

Select Category For Move
    [Arguments]    ${selected_value}
    Wait And Click Element    ${MOVE_CATEGORY.replace('selected', '${selected_value.upper()}').replace(' ', '_')}

Verify Package Details Page Component
    Wait Until Element Is Visible    ${DETAILS_TITLE.replace('title', 'Package Information')}
    Wait Until Element Is Visible    ${DETAILS_LABEL.replace('field_label', 'Category')}
    Wait Until Element Is Visible    ${DETAILS_LABEL.replace('field_label', 'Package Name')}
    Wait Until Element Is Visible    ${DETAILS_LABEL.replace('field_label', 'Developer')}
    Wait Until Element Is Visible    ${DETAILS_LABEL.replace('field_label', 'Created')}
    Wait Until Element Is Visible    ${DETAILS_LABEL.replace('field_label', 'Game Title')}
    Wait Until Element Is Visible    ${DETAILS_LABEL.replace('field_label', 'Store')}
    Wait Until Element Is Visible    ${DETAILS_LABEL.replace('field_label', 'Updated')}
    Wait Until Element Is Visible    ${DETAILS_TITLE.replace('title', 'Update History')}
    Wait Until Element Is Visible    ${DETAILS_HISTORY_COLUMN_0.replace('column', 'Update Date')}
    Wait Until Element Is Visible    ${DETAILS_HISTORY_COLUMN_1.replace('column', 'Author')}
    Wait Until Element Is Visible    ${DETAILS_HISTORY_COLUMN_2.replace('column', 'Action')}
    Wait Until Element Is Visible    ${DETAILS_HISTORY_COLUMN_3.replace('column', 'Updated Items')}
    Wait Until Element Is Visible    ${DETAILS_HISTORY_COLUMN_4.replace('column', 'History Comment')}

Verify Error Message Field
    [Arguments]    ${error}
    Wait Until Element Is Visible    ${ERROR_REQUIRED_FIELD.replace('error_message', '${error}')}

Verify Toast Error Message
    [Arguments]    ${error}
    Wait Until Element Is Visible    ${MODAL_ERROR_MESSAGE.replace('error', '${error}')}

Click Package Name In Add Package
    Wait And Click Element    ${INPUT_PACKAGE_NAME_ADD}

Click Title In Add Package
    Wait And Click Element    ${INPUT_TITLE_ADD}

Click Developer In Add Package
    Wait And Click Element    ${INPUT_DEVELOPER_ADD}

Click History Comment In Add Package
    Wait And Click Element    ${INPUT_COMMENT_ADD}

Input Package Name In Add Package
    [Arguments]    ${package_name}
    Wait And Input Text    ${INPUT_PACKAGE_NAME_ADD}    ${package_name}

Input Developer In Add Package
    [Arguments]    ${developer}
    Wait And Input Text    ${INPUT_DEVELOPER_ADD}    ${developer}

Input History Comment In Add Package
    [Arguments]    ${comment}
    Wait And Input Text    ${INPUT_COMMENT_ADD}    ${comment}

Input History Comment In Move Package
    [Arguments]    ${comment}
    Wait And Input Text    ${INPUT_COMMENT_MOVE}    ${comment}

Input Game Title In Add Package
    [Arguments]    ${title}
    Wait And Input Text    ${INPUT_TITLE_ADD}    ${title}

Select Store In Add Package
    [Arguments]    ${store}
    Wait And Select From List    ${INPUT_STORE_ADD}    ${store}

Select Package Category
    [Arguments]    ${category}
    Wait And Click Element    ${RADIO_CATEGORY.replace('category', '${category}')}

Clear Field Value
    [Arguments]    ${field}
    IF    '${field}' == 'title'
        Press Keys    ${INPUT_TITLE_ADD}    CTRL+A    BACKSPACE
    END
    IF    '${field}' == 'developer'
        Press Keys    ${INPUT_DEVELOPER_ADD}    CTRL+A    BACKSPACE
    END
