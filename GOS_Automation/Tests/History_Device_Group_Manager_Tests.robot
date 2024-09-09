*** Settings ***
Resource         ../Actions/Login_Actions.robot
Resource         ../Actions/Device_Group_Manager_Actions.robot
Resource         ../Actions/Common_Actions.robot
Resource         ../PageObjects/Login_Page.robot
Resource         ../PageObjects/Common_Page_Object.robot
Resource         ../PageObjects/Package_Page_Object.resource
Resource         ../Constants/Common.robot
Library          ../Actions/totp.py
Suite Setup      Login user

*** Test Cases ***
Device Group Manager page component should be displayed
    Navigate to Module    ${MODULE_HISTORY_DEVICE_GROUP_MANAGER}
    Verify Device Group Manager Page Component

Searching a device using device name search field should be Successful
    Search Device using search field    ${LBL_DEVICE_NAME}    ${TEST_CAPITALIZED}
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Search Field in Result Table    ${LBL_DEVICE_NAME}    ${TEST_CAPITALIZED}

Searching a device using product name search field should be Successful
    Search Device using search field    ${LBL_PRODUCT_NAME}    ${TEST_CAPITALIZED}
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Search Field in Result Table    ${LBL_PRODUCT_NAME}    ${TEST_CAPITALIZED}

Searching a device using device group name search field should be Successful
    Search Device using search field    ${LBL_DEVICE_GROUP_NAME}    ${TEST_CAPITALIZED}
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Search Field in Result Table    ${LBL_DEVICE_GROUP_NAME}    ${TEST_CAPITALIZED}
    [Teardown]  Close Browser

# Searching a device using device model name search field should be Successful
#     Search Device using search field    Device Model Name    Note
#     Wait Until Element Is Not Visible    ${progress_bar}
#     Verify Search Field in Result Table    Device Model Name    Note
    



