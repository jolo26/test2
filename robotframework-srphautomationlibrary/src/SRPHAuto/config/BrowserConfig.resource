*** Variables ***
# Assertion Operator
${OPERATOR_EQUAL}                          equal
${OPERATOR_NOT_EQUAL}                      inequal
${OPERATOR_GREATER_THAN}                   greater than
${OPERATOR_GREATER_THAN_OR_EQUAL_TO}       >=
${OPERATOR_LESS_THAN}                      less than
${OPERATOR_LESS_THAN_OR_EQUAL_TO}          <=
${OPERATOR_CONTAINS}                       contains
${OPERATOR_NOT_CONTAINS}                   not contains
${OPERATOR_STARTS_WITH}                    starts
${OPERATOR_ENDS_WITH}                      ends

# Element State
${ELEMENT_STATE_ATTACHED}                  attached
${ELEMENT_STATE_DETACHED}                  detached
${ELEMENT_STATE_VISIBLE}                   visible
${ELEMENT_STATE_HIDDEN}                    hidden
${ELEMENT_STATE_ENABLED}                   enabled
${ELEMENT_STATE_DISABLED}                  disabled
${ELEMENT_STATE_EDITABLE}                  editable
${ELEMENT_STATE_READ_ONLY}                 readonly
${ELEMENT_STATE_SELECTED}                  selected
${ELEMENT_STATE_DESELECTED}                deselected
${ELEMENT_STATE_FOCUSED}                   focused
${ELEMENT_STATE_UNFOCUSED}                 defocused
${ELEMENT_STATE_CHECKED}                   checked
${ELEMENT_STATE_UNCHECKED}                 unchecked
${ELEMENT_STATE_STABBLE}                   stable

# Error Messages
${ERR_MSG_ELEMENT_NOT_CHECKED}             Element is not checked!
${ERR_MSG_ELEMENT_NOT_DISABLED}            Element is not disabled!
${ERR_MSG_ELEMENT_NOT_EDITABLE}            Element is not editable!
${ERR_MSG_ELEMENT_NOT_HIDDEN}              Element is not hidden!
${ERR_MSG_ELEMENT_NOT_IN_READ_ONLY_STATE}  Element is not in read only state!
${ERR_MSG_ELEMENT_NOT_SELECTED}            Element is not selected!
${ERR_MSG_ELEMENT_NOT_UNSELECTED}          Element is not unselected!
${ERR_MSG_ELEMENT_NOT_VISIBLE}             Element is not visible!
${ERR_MSG_PAGE_CONTAINS_ELEMENT}           Page still contains an element!
${ERR_MSG_PAGE_NOT_CONTAINS_ELEMENT}       Page does not contain element!

# Browsers
@{BROWSERS_LIST}  chromium  firefox  webkit
@{BROWSER_SCOPE}  Global  Test  Suite  Task

&{CHROMIUM_BROWSER_CONFIG}  browser=chromium
...  headless=${False}
...  args=${None}
...  channel=${None}
...  chromiumSandbox=${False}
...  devtools=${False}
...  downloadsPath=${None}
...  env=${None}
...  executablePath=${None}
...  firefoxUserPrefs=${None}
...  handleSIGHUP=${True}
...  handleSIGINT=${True}
...  handleSIGTERM=${True}
...  ignoreDefaultArgs=${None}
...  proxy=${None}
...  reuse_existing=${True}
...  slowMo=0:00:00

## Browser Context
&{CHROMIUM_CONTEXT}  acceptDownloads=${True}
...  baseURL=${None}
...  bypassCSP=${False}
...  colorScheme=${None}
...  defaultBrowserType=${BROWSERS_LIST}[0]
...  deviceScaleFactor=${None}
...  extraHTTPHeaders=${None}
...  forcedColors=none
...  geolocation=${None}
...  hasTouch=${None}
...  httpCredentials=${None}
...  ignoreHTTPSErrors=${False}
...  isMobile=${None}
...  javaScriptEnabled=${True}
...  locale=${None}
...  offline=${False}
...  permissions=${None}
...  proxy=${None}
...  recordHar=${None}
...  recordVideo=${None}
...  reducedMotion=no_preference
...  screen=${None}
...  serviceWorkers=allow
...  storageState=${None}
...  timezoneId=${None}
...  tracing=${None}
...  userAgent=${None}
...  viewport={"width": ${viewport_width}, "height": ${viewport_height}}

# PageLoadStates
@{PAGE_LOAD_STRATEGY}  load  domcontentloaded  networkidle  commit

# ElementStates
@{ELEMENT_STATES}  attached  detached  visible  hidden  enabled  disabled  editable  readonly  selected  deselected  focused  defocused  checked  unchecked  stable

# Viewport
${viewport_width}     1920
${viewport_height}    1080

# Timeout
${EAGER_TIMEOUT}     1m
${NORMAL_TIMEOUT}    30s
${SHORT_TIMEOUT}     15s
${PRESENCE_TIMEOUT}  500ms