*** Settings ***
Resource         ../Actions/Login_Actions.robot
Resource         ../Actions/Product_Manager_Actions.robot
Resource         ../Actions/Common_Actions.robot
Resource         ../PageObjects/Login_Page.robot
Resource         ../PageObjects/Common_Page_Object.robot
Resource         ../PageObjects/Product_Page_Object.robot
Resource         ../Constants/Common.robot
Library          ../Actions/totp.py
Library          ../Utils/Random_Words.py
Suite Setup      Login user 

*** Test Cases ***
Product Manager page component should be displayed
    Navigate to Module    ${MODULE_PRODUCT_MANAGER}
    Verify Product Manager Page Component

Searching a product using device name search field should be Successful
    Search Product using search field    ${LBL_DEVICE_NAME}    ${TEST_CAPITALIZED}
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Search Field in Result Table    ${LBL_DEVICE_NAME}    ${TEST_CAPITALIZED}

Searching a product using product name search field should be Successful
    Search Product using search field    ${LBL_DEVICE_NAME}    ${TEST_CAPITALIZED}
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Search Field in Result Table    ${LBL_DEVICE_NAME}    ${TEST_CAPITALIZED}

Searching a product using device group name search field should be Successful
    Search Product using search field    ${LBL_DEVICE_GROUP_NAME}    ${TEST_CAPITALIZED}
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Search Field in Result Table    ${LBL_DEVICE_GROUP_NAME}    ${TEST_CAPITALIZED}

Searching a product using device model name search field should be Successful
    Search Product using search field    ${LBL_DEVICE_GROUP_NAME}    ${TEST_SMALL_CAPS}
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Search Field in Result Table    ${LBL_DEVICE_GROUP_NAME}    ${TEST_SMALL_CAPS}

Product_Details_device manager details page should be correct
    Navigate to Module    ${MODULE_PRODUCT_MANAGER}
    Search Product using search field    ${LBL_PRODUCT_NAME}    ${TEST_SMALL_CAPS}
    Wait Until Element Is Not Visible    ${progress_bar}
    Click Searched Product    ${TEST_SMALL_CAPS}
    Verify Product Manager Details Page Component

Product_Details_device manager details page should be redirected to device manager list page when List button is clicked
    Navigate to Module    ${MODULE_PRODUCT_MANAGER}
    Search Product using search field    ${LBL_PRODUCT_NAME}    ${TEST_SMALL_CAPS}
    Wait Until Element Is Not Visible    ${progress_bar}
    Click Searched Product    ${TEST_SMALL_CAPS}
    Click List Button
    Verify Product Manager Page Component
    [Teardown]    Close Browser



