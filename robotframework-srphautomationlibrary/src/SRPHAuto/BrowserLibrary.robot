*** Settings ***
Library    Browser
Library    SRPHAuto.EnvLoader
Library    OperatingSystem
Library    RetryFailed
Resource   ./config/BrowserConfig.resource

*** Keywords ***
# Browser Keywords
# Add Cookie To The Browser
Close "${browser}" Browser
    [Documentation]  Closes the "CURRENT" or "ALL" Browser.
    ...  \n Active browser is set to the browser that was active before this one.
    ...  Closes all context and pages belongings to this browser.
    ...  \n Arguments:
    ...  \n ${browser}: Browser to close. Set to "CURRENT" to selects the active browser to close.
    ...  \n Set to "ALL" to closes all browsers.
    ...  \n Example:
    ...  \n Close "ALL" BROWSER # Close all browser
    ...  \n Close "CURRENT" BROWSER # Close current browser
    Close Browser  ${browser}

Close Browser Context
    [Arguments]  ${context}=CURRENT  ${browser}=CURRENT
    Close Context  ${context}  ${browser}

Launch Chromium Browser
    [Documentation]  Launch the chromium browser and navigate to the target ${url}. Capable of handling different scopes for better wide usages.
    ...  \n Arguments:
    ...  \n 1. *url : Set the URL to navigate the page to. The url should include protocol, e.g. https:// or "http://".
    ...  \n 2. *scope : Scope defines the live time of that setting. Available values are Global, Suite or Test / Task. See Scope Settings for more details.
    ...  \n 3. is_headless : Set to True if you want headless. Defaults to False..
    ...  \n 4. dl_path : If specified, accepted downloads are downloaded into this folder. Otherwise, temporary folder is created and is deleted when browser is closed. 
    ...  Regarding file deletion, see the docs of Download and Promise To Wait For Download.
    [Arguments]  ${url}  ${scope}  ${is_headless}=${False}  ${dl_path}=${None}
    Set Up Chromium Browser  &{CHROMIUM_BROWSER_CONFIG}
    Set Up Chromium Browser Context  &{CHROMIUM_CONTEXT}
    Set Browser Timeout  timeout=${EAGER_TIMEOUT}  scope=${scope}
    Navigate To URL  url=${url}
    Wait For Page To Load

Navigate Backward
    [Documentation]  Navigates to the previous page in history.
    ...  \n Arguments: No Argument(s)
    Go Back

Navigate Forward
    [Documentation]  Navigates to the next page in history.
    ...  \n Arguments: No Argument(s)
    Go Forward

Navigate To URL
    [Documentation]  Open a new page. A Page is the Playwright equivalent to a tab.
    ...  \n Arguments:
    ...  \n ${url} : [Optional] URL to navigate the page to. The URL should include protocol, e.g. https://
    ...  \n ${state} : When to consider operation succeeded, defaults to 'domcontentloaded'.
    ...  \n Events can be either: 
    ...  \n 1. 'domcontentloaded' - consider operation to be finished when the DOMContentLoaded event is fired.
    ...  \n 2. 'load' - consider operation to be finished when the load even is fired.
    ...  \n 3. 'networkidle' - consider operation to be finished when there are no network connections for at least 500ms.
    ...  \n 4. 'commit' - consider operation to be finished when network response is received and the document started loading.
    [Arguments]  ${url}  ${state}=domcontentloaded
    New Page  url=${url}  wait_until=${state}

Refresh Page
    [Documentation]  Reloads current active page.
    ...  \n Arguments: No Argument(s)
    Reload

Set Up Chromium Browser
    [Arguments]  &{config}
    New Browser  &{config}

Set Up Chromium Browser Context
    [Arguments]  &{config}
    New Context  &{config}
    Take Page Screenshot

Take Page Screenshot
    [Documentation]  Take a screenshot of the current window and saves it to disk.
    ...  \n Arguments:
    ...  \n ${filename} : Filename into which to save. The file will be saved in the robot framework ${OUTPUTDIR}/browser/screenshot directory
    ...  \n by default, but it can be overwritten by providing custom path or filename. The ${OUTPUT_DIR}/browser/ is removed at the first suite startup.
    ...  \n ${file_type} : Can be set to 'jpeg' and currently in 'png' in default. 
    ...  \n ${full_page} : When set to 'True', takes a screenshot of the full scrollable page, instaed of the currently visible viewport. Defaults to 'False'.
    ...  \n ${quality} : The quality of the image, between 0-100. Not applicable to png images. Defaults to '0'.
    ...  \n ${return_as} : Defines what this keyword returns. It can be either a path to the screenshot file as string or Path object, or the image data 
    ...  \n as bytes or base64 encoded string. Possible values are ['path', 'path_string', 'bytes', 'base64'] 
    [Arguments]  ${filename}=${None}  ${file_type}=png  ${full_page}=${False}  ${quality}=0  ${return_as}=path_string
    IF  ${filename} is ${None}
        IF   "${file_type}" == "jpeg"
            Take Screenshot  fullPage=${full_page}  fileType=${file_type}  quality=${quality}  return_as=${return_as}
        ELSE
            Take Screenshot  fullPage=${full_page}  return_as=${return_as}
        END
    ELSE
        IF   "${file_type}" == "jpeg"
            Take Screenshot  filename=${filename}  fullPage=${full_page}  fileType=${file_type}  quality=${quality}  return_as=${return_as}
        ELSE
            Take Screenshot  filename=${filename}  fullPage=${full_page}  return_as=${return_as}
        END
    END

