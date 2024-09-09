*** Settings ***
Documentation   A set of keywords for mobile automation. There are pre-defined keywords for starting
...             sessions with commonly used scenarios such as opening browsers, opening existing applications,
...             and installing applications. Some keywords are applicable in Android only.
...             Also, take note that to be able to use default values for the Appium Server URL, port,
...             and default capabilities, make sure to declare the following in a file that will be imported
...             using the 'Resources' section or can be set using 'Set Test Variable':
...             BASE_APPIUM_SERVER_URL - the base url where the appium server was started.
...             DEFAULT_PORT - the port where the appium server was started.
...             DEFAULT_CAPABILITIES - the common capabilities that will be applied in most test scenarios
...             CHROMEDRIVER_EXEC_PATH - the path to a writable directory on the Appium server's host,
...             where new Chromedriver binaries can be downloaded and executed from
...             CHROME_MAPPING_FILE_PATH - the path to a JSON file on the Appium server's host, where a mapping
...             will be stored of Chromedriver versions to Chrome support
...             DEFAULT_APPIUM_TIMEOUT - the timeout in seconds that will be used by all Appium Wait keywords if no
...             timeout is set. Use this wisely so you won't have to specify timeouts per keyword.
...             All these variables are pre-declared in RobotFramework-TestFramework/TestData/Common.robot file
Library         AppiumLibrary
Library         Collections
Library         OperatingSystem
Library         DateTime

*** Keywords ***
## SESSIONS ##
Launch Customized Session
    [Documentation]  Starts a session with the given capabilities set.
    ...  Arguments:
    ...  device_info: (dict) Contains the basic information of the device which should include platformName
    ...  platformVersion, and udid(for Android) or deviceName(for iOS) at the very least
    ...  automation_name: (string) Set to UiAutomator2 by default. Change this if you would like to use a different
    ...  automation driver
    ...  alias: (string) A name set for your session. If you will be using more than 1 device in a testcase you can switch
    ...  between devices easily by using the alias of the session.
    ...  url: (string) The base url of the appium server where connection will be established.
    ...  URL is set to localhost as default.
    ...  port: (string) The port of the appium server where connection will be established
    ...  Port is set to 4273 as default.
    ...  adb_exec_timeout: (string) The waiting period for an adb command to finish. This is set to 20000ms by default.
    ...  appium_timeout: (string) Timeout used for Appium Wait keywords. Default timeout will be used if this is not set.
    ...  custom_capabilities: (dict) all the other needed capabilities of the test scenario.
    [Arguments]  ${device_info}  ${automation_name}=${None}  ${alias}=${None}  ${url}=${None}
    ...  ${port}=${None}  ${adb_exec_timeout}=${None}  ${appium_timeout}=${None}  &{custom_capabilities}
    ${url}  ${port}  ${appium_timeout}  Get Environment  ${url}  ${port}  ${appium_timeout}
    ${capabilities}  Create Device Capabilities  ${device_info}  ${automation_name}  ${alias}
    ...  ${adb_exec_timeout}  &{custom_capabilities}
    Open Application   ${url}:${port}/wd/hub  &{capabilities}
    Set Appium Timeout  ${appium_timeout}

