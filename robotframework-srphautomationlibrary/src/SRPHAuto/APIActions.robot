*** Settings ***
Documentation    A set of keywords for calling API. Users have the ability to set a predefined session instance that can be reused throughout the whole test.
...              Below are the needed variables for the API keywords to work. Note that they should be either declared in the `Resources` Section or declared by
...              keywords that set variables that are not in local scope (Preferrably Set Test Variable.)
...              EXAMPLE_PATH - path where `Example` folder is located. Here, we place the example json of the endpoint (can be copied from swagger documentation)
...              MAPPING_PATH - path where `Mapping` folder is located. Here, we place the json request mapping of the endpoint 
...              (key is the json path name, value is the jsonPath)
...              RESPONSE_MAPPING_PATH - path where `ResponseMapping` folder is located. Here, we place the json response mapping of the endpoint 
...              (key is the json path name, value is the jsonPath)
...              DEFAULT_PATH - path where `Defaults` folder is located. Here, we place the default values of the endpoint (key is the json path name, value is the data)
...              DEFAULT_HEADERS - a dictionary containing the default headers that all the endpoints use.
...              RESPONSE_TIMEOUT - maximum timeout for waiting the response
...              <<REQUEST_NAME>>_ENDPOINT - the variable containing the actual endpoint of the request name being called.
...              API_URL - variable to store the API base URL.
Library          SRPHAuto.APILibrary
Library          RequestsLibrary
Library          OperatingSystem
Library          Collections

*** Keywords ***
Call GET Request
    [Documentation]  Arguments:
    ...  request_name: (string) the identifier of the request. should be the same file name as the json files for that endpoint.
    ...  url: (string) the base url. can be left undeclared so it will use the deafult API_URL.
    ...  endpoint: (string) the endpoint. can be left undeclared so it will use the deafult <<request_name>>_endpoint.
    ...  session_alias: (string) the name of the predefined session instance created. can be left undeclared so it will automatically create a single use api session.
    ...  headers: (dict) contains a set of desired headers for the request. can be left undeclared so it will use DEFAULT_HEADERS value.
    ...  params: (dict) contains a set of params for the request. can be left undeclared if the endpoint doesn't need it.
    ...  cookies: (dict) contains a set of cookies for the request. can be left undeclared if the endpoint doesn't need it.
    ...  timeout: (int) timeout value in seconds. can be left undeclared so it will use REQUEST_TIMEOUT value.
    ...  custom_parameters: (dict) contains a set of additional custom parameters that are needed by the request.
    [Arguments]  ${request_name}  ${url}=${None}  ${endpoint}=${None}  ${session_alias}=${None}  ${headers}=${None}  ${params}=${None}  ${cookies}=${None}  
    ...  ${timeout}=${None}  &{custom_parameters}
    ${url}  ${timeout}  ${endpoint}  Retrieve Default API Values  ${request_name}  ${url}  ${timeout}  ${endpoint}
    ${session_alias}  IF  '${session_alias}' == '${None}'  Prepare Session  getapi  ${url}  ${headers}  ${cookies}  ${timeout}  False  
    ...  ELSE  Set Variable  ${session_alias}
    ${response}  GET On Session  ${session_alias}  ${endpoint}  params=${params}  timeout=${timeout}  expected_status=any  &{custom_parameters}
    RETURN  ${response}