Wait For Page To Load
    [Documentation]  Waits that the page reaches the required load state.
    ...  \n This resolves when the page reaches a required state, 'load' by default. The navigation must have been committed when this method is called.
    ...  \n If current document has already reached the required state, resolves immediately.
    ...  \n Arguments:
    ...  \n ${state} : State to wait for, defaults to 'load'. Possible values are ['load', 'domcontentloaded', 'networkidle']
    ...  \n ${timeout} : Timeout support Robot Framework time format. Uses browser timeout if not set.
    ...  \n Example:
    ...  \n Navigate To URL  ${URL}
    ...  \n Wait For Page To Load  domcontentloaded  timeout=10s
    [Arguments]  ${state}=load  ${timeout}=${None}
    Wait For Load State  state=${state}  timeout=${timeout}

### Element Keywords
## Returning Element State
Get Element Text Value
    [Documentation]  
    ...  \n Arguments:
    [Arguments]  ${locator}
    ${text}  Get Text  ${locator}
    RETURN  ${text}

Is Element Checked
    [Documentation]  Arguments:
    [Arguments]  ${locator}
    ${state}  Run Keyword And Return Status  
    ...  Wait For Elements State  ${locator}  state=checked  timeout=${PRESENCE_TIMEOUT}
    RETURN  ${state}

Is Element Contains Attribute Value
    [Documentation]  Arguments:
    [Arguments]  ${locator}  ${property}
    ${state}  Is Element Visible  ${locator}
    IF  ${state}
        ${value}  Get Property  ${locator}  ${property}
    END
    RETURN  ${value}

Is Element Editable
    [Documentation]  Arguments:
    [Arguments]  ${locator}
    ${state}  Run Keyword And Return Status  
    ...  Wait For Elements State  ${locator}  state=editable  timeout=${PRESENCE_TIMEOUT}
    RETURN  ${state}

Is Element Enabled
    [Documentation]  Arguments:
    [Arguments]  ${locator}
    ${state}  Run Keyword And Return Status  
    ...  Wait For Elements State  ${locator}  state=enabled  timeout=${PRESENCE_TIMEOUT}
    RETURN  ${state}

Is Element Disabled
    [Documentation]  Arguments:
    [Arguments]  ${locator}
    ${state}  Run Keyword And Return Status  
    ...  Wait For Elements State  ${locator}  state=disabled  timeout=${PRESENCE_TIMEOUT}
    RETURN  ${state}

Is Element Focused
    [Documentation]  Arguments:
    [Arguments]  ${locator}
    ${state}  Run Keyword And Return Status
    ...  Wait For Elements State  ${locator}  state=focused  timeout=${PRESENCE_TIMEOUT}
    RETURN  ${state}

Is Element In Read Only State
    [Documentation]  Arguments:
    [Arguments]  ${locator}
    ${state}  Run Keyword And Return Status
    ...  Wait For Elements State  ${locator}  state=readonly  timeout=${PRESENCE_TIMEOUT}
    RETURN  ${state}

Is Element Hidden
    [Arguments]  ${locator}
    ${state}  Run Keyword And Return Status
    ...  Wait For Elements State  ${locator}  state=hidden  timeout=${PRESENCE_TIMEOUT}
    RETURN  ${state}

Is Element Present
    [Documentation]  Arguments:
    [Arguments]  ${locator}
    ${state}  Run Keyword And Return Status  
    ...  Wait For Elements State  ${locator}  state=attached  timeout=${PRESENCE_TIMEOUT}
    RETURN  ${state}

Is Element Unchecked
    [Documentation]  Arguments:
    [Arguments]  ${locator}
    ${state}  Run Keyword And Return Status  
    ...  Wait For Elements State  ${locator}  state=unchecked  timeout=${PRESENCE_TIMEOUT}
    RETURN  ${state}