Open Existing Application
    [Documentation]  Starts a session then opens an existing application in the device.
    ...  Arguments:
    ...  device_info: (dict) Contains the basic information of the device which should include platformName
    ...  platformVersion, and udid(for Android) or deviceName(for iOS) at the very least
    ...  app_package: (string) Package name of the app to be opened
    ...  app_activity: (string) The desired activity of the app that will be opened
    ...  app_wait_activity: (string) The activity that appium will wait for once the app is launched.
    ...  automation_name: (string) Set to UiAutomator2 by default. Change this if you would like to use a different
    ...  automation driver
    ...  alias: (string) A name set for your session. If you will be using more than 1 device in a testcase you can switch
    ...  between devices easily by using the alias of the session.
    ...  url : (string) The base url of the appium server where connection will be established.
    ...  URL is set to localhost as default.
    ...  port : (string) The port of the appium server where connection will be established
    ...  Port is set to 4273 as default.
    ...  adb_exec_timeout: (string) The waiting period for an adb command to finish. This is set to 20000ms by default.
    ...  appium_timeout: (string) Timeout used for Appium Wait keywords. Default timeout will be used if this is not set.
    [Arguments]  ${device_info}  ${app_package}  ${app_activity}  ${app_wait_activity}=${None}
    ...  ${automation_name}=${None}  ${alias}=${None}
    ...  ${url}=${None}  ${port}=${None}  ${adb_exec_timeout}=${None}  ${appium_timeout}=${None}
    ${url}  ${port}  ${appium_timeout}  Get Environment  ${url}  ${port}  ${appium_timeout}
    ${capabilities}  Create Device Capabilities  ${device_info}  ${automation_name}
    ...  ${alias}  ${adb_exec_timeout}  appPackage=${app_package}  appActivity=${app_activity}
    IF  '${app_wait_activity}' != '${None}'  Set To Dictionary   ${capabilities}  appWaitActivity=${app_wait_activity}
    Open Application   ${url}:${port}/wd/hub  &{capabilities}
    Set Appium Timeout  ${appium_timeout}

Install Application
    [Documentation]  Starts a session then installs an application. Opening the application is optional.
    ...  Arguments:
    ...  device_info: (dict) Contains the basic information of the device which should include platformName
    ...  platformVersion, and udid(for Android) or deviceName(for iOS) at the very least
    ...  app_file_path :  (string) The absolute file path where the apk file is located.
    ...  open_application : (boolean) Launches the application after installation if this is set to True.
    ...  app_wait_activity : (string) If the first application activity upon launching the app is not the MainActivity,
    ...  then this has to be set to the expected activity upon launching. Otherwise, it can be ignored.
    ...  automation_name: (string) Set to UiAutomator2 by default. Change this if you would like to use a different
    ...  automation driver
    ...  alias: (string) A name set for your session. If you will be using more than 1 device in a testcase you can switch
    ...  between devices easily by using the alias of the session.
    ...  url : (string) The base url of the appium server where connection will be established.
    ...  URL is set to localhost as default.
    ...  port : (string) The port of the appium server where connection will be established
    ...  Port is set to 4273 as default.
    ...  adb_exec_timeout: (string) The waiting period for an adb command to finish. This is set to 20000ms by default.
    ...  appium_timeout: (string) Timeout used for Appium Wait keywords. Default timeout will be used if this is not set.
    [Arguments]  ${device_info}  ${app_file_path}  ${open_application}=${False}
    ...  ${app_wait_activity}=${None}  ${automation_name}=${None}  ${alias}=${None}
    ...  ${url}=${None}  ${port}=${None}  ${adb_exec_timeout}=${None}  ${appium_timeout}=${None}
    ${url}  ${port}  ${appium_timeout}  Get Environment  ${url}  ${port}  ${appium_timeout}
    ${capabilities}  Create Device Capabilities  ${device_info}  ${automation_name}
    ...  ${alias}  ${adb_exec_timeout}  app=${app_file_path}  autoLaunch=${open_application}
    IF  '${app_wait_activity}' != '${None}'  Set To Dictionary  ${capabilities}  appWaitActivity=${app_wait_activity}
    Open Application   ${url}:${port}/wd/hub  &{capabilities}
    Set Appium Timeout  ${appium_timeout}