Call POST Request
    [Documentation]  Arguments:
    ...  request_name: (string) the identifier of the request. should be the same file name as the json files for that endpoint.
    ...  url: (string) the base url. can be left undeclared so it will use the deafult API_URL.
    ...  endpoint: (string) the endpoint. can be left undeclared so it will use the deafult <<request_name>>_endpoint.
    ...  session_alias: (string) the name of the predefined session instance created. can be left undeclared so it will automatically create a single use api session.
    ...  headers: (dict) contains a set of desired headers for the request. can be left undeclared so it will use DEFAULT_HEADERS value.
    ...  params: (dict) contains a set of params for the request. can be left undeclared if the endpoint doesn't need it.
    ...  cookies: (dict) contains a set of cookies for the request. can be left undeclared if the endpoint doesn't need it.
    ...  timeout: (int) timeout value in seconds. can be left undeclared so it will use REQUEST_TIMEOUT value.
    ...  custom_parameters: (dict) contains a set of additional custom parameters that are needed by the request. especially useful for setting up additional values
    ...  in the request body aside from the default parameters set for the endpoint.
    [Arguments]  ${request_name}  ${url}=${None}  ${endpoint}=${None}  ${session_alias}=${None}  ${headers}=${None}  ${files}=${None}  ${cookies}=${None}  
    ...  ${timeout}=${None}  &{custom_parameters}
    ${url}  ${timeout}  ${endpoint}  Retrieve Default API Values  ${request_name}  ${url}  ${timeout}  ${endpoint}
    ${data}  Generate Request Body  ${request_name}  &{custom_parameters}
    ${session_alias}  IF  '${session_alias}' == '${None}'  Prepare Session  postapi  ${url}  ${headers}  ${cookies}  ${timeout}  False  
    ...  ELSE  Set Variable  ${session_alias}
    ${response}  POST On Session  ${session_alias}  ${endpoint}  data=${data}  files=${files}  timeout=${timeout}  expected_status=any
    RETURN  ${response}

Call PUT Request
    [Documentation]  Arguments:
    ...  request_name: (string) the identifier of the request. should be the same file name as the json files for that endpoint.
    ...  url: (string) the base url. can be left undeclared so it will use the deafult API_URL.
    ...  endpoint: (string) the endpoint. can be left undeclared so it will use the deafult <<request_name>>_endpoint.
    ...  session_alias: (string) the name of the predefined session instance created. can be left undeclared so it will automatically create a single use api session.
    ...  headers: (dict) contains a set of desired headers for the request. can be left undeclared so it will use DEFAULT_HEADERS value.
    ...  params: (dict) contains a set of params for the request. can be left undeclared if the endpoint doesn't need it.
    ...  cookies: (dict) contains a set of cookies for the request. can be left undeclared if the endpoint doesn't need it.
    ...  timeout: (int) timeout value in seconds. can be left undeclared so it will use REQUEST_TIMEOUT value.
    ...  custom_parameters: (dict) contains a set of additional custom parameters that are needed by the request. especially useful for setting up additional values
    ...  in the request body aside from the default parameters set for the endpoint.
    [Arguments]  ${request_name}  ${url}=${None}  ${endpoint}=${None}  ${session_alias}=${None}  ${headers}=${None}  ${cookies}=${None}  
    ...  ${timeout}=${None}  &{custom_parameters}
    ${url}  ${timeout}  ${endpoint}  Retrieve Default API Values  ${request_name}  ${url}  ${timeout}  ${endpoint}
    ${data}  Generate Request Body    ${request_name}  &{custom_parameters}
    ${session_alias}  IF  '${session_alias}' == '${None}'  Prepare Session  putapi  ${url}  ${headers}  ${cookies}  ${timeout}  False  
    ...  ELSE  Set Variable  ${session_alias}
    ${response}  PUT On Session  ${session_alias}  ${endpoint}  data=${data}  timeout=${timeout}  expected_status=any
    RETURN  ${response}

