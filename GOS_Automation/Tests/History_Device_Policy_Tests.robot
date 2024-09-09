*** Settings ***
Resource         ../Actions/Login_Actions.robot
Resource         ../Actions/Device_Policy_Actions.robot
Resource         ../Actions/Common_Actions.robot
Resource         ../PageObjects/Login_Page.robot
Resource         ../PageObjects/Common_Page_Object.robot
Resource         ../PageObjects/Package_Page_Object.robot
Resource         ../Constants/Common.robot
Library          ../Actions/totp.py
Suite Setup      Login user
         
*** Test Cases ***
Device Policy page component should be displayed
    Navigate to Module    ${MODULE_HISTORY_DEVICE_POLICY}
    Verify Device Policy Hstory Page Component

Device Policy - List - searching existing Device Group Name should be displayed
    Input Device Group    ro-dg-dont-delete       
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify Device Group of Device Policy in Result Table    ro-dg-dont-delete

Device Policy - List - searching data that has not been created yet should return no data in table
    Input Device Group    ${NOT_EXISTING_DATA}        
    Click Search
    Wait Until Element Is Not Visible    ${progress_bar}
    Verify No Result in Result Table