Open Browser
    [Documentation]  Starts a session then launches the browser specified. Setting of driver executable path is only
    ...  applicable for Chrome driver
    ...  Arguments:
    ...  device_info: (dict) Contains the basic information of the device which should include platformName
    ...  platformVersion, and udid(for Android) or deviceName(for iOS) at the very least
    ...  browser: (string) The browser to be launched.
    ...  set_driver_exec_path: (boolean) Sets the default directory where chromedriver binaries can be downloaded to or
    ...  executed from.
    ...  automation_name: (string) Set to UiAutomator2 by default. Change this if you would like to use a different
    ...  automation driver
    ...  alias: (string) A name set for your session. If you will be using more than 1 device in a testcase you can switch
    ...  between devices easily by using the alias of the session.
    ...  url : (string) The base url of the appium server where connection will be established.
    ...  URL is set to localhost as default.
    ...  port : (string) The port of the appium server where connection will be established
    ...  Port is set to 4273 as default.
    ...  adb_exec_timeout: (string) The waiting period for an adb command to finish. This is set to 20000ms by default.
    ...  appium_timeout: (string) Timeout used for Appium Wait keywords. Default timeout will be used if this is not set.
    [Arguments]  ${device_info}  ${browser}  ${set_driver_exec_path}=False
    ...  ${automation_name}=${None}  ${alias}=${None}  ${url}=${None}  ${port}=${None}
    ...  ${adb_exec_timeout}=${None}  ${appium_timeout}=${None}
    ${url}  ${port}  ${appium_timeout}  Get Environment  ${url}  ${port}  ${appium_timeout}
    ${capabilities}  Create Device Capabilities  ${device_info}  ${automation_name}  ${alias}  ${adb_exec_timeout}
    ...  browserName=${browser}
    IF  ${set_driver_exec_path}
        ${chrome_executable_path}  Get Variable Value  $CHROMEDRIVER_EXEC_PATH
        ${chrome_mapping_path}  Get Variable Value  $CHROME_MAPPING_FILE_PATH
        Set To Dictionary  ${capabilities}  chromedriverExecutableDir=${chrome_executable_path}
        Set To Dictionary  ${capabilities}  chromedriverChromeMappingFile=${chrome_mapping_path}
    END
    Open Application   ${url}:${port}/wd/hub  &{capabilities}
    Set Appium Timeout  ${appium_timeout}

## Network Connection Actions ##
Turn On Wifi
    [Documentation]  Turns Wi-Fi on. This is for Android only.
    ${network_conn_status}  Get Network Connection Status
    IF  ${network_conn_status} == 2 or ${network_conn_status} == 6
        Log  Wi-Fi is already turned on.
    ELSE IF  ${network_conn_status} == 4
        Set Network Connection Status  6
    ELSE
        Set Network Connection Status  2
    END
    ${current_network_status}  Get Network Connection Status
    Wait Until Keyword Succeeds  3x  1s  Should Be True  ${current_network_status} == 6 or ${current_network_status} == 2

Turn Off Wifi
    [Documentation]  Turns Wi-Fi off. This is for Android only.
    ${network_conn_status}  Get Network Connection Status
    IF  ${network_conn_status} == 0 or ${network_conn_status} == 1 or ${network_conn_status} == 4
        Log  Wi-Fi is already turned off.
    ELSE IF  ${network_conn_status} == 2
        Set Network Connection Status  0
    ELSE IF  ${network_conn_status} == 6
        Set Network Connection Status  4
    END
    ${current_network_status}  Get Network Connection Status
    Wait Until Keyword Succeeds  3x  1s  Should Be True  ${current_network_status} == 0 or ${current_network_status} == 4

Turn On Mobile Data
    [Documentation]  Turns mobile data on. This is for Android only.
    ${network_conn_status}  Get Network Connection Status
    IF  ${network_conn_status} == 4 or ${network_conn_status} == 6
        Log  Mobile Data is already turned on.
    ELSE IF  ${network_conn_status} == 2
        Set Network Connection Status  6
    ELSE
        Set Network Connection Status  4
    END
    ${current_network_status}  Get Network Connection Status
    Wait Until Keyword Succeeds  3x  1s  Should Be True  ${current_network_status} == 6 or ${current_network_status} == 4

Turn Off Mobile Data
    [Documentation]  Turns mobile data off. This is for Android only.
    ${network_conn_status}  Get Network Connection Status
    IF  ${network_conn_status} == 0 or ${network_conn_status} == 1 or ${network_conn_status} == 2
        Log  Wi-Fi is already turned off.
    ELSE IF  ${network_conn_status} == 4
        Set Network Connection Status  0
    ELSE IF  ${network_conn_status} == 6
        Set Network Connection Status  2
    END
    ${current_network_status}  Get Network Connection Status
    Wait Until Keyword Succeeds  3x  1s  Should Be True  ${current_network_status} == 0 or ${current_network_status} == 2

