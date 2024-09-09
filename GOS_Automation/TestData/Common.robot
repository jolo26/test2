*** Variables ***
#WEB
@{OPTIONS_LIST}                --ignore-certificate-errors
...                            --disable-dev-shm-usage
...                            --disable-popup-blocking
...                            --disable-extensions
...                            --no-sandbox
...                            window-size\=1920,1080
...                            --start-maximized
${IS_HEADLESS}                 False
${INCOGNITO}                   True
${URL}                         https://admin-redesign.dev-gos-gsp.io/
${DEFAULT_TIMEOUT}             30s
${ENABLE_SELENIUM_SPEED}       False
${SELENIUM_SPEED}              1s

#API
${API_URL}                      https://gos-admin-api.stg-gos-gsp.io
${RESPONSE_TIMEOUT}             10
${BASE_API_DATA_PATH}           ${EXECDIR}${/}4_TestData${/}API
${DEFAULT_PATH}                 ${BASE_API_DATA_PATH}${/}Defaults
${EXAMPLE_PATH}                 ${BASE_API_DATA_PATH}${/}Examples
${MAPPING_PATH}                 ${BASE_API_DATA_PATH}${/}Mapping
${RESPONSE_MAPPING_PATH}        ${BASE_API_DATA_PATH}${/}ResponseMapping
&{DEFAULT_HEADERS}              accept=application/json  content-type=application/json

#Mobile
${BASE_APPIUM_SERVER_URL}       http://localhost
${DEFAULT_PORT}                 4723
&{DEFAULT_CAPABILITIES}         automationName=Uiautomator2  newCommandTimeout=0  autoGrantPermissions=${True}  adbExecTimeout=20000
${CHROMEDRIVER_EXEC_PATH}       C:${/}Users${/}username${/}webdrivers
${CHROME_MAPPING_FILE_PATH}     C:${/}Users${/}username${/}AppData${/}Roaming${/}npm${/}node_modules${/}appium${/}node_modules${/}appium-chromedriver${/}config${/}mapping.json
${DEFAULT_APPIUM_TIMEOUT}       5 seconds

#CREDENTIALS
${DEFAULT_USERNAME}            standard_user        
${DEFAULT_PASSWORD}            secret_sauce

# VRT Configurations
${VRT_API_URL}                    http://localhost:4200
${VRT_API_KEY}                    XSVQ4J681JMCFQPMPM0H0A03YC5X
${VRT_PROJECT_KEY}                02ff3ab7-0038-42c4-8683-dd39e55e2679
${VRT_CI_BUILD_ID}                sample_branch
${VRT_BRANCH_NAME}                rf_sample
${VRT_ENABLE_SOFT_ASSERT}         true
${VRT_DEFAULT_TOLERANCE_LEVEL}    5.0
${BROWSER}                        Chrome
${DEVICE}                         Windows
${VIEWPORT}                       1920x1080

&{VRT_CONFIG}                     api_url=${VRT_API_URL}
...                               api_key=${VRT_API_KEY}
...                               project=${VRT_PROJECT_KEY}
...                               ci_build_id=${VRT_CI_BUILD_ID}
...                               branch_name=${VRT_BRANCH_NAME}
...                               enable_soft_assert=${VRT_ENABLE_SOFT_ASSERT}
...                               default_tolerance_level=${VRT_DEFAULT_TOLERANCE_LEVEL}
...                               browser=${BROWSER}
...                               device=${DEVICE}
...                               viewport=${VIEWPORT}


${HISTORY_COMMENT}                  Test Automation - SRPH

${INVALID_PACKAGE_NAME}             com.$%W^##$#$%
${TEST_CAPITALIZED}                 TEST
${TEST_SMALL_CAPS}                  test
${TEST_TITLE}                       Test
${NOT_EXISTING_DATA}                NOTEXISTINGXXXXYYYYZZZZ