Is Element Unselected
    [Documentation]  Arguments:
    [Arguments]  ${locator}
    ${state}  Run Keyword And Return Status  
    ...  Wait For Elements State  ${locator}  state=deselected  timeout=${PRESENCE_TIMEOUT}
    RETURN  ${state}

Is Element Unfocused
    [Documentation]  Arguments:
    [Arguments]  ${locator}
    ${state}  Run Keyword And Return Status
    ...  Wait For Elements State  ${locator}  state=defocused  timeout=${PRESENCE_TIMEOUT}
    RETURN  ${state}

Is Element Selected
    [Documentation]  Arguments:
    [Arguments]  ${locator}
    ${state}  Run Keyword And Return Status  
    ...  Wait For Elements State  ${locator}  state=selected  timeout=${PRESENCE_TIMEOUT}
    RETURN  ${state}

Is Element Stable
    [Documentation]  Arguments:
    [Arguments]  ${locator}
    ${state}  Run Keyword And Return Status  
    ...  Wait For Elements State  ${locator}  state=stable  timeout=${PRESENCE_TIMEOUT}
    RETURN  ${state}

Is Element Visible
    [Documentation]  Arguments:
    [Arguments]  ${locator}
    ${state}  Run Keyword And Return Status  
    ...  Wait For Elements State  ${locator}  state=visible  timeout=${PRESENCE_TIMEOUT}
    RETURN  ${state}

Return Web Element
    [Documentation]  Arguments:
    [Arguments]  ${locator}
    ${locator}  Get Element  ${locator}
    RETURN  ${locator}

Return Web Elemets
    [Documentation]  Arguments:
    [Arguments]  ${locator}
    @{locators}  Get Elements  ${locator}
    RETURN  @{locators}

## Wait keywords
Wait For Element To Be Checked
    [Documentation]  Waits until the target element (${locator}) to be checked.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${timeout}: Supports RF timestamp, will use the library timeout if not set.
    [Arguments]    ${locator}  ${timeout}=${None}
    Wait Until Keyword Succeeds  3x  ${PRESENCE_TIMEOUT}
    ...  Wait For Elements State  ${locator}  state=checked  timeout=${timeout}

Wait For Element To Be Disabled
    [Documentation]  Waits until the target element (${locator}) to be disabled.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${timeout}: Supports RF timestamp, will use the library timeout if not set.
    [Arguments]    ${locator}  ${timeout}=${None}
    Wait Until Keyword Succeeds  3x  ${PRESENCE_TIMEOUT}
    ...  Wait For Elements State  ${locator}  state=disabled  timeout=${timeout}

Wait For Element To Be Editable
    [Documentation]  Waits until the target element (${locator}) to be editable.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${timeout}: Supports RF timestamp, will use the library timeout if not set.
    [Arguments]    ${locator}  ${timeout}=${None}
    Wait Until Keyword Succeeds  3x  ${PRESENCE_TIMEOUT}
    ...  Wait For Elements State  ${locator}  state=editable  timeout=${timeout}

Wait For Element To Be Enabled
    [Documentation]  Waits until the target element (${locator}) to be enabled.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${timeout}: Supports RF timestamp, will use the library timeout if not set.
    [Arguments]    ${locator}  ${timeout}=${None}
    Wait Until Keyword Succeeds  3x  ${PRESENCE_TIMEOUT}
    ...  Wait For Elements State  ${locator}  state=enabled  timeout=${timeout}

Wait For Element To Be Hidden
    [Documentation]  Waits until the target element (${locator}) to be hidden.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${timeout}: Supports RF timestamp, will use the library timeout if not set.
    [Arguments]    ${locator}  ${timeout}=${None}
    Wait Until Keyword Succeeds  3x  ${PRESENCE_TIMEOUT}
    ...  Wait For Elements State  ${locator}  state=hidden  timeout=${timeout}

Wait For Element Not To Be Present
    [Documentation]  Waits until the target element (${locator}) not to be present.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${timeout}: Supports RF timestamp, will use the library timeout if not set.
    [Arguments]    ${locator}  ${timeout}=${None}
    Wait Until Keyword Succeeds  3x  ${PRESENCE_TIMEOUT}
    ...  Wait For Elements State  ${locator}  state=detached  timeout=${timeout}

Wait For Element To Be Present
    [Documentation]  Waits until the target element (${locator}) to be present.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${timeout}: Supports RF timestamp, will use the library timeout if not set.
    [Arguments]    ${locator}  ${timeout}=${None}
    ${state}  Is Element Present  ${locator}
    Wait Until Keyword Succeeds  3x  ${PRESENCE_TIMEOUT}
    ...  Wait For Elements State  ${locator}  state=attached  timeout=${timeout}