Turn On Airplane Mode
    [Documentation]  Turns on airplane mode. This is for Android only.
    ${network_conn_status}  Get Network Connection Status
    Set Test Variable  ${initial_conn_status}  ${network_conn_status}
    IF  ${network_conn_status} != 1  Set Network Connection Status  1
    ${current_network_status}  Get Network Connection Status
    Wait Until Keyword Succeeds  3x  1s  Should Be True  ${current_network_status} == ${initial_conn_status}

Turn Off Airplane Mode
    [Documentation]  Turns off airplane mode. This is for Android only.
    ${network_conn_status}  Get Network Connection Status
    IF  ${network_conn_status} == 1
        Set Network Connection Status  ${initial_conn_status}
    ELSE
        Log  Airplane mode is already turned off.
    END
    ${current_network_status}  Get Network Connection Status
    Wait Until Keyword Succeeds  3x  1s  Should Be True  ${current_network_status} == 1

## Element Actions ##
Wait And Clear Text
    [Documentation]  This is a series of chained Appium keywords, that first waits until the text field exists in the page,
    ...  and then clears it.
    ...  locator : (string) An xml/html locator(XPATH, ID, NAME, etc)
    ...  timeout : (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${timeout}=${None}
    Wait Until Page Contains Element  ${locator}  ${timeout}
    Clear Text  ${locator}

Wait And Click Element
    [Documentation]  This is a series of chained Appium keywords, that first waits until the element exists in the page,
    ...  and then clicks it.
    ...  locator : (string) An xml/html locator(XPATH, ID, NAME, etc)
    ...  timeout : (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${timeout}=${None}
    Wait Until Page Contains Element  ${locator}  ${timeout}
    Click Element  ${locator}

Enter Text
    [Documentation]  This is a series of chained Appium keywords, that first waits until the element exists in the page
    ...  and then inputs text.
    ...  locator : (string) An xml/html locator(XPATH, ID, NAME, etc)
    ...  timeout : (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${text}  ${timeout}=${None}
    Wait Until Page Contains Element  ${locator}  ${timeout}
    Input Text  ${locator}  ${text}

## Mobile Button Actions ##
Press Mobile Back Button ${count} Times
    [Documentation]  Presses mobile back button. This is for Android only.
    ...              Arguments:
    ...              count: (string)  The number of times pressing of back button will be done.
    Repeat Keyword  ${count} times  Press Keycode  ${4}

Press Home Button ${count} Times
    [Documentation]  Presses mobile home button. This is for Android only.
    ...              Arguments:
    ...              count: (string)  The number of times pressing of home button will be done.
    Repeat Keyword  ${count} times  Press Keycode  ${3}

Press Power Button ${count} Times
    [Documentation]  Presses mobile power button. This is for Android only.
    ...              Arguments:
    ...              count: (string)  The number of times pressing of power button will be done.
    Repeat Keyword  ${count} times  Press Keycode  ${26}

Press Volume Up ${count} Times
    [Documentation]  Presses mobile volume up button. This is for Android only.
    ...              Arguments:
    ...              count: (string)  The number of times pressing of volume up button will be done.
    Repeat Keyword  ${count} times  Press Keycode  ${24}

Press Volume Down ${count} Times
    [Documentation]  Presses mobile volume down button. This is for Android only.
    ...              Arguments:
    ...              count: (string)  The number of times pressing of volume down button will be done.
    Repeat Keyword  ${count} times  Press Keycode  ${25}

## Date And Time Actions ##
Set Device Date And Time
    [Documentation]  Sets the device's date and time. Make sure to set --relaxed-security flag when starting the
    ...              appium server to be able to use this keyword. This is for Android only.
    ...              Arguments:
    ...              all arguments should follow 2-digit format
    [Arguments]  ${month}  ${day}  ${year}  ${hour}  ${minute}  ${second}
    Execute Adb Shell    date  ${month}${day}${hour}${minute}${year}.${second}

Sync Device Date And Time With Local System
    [Documentation]  Retrieves the local system's current date and time and syncs the device's date and time. Make sure
    ...              to set --relaxed-security flag when starting the appium server to be able to use this keyword.
    ...              This is for Android only.
    ${local_system_time}  Get Current Date  time_zone=local  result_format=%m%d%H%M%Y.%S
    Execute Adb Shell    date  ${local_system_time}

## Gestures ##
Swipe ${swipe_direction} ${count} Times
    [Documentation]  Executes swipe gesture a number of times.
    ...              Arguments:
    ...              count: (string)  The number of times swipe left will be done.
    ...              swipe_direction: (string)  Direction of swipe gesture(e.g. left, right, up, down)
    IF  '${swipe_direction.lower()}' == 'left'
        Repeat Keyword  ${count} times  Swipe By Percent    80    50    30    50
    ELSE IF  '${swipe_direction.lower()}' == 'right'
        Repeat Keyword  ${count} times  Swipe By Percent    30    50    80    50
    ELSE IF  '${swipe_direction.lower()}' == 'up'
        Repeat Keyword  ${count} times  Swipe By Percent    50    80    50    30
    ELSE IF  '${swipe_direction.lower()}' == 'down'
        Repeat Keyword  ${count} times  Swipe By Percent    50    30    50    80
    ELSE
        Fail  Swipe direction not valid.
    END

Swipe Until Element Is Visible
    [Documentation]  Performs swipe gestures until element is visible.
    ...              Arguments:
    ...              locator: (string) An xml/html locator(XPATH, ID, NAME, etc)
    ...              swipe_direction: (string)  Direction of swipe gesture(e.g. left, right, up, down)
    ...              limit: (string) The max threshold of iterations of the while loop to avoid infinite looping.
    [Arguments]  ${locator}  ${swipe_direction}  ${limit}=10
    ${is_visible}  Run Keyword And Return Status  Element Is Visible  ${locator}
    WHILE  not ${is_visible}  limit=${limit}
        Swipe ${swipe_direction} 1 Times
        ${is_visible}  Run Keyword And Return Status  Element Is Visible  ${locator}
    END

## Verifications ##
Element Attribute Value Matches Pattern
    [Documentation]  This is a series of chained Appium keywords, that first waits until the element exists in the page
    ...  and then checks the value of the element's attribute if it matches the given pattern.
    ...  locator : (string) An xml/html locator(XPATH, ID, NAME, etc)
    ...  attribute_name : (string) The element's attribute where the value will be retrieved (name, text, class, etc)
    ...  pattern : (string) The pattern where the value will be compared if it matches.
    ...  regexp : Set to True if you want to use regular expressions for the pattern.
    ...  timeout : (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${attribute_name}  ${pattern}  ${regexp}=False   ${timeout}=${None}
    Wait Until Page Contains Element  ${locator}  ${timeout}
    Element Attribute Should Match  ${locator}  ${attribute_name}  ${pattern}  ${regexp}

Element Is Disabled
    [Documentation]  This is a series of chained Appium keywords, that first waits until the element exists in the page
    ...  and then checks if the element is disabled.
    ...  locator : (string) An xml/html locator(XPATH, ID, NAME, etc)
    ...  timeout : (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${timeout}=${None}
    Wait Until Page Contains Element  ${locator}  ${timeout}
    Element Should Be Disabled  ${locator}

Element Is Enabled
    [Documentation]  This is a series of chained Appium keywords, that first waits until the element exists in the page
    ...  and then checks if the element is enabled.
    ...  locator : (string) An xml/html locator(XPATH, ID, NAME, etc)
    ...  timeout : (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${timeout}=${None}
    Wait Until Page Contains Element  ${locator}  ${timeout}
    Element Should Be Enabled  ${locator}

Element Is Visible
    [Documentation]  This is a series of chained Appium keywords, that first waits until the element exists in the page
    ...  and then checks if the element is visible.
    ...  locator : (string) An xml/html locator(XPATH, ID, NAME, etc)
    ...  timeout : (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${timeout}=${None}
    Wait Until Page Contains Element  ${locator}  ${timeout}
    Element Should Be Visible  ${locator}

Element Contains Text
    [Documentation]  This is a series of chained Appium keywords, that first waits until the element exists in the page
    ...  and then checks if the element contains specific text.
    ...  locator : (string) An xml/html locator(XPATH, ID, NAME, etc)
    ...  timeout : (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${text}  ${timeout}=${None}
    Wait Until Page Contains Element  ${locator}  ${timeout}
    Element Should Contain Text  ${locator}  ${text}

Element Does Not Contain Text
    [Documentation]  This is a series of chained Appium keywords, that first waits until the element exists in the page
    ...  and then checks if the element does not contain specific text.
    ...  locator : (string) An xml/html locator(XPATH, ID, NAME, etc)
    ...  timeout : (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${text}  ${timeout}=${None}
    Wait Until Page Contains Element  ${locator}  ${timeout}
    Element Should Not Contain Text  ${locator}  ${text}

Element Text Equals
    [Documentation]  This is a series of chained Appium keywords, that first waits until the element exists in the page
    ...  and then checks if the element contains the exact text.
    ...  locator : (string) An xml/html locator(XPATH, ID, NAME, etc)
    ...  timeout : (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${text}  ${timeout}=${None}
    Wait Until Page Contains Element  ${locator}  ${timeout}
    Element Text Should Be  ${locator}  ${text}

Element Value Equals
    [Documentation]  This is a series of chained Appium keywords, that first waits until the element exists in the page
    ...  and then checks if the element's attribute value is equal to expected value.
    ...  locator : (string) An xml/html locator(XPATH, ID, NAME, etc)
    ...  timeout : (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${value}  ${timeout}=${None}
    Wait Until Page Contains Element  ${locator}  ${timeout}
    Element Value Should Be  ${locator}  ${value}

## Helpers ##
Create Device Capabilities
    [Documentation]  Collates all the capabilities specified in the project in one dictionary.
    ...   Arguments:
    ...   platform_name: (string) The type of operating system being used by the device (e.g. Android, iOS)
    ...   platform_version: (string) The current operating system version of the device.
    ...   udid: (string) The specific device ID of the device to be automated.
    ...   additional_caps:  pass all the other capabilities needed to satisfy the test scenario
    [Arguments]  ${device_info}  ${automation_name}=${None}  ${alias}=${None}  ${adb_exec_timeout}=${None}  &{custom_capabilities}
    &{capabilities}  Create Dictionary  &{device_info}
    &{default_capabilities}  Get Variable Value  $DEFAULT_CAPABILITIES
    Set To Dictionary  ${capabilities}  &{default_capabilities}
    IF  '${automation_name}' != '${None}'  Set To Dictionary  ${capabilities}  automationName=${automation_name}
    IF  '${adb_exec_timeout}' != '${None}'  Set To Dictionary  ${capabilities}  adbExecTimeout=${adb_exec_timeout}
    IF  '${alias}' != '${None}'  Set To Dictionary   ${capabilities}  alias=${alias}
    Set To Dictionary  ${capabilities}  &{custom_capabilities}
    RETURN  ${capabilities}

Get Environment
    [Documentation]  Retrieves the default Appium Server URL and port where the session will be established
    ...              if there is none specified.
    [Arguments]  ${url}  ${port}  ${appium_timeout}
    ${url}  IF  '${url}' == '${None}'  Get Variable Value  $BASE_APPIUM_SERVER_URL  ELSE  Set Variable  ${url}
    ${port}  IF  '${port}' == '${None}'  Get Variable Value  $DEFAULT_PORT  ELSE  Set Variable  ${port}
    ${appium_timeout}  IF  '${appium_timeout}' == '${None}'  Get Variable Value  $DEFAULT_APPIUM_TIMEOUT  ELSE  Set Variable  ${appium_timeout}
    RETURN  ${url}  ${port}  ${appium_timeout}