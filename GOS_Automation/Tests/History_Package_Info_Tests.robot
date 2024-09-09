*** Settings ***
Resource         ../Actions/Login_Actions.robot
Resource         ../Actions/Package_Actions.robot
Resource         ../Actions/History_Package_Actions.robot
Resource         ../Actions/Common_Actions.robot
Resource         ../PageObjects/Login_Page.robot
Resource         ../PageObjects/Common_Page_Object.robot
Resource         ../PageObjects/History_Package_Page_Object.robot
Resource         ../Constants/Package_Info.robot
Resource         ../Constants/Common.robot
Resource         ../TestData/Common.robot
Library          ../Actions/totp.py
Suite Setup      Login user


*** Test Cases ***
Package Info page component should be displayed
    Navigate to Module    ${MODULE_HISTORY_PACKAGE}
    Verify Package Hstory Page Component

Searching a package using category GAME should be Successful
    Search by Category   ${CAT_GAME}
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Hstory Package Category in Result Table    ${CAT_GAME}

Searching a package using category NON GAME should be Successful
    Search by Category    ${CAT_NON_GAME}
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Hstory Package Category in Result Table    ${CAT_NON_GAME}

Searching a package using category Unknown should be Successful
    Search by Category     ${CAT_UNKNOWN}
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Hstory Package Category in Result Table    ${CAT_UNKNOWN}

Searching a package using package name case insensitive search field should be Successful
    Select Search Field in Package Info    ${LBL_PACKAGE_NAME}
    Select Case Sensitive or Case Insensitive    ${CASE_INSENSITIVE}
    Input Data in Seach Field in Package Info    ${TEST_CAPITALIZED}
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Hstory Search Field in Result Table    ${LBL_PACKAGE_NAME}    ${TEST_CAPITALIZED}    False

Searching a package using package name case Sensitive search field should be Successful
    Select Search Field in Package Info    ${LBL_PACKAGE_NAME}
    Select Case Sensitive or Case Insensitive    ${CASE_SENSITIVE}
    Input Data in Seach Field in Package Info    ${TEST_SMALL_CAPS}
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Hstory Search Field in Result Table    ${LBL_PACKAGE_NAME}    ${TEST_SMALL_CAPS}

Searching a package using title search field should be Successful
    Select Search Field in Package Info    ${LBL_TITLE}
    Input Data in Seach Field in Package Info    ${TEST_SMALL_CAPS}
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Hstory Search Field in Result Table    ${LBL_TITLE}    ${TEST_SMALL_CAPS}

Package_Info_Details_Package Info details page should be correct
    Navigate to Module    ${MODULE_PACKAGE}
    Select Package Name or Title    ${LBL_TITLE}
    Input Package Name    ${TEST_SMALL_CAPS}
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Click Searched Package    ${TEST_SMALL_CAPS}
    Verify Package Details Page Component
    [Teardown]    Close Browser