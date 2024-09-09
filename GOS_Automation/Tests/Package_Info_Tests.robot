*** SETTINGS ***
Resource            SRPHAuto/APIActions.robot
Resource            ../Actions/Login_Actions.robot
Resource            ../Actions/Package_Actions.resource
Resource            ../Actions/Common_Actions.robot
Resource            ../PageObjects/Login_Page.robot
Resource            ../PageObjects/Common_Page_Object.robot
Resource            ../PageObjects/Package_Page_Object.resource
Resource            ../Constants/Common.robot
Resource            ../Constants/Package_Info.robot
Resource            ../TestData/Package.robot
Resource            ../Actions/API/Book_Actions.robot
Library             ../Utils/Random_Words.py
Library             ../Actions/totp.py

Suite Setup         Login User
Suite Teardown      Close Browser


*** TEST CASES ***
(SRPHGBEQA-T8390) [Package Info - List] package info page should display correct page component
    ${package_game}        Get Random Package    ${CAT_GAME}
    ${package_non_game}    Get Random Package    ${CAT_NON_GAME}
    ${package_unknown}     Get Random Package    ${CAT_UNKNOWN}
    ${package_unknown_required}    Get Random Package    ${CAT_UNKNOWN}
    ${package_unknown_for_move}    Get Random Package    ${CAT_UNKNOWN}
    ${title}        Get Random Word
    ${developer}        Get Random Word
    ${title_updated}        Get Random Word
    ${developer_updated}        Get Random Word
    Set Global Variable    ${PACKAGE_GAME}
    Set Global Variable    ${PACKAGE_NON_GAME}
    Set Global Variable    ${PACKAGE_UNKNOWN}
    Set Global Variable    ${PACKAGE_UNKNOWN_REQUIRED}
    Set Global Variable    ${PACKAGE_UNKNOWN_FOR_MOVE}
    Set Global Variable    ${TITLE}
    Set Global Variable    ${DEVELOPER}
    Set Global Variable    ${TITLE_UPDATED}
    Set Global Variable    ${DEVELOPER_UPDATED}
    Navigate To Module    ${MODULE_PACKAGE}
    Verify Package Page Component

# ADD PACKAGE

(SRPHGBEQA-T5312) [Package Info - Add] game package info when all fields are populated can be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Input Package Name In Add Package    ${PACKAGE_GAME}
    Input Developer In Add Package    ${DEVELOPER}
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Input Game Title In Add Package    ${TITLE}
    Select Store In Add Package    ${ONE}
    Click Save Button
    Sleep    10s

(SRPHGBEQA-T5314) [Package Info - Add] game package info when package name is empty cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Click Package Name In Add Package
    Input Developer In Add Package    ${DEVELOPER}
    Verify Error Message Field    ${ERROR_PACKAGE_REQUIRED}

Package_Info_Add_game package info when package name has invalid value cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Input Package Name In Add Package    ${INVALID_PACKAGE_NAME}
    Input Developer In Add Package    ${DEVELOPER}
    Verify Error Message Field    ${ERROR_INVALID_NAME}

Package_Info_Add_game package info when package name is more than maximum (256) cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Input Package Name In Add Package    ${INPUT_256_CHAR}
    Input Developer In Add Package    ${DEVELOPER}
    Verify Error Message Field    ${ERROR_PACKAGE_CANNOT_EXCEED_255}

Package_Info_Add_game package info when using existing package name cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Input Package Name In Add Package    ${PACKAGE_GAME}
    Input Developer In Add Package    ${DEVELOPER}
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Input Game Title In Add Package    ${TITLE}
    Select Store In Add Package    ${ONE}
    Click Save Button
    Verify Toast Error Message    ${ERROR_PACKAGE_ALREADY_EXISTS}

Package_Info_Add_game package info when title is empty cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Click Title In Add Package
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Verify Error Message Field    ${ERROR_TITLE_REQUIRED}

Package_Info_Add_game package info when title is more than maximum (256) cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Input Game Title In Add Package    ${INPUT_256_CHAR}
    Input Developer In Add Package    ${DEVELOPER}
    Verify Error Message Field    ${ERROR_TITLE_CANNOT_EXCEED_255}

