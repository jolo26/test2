*** Settings ***
Resource         ../Actions/Login_Actions.robot
Resource         ../Actions/Device_Manager_Actions.robot
Resource         ../Actions/Common_Actions.robot
Resource         ../PageObjects/Login_Page.robot
Resource         ../PageObjects/Common_Page_Object.robot
Resource         ../PageObjects/Package_Page_Object.robot
Resource         ../Constants/Common.robot
Library          ../Actions/totp.py
Suite Setup      Login user

*** Test Cases ***
Package Info page component should be displayed
    Navigate to Module    ${MODULE_DEVICE_MANAGER}
    Verify Device Manager Page Component

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


   



