*** Settings ***
Library    SRPHAuto.UILibrary
Library    SRPHAuto.FileLibrary
Library    String
Library    OperatingSystem
Library    SeleniumLibrary
Library    Collections

*** Keywords ***
Launch Chrome Browser
    [Documentation]  Arguments:
    ...  is_headless : set to True to run the test suite in headless mode
    ...  incognito : set to True to run the test suite in incognito mode
    ...  chrome_options_list: pass on all the necessary chrome options here
    [Arguments]  ${is_headless}=False  ${incognito}=False  ${chrome_options_list}=@{EMPTY}
    ${chrome_options_obj}  Create Chrome Options    ${is_headless}  ${incognito}  ${chrome_options_list}
    Create Webdriver  Chrome  options=${chrome_options_obj}

Check If Latest Chrome Is Installed
    ${is_compatible}  Check If Chrome Driver Is Compatible
    Set Task Variable   ${INSTALL_CHROME_DRIVER}  ${is_compatible}

Find Latest Webdriver Path
    [Documentation]  finds the webdriver executable in .wdm folder recursively.
    ${base_path}  Join Path  ${EXECDIR}  .wdm  drivers  chromedriver
    @{files}  Find Files  ${base_path}${/}**${/}chromedriver.exe  include_dirs=False
    [Return]  ${files}[-1]

Create Chrome Options
    [Documentation]  builds up the all the needed chrome options as well as the additional
    ...  options needed by the project that will use this keyword.
    [Arguments]  ${is_headless}  ${incognito}  ${other_chrome_options}
    ${chrome_options}  Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    IF  ${is_headless}  Call Method    ${chrome_options}    add_argument    --headless\=new
    IF  ${incognito}    Call Method    ${chrome_options}    add_argument    --incognito
    FOR  ${option}  IN  @{other_chrome_options}
        Call Method    ${chrome_options}    add_argument    ${option}
    END
    Set Download Path
    ${prefs}  Create Dictionary  download.default_directory=${DOWNLOADDIR}
    Call Method    ${chrome_options}    add_experimental_option  prefs  ${prefs}
    [Return]  ${chrome_options}

Set Download Path
    [Documentation]  setups the randomly generated path for the download files to be placed on.
    ${randomized_path}  Generate Random String  4  [LETTERS][NUMBERS]
    ${generated_path}   Join Path    ${TEMPDIR}  ${randomized_path}
    Set Suite Variable  ${DOWNLOADDIR}  ${generated_path}