Package_Info_Add_game package info when developer is empty cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Click Developer In Add Package
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Verify Error Message Field    ${ERROR_DEVELOPER_REQUIRED}

Package_Info_Add_game package info when developer is more than maximum (256) cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Input Developer In Add Package    ${INPUT_256_CHAR}
    Click Package Name In Add Package
    Verify Error Message Field    ${ERROR_DEVELOPER_CANNOT_EXCEED_255}

Package_Info_Add_game package info when history comment is empty cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Click History Comment In Add Package
    Click Package Name In Add Package
    Verify Error Message Field    ${ERROR_COMMENT_REQUIRED}

Package_Info_Add_game package info when history comment is more than maximum (1001) cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Input History Comment In Add Package    ${INPUT_1001_CHAR}
    Click Package Name In Add Package
    Verify Error Message Field    ${ERROR_COMMENT_CANNOT_EXCEED_1000}

Package_Info_Add_Non_game package info when all fields are populated can be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Select Package Category    ${CAT_NON_GAME}
    Input Package Name In Add Package    ${PACKAGE_NON_GAME}
    Input Developer In Add Package    ${DEVELOPER}
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Input Game Title In Add Package    ${TITLE}
    Select Store In Add Package    ${ONE}
    Click Save Button

Package_Info_Add_non_game package info when package name is empty cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Select Package Category    ${CAT_NON_GAME}
    Click Package Name In Add Package
    Input Developer In Add Package    ${DEVELOPER}
    Verify Error Message Field    ${ERROR_PACKAGE_REQUIRED}

Package_Info_Add_non_game package info when package name has invalid value cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Select Package Category    ${CAT_NON_GAME}
    Input Package Name In Add Package    ${INVALID_PACKAGE_NAME}
    Input Developer In Add Package    ${DEVELOPER}
    Verify Error Message Field    ${ERROR_INVALID_NAME}

Package_Info_Add_non_game package info when package name is more than maximum (256) cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Select Package Category    ${CAT_NON_GAME}
    Input Package Name In Add Package    ${INPUT_256_CHAR}
    Input Developer In Add Package    ${DEVELOPER}
    Verify Error Message Field    ${ERROR_PACKAGE_CANNOT_EXCEED_255}

Package_Info_Add_non_game package info when using existing package name cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Select Package Category    ${CAT_NON_GAME}
    Input Package Name In Add Package    ${PACKAGE_NON_GAME}
    Input Developer In Add Package    ${DEVELOPER}
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Input Game Title In Add Package    ${TITLE}
    Select Store In Add Package    ${ONE}
    Click Save Button
    Verify Toast Error Message    ${ERROR_PACKAGE_ALREADY_EXISTS}

Package_Info_Add_non_game package info when title is empty cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Select Package Category    ${CAT_NON_GAME}
    Click Title In Add Package
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Verify Error Message Field    ${ERROR_TITLE_REQUIRED}

Package_Info_Add_non_game package info when title is more than maximum (256) cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Select Package Category    ${CAT_NON_GAME}
    Input Game Title In Add Package    ${INPUT_256_CHAR}
    Input Developer In Add Package    ${DEVELOPER}
    Verify Error Message Field    ${ERROR_TITLE_CANNOT_EXCEED_255}

Package_Info_Add_non_game package info when developer is empty cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Select Package Category    ${CAT_NON_GAME}
    Click Developer In Add Package
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Verify Error Message Field    ${ERROR_DEVELOPER_REQUIRED}

Package_Info_Add_non_game package info when developer is more than maximum (256) cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Select Package Category    ${CAT_NON_GAME}
    Input Developer In Add Package    ${INPUT_256_CHAR}
    Click Package Name In Add Package
    Verify Error Message Field    ${ERROR_DEVELOPER_CANNOT_EXCEED_255}

Package_Info_Add_non_game package info when history comment is empty cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Select Package Category    ${CAT_NON_GAME}
    Click History Comment In Add Package
    Click Package Name In Add Package
    Verify Error Message Field    ${ERROR_COMMENT_REQUIRED}

