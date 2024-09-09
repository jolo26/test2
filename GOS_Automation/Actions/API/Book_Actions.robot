*** Settings ***
Resource  SRPHAuto/APIActions.robot
Resource  ../../TestData/Common.robot

*** Variables ***
${url}        https://gos-adin-api.stg-gos-gsp.io/api/packages
*** Keywords ***
Get Book
    [Arguments]  ${session_alias}=${None}
    # &{params}  Create Dictionary  ISBN=${isbn}
    # ${token}  Get Variable Value    $DEFAULT_TOKEN
    # &{headers}  Create Dictionary  &{DEFAULT_HEADERS}  Authorization=Bearer ${token}
    ${response}  Call GET Request  Get_Book    url=${url}
    ${value}    Extract Value From Response    Get_Book    ${response}    
    Log To Console    ${value} 
    # RETURN  ${response}

Get Package
    [Arguments]    ${package}
    ${response}    Call GET Request    $request_name
