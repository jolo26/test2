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
    Navigate to Module    ${MODULE_DEVICE_GROUP_MANAGER}
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

Searching a device using device model name search field should be Successful
    Search Device using search field    ${LBL_DEVICE_MODEL_NAME}    Note
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Search Field in Result Table    ${LBL_DEVICE_MODEL_NAME}    Note
    [Teardown]  Close Browser

Device_info_Detailsdevice manager details page should be correct
    Navigate to Module    ${MODULE_DEVICE_GROUP_MANAGER}
    Search Device using search field    ${LBL_DEVICE_GROUP_NAME}    ${TEST_SMALL_CAPS}
    Wait Until Element Is Not Visible    ${progress_bar}
    Click Searched Device Group   ${TEST_SMALL_CAPS}
    Verify Device Group Manager Details Page Component


Device_info_Detailsdevice manager details page should be redirected to device manager list page when List button is clicked
    Navigate to Module    ${MODULE_DEVICE_GROUP_MANAGER}
    Search Device using search field    ${LBL_DEVICE_GROUP_NAME}     ${TEST_SMALL_CAPS}
    Wait Until Element Is Not Visible    ${progress_bar}
    Click Searched Device Group   ${TEST_SMALL_CAPS}
    Click List Button
    Verify Device Group Manager Page Component
    [Teardown]    Close Browser



