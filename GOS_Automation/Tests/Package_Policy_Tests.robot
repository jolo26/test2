*** Settings ***
Resource         ../Actions/Login_Actions.robot
Resource         ../Actions/Package_Policy_Actions.robot
Resource         ../Actions/Common_Actions.robot
Resource         ../PageObjects/Login_Page.robot
Resource         ../PageObjects/Common_Page_Object.robot
Resource         ../PageObjects/Package_Page_Object.robot
Resource         ../Constants/Common.robot
Library          ../Actions/totp.py
Suite Setup      Login user
         
*** Test Cases ***
Package Policy page component should be displayed
    Navigate to Module    ${MODULE_PACKAGE_POLICY}
    Verify Package Policy Page Component

Package Policy - List - searching package equals to exact value by not case sensitive should be displayed
    Navigate to Module    ${MODULE_PACKAGE_POLICY}
    Select Equals or Begin with    ${EQUAL}
    Select Case Sensitive or Case Insensitive   ${CASE_INSENSITIVE}
    Input Package Name in Package Policy    test.ascacqwe
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Equals and Case Sensitive Package Policy in Result Table    test.ascacqwe

Package Policy - List - searching package that begins with partial text by case sensitive should display all similar Package names
    Navigate to Module    ${MODULE_PACKAGE_POLICY}
    Select Equals or Begin with    ${BEGIN}
    Select Case Sensitive or Case Insensitive    ${CASE_SENSITIVE}
    Input Package Name in Package Policy    ${TEST_SMALL_CAPS}
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Begin with and Case Sensitive Package Policy in Result Table    ${TEST_SMALL_CAPS}

Package Policy - List - searching Package equals to exact value with trailing tabs and spaces by case sensitive should still be displayed
    Navigate to Module    ${MODULE_PACKAGE_POLICY}
    Select Equals or Begin with    ${EQUAL}
    Select Case Sensitive or Case Insensitive    ${CASE_SENSITIVE}
    Input Package Name in Package Policy    test.ascacqwe          
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Equals and Case Sensitive Package Policy in Result Table    test.ascacqwe

Package Policy - List - searching Package that begins with partial text with trailing tabs and spaces by not case sensitive should still be displayed
    Navigate to Module    ${MODULE_PACKAGE_POLICY}
    Select Equals or Begin with    ${BEGIN} 
    Select Case Sensitive or Case Insensitive    ${CASE_INSENSITIVE}
    Input Package Name in Package Policy    ${TEST_SMALL_CAPS}         
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Begin with and Case Sensitive Package Policy in Result Table    ${TEST_SMALL_CAPS}
    
Package Policy - List - searching nonexistent package equals to exact value by not case sensitive should return no data
    Navigate to Module    ${MODULE_PACKAGE_POLICY}
    Select Equals or Begin with    ${EQUAL}
    Select Case Sensitive or Case Insensitive    ${CASE_INSENSITIVE}
    Input Package Name in Package Policy    ${NOT_EXISTING_DATA}        
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify No Result in Result Table

Package Policy - List - searching nonexistent package that begins with partial text by case sensitive should return no data
    Navigate to Module    ${MODULE_PACKAGE_POLICY}
    Select Equals or Begin with    ${BEGIN}
    Select Case Sensitive or Case Insensitive    ${CASE_SENSITIVE}
    Input Package Name in Package Policy    ${NOT_EXISTING_DATA}        
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify No Result in Result Table


Package Policy - List - searching existing Device Group Name should be displayed
    Navigate to Module    ${MODULE_PACKAGE_POLICY}
    Input Device Group    ro-dg-dont-delete       
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Device Group of Package Policy in Result Table    ro-dg-dont-delete  

Package Policy - List - searching existing Device Group Name partially should display all similar device group names
    Navigate to Module    ${MODULE_PACKAGE_POLICY}
    Input Device Group    ${TEST_TITLE}        
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Device Group of Package Policy in Result Table    ${TEST_TITLE}

Package Policy - List - searching exact package name by not case sensitive with Device Group should be displayed
    Navigate to Module    ${MODULE_PACKAGE_POLICY}
    Select Equals or Begin with    ${EQUAL}
    Select Case Sensitive or Case Insensitive    ${CASE_INSENSITIVE}
    Input Package Name in Package Policy    COM.ro.dont.delete
    Select AND OR Operation    ${OPERATION_AND}  
    Input Device Group    ro-dg-dont-delete      
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Device Group AND Package of Package Policy in Result Table    COM.ro.dont.delete    ro-dg-dont-delete 

Package Policy - List - searching package name partially by case sensitive with Device Group should be displayed
    Navigate to Module    ${MODULE_PACKAGE_POLICY}
    Select Equals or Begin with    ${EQUAL}
    Select Case Sensitive or Case Insensitive    ${CASE_SENSITIVE}
    Input Package Name in Package Policy    com.ro.dont.delete
    Select AND OR Operation    ${OPERATION_OR}
    Input Device Group    refresh-test    
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Device Group OR Package of Package Policy in Result Table    com.ro.dont.delete    refresh-test

Package Policy - Details - details page should be correct
    Navigate to Module    ${MODULE_PACKAGE_POLICY}
    Select Equals or Begin with    ${EQUAL}
    Select Case Sensitive or Case Insensitive    ${CASE_INSENSITIVE}
    Input Package Name in Package Policy    test.ascacqwe
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Click Searched Package Policy    test.ascacqwe
    Verify Package Policy Details Page Component

Package Policy - Details - device policy details page should be redirected to device policy list page when List button is clicked
        Navigate to Module    ${MODULE_PACKAGE_POLICY}
    Select Equals or Begin with    ${EQUAL}
    Select Case Sensitive or Case Insensitive    ${CASE_INSENSITIVE}
    Input Package Name in Package Policy    test.ascacqwe
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Click Searched Package Policy    test.ascacqwe
    Click List Button
    Verify Package Policy Page Component
    [Teardown]    Close Browser