Wait For Element To Be Read Only State
    [Documentation]  Waits until the target element (${locator}) to be in read only state.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${timeout}: Supports RF timestamp, will use the library timeout if not set.
    [Arguments]    ${locator}  ${timeout}=${None}
    Wait Until Keyword Succeeds  3x  ${PRESENCE_TIMEOUT}
    ...  Wait For Elements State  ${locator}  state=readonly  timeout=${timeout}

Wait For Element To Be Stable
    [Documentation]  Waits until the target element (${locator}) to be stable.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${timeout}: Supports RF timestamp, will use the library timeout if not set.
    [Arguments]    ${locator}  ${timeout}=${None}
    Wait Until Keyword Succeeds  3x  ${PRESENCE_TIMEOUT}
    ...  Wait For Elements State  ${locator}  state=stable  timeout=${timeout}

Wait For Element To Be Unchecked
    [Documentation]  Waits until the target element (${locator}) to be unchecked.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${timeout}: Supports RF timestamp, will use the library timeout if not set.
    [Arguments]    ${locator}  ${timeout}=${None}
    Wait Until Keyword Succeeds  3x  ${PRESENCE_TIMEOUT}
    ...  Wait For Elements State  ${locator}  state=unchecked  timeout=${timeout}

Wait For Element To Be Visible
    [Documentation]  Waits until the target element (${locator}) to be visible.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${timeout}: Supports RF timestamp, will use the library timeout if not set.
    [Arguments]    ${locator}  ${timeout}=${None}
    Wait Until Keyword Succeeds  3x  ${PRESENCE_TIMEOUT}
    ...  Wait For Elements State  ${locator}  state=visible  timeout=${timeout}

## Action keywords
Activate IFrame Locator
    [Documentation]  Sets the focus on iframe for all selectors in the given scope. 
    ...  \n After using this keyword use 'Deactivate IFrame Locator' keyword to sets off the focus on the IFrame.
    ...  \n Arguments:
    ...  \n ${prefix} : Locator of the prefix/iframe.
    ...  \n Example:
    ...  \n Activate IFramee Locator  ${IFRAME_LOCATOR}     | Activated the IFrame selector. All the locators are focus inside the IFramew ${locator}.
    ...  \n Trigger Click  ${LOGIN_BUTTON_LOCATOR}          | Clicks the button inside the IFrame with selector ${IFRAME_LOCATOR} >>> ${LOGIN_BUTTON_LOCATOR}
    ...  \n Deactivate IFrame Locator                       | Turn off the focus on the ${IFRAME_LOCATOR} and back to original HTML body.
    [Arguments]    ${prefix}
    Set Selector Prefix  ${prefix} >>>

# Add CSS Style Tag


Check Element Check Box
    [Documentation]  Checks the checkbox or selects radio button found by ${locator}.
    ...  Does nothing if the element is already checked/selected.
    ...  \n Arguments:
    ...  \n ${checkbox_locator}: Input selector of the checkbox.
    ...  \n ${checkbox_span_locator}: Span selector of the checkbox.
    [Arguments]  ${checkbox_locator}  ${checkbox_span_locator}
    ${state}  Is Element Checked  ${checkbox_locator}
    IF  not ${state}
        Check Checkbox  ${checkbox_span_locator}
    ELSE
        Log  message=Check box already in checked state
    END

Clear Input Text
    [Documentation]  Clear the text field found by the ${locator}.
    ...  \n ${locator} : Selector of the text field.
    [Arguments]  ${locator}
    Clear Text  ${locator}

Deactivate IFrame Locator
    [Documentation]  Sets off the focus on iframe for all the selectors after using the 'Activate IFrame Locator'. 
    ...  Only use this keyword if you use the 'Activate IFrame Locator' keyword.
    ...  \n Arguments: No Argument(s)
    Set Selector Prefix  ${None}

Download File
    [Documentation]  Download a file by using the href from anchor tag.
    ...  \n ${download_button}: Selector of the download button/anchor that has href attribute (button or anchor).
    ...  \n ${save_as}: Path where the file shall be saved persistently. If empty, generated unique path (GUID) is used and file is deleted
    ...  when the context is closed.
    ...  \n Example:
    ...  \n Download File  ${BTN_DOWNLOAD}  ${OUTPUT_DIR}/downloads/
    ...  \n Download File  ${BTN_DOWNLOAD}  ${OUTPUT_DIR}/downloads/downloaded_file.txt
    [Arguments]  ${download_button}  ${save_as}
    ${url}  Get Property  ${download_button}  property=href
    Download  ${url}  ${save_as}

