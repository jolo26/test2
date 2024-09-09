*** Settings ***
Resource    ../src/SRPHAuto/SeleniumActions.robot
Test Teardown  Close Browser

*** Test Cases ***
Test 1
    Launch Chrome Browser
    Go To    https://www.saucedemo.com/
    Mouse Scroll  y=1
    Input Text  id:user-name  teststs