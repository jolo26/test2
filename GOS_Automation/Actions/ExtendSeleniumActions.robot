*** Settings ***
Resource   SRPHAuto/SeleniumActions.robot
Resource   ../TestData/Common.robot

*** Keywords ***
Initialize Browser
    Launch Chrome Browser  ${IS_HEADLESS}  ${INCOGNITO}  ${OPTIONS_LIST}
    Set Selenium Timeout    ${DEFAULT_TIMEOUT}
    IF  ${ENABLE_SELENIUM_SPEED}  Set Selenium Speed    ${SELENIUM_SPEED}
    Go To  ${URL}
    