Drag And Drop Element
    [Documentation]  Executes a Drag & Drop operation from the element selected by the ${from_selector} to the element selected by ${to_locator}.
    ...  \n Arguments:
    ...  \n ${from_locator}: Identifies the element, which center is the start-point.
    ...  \n ${to_locator}: Identifies the element, which center is the end-point.
    ...  \n ${steps}: Defines how many intermediate mouse move events are sent. Often it is necessary to send more than one intermediate event to get
    ...  the desired result. Defaults to 1.
    [Arguments]  ${from_locator}  ${to_locator}  ${steps}=1
    Drag And Drop  ${from_locator}  ${to_locator}  steps=${steps}

Enter Text
    [Documentation]  Clears and fills the given text into the text field found by the ${locator}.
    ...  \n This method waits for an element matching the locator to appear, waits for actionability checks, focuses the lements,
    ...  fills it and triggers an input even after filling.
    ...  \n If the element matching selector is not an <input>, <textarea>, or [contenteditable] element, this method throws an error.
    ...  \n Note that you can pass an empty string as 'text' to clear the input field.
    ...  \n Arguments:
    ...  \n ${locator} : Selector of the text field (input or text area).
    ...  \n ${text} : Text for the text field.
    ...  \n ${force} : [OPTIONAL] Set to 'True' to skip Playwrigth's.
    [Arguments]  ${locator}  ${text}  ${force}=${False}
    Fill Text  ${locator}  txt=${text}  force=${force}
    ${state}  Is Element Focused  ${locator}
    Log  ${state}

Enter Password
    [Documentation]  Fills the given '${secret}' from 'variable_name' into the text field found by ${locator}.
    ...  \n This keyword does not log '${secret}' in Robot Framework logs, when keyword resolves the '${secret}' variable internally.
    ...  \n When '${secret}' variable is prefixed with '$', without curly braces, Browser Library will resolve the corresponding Robot Framework Variable.
    ...  \n If the '${secret}' variable is prefixed with '%', Browser Library will resolve corresponding environment variable.
    ...  \n Arguments:
    ...  \n ${locator} : Selector of the text field.
    ...  \n ${secret} : The secret string that should be filled into the text field.
    ...  \n ${force} : [OPTIONAL] Set to 'True' to skip Playwrigth's.
    ...  \n Example:
    ...  \n Enter Password  ${INPUT_PASSWORD}  $USERNAME  | Keyword resolved variable value from Robot Framework varaibles and the keyword will use 
    ...  the standard 'Enter Text' keyword
    ...  \n Enter Password  ${INPUT_PASSWORD}  %PASSWORD  type=secret  | Keyword resolve variable value from environment variables and the keyword will use
    ...  the 'Fill Secret' keyword.
    [Arguments]  ${locator}  ${password}  ${type}=normal  ${force}=${False}
    IF  "${type}"=="secret"
        Fill Secret  ${locator}  ${password}  force=${force}
    ELSE
        Enter Text  ${locator}  ${password}  force=${force}
    END

Focus On Element
    [Documentation]  Move focus on to the element found by the ${locator}.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    [Arguments]  ${locator}
    ${state}  Is Element Focused  ${locator}
    IF  not ${state}
        Focus  ${locator}
    ELSE
        Log  message=Target element already in focused!
    END

Hover Over
    [Documentation]  Moves the virtual mouse and scrolls to the element found by ${locator}
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${position_x}: A point to hover relative to the top-left corner of element bounding box. If not specified, hovers over some visible point
    ...  of the element. Only positive values within the bounding-box are allowed.
    ...  \n ${position_y}: A point to hover relative to the top-left corner of element bounding box. If not specified, hovers over some visible point
    ...  of the element. Only positive values within the bounding-box are allowed.
    ...  \n ${force}: Set to ${True} to skip Playwright's. Default to ${False}
    [Arguments]  ${locator}  ${position_x}=${None}  ${position_y}=${None}  ${force}=${False}
    Hover  ${locator}  position_x=${position_x}  position_y=${position_y}  force=${force}

Take Element Screenshot
    [Documentation]  Take a screenshot to the target ${locator} and saves it to disk.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${filename}: Filename into which to save. The file will be saved into the RF ${OUTPUT_DIR}/browser/screenshot directory by default,
    ...  but i can be overwritten by providing custom path or filename. The ${OUTPUT_DIR}/browser/ is removed at the first suite startup.
    ...  \n ${return_as}: Define what this keyword returns. Possible values are [path, path_string, bytes, base64]. Default value is "path_string".
    ...  \n ${timeout}: Maximum time how long taking screenshot can last, support RF time format, like 10s or 1 min. Default value is ${None}
    [Arguments]  ${locator}  ${filename}=${None}  ${return_as}=path_string  ${timeout}=${None}
    IF  ${filename} == ${None}
        Take Screenshot  selector=${locator}  return_as=${return_as}  timeout=${timeout}
    ELSE
        Take Screenshot  filename=${filename}  return_as=${return_as}  selector=${locator}  timeout=${timeout}
    END