Package_Info_Add_non_game package info when history comment is more than maximum (1001) cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Select Package Category    ${CAT_NON_GAME}
    Input History Comment In Add Package    ${INPUT_1001_CHAR}
    Click Package Name In Add Package
    Verify Error Message Field    ${ERROR_COMMENT_CANNOT_EXCEED_1000}

Package_Info_Add_Unknown package info when all fields are populated can be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Select Package Category    ${CAT_UNKNOWN}
    Input Package Name In Add Package    ${PACKAGE_UNKNOWN}
    Input Developer In Add Package    ${DEVELOPER}
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Input Game Title In Add Package    ${TITLE}
    Select Store In Add Package    ${ONE}
    Click Save Button

Package_Info_Add_Unknown package info when only required fields are populated can be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Select Package Category    ${CAT_UNKNOWN}
    Input Package Name In Add Package    ${PACKAGE_UNKNOWN_REQUIRED}
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Select Store In Add Package    ${ONE}
    Click Save Button

Package_Info_Add_unknown package info when package name is empty cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Select Package Category    ${CAT_UNKNOWN}
    Click Package Name In Add Package
    Input Developer In Add Package    ${DEVELOPER}
    Verify Error Message Field    ${ERROR_PACKAGE_REQUIRED}

Package_Info_Add_unknown package info when package name has invalid value cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Select Package Category    ${CAT_UNKNOWN}
    Input Package Name In Add Package     ${INVALID_PACKAGE_NAME}
    Input Developer In Add Package    ${DEVELOPER}
    Verify Error Message Field    ${ERROR_INVALID_NAME}

Package_Info_Add_unknown package info when package name is more than maximum (256) cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Select Package Category    ${CAT_UNKNOWN}
    Input Package Name In Add Package    ${INPUT_256_CHAR}
    Input Developer In Add Package    ${DEVELOPER}
    Verify Error Message Field    ${ERROR_PACKAGE_CANNOT_EXCEED_255}

Package_Info_Add_unknown package info when using existing package name cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Select Package Category    ${CAT_UNKNOWN}
    Input Package Name In Add Package    ${PACKAGE_UNKNOWN_REQUIRED}
    Input Developer In Add Package    ${DEVELOPER}
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Input Game Title In Add Package    ${TITLE}
    Select Store In Add Package    ${ONE}
    Click Save Button
    Verify Toast Error Message    ${ERROR_PACKAGE_ALREADY_EXISTS}

Package_Info_Add_unknown package info when title is more than maximum (256) cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Select Package Category    ${CAT_UNKNOWN}
    Input Game Title In Add Package    ${INPUT_256_CHAR}
    Input Developer In Add Package    ${DEVELOPER}
    Verify Error Message Field    ${ERROR_TITLE_CANNOT_EXCEED_255}

Package_Info_Add_unknown package info when developer is more than maximum (256) cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Select Package Category    ${CAT_UNKNOWN}
    Input Developer In Add Package    ${INPUT_256_CHAR}
    Click Package Name In Add Package
    Verify Error Message Field    ${ERROR_DEVELOPER_CANNOT_EXCEED_255}

Package_Info_Add_unknown package info when history comment is empty cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Select Package Category    ${CAT_UNKNOWN}
    Click History Comment In Add Package
    Click Package Name In Add Package
    Verify Error Message Field    ${ERROR_COMMENT_REQUIRED}

Package_Info_Add_unknown package info when history comment is more than maximum (1001) cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Select Package Category    ${CAT_UNKNOWN}
    Input History Comment In Add Package    ${INPUT_1001_CHAR}
    Click Package Name In Add Package
    Verify Error Message Field    ${ERROR_COMMENT_CANNOT_EXCEED_1000}

[Package Info - Add] add package info page will be redirected to package list page when cancel button is clicked
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Select Package Category    ${CAT_UNKNOWN}
    Input Package Name In Add Package    ${PACKAGE_GAME}
    Input Developer In Add Package    ${DEVELOPER}
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Input Game Title In Add Package    ${TITLE}
    Select Store In Add Package    ${ONE}
    Click Cancel Button
    Verify Package Page Component

