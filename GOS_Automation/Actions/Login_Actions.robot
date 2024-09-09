*** Comments ***
Please place your login actions here.


*** Settings ***
Resource    ../PageObjects/Login_Page.robot
Resource    ../Actions/Common_Actions.robot
Resource    ../TestData/Common.robot
Resource    ../TestData/Environment.robot
Resource    ExtendSeleniumActions.robot
Library     ../Actions/totp.py


*** Keywords ***
Login user
    [Arguments]    ${username}=${USERNAME}    ${password}=${PASSWORD}
    Initialize Browser
    Maximize Browser Window
    Wait And Input Text    ${username_input}    ${username}
    Wait And Input Password    ${password_input}    ${password}
    ${otp}    Get Totp    ${TOKEN}
    Wait And Input Text    ${otp_input}    ${otp}
    Wait And Click Element    ${login_btn}
    Wait And Mouse Over    ${gos_header}
    Is Element Visible    ${gos_header}