Call DELETE Request
    [Documentation]  Arguments:
    ...  request_name: (string) the identifier of the request. should be the same file name as the json files for that endpoint.
    ...  url: (string) the base url. can be left undeclared so it will use the deafult API_URL.
    ...  endpoint: (string) the endpoint. can be left undeclared so it will use the deafult <<request_name>>_endpoint.
    ...  session_alias: (string) the name of the predefined session instance created. can be left undeclared so it will automatically create a single use api session.
    ...  headers: (dict) contains a set of desired headers for the request. can be left undeclared so it will use DEFAULT_HEADERS value.
    ...  params: (dict) contains a set of params for the request. can be left undeclared if the endpoint doesn't need it.
    ...  cookies: (dict) contains a set of cookies for the request. can be left undeclared if the endpoint doesn't need it.
    ...  timeout: (int) timeout value in seconds. can be left undeclared so it will use REQUEST_TIMEOUT value.
    ...  custom_parameters: (dict) contains a set of additional custom parameters that are needed by the request.
    [Arguments]  ${request_name}  ${url}=${None}  ${endpoint}=${None}  ${session_alias}=${None}  ${headers}=${None}  ${cookies}=${None}  
    ...  ${timeout}=${None}  &{custom_parameters}
    ${url}  ${timeout}  ${endpoint}  Retrieve Default API Values  ${request_name}  ${url}  ${timeout}  ${endpoint}
    ${session_alias}  IF  '${session_alias}' == '${None}'  Prepare Session  deleteapi  ${url}  ${headers}  ${cookies}  ${timeout}  False  
    ...  ELSE  Set Variable  ${session_alias}
    ${response}  DELETE On Session  ${session_alias}  ${endpoint}  timeout=${timeout}  expected_status=any  &{custom_parameters}
    RETURN  ${response}

Call PATCH Request
    [Documentation]  Arguments:
    ...  request_name: (string) the identifier of the request. should be the same file name as the json files for that endpoint.
    ...  url: (string) the base url. can be left undeclared so it will use the deafult API_URL.
    ...  endpoint: (string) the endpoint. can be left undeclared so it will use the deafult <<request_name>>_endpoint.
    ...  session_alias: (string) the name of the predefined session instance created. can be left undeclared so it will automatically create a single use api session.
    ...  headers: (dict) contains a set of desired headers for the request. can be left undeclared so it will use DEFAULT_HEADERS value.
    ...  params: (dict) contains a set of params for the request. can be left undeclared if the endpoint doesn't need it.
    ...  cookies: (dict) contains a set of cookies for the request. can be left undeclared if the endpoint doesn't need it.
    ...  timeout: (int) timeout value in seconds. can be left undeclared so it will use REQUEST_TIMEOUT value.
    ...  custom_parameters: (dict) contains a set of additional custom parameters that are needed by the request. especially useful for setting up additional values
    ...  in the request body aside from the default parameters set for the endpoint.
    [Arguments]  ${request_name}  ${url}=${None}  ${endpoint}=${None}  ${session_alias}=${None}  ${headers}=${None}  ${cookies}=${None}  
    ...  ${timeout}=${None}  &{custom_parameters}
    ${url}  ${timeout}  ${endpoint}  Retrieve Default API Values  ${request_name}  ${url}  ${timeout}  ${endpoint}
    ${data}  Generate Request Body    ${request_name}  &{custom_parameters}
    ${session_alias}  IF  '${session_alias}' == '${None}'  Prepare Session  patchapi  ${url}  ${headers}  ${cookies}  ${timeout}  False  
    ...  ELSE  Set Variable  ${session_alias}
    ${response}  PATCH On Session  ${session_alias}  ${endpoint}  data=${data}  timeout=${timeout}  expected_status=any  &{custom_parameters}
    RETURN  ${response}

Generate Request Body
    [Documentation]  auto-generates the request body desired to perform the call. Please see the diagram in README for the detailed explanation.
    [Arguments]  ${request_name}  &{custom_parameters}
    ${example_path}  Get Variable Value  $EXAMPLE_PATH
    ${mapping_path}  Get Variable Value  $MAPPING_PATH
    ${default_path}  Get Variable Value  $DEFAULT_PATH
    ${FULL_EXAMPLE_PATH}  Set Variable  ${EXAMPLE_PATH}${/}${request_name}.json
    ${FULL_MAPPING_PATH}  Set Variable  ${MAPPING_PATH}${/}${request_name}.json
    ${FULL_DEFAULT_PATH}  Set Variable  ${DEFAULT_PATH}${/}${request_name}.json
    ${does_file_exist}  Run Keyword And Return Status  File Should Exist    ${FULL_DEFAULT_PATH}  
    ${FULL_DEFAULT_PATH}  Set Variable If  ${does_file_exist}  ${FULL_DEFAULT_PATH}  ${None}
    ${data}  Build Request Data  ${FULL_EXAMPLE_PATH}  ${FULL_MAPPING_PATH}  ${FULL_DEFAULT_PATH}  &{custom_parameters}
    RETURN  ${data}