# EDIT

[Package Info - Edit] game package info when all fields are populated can be Edited
    Navigate To Module    ${MODULE_PACKAGE}
    Select Package Name Or Title    ${LBL_PACKAGE_NAME}
    Input Package Name    ${PACKAGE_GAME}
    Click Search
    Click Searched Package    ${PACKAGE_GAME}
    # Edit Steps
    Click Edit
    Input Developer In Add Package    ${DEVELOPER_UPDATED}
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Input Game Title In Add Package    ${TITLE_UPDATED}
    Select Store In Add Package    ${MSCC}
    Click Save Button

[Package Info - Edit] game package info when title is empty cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Select Package Name Or Title    ${LBL_PACKAGE_NAME}
    Input Package Name    ${PACKAGE_GAME}
    Click Search
    Click Searched Package    ${PACKAGE_GAME}
    # Edit Steps
    Click Edit
    Clear Field Value   title
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Verify Error Message Field    ${ERROR_TITLE_REQUIRED}

[Package Info - Edit] game package info when title is more than maximum (256) cannot be added
    Input Game Title In Add Package    ${INPUT_256_CHAR}
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Verify Error Message Field    ${ERROR_TITLE_CANNOT_EXCEED_255}

[Package Info - Edit] game package info when developer is empty cannot be added
    Clear Field Value   developer
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Verify Error Message Field    ${ERROR_DEVELOPER_REQUIRED}

[Package Info - Edit] game package info when developer is more than maximum (256) cannot be added
    Input Developer In Add Package    ${INPUT_256_CHAR}
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Verify Error Message Field    ${ERROR_DEVELOPER_CANNOT_EXCEED_255}

[Package Info - Edit] game package info when history comment is empty cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Select Package Name Or Title    ${LBL_PACKAGE_NAME}
    Input Package Name    ${PACKAGE_GAME}
    Click Search
    Click Searched Package    ${PACKAGE_GAME}
    # Edit Steps
    Click Edit
    Click History Comment In Add Package
    Input Game Title In Add Package    ${TITLE_UPDATED}
    Verify Error Message Field    ${ERROR_COMMENT_REQUIRED}

[Package Info - Edit] game package info when history comment is more than maximum (1001) cannot be added
    Input History Comment In Add Package    ${INPUT_1001_CHAR}
    Verify Error Message Field    ${ERROR_COMMENT_CANNOT_EXCEED_1000}

[Package Info - Edit] non game package info when all fields are populated can be added
    Navigate To Module    ${MODULE_PACKAGE}
    Select Package Name Or Title    ${LBL_PACKAGE_NAME}
    Input Package Name    ${PACKAGE_NON_GAME}
    Click Search
    Click Searched Package    ${PACKAGE_NON_GAME}
    # Edit Steps
    Click Edit
    Input Developer In Add Package    ${DEVELOPER_UPDATED}
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Input Game Title In Add Package    ${TITLE_UPDATED}
    Select Store In Add Package    ${MSCC}
    Click Save Button

[Package Info - Edit] non game package info when title is empty cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Select Package Name Or Title    ${LBL_PACKAGE_NAME}
    Input Package Name    ${PACKAGE_NON_GAME}
    Click Search
    Click Searched Package    ${PACKAGE_NON_GAME}
    # Edit Steps
    Click Edit
    Clear Field Value   title
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Verify Error Message Field    ${ERROR_TITLE_REQUIRED}

[Package Info - Edit] non game package info when title is more than maximum (256) cannot be added
    Input Game Title In Add Package    ${INPUT_256_CHAR}
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Verify Error Message Field    ${ERROR_TITLE_CANNOT_EXCEED_255}

[Package Info - Edit] non game package info when developer is empty cannot be added
    Clear Field Value   developer
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Verify Error Message Field    ${ERROR_DEVELOPER_REQUIRED}

[Package Info - Edit] non game package info when developer is more than maximum (256) cannot be added
    Input Developer In Add Package    ${INPUT_256_CHAR}
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Verify Error Message Field    ${ERROR_DEVELOPER_CANNOT_EXCEED_255}