Trigger Click
    [Documentation]  Simulates mouse click on the element found by ${locator}.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${button}: Part of the mouse button to be click, possible values are [left, middle, right]. Default value is left.
    ...  \n ${modifiers}: Modifiers keys to press. Ensure that only these modifiers are pressed during the click, and then restores current
    ...  modifiers back. If not specified, currently pressed modifeiers are used.
    ...  \n ${clickCount}: Number of count(s) to be press. Defaults to 1.
    ...  \n ${delay}: Time to wait between mouse-down and mouse-up. Defaults to 0.
    ...  \n ${trial}: When set, this method only performs the actionability checks and skips the action. Defaults to ${False}.
    [Arguments]  ${locator}  ${button}=left  ${modifiers}=${None}  ${clickCount}=1  ${delay}=0  ${trial}=${False}
    Hover Over  ${locator}
    IF  ${modifiers} == ${None}
        Click With Options  ${locator}  ${button}  clickCount=${clickCount}  delay=${delay}  trial=${trial}
    ELSE
        Click With Options  ${locator}  ${button}  ${modifiers}  clickCount=${clickCount}  delay=${delay}  trial=${trial}
    END

Trigger Double Click
    [Documentation]  Simulates mouse double click on the element found by ${locator}.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${delay}: Time to wait between mouse-down and mouse-up. Defaults to 0.
    ...  \n ${trial}: When set, this method only performs the actionability checks and skips the action. Defaults to ${False}.
    [Arguments]  ${locator}  ${delay}=${None}  ${trial}=${False}
    Hover Over  ${locator}
    Click With Options  ${locator}  left  clickCount=2  delay=${delay}  trial=${trial}


## Assertion Keywords
### Element State Assertion
Verify Element Is Checked
    [Documentation]  Check first if the element is checked then assert if it's checked.
    ...  Will fail if the element is in unchecked state and use the custom error message.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    [Arguments]  ${locator}
    ${state}  Is Element Checked  ${locator}
    IF  ${state}
        Get Element States  ${locator}  contains  checked
    ELSE
        Fail  msg=${locator} ${ERR_MSG_ELEMENT_NOT_CHECKED}
    END

Verify Element Is Unchecked
    [Documentation]  Check first if the element is unchecked then assert if it's unchecked.
    ...  Will fail if the element is in checked state and use the custom error message.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    [Arguments]  ${locator}
    ${state}  Is Element Checked  ${locator}
    IF  ${state}
        Get Element States  ${locator}  contains  checked
    ELSE
        Fail  msg=${locator} ${ERR_MSG_ELEMENT_NOT_CHECKED}
    END

Verify Element Contains Property Value
    [Documentation]  Assert element property contains ${expected_value}.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${property}: Property value to be assert.
    ...  \n ${expected_value}: Expected value of the property.
    [Arguments]  ${locator}  ${property}  ${expected_value}
    ${property_value}  Is Element Contains Attribute Value  ${locator}  ${property}
    Should Contain  ${property_value}  ${expected_value}

Verify Element Is Enabled
    [Documentation]  Check first if the element is enabled then assert if it's enabled.
    ...  Will fail if the element is disabled and use the custom error message.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    [Arguments]  ${locator}
    ${state}  Is Element Disabled  ${locator}
    IF  ${state}
        Get Element States  ${locator}  ${OPERATOR_CONTAINS}  ${ELEMENT_STATE_ENABLED}
    ELSE
        Fail  msg=${locator} ${ERR_MSG_ELEMENT_NOT_DISABLED}
    END

Verify Element Is Disabled
    [Documentation]  Check first if the element is disabled then assert if it's disabled.
    ...  Will fail if the element is enabled and use the custom error message.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    [Arguments]  ${locator}
    ${state}  Is Element Disabled  ${locator}
    IF  ${state}
        Get Element States  ${locator}  ${OPERATOR_CONTAINS}  ${ELEMENT_STATE_DISABLED}
    ELSE
        Fail  msg=${locator} ${ERR_MSG_ELEMENT_NOT_DISABLED}
    END

Verify Element Is Editable
    [Documentation]  Check first if the element is editable then assert if it's editable.
    ...  Will fail if the element is in read only state and use the custom error message.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    [Arguments]  ${locator}
    ${state}  Is Element Editable  ${locator}
    IF  ${state}
        Get Element States  ${locator}  ${OPERATOR_CONTAINS}  ${ELEMENT_STATE_EDITABLE}
    ELSE
        Fail  msg=${locator} ${ERR_MSG_ELEMENT_NOT_EDITABLE}
    END