Retrieve Default API Values
    [Documentation]  retrieves the default values for the url, timeout and endpoint if these arguments are not supplied upon keyword usage.
    [Arguments]  ${request_name}  ${url}  ${timeout}  ${endpoint}
    ${url}  IF  '${url}' == '${None}'  Get Variable Value  $API_URL  ELSE  Set Variable  ${url}
    ${timeout}  IF  '${timeout}' == '${None}'  Get Variable Value  $RESPONSE_TIMEOUT  ELSE  Set Variable  ${timeout}
    ${endpoint}  IF  '${endpoint}' == '${None}'  Get Variable Value  $${request_name.upper()}_ENDPOINT  ELSE  Set Variable  ${endpoint}
    RETURN  ${url}  ${timeout}  ${endpoint}

Prepare Session
    [Documentation]  pre-defines a session instance before the actual test. Preferrably, this is used in Test Setup.
    [Arguments]  ${session_alias}  ${url}=${None}  ${headers}=${None}  ${cookies}=${None}  ${timeout}=${None}  ${set_test_variable}=${True}
    ${url}  IF  '${url}' == '${None}'  Get Variable Value  $API_URL  ELSE  Set Variable  ${url}
    ${timeout}  IF  '${timeout}' == '${None}'  Get Variable Value  $RESPONSE_TIMEOUT  ELSE  Set Variable  ${timeout}
    ${headers}  IF  '${headers}' == '${None}'  Get Variable Value  $DEFAULT_HEADERS  ELSE  Set Variable  ${headers}
    ${session}  Create Session  ${session_alias}  ${url}  ${headers}  ${cookies}  timeout=${timeout}
    IF  ${set_test_variable}  Set Test Variable    ${session_alias}
    RETURN  ${session_alias}

Extract Value From Response
    [Documentation]  extracts the value of the supplied json path for that request name.
    ...  Arguments:
    ...  request_name: (string) the identifier of the request. should be the same file name as the json files for that endpoint.
    ...  response: (response object) the instance of the response generated upon calling the request.
    ...  json_path_name: (string) the identifier of the json_path. please refer to the response mapping json file of the request name.
    [Arguments]  ${request_name}  ${response}  ${json_path_name}
    ${response_mapping_path}  Get Variable Value  $RESPONSE_MAPPING_PATH
    ${value}  Get Value From Response    ${response}    ${response_mapping_path}${/}${request_name}.json  ${json_path_name}
    RETURN  ${value}
    
Response Value Should Be Equal
    [Documentation]  Arguments:
    ...  request_name: (string) the identifier of the request. should be the same file name as the json files for that endpoint.
    ...  response: (response object) the instance of the response generated upon calling the request.
    ...  json_path_name: (string) the identifier of the json_path. please refer to the response mapping json file of the request name.
    ...  expected_value: contains the expected value of the extracted json path query.
    [Arguments]  ${request_name}  ${response}  ${json_path_name}  ${expected_value}
    ${value}  Extract Value From Response  ${request_name}  ${response}  ${json_path_name}
    Should Be Equal As Strings    ${value}    ${expected_value}

Response Value Should Contain
    [Documentation]  Arguments:
    ...  request_name: (string) the identifier of the request. should be the same file name as the json files for that endpoint.
    ...  response: (response object) the instance of the response generated upon calling the request.
    ...  json_path_name: (string) the identifier of the json_path. please refer to the response mapping json file of the request name.
    ...  expected_value: contains the expected value of the extracted json path query.
    [Arguments]  ${request_name}  ${response}  ${json_path_name}  ${expected_value}
    ${value}  Extract Value From Response  ${request_name}  ${response}  ${json_path_name}
    Should Contain    ${value}    ${expected_value}