[Package Info - Edit] non game package info when history comment is empty cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Select Package Name Or Title    ${LBL_PACKAGE_NAME}
    Input Package Name    ${PACKAGE_NON_GAME}
    Click Search
    Click Searched Package    ${PACKAGE_NON_GAME}
    # Edit Steps
    Click Edit
    Click History Comment In Add Package
    Input Game Title In Add Package    ${TITLE_UPDATED}
    Verify Error Message Field    ${ERROR_COMMENT_REQUIRED}

[Package Info - Edit] non game package info when history comment is more than maximum (1001) cannot be added
    Input History Comment In Add Package    ${INPUT_1001_CHAR}
    Verify Error Message Field    ${ERROR_COMMENT_CANNOT_EXCEED_1000}

[Package Info - Edit] unknown package info when all fields are populated can be added
    Navigate To Module    ${MODULE_PACKAGE}
    Select Package Name Or Title    ${LBL_PACKAGE_NAME}
    Input Package Name    ${PACKAGE_UNKNOWN}
    Click Search
    Click Searched Package    ${PACKAGE_UNKNOWN}
    # Edit Steps
    Click Edit
    Input Developer In Add Package    ${DEVELOPER_UPDATED}
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Input Game Title In Add Package    ${TITLE_UPDATED}
    Select Store In Add Package    ${MSCC}
    Click Save Button

[Package Info - Edit] unknown package info with only optional fields populated can be added
    Navigate To Module    ${MODULE_PACKAGE}
    Select Package Name Or Title    ${LBL_PACKAGE_NAME}
    Input Package Name    ${PACKAGE_UNKNOWN_REQUIRED}
    Click Search
    Click Searched Package    ${PACKAGE_UNKNOWN_REQUIRED}
    # Edit Steps
    Click Edit
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Select Store In Add Package    ${MSCC}
    Click Save Button

Package_Info_Edit_unknown package info when title is more than maximum (256) cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Select Package Category    ${CAT_UNKNOWN}
    Input Game Title In Add Package    ${INPUT_256_CHAR}
    Input Developer In Add Package    ${DEVELOPER}
    Verify Error Message Field    ${ERROR_TITLE_CANNOT_EXCEED_255}

[Package Info - Edit] unknown package info when title is empty cannot be added
    Input Game Title In Add Package    ${INPUT_256_CHAR}
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Verify Error Message Field    ${ERROR_TITLE_CANNOT_EXCEED_255}

[Package Info - Edit] unknown package info when developer is more than maximum (256) cannot be added
    Input Developer In Add Package    ${INPUT_256_CHAR}
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Verify Error Message Field    ${ERROR_DEVELOPER_CANNOT_EXCEED_255}

[Package Info - Edit] unknown package info when history comment is empty cannot be added
    Navigate To Module    ${MODULE_PACKAGE}
    Select Package Name Or Title    ${LBL_PACKAGE_NAME}
    Input Package Name    ${PACKAGE_UNKNOWN}
    Click Search
    Click Searched Package    ${PACKAGE_UNKNOWN}
    # Edit Steps
    Click Edit
    Click History Comment In Add Package
    Input Game Title In Add Package    ${TITLE_UPDATED}
    Verify Error Message Field    ${ERROR_COMMENT_REQUIRED}

[Package Info - Edit] unknown package info when history comment is more than maximum (1001) cannot be added
    Input History Comment In Add Package    ${INPUT_1001_CHAR}
    Verify Error Message Field    ${ERROR_COMMENT_CANNOT_EXCEED_1000}

# MOVE

[Package Info - Move] package can change from Game to non game
    Navigate To Module    ${MODULE_PACKAGE}
    Search Package    ${LBL_PACKAGE_NAME}    ${PACKAGE_GAME}
    Click Checkbox For Package
    Click Move
    Select Category For Move    ${CAT_NON_GAME}
    Input History Comment In Move Package    ${HISTORY_COMMENT}
    Click Move In Modal
    Search Package    ${LBL_PACKAGE_NAME}    ${PACKAGE_GAME}
    Verify Category In Result Table    ${CAT_NON_GAME}

