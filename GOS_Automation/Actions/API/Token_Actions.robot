*** Settings ***
Resource  SRPHAuto/APIActions.robot
Resource  ../../TestData/Common.robot

*** Keywords ***
Generate Token
    [Arguments]  ${session_alias}=${None}  &{custom_parameters}
    ${response}  Call POST Request  Generate_Token  session_alias=${session_alias}  headers=${DEFAULT_HEADERS}  &{custom_parameters}
    ${token}  Extract Value From Response    Generate_Token    ${response}  token
    Set Test Variable    ${DEFAULT_TOKEN}  ${token}
    RETURN  ${token}