Verify Element Is In Read Only State
    [Documentation]  Check first if the element is in read only state then assert if it's in read only state.
    ...  Will fail if the element is editable state and use the custom error message.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    [Arguments]  ${locator}
    ${state}  Is Element In Read Only State  ${locator}
    IF  ${state}
        Get Element States  ${locator}  ${OPERATOR_CONTAINS}  ${ELEMENT_STATE_READ_ONLY}
    ELSE
        Fail  msg=${locator} ${ERR_MSG_ELEMENT_NOT_IN_READ_ONLY_STATE}
    END

Verify Element Is Selected
    [Documentation]  Check first if the element is selected then assert if it's selected.
    ...  Will fail if the element is still unselected and use the custom error message.
    ...  This keyword can be used on <option> element.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    [Arguments]  ${locator}
    ${state}  Is Element Selected  ${locator}
    IF  ${state}
        Get Element States  ${locator}  ${OPERATOR_CONTAINS}  ${ELEMENT_STATE_SELECTED}
    ELSE
        Fail  msg=${locatoR} ${ERR_MSG_ELEMENT_NOT_SELECTED}
    END

Verify Element Is Unselected
    [Documentation]  Check first if the element is unselected then assert if it's unselected.
    ...  Will fail if the element is still selected and use the custom error message.
    ...  This keyword can be used on <option> element.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    [Arguments]  ${locator}
    ${state}  Is Element Unselected  ${locator}
    IF  ${state}
        Get Element States  ${locator}  ${OPERATOR_CONTAINS}  ${ELEMENT_STATE_DESELECTED}
    ELSE
        Fail  msg=${locator} ${ERR_MSG_ELEMENT_NOT_UNSELECTED}
    END

Verify Element Is Visible
    [Documentation]  Check first if the element is visible then assert if it's visible. 
    ...  Will fail if the element is not visible and use the custom error message.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    [Arguments]  ${locator}
    ${state}  Is Element Visible  ${locator}
    IF  ${state}
        Get Element States  ${locator}  ${OPERATOR_CONTAINS}  ${ELEMENT_STATE_VISIBLE}
    ELSE
        Fail  msg=${locator} ${ERR_MSG_ELEMENT_NOT_VISIBLE}
    END

Verify Element Is Hidden
    [Documentation]  Check first if the element is hidden then assert if it's hidden.
    ...  Will fail if the element is visible and use the custom error message.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    [Arguments]  ${locator}
    ${state}  Is Element Hidden  ${locator}
    IF  ${state}
        Get Element States  ${locator}  ${OPERATOR_CONTAINS}  ${ELEMENT_STATE_HIDDEN}
    ELSE
        Fail  msg=${locator} ${ERR_MSG_ELEMENT_NOT_HIDDEN}
    END

### Element Attribute/CSS Assertion
Verify Element Attribute
    [Documentation]  Assert the HTML attribute of the element found by selector.
    ...  \n Argument: 
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${attr}: (string) A attribute name to be verify.
    ...  \n ${expected_val}: (string) A string or any value to be compared to the actual value of the web element.
    ...  \n ${operator}: (string) A verificaiton method, can be [${OPERATOR_EQUAL}, ${OPERATOR_NOT_EQUAL}, 
    ...  ${OPERATOR_GREATER_THAN}, ${OPERATOR_GREATER_THAN_OR_EQUAL_TO}, ${OPERATOR_LESS_THAN}, ${OPERATOR_LESS_THAN_OR_EQUAL_TO}, 
    ...  ${OPERATOR_CONTAINS}, ${OPERATOR_NOT_CONTAINS}, ${OPERATOR_STARTS_WITH}, ${OPERATOR_ENDS_WITH}]
    [Arguments]  ${locator}  ${attr}  ${expected_val}  ${operator}=${OPERATOR_CONTAINS}
    Get Attribute  ${locator}  ${attr}  ${operator}  ${expected_val}

### Element Text Assertion
Verify Element Text Equal
    [Documentation]  Assert the target locator value attribute equals to the expected value.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${expected_value}: (string) A string or any value to be compared to the actual value of the web element.
    [Arguments]  ${locator}  ${expected_value}
    Get Text  ${locator}  ${OPERATOR_EQUAL}  ${expected_value}

Verify Element Text Not Equal
    [Documentation]  Assert the target locator value attribute not equal to the expected value.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${expected_value}: (string) A string or any value to be compared to the actual value of the web element.
    [Arguments]  ${locator}  ${expected_value}
    Get Text  ${locator}  ${OPERATOR_NOT_EQUAL}  ${expected_value}