[Package Info - Move] package can change from non game to game
    Navigate To Module    ${MODULE_PACKAGE}
    Search Package    ${LBL_PACKAGE_NAME}    ${PACKAGE_GAME}
    Click Checkbox For Package
    Click Move
    Select Category For Move    ${CAT_GAME}
    Input History Comment In Move Package    ${HISTORY_COMMENT}
    Click Move In Modal
    Search Package    ${LBL_PACKAGE_NAME}    ${PACKAGE_GAME}
    Verify Category In Result Table    ${CAT_GAME}

[Package Info - Move] package can change from Unknown to non game
    Navigate To Module    ${MODULE_PACKAGE}
    Search Package    ${LBL_PACKAGE_NAME}    ${PACKAGE_UNKNOWN}
    Click Checkbox For Package
    Click Move
    Select Category For Move    ${CAT_NON_GAME}
    Input History Comment In Move Package    ${HISTORY_COMMENT}
    Click Move In Modal
    Search Package    ${LBL_PACKAGE_NAME}    ${PACKAGE_UNKNOWN}
    Verify Category In Result Table    ${CAT_NON_GAME}

[Package Info - Move] package can change from Unknown to game
    # Precon
    Navigate To Module    ${MODULE_PACKAGE}
    Click Add Button
    Select Package Category    ${CAT_UNKNOWN}
    Input Package Name In Add Package    ${PACKAGE_UNKNOWN_FOR_MOVE}
    Input History Comment In Add Package    ${HISTORY_COMMENT}
    Select Store In Add Package    ${ONE}
    Click Save Button
    Navigate To Module    ${MODULE_PACKAGE}
    Search Package    ${LBL_PACKAGE_NAME}    ${PACKAGE_UNKNOWN_FOR_MOVE}
    Click Checkbox For Package
    Click Move
    Select Category For Move    ${CAT_GAME}
    Input History Comment In Move Package    ${HISTORY_COMMENT}
    Click Move In Modal
    Search Package    ${LBL_PACKAGE_NAME}    ${PACKAGE_UNKNOWN_FOR_MOVE}
    Verify Category In Result Table    ${CAT_GAME}

# SEARCH

Searching a package using category GAME should be Successful
    Navigate To Module    ${MODULE_PACKAGE}
    Search By Category   ${CAT_GAME}
    Verify Category In Result Table    ${CAT_GAME}

Searching a package using category NON GAME should be Successful
    Navigate To Module    ${MODULE_PACKAGE}
    Search By Category    ${CAT_NON_GAME}
    Verify Category In Result Table    ${CAT_NON_GAME}

Searching a package using category Unknown should be Successful
    Navigate To Module    ${MODULE_PACKAGE}
    Search By Category     ${CAT_UNKNOWN}
    Verify Category In Result Table    ${CAT_UNKNOWN}

Searching a package using store Google Play should be Successful
    Navigate To Module    ${MODULE_PACKAGE}
    Search By Category    ${ALL}
    Search By Store     ${GOOGLE_PLAY}
    Verify Store In Result Table    ${GOOGLE_PLAY}

Searching a package using store Galaxy Apps should be Successful
    Navigate To Module    ${MODULE_PACKAGE}
    Search By Store    ${GALAXY_APPS}
    Verify Store In Result Table    ${GALAXY_APPS}

Searching a package using store One should be Successful
    Navigate To Module    ${MODULE_PACKAGE}
    Search By Store    ${ONE}
    Verify Store In Result Table    ${ONE}

Searching a package using store MSCC should be Successful
    Navigate To Module    ${MODULE_PACKAGE}
    Search By Store     ${MSCC}
    Verify Store In Result Table    ${MSCC}

Searching a package using store Naver should be Successful
    Navigate To Module    ${MODULE_PACKAGE}
    Search By Store     ${NAVER}
    Verify Store In Result Table    ${NAVER}

Searching a package using store T store should be Successful
    Navigate To Module    ${MODULE_PACKAGE}
    Search By Store     ${T_STORE}
    Verify Store In Result Table    ${T_STORE}

Searching a package using store Tencent should be Successful
    Navigate To Module    ${MODULE_PACKAGE}
    Search By Store     ${TENCENT}
    Verify Store In Result Table    ${TENCENT}

Searching a package using store Wandoujia should be Successful
    Navigate To Module    ${MODULE_PACKAGE}
    Search By Store     ${WANDOUJIA}
    Verify Store In Result Table    ${WANDOUJIA}

Searching a package using store Amazon should be Successful
    Navigate To Module    ${MODULE_PACKAGE}
    Search By Store     ${AMAZON}
    Verify Store In Result Table    ${AMAZON}

Searching a package using store Baidu should be Successful
    Navigate To Module    ${MODULE_PACKAGE}
    Search By Store     ${BAIDU}
    Verify Store In Result Table    ${BAIDU}

Searching a package using store 360 store should be Successful
    Navigate To Module    ${MODULE_PACKAGE}
    Search By Store     ${360_STORE}
    Verify Store In Result Table    ${360_STORE}

Searching a package using store Cool Apk should be Successful
    Navigate To Module    ${MODULE_PACKAGE}
    Search By Store     ${COOL_APK}
    Verify Store In Result Table    ${COOL_APK}

Searching a package using store Xiaomi should be Successful
    Navigate To Module    ${MODULE_PACKAGE}
    Search By Store     ${XIAOMI}
    Verify Store In Result Table    ${XIAOMI}

Searching a package using store Hi Apk should be Successful
    Navigate To Module    ${MODULE_PACKAGE}
    Search By Store     ${HI_APK}
    Verify Store In Result Table    ${HI_APK}

(SRPHGBEQA-T8410) [Package Info - List] Package Info searched by 'China Integrated Store' store should be returned in ASC order by package name
    Navigate To Module    ${MODULE_PACKAGE}
    Search By Store    ${CHINA_INTEGRATED_STORE}
    Verify Store In Result Table    ${CHINA_INTEGRATED_STORE}

(SRPHGBEQA-T8411) [Package Info - List] Package Info searched by 'Manual' store should be returned in ASC order by package name
    Navigate To Module    ${MODULE_PACKAGE}
    Search By Store     ${MANUAL}
    Verify Store In Result Table    ${MANUAL}

Searching a package using package name case insensitive search field should be Successful
    Navigate To Module    ${MODULE_PACKAGE}
    Search By Store     ${ALL}
    Select Search Field In Package Info    ${LBL_PACKAGE_NAME}
    Select Case Sensitive Or Case Insensitive    ${CASE_INSENSITIVE}
    Input Data In Seach Field In Package Info    ${TEST_CAPITALIZED}
    Click Search
    Verify Search Field In Result Table    ${LBL_PACKAGE_NAME}    ${TEST_CAPITALIZED}    False

Searching a package using package name case Sensitive search field should be Successful
    Navigate To Module    ${MODULE_PACKAGE}
    Select Search Field In Package Info    ${LBL_PACKAGE_NAME}
    Select Case Sensitive Or Case Insensitive    ${CASE_SENSITIVE}
    Input Data In Seach Field In Package Info    ${TEST_SMALL_CAPS}
    Click Search
    Verify Search Field In Result Table    ${LBL_PACKAGE_NAME}    ${TEST_SMALL_CAPS}

Searching a package using title search field should be Successful
    Navigate To Module    ${MODULE_PACKAGE}
    Select Search Field In Package Info    ${LBL_TITLE}
    Input Data In Seach Field In Package Info    ${TEST_SMALL_CAPS}
    Click Search
    Verify Search Field In Result Table    ${LBL_TITLE}    ${TEST_SMALL_CAPS}

Package_Info_Details_Package Info details page should be correct
    Navigate To Module    ${MODULE_PACKAGE}
    Select Package Name Or Title    ${LBL_PACKAGE_NAME}
    Input Package Name    ${TEST_SMALL_CAPS}
    Click Search
    Click Searched Package    ${TEST_SMALL_CAPS}
    Verify Package Details Page Component

# This is just a test
#     [Tags]  regression
#     Get Book