Element Value Should Be Equal
    [Documentation]  Assert that the value attribute of a web element is equal to a given value
    ...  locator: (string) A selenium locator(CSS, XPATH, ID, NAME, etc)
    ...  expected_value: (string) A string or int value to be compared against the actual web element value
    ...  timeout: (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${expected_value}  ${timeout}=${None}
    Wait And Focus On Element  ${locator}  ${timeout}
    ${value}  Get Value    ${locator}
    Should Be Equal    ${value}    ${expected_value}

Element Value Should Not Be Equal
    [Documentation]  Assert that the value attribute of a web element is not equal to a given value
    ...  locator: (string) A selenium locator(CSS, XPATH, ID, NAME, etc)
    ...  expected_value: (string) A string or int value to be compared against the actual web element value
    ...  timeout: (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${expected_value}  ${timeout}=${None}
    Wait And Focus On Element  ${locator}  ${timeout}
    ${value}  Get Value    ${locator}
    Should Not Be Equal    ${value}    ${expected_value}

Verify Element Attribute
    [Documentation]  Assert that the value of attribute name web element meets the verification in the argument
    ...  locator: (string) A selenium locator(CSS, XPATH, ID, NAME, etc)
    ...  attribute_name: (string) A attribute name to be verify
    ...  expected_value: (string) A string or int value to be compared against the actual web element value
    ...  verifcation: (string)  A verification method, can be (equal, not equal, contains, empty)
    ...  timeout: (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${attribute_name}  ${expected_value}  ${verification}  ${timeout}=${None}
    Wait And Focus On Element  ${locator}  ${timeout}
    ${attribute}  SeleniumLibrary.Get Element Attribute  ${locator}  ${attribute_name}
    IF  '${verification.lower()}' == 'equal'
        Should Be Equal  ${attribute}  ${expected_value}
    ELSE IF  '${verification.lower()}' == 'not equal'
        Should Not Be Equal  ${attribute}  ${expected_value}
    ELSE IF  '${verification.lower()}' == 'contains'
        Should Contain Any  ${attribute}  ${expected_value}
    ELSE IF  '${verification.lower()}' == 'empty'
        Should Be Empty  ${attribute}
    END

Verify ${locator} Is ${verification}
    [Documentation]  Assert the element status based on verification
    ...  locator: (string) A selenium locator(CSS, XPATH, ID, NAME, etc)
    ...  verification: (string)  A verification method, can be (visible, not visible, enabled, disabled)
    IF  '${verification.lower()}' != 'not visible'  Wait And Focus On Element  ${locator}
    IF  '${verification.lower()}' == 'visible'
        SeleniumLibrary.Element Should Be Visible  ${locator}
    ELSE IF  '${verification.lower()}' == 'not visible'
        SeleniumLibrary.Element Should Not Be Visible  ${locator}
    ELSE IF  '${verification.lower()}' == 'enabled'
        SeleniumLibrary.Element Should Be Enabled  ${locator}
    ELSE IF  '${verification.lower()}' == 'disabled'
        SeleniumLibrary.Element Should Be Disabled  ${locator}
    END

Wait And Focus On Element
    [Documentation]  This is a series of chained Selenium keywords, that first waits for an element to be on the DOM, executes
    ...  Focus on it, then it waits for it to be visible.
    ...  locator: (string) A selenium locator(CSS, XPATH, ID, NAME, etc)
    ...  timeout: (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${timeout}=${None}
    IF  not ${timeout}
        ${timeout}  Get Selenium Timeout
    END
    SeleniumLibrary.Wait Until Page Contains Element  ${locator}  ${timeout}
    SeleniumLibrary.Wait Until Element Is Visible    ${locator}
    Set Log Level  ERROR
    Wait Until Keyword Succeeds    ${timeout}  500ms  Set Focus To Element  ${locator}
    [Teardown]  Set Log Level  INFO

Wait And Click Element
    [Documentation]  This is a series of chained Selenium keywords, that tries to find a web element first, and then clicks it.
    ...  If the element fails to be clicked, it will scroll to the bottom of the page and try again.
    ...  locator: (string) A selenium locator(CSS, XPATH, ID, NAME, etc)
    ...  timeout: (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${timeout}=${None}
    Wait And Focus On Element  ${locator}  ${timeout}
    Click Element  ${locator}

Wait And Input Text
    [Documentation]  This is a series of chained Selenium keywords, that tries to find a web element first, and then input text.
    ...  If the element fails to typed into, it will scroll to the bottom of the page and try again.
    ...  locator: (string) A selenium locator(CSS, XPATH, ID, NAME, etc)
    ...  text: (string) Text to be typed into the input field.
    ...  timeout: (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${text}  ${timeout}=${None}
    Wait And Focus On Element  ${locator}  ${timeout}
    Input Text  ${locator}  ${text}

Wait And Input Password
    [Documentation]  This is a series of chained Selenium keywords, that tries to find a web element first, and then input text.
    ...  The password text is not printed displayed in logs.
    ...  If the element fails to typed into, it will scroll to the bottom of the page and try again.
    ...  locator: (string) A selenium locator(CSS, XPATH, ID, NAME, etc)
    ...  password: (string) Password text to be typed into the input field.
    ...  timeout: (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${text}  ${timeout}=${None}
    Wait And Focus On Element  ${locator}  ${timeout}
    Input Password  ${locator}  ${text}

Wait And Select Frame
    [Documentation]  This is a series of chained Selenium keywords, that first waits until an iFrame exists in the page, and then
    ...  selects it.
    ...  locator: (string) A selenium locator(CSS, XPATH, ID, NAME, etc)
    ...  timeout: (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${timeout}=${None}
    Wait Until Page Contains Element    ${locator}  ${timeout}
    Select Frame  ${locator}

Select Nested Frame
    [Documentation]  Selects a frame nested in other frames
    ...  locators: (list) A list of selenium locators(CSS, XPATH, ID, NAME, etc)
    ...  Example (Selects iframe3 after traversing iframe1 and iframe2):
    ...  |  `Select Nested Frame`  |  id-iframe1  |  id=iframe2  |  id=iframe3  |
    [Arguments]  @{locators}
    FOR  ${locator}  IN  @{locators}
        Wait Until Page Contains Element  ${locator}
        Select Frame  ${locator}
    END

Unselect And Select Frame
    [Documentation]  This is a series of chained Selenium keywords, that first unselects the current iFrame, then executes a
    ...  wait for and select frame for a new iFrame.
    ...  locator: (string) A selenium locator(CSS, XPATH, ID, NAME, etc)
    ...  timeout: (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${timeout}=${None}
    Unselect Frame
    Wait And Select Frame  ${locator}  ${timeout}

Wait And Select From List
    [Documentation]  This is a series of chained Selenium keywords, that first waits for and focuses on a list element, then
    ...  selects an item(s).
    ...  locator:  (string) A selenium locator(CSS, XPATH, ID, NAME, etc)
    ...  target: (string, array of strings) The list item(s) to be selected (string, or list of strings)
    ...  timeout: (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${target}  ${timeout}=${None}
    Wait And Focus On Element  ${locator}  ${timeout}
    Select From List By Label  ${locator}  ${target}

Wait And Select From List By Value
    [Documentation]  This is a series of chained Selenium keywords, that first waits for and focuses on a list element, then
    ...  selects an item(s) for it using the value attribute of the item(s) web element.
    ...  locator:  (string) A selenium locator(CSS, XPATH, ID, NAME, etc)
    ...  value: (string, array of strings) The list item(s) to be selected (string, or list of strings)
    ...  timeout: (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${value}  ${timeout}=${None}
    Wait And Focus On Element  ${locator}  ${timeout}
    Select From List By Value  ${locator}  ${value}

Wait And Select From List By Index
    [Documentation]  This is a series of chained Selenium keywords, that first waits for and focuses on a list element, then
    ...  selects an item(s) for it using the index of the item(s) web element.
    ...  locator:  (string) A selenium locator(CSS, XPATH, ID, NAME, etc)
    ...  index: (int) The index of the item to be selected
    ...  timeout: (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${index}  ${timeout}=${None}
    Wait And Focus On Element  ${locator}  ${timeout}
    Select From List By Index  ${locator}  ${index}

Wait And Mouse Over
    [Documentation]  This is a series of chained Selenium keywords, that first waits for an element to be visible, then executes a
    ...  mouse over command on it.
    ...  locator: (string) A selenium locator(CSS, XPATH, ID, NAME, etc)
    ...  timeout: (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${timeout}=${None}
    Wait And Focus On Element  ${locator}  ${timeout}
    Mouse Over  ${locator}

Wait And Mouse Over And Click
    [Documentation]  This is a series of chained Selenium keywords, that first waits for an element to be visible, executes a
    ...  mouse over command on it, and it finally clicks it.
    ...  locator: (string) A selenium locator(CSS, XPATH, ID, NAME, etc)
    ...  timeout: (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${locator}  ${timeout}=${None}
    Wait And Mouse Over  ${locator}  ${timeout}
    Click Element  ${locator}

Window Should Not Be Open
    [Documentation]  This is a series of chained Selenium keywords, used to check that a window with the title no longer exists.
    ...  title: (string) The title of the window you are expecting to be closed.
    [Arguments]  ${title}
    @{titles}  Get Window Titles
    List Should Not Contain Value  ${titles}  ${title}

Wait And Select Window
    [Documentation]  This is a series of chained Selenium keywords, used to wait until a window with the title argument exists,
    ...  then it selects that window.
    ...  title: (string) The title of the window you are waiting for.
    ...  timeout: (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${title}  ${timeout}=${None}
    Wait Until Window Opens  ${title}  ${timeout}
    Switch Window  ${title}

Get Texts From Elements List
    [Documentation]  This keyword extracts the HTML text of a list of web elements, and returns a list.
    ...  web_elements_list: (array of selenium web elements) A selenium web element objects list.
    ...  return: (array of strings) A list of strings extracted from the web elements.
    [Arguments]  ${locator}
    @{elements}  Get WebElements  ${locator}
    @{text_list}  Create List
    FOR  ${element}  IN  @{elements}
        ${text}  Get Text  ${element}
        Append To List  ${text_list}  ${text}
    END
    [Return]  @{text_list}

Get Values From Elements List
    [Documentation]  This keyword extracts the HTML value of a list of web elements, and returns a list.
    ...  web_elements_list: (array of selenium web elements) A selenium web element objects list.
    ...  return: (array of strings) A list of strings extracted from the web elements.
    [Arguments]  ${locator}
    @{elements}  Get WebElements  ${locator}
    @{values_list}  Create List
    FOR  ${element}  IN  @{elements}
        ${text}  Get Value  ${element}
        Append To List  ${values_list}  ${text}
    END
    [Return]  @{values_list}

Get Vertical Position From Elements List
    [Documentation]  This keyword extracts the vertical position in pixels of a list of web elements, and returns a list.
    ...  web_elements_list: (array of selenium web elements) A selenium web element objects list.
    ...  return: (array of integers) A list of integers of the vertical pixel positions for the provided web elements.
    [Arguments]  ${locator}
    @{elements}  Get WebElements  ${locator}
    @{vertical_list}  Create List
        FOR  ${element}  IN  @{elements}
        ${position}  Get Vertical Position  ${element}
        Append To List  ${vertical_list}  ${position}
    END
    [Return]  @{vertical_list}

Wait Until Window Closes
    [Documentation]  This is a series of chained Selenium keywords, used to wait until a window with the title no longer exists.
    ...  title: (string) The title of the window you are expecting to close.
    ...  timeout: (float) Time in seconds to wait, will use global timeout if not set.
    [Arguments]  ${title}  ${timeout}=${None}
    IF  not ${timeout}
        ${timeout}  Get Selenium Timeout
    END
    Set Log Level  ERROR
    Wait Until Keyword Succeeds  ${timeout}  500ms  Window Should Not Be Open  ${title}
    [Teardown]  Set Log Level  INFO

Wait Until Element Contains Value
    [Documentation]  Waits until the element ``locator`` appears on the current page and contains value.
    ...  Fails if ``timeout`` expires before the element appears. See
    ...  the `Timeouts` section for more information about using timeouts and
    ...  their default value and the `Locating elements` section for details
    ...  about the locator syntax.
    [Arguments]  ${locator}  ${expected_value}  ${timeout}=${None}
    IF  not ${timeout}
        ${timeout}  Get Selenium Timeout
    END
    Wait Until Page Contains Element  ${locator}
    Set Log Level  ERROR
    Wait Until Keyword Succeeds  ${timeout}  500ms  Element Value Should Be Equal  ${locator}  ${expected_value}
    [Teardown]  Set Log Level  INFO

Get Element CSS Attribute Value
    [Documentation]  Get the CSS attribute value of an element. This would be the values within the 'style' tag.
    ...  locator: (string) A selenium locator(CSS, XPATH, ID, NAME, etc)
    ...  attribute: (string) The attribute you wish to get the value for.
    [Arguments]  ${locator}  ${attribute}
    ${element}  Get WebElement  ${locator}
    ${value}  Call Method  ${element}  value_of_css_property  ${attribute}
    [Return]  ${value}

Element CSS Attribute Value Should Be
    [Documentation]  Get the CSS attribute value of an element and compare it to an expected value.
    ...  This would be the values within the 'style' tag.
    ...  locator: (string) A selenium locator(CSS, XPATH, ID, NAME, etc)
    ...  attribute: (string) The attribute you wish to get the value for.
    ...  expected_value: (string) The expected attribute value to be compared against the actual
    ...  attribute value
    [Arguments]  ${locator}  ${attribute}  ${expected_value}
    ${actual_value}  Get Element CSS Attribute Value  ${locator}  ${attribute}
    Should Be Equal  ${actual_value}  ${expected_value}

Is Element Visible
    [Documentation]  Return the current state of the element, the keyword will return true if the element 
    ...  is visible and false if it is not visible.
    [Arguments]    ${locator}
    ${status}    Run Keyword And Return Status    Element Should Be Visible    ${locator}
    RETURN    ${status}