Verify Element Text Greater Than
    [Documentation]  Assert the target locator value attribute is greater than to the expected value.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${expected_value}: (string) A string or any value to be compared to the actual value of the web element.
    [Arguments]  ${locator}  ${expected_value}
    Get Text  ${locator}  ${OPERATOR_GREATER_THAN}  ${expected_value}

Verify Element Text Greater Than Or Equal
    [Documentation]  Assert the target locator value attribute is greater than or equal to the expected value.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${expected_value}: (string) A string or any value to be compared to the actual value of the web element.
    [Arguments]  ${locator}  ${expected_value}
    Get Text  ${locator}  ${OPERATOR_GREATER_THAN_OR_EQUAL_TO}  ${expected_value}

Verify Element Text Less Than
    [Documentation]  Assert the target locator value attribute is less than to the expected value.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${expected_value}: (string) A string or any value to be compared to the actual value of the web element.
    [Arguments]  ${locator}  ${expected_value}
    Get Text  ${locator}  ${OPERATOR_LESS_THAN}  ${expected_value}

Verify Element Text Less Than Or Equal
    [Documentation]  Assert the target locator value attribute is less than or equal to the expected value.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${expected_value}: (string) A string or any value to be compared to the actual value of the web element.
    [Arguments]  ${locator}  ${expected_value}
    Get Text  ${locator}  ${OPERATOR_LESS_THAN_OR_EQUAL_TO}  ${expected_value}

Verify ELement Text Contains
    [Documentation]  Assert the target locator value attribute contains the expected value.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${expected_value}: (string) A string or any value to be validated if it's in the actual value of the web element.
    [Arguments]  ${locator}  ${expected_value}
    Get Text  ${locator}  ${OPERATOR_CONTAINS}  ${expected_value}

Verify ELement Text Not Contains
    [Documentation]  Assert the target locator value attribute not contains the expected value.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${expected_value}: (string) A string or any value to be validated if it's in the actual value of the web element.
    [Arguments]  ${locator}  ${expected_value}
    Get Text  ${locator}  ${OPERATOR_NOT_CONTAINS}  ${expected_value}
    
Verify Element Text Starts With
    [Documentation]  Assert the target locator value attribute starts with the expected value.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${expected_value}: (string) A string or any value to be validated if it's in the actual value of the web element.
    [Arguments]  ${locator}  ${expected_value}
    Get Text  ${locator}  ${OPERATOR_STARTS_WITH}  ${expected_value}

Verify Element Text Ends With
    [Documentation]  Assert the target locator value attribute ends with the expected value.
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    ...  \n ${expected_value}: (string) A string or any value to be validated if it's in the actual value of the web element.
    [Arguments]  ${locator}  ${expected_value}
    Get Text  ${locator}  ${OPERATOR_ENDS_WITH}  ${expected_value}

### Page Assertion Keyword
Verify Page Contains Element
    [Documentation]  Verify if the page does contains element (${locator}).
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    [Arguments]  ${locator}
    ${state}  Is Element Present  ${locator}
    IF  ${state}
        Get Element States  ${locator}  ${OPERATOR_CONTAINS}  ${ELEMENT_STATE_ATTACHED}
    ELSE
        Fail  msg=${ERR_MSG_PAGE_NOT_CONTAINS_ELEMENT} ${locator}
    END

Verify Page Does Not Contain Element
    [Documentation]  Verify if the page does not contain element (${locator}).
    ...  \n Arguments:
    ...  \n ${locator}: (string) A selenium locator (CSS, XPATH, ID, NAME, etc.)
    [Arguments]  ${locator}
    ${state}  Is Element Hidden  ${locator}
    IF  ${state}
        Get Element States  ${locator}  ${OPERATOR_CONTAINS}  ${ELEMENT_STATE_DETACHED}
    ELSE
        Fail  msg=${ERR_MSG_PAGE_CONTAINS_ELEMENT} ${locator}
    END

### File Assertion
Verify File Exist
    [Documentation]  This keyword uses OperatingSystem keyword. Verify if the file exist from ${file_path}.
    ...  \n Arguments:
    [Arguments]  ${file_path}
    OperatingSystem.File Should Exist  ${file_path}

## Miscellaneous Keywords
Replace Value In Variable
    [Documentation]  This keyword replace replace the ${target_text} from ${text} with the ${new_text} and return it.
    ...  \n Example:
    ...  \n ${new_val}  Replace Value In Variable  Hello World!  World!  Python!
    ...  \n Log  ${new_val} # Output: Hello Python!
    [Arguments]  ${text}  ${target_text}  ${new_text}
    RETURN  ${text.replace("${target_text}", "${new_text}")}