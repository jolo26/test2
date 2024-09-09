*** Settings ***
Resource         ../Actions/Login_Actions.robot
Resource         ../Actions/History_Package_Policy_Actions.robot
Resource         ../Actions/Common_Actions.robot
Resource         ../PageObjects/Login_Page.robot
Resource         ../PageObjects/Common_Page_Object.robot
Resource         ../PageObjects/Package_Page_Object.robot
Resource         ../Constants/Common.robot
Library          ../Actions/totp.py
Suite Setup      Login user
         
*** Test Cases ***
Package Policy page component should be displayed
    Navigate to Module    ${MODULE_HISTORY_PACKAGE_POLICY}
    Verify Package Policy Hstory Page Component

Package Policy - List - searching package equals to exact value by not case sensitive should be displayed
    Navigate to Module    ${MODULE_HISTORY_PACKAGE_POLICY}
    Select Case Sensitive or Case Insensitive    ${CASE_INSENSITIVE}
    Input Package Name    test.ascacqwe
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Equals and Case Insensitive Package Policy in Result Table in hstory    test.ascacqwe

Package Policy - List - searching package that begins with partial text by case sensitive should display all similar Package names
    Navigate to Module    ${MODULE_HISTORY_PACKAGE_POLICY}
    Select Package Name or Device Group    ${LBL_PACKAGE_NAME}
    Select Case Sensitive or Case Insensitive    ${CASE_SENSITIVE}
    Input Package Name    ${TEST_SMALL_CAPS}
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Begin with and Case Sensitive Package Policy in Result Table    ${TEST_SMALL_CAPS}

Package Policy - List - searching Package equals to exact value with trailing tabs and spaces by case sensitive should still be displayed
    Navigate to Module    ${MODULE_HISTORY_PACKAGE_POLICY}
    Select Package Name or Device Group    ${LBL_PACKAGE_NAME}
    Select Case Sensitive or Case Insensitive    ${CASE_SENSITIVE}
    Input Package Name    test.ascacqwe          
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Equals and Case Insensitive Package Policy in Result Table in hstory    test.ascacqwe

Package Policy - List - searching Package equals to exact value with trailing tabs and spaces by case sensitive should still be displayed
    Navigate to Module    ${MODULE_HISTORY_PACKAGE_POLICY}
    Select Package Name or Device Group    ${LBL_PACKAGE_NAME}
    Select Case Sensitive or Case Insensitive    ${CASE_SENSITIVE}
    Input Package Name    ${TEST_SMALL_CAPS}          
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Equals and Case Insensitive Package Policy in Result Table in hstory    ${TEST_SMALL_CAPS}
    
Package Policy - List - searching nonexistent package equals to exact value by not case sensitive should return no data
    Navigate to Module    ${MODULE_HISTORY_PACKAGE_POLICY}
    Select Package Name or Device Group    ${LBL_PACKAGE_NAME}
    Select Case Sensitive or Case Insensitive    ${CASE_INSENSITIVE}
    Input Package Name    ${NOT_EXISTING_DATA}        
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify No Result in Result Table

Package Policy - List - searching existing Device Group Name should be displayed
    Navigate to Module    ${MODULE_HISTORY_PACKAGE_POLICY}
    Select Package Name or Device Group    ${LBL_DEVICE_GROUP_NAME}
    Input Device Group    ro-dg-dont-delete       
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Device Group of Package Policy in Result Table    ro-dg-dont-delete  


Package Policy - List - searching nonexistent device group name should return no data
    Navigate to Module    ${MODULE_HISTORY_PACKAGE_POLICY}
    Select Package Name or Device Group    ${LBL_DEVICE_GROUP_NAME}
    Input Package Name    ${NOT_EXISTING_DATA}       
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify No Result in Result Table

History_Package_Info_Details_Package info details page should be correct
    Navigate to Module    ${MODULE_HISTORY_PACKAGE_POLICY}
    Input Package Name    test.apptest117.app.game.juggle
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Click Searched Package Policy   test.apptest117.app.game.juggle
    Verify Package Policy Hstory Details Page Component

History_Package_Info_Details_Package Info details page should be redirected to device manager list page when List button is clicked
    Navigate to Module    ${MODULE_HISTORY_PACKAGE_POLICY}
    Input Package Name    test.apptest117.app.game.juggle
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Click Searched Package Policy   test.apptest117.app.game.juggle
    Click List Button
    Verify Package Policy Hstory Page Component
    [Teardown]    Close Browser


