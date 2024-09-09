*** SETTINGS ***
Resource            SRPHAuto/APIActions.robot
Resource            ../Actions/Login_Actions.robot
#used
Resource            ../Actions/Account_Actions.resource

Resource            ../Actions/Common_Actions.robot
Resource            ../PageObjects/Login_Page.robot
Resource            ../PageObjects/Common_Page_Object.robot
Resource            ../PageObjects/Package_Page_Object.resource
Resource            ../Constants/Common.robot
Resource            ../Constants/Account.resource
Resource            ../TestData/Package.robot
Resource            ../Actions/API/Book_Actions.robot
Library             ../Utils/Random_Words.py
Library             ../Actions/totp.py

Suite Setup         Login User
Suite Teardown      Close Browser


*** TEST CASES ***
(SRPHGBEQA-T10587) [Account] Account Page objects should be displayed
    Navigate To Module    ${ACCOUNT}
    Verify Account Page Component

(SRPHGBEQA-T10588) [Account] Account Table Columns should be displayed in order
    Navigate To Module    ${ACCOUNT}
    Verify Account Page Component

(SRPHGBEQA-T10590) [Account] User ID searched using exact keyword should be displayed
    Navigate To Module    ${ACCOUNT}
    Input User ID    a.yango
    Click Search
    Verify Search Field User ID In Result Table    User ID    a.yango

(SRPHGBEQA-T10591) [Account] User ID searched using exact keyword should be displayed
    Navigate To Module    ${ACCOUNT}
    Input User ID    a.ya
    Click Search
    Verify Search Field User ID In Result Table    User ID    a.ya

(SRPHGBEQA-T10592) [Account] User ID searched using exact keyword with trailing spaces and tabs should be displayed
    Navigate To Module    ${ACCOUNT}
    Input User ID        a.yango       
    Click Search
    Verify Search Field User ID In Result Table    User ID    a.yango

(SRPHGBEQA-T10593) [Account] User ID searched using exact keyword with trailing spaces and tabs should be displayed
    Navigate To Module    ${ACCOUNT}
    Input User ID    ${NOT_EXISTING_DATA}       
    Click Search
    Verify No Result in Result Table

(SRPHGBEQA-T10597) [Account] Data Table Settings Modal components should be displayed
    Navigate To Module    ${ACCOUNT}    
    Click Data Table Settings
    Verify Data Table Settings Component in Account Page
    Click Cancel Data Table Button

(SRPHGBEQA-T10598) [Account] Ellipsis button should display ALL actions available
    Navigate To Module    ${ACCOUNT}    
    Input User ID        srph_automation_account
    Click Search
    Click Ellipsis
    Verify Account Options
    #Teardown
    Click Lock Unlock Account    LOCK
    Click Lock Unlock No Button

(SRPHGBEQA-T10599) [Account] Edit Modal should display all components
    Navigate To Module    ${ACCOUNT}    
    ${user_input}    Input User ID        srph_automation_account
    Click Search
    Click Ellipsis
    Click Edit Account
    Verify Account Edit Modal    ${user_input}
    #Teardown
    Click Lock Unlock Account    LOCK
    Click Lock Unlock No Button

(SRPHGBEQA-T10601) [Account] User switched to Admin Type should have full authorization to all modules
    Navigate To Module    ${ACCOUNT}    
    ${user_input}    Input User ID        srph_automation_account
    Click Search
    Click Ellipsis
    Click Edit Account
    Select User Type    ADMIN
    Click Account Save
    Verify Successful Toaster    ${user_input}
    Verify Admin User Type    ${user_input}

(SRPHGBEQA-T10604) [Account] User switched to General User Type should be allowed
    Navigate To Module    ${ACCOUNT}    
    ${user_input}    Input User ID        srph_automation_account
    Click Search
    Click Ellipsis
    Click Edit Account
    Select User Type    USER
    Click Account Save
    Verify Successful Toaster    ${user_input}
    Verify User User Type    ${user_input}

(SRPHGBEQA-T10605) [Account] General type user should be able to change Read/Write permission to Package Info only
    Navigate To Module    ${ACCOUNT}    
    ${user_input}    Input User ID        srph_automation_account
    Click Search
    Click Ellipsis
    Click Edit Account
    ${package}    Select Account Authority    ${PACKAGE_INFO_AUTH}    ${EDITABLE_AUTH}
    ${device}    Select Account Authority    ${DEVICE_AUTH}    ${READ_ONLY_AUTH}
    ${device_policy}    Select Account Authority    ${DEVICE_POLICY_AUTH}    ${READ_ONLY_AUTH}
    ${package_policy}    Select Account Authority    ${PACKAGE_POLICY_AUTH}    ${READ_ONLY_AUTH}
    Click Account Save
    Verify Successful Toaster    ${user_input}
    Verify User User Type    ${user_input}
    Verify Saved Authority    ${user_input}    ${package}    ${device}    ${device_policy}    ${package_policy}

(SRPHGBEQA-T10606) [Account] General type user should be able to change Read/Write permission to Device Info only
    Navigate To Module    ${ACCOUNT}    
    ${user_input}    Input User ID        srph_automation_account
    Click Search
    Click Ellipsis
    Click Edit Account
    ${package}    Select Account Authority    ${PACKAGE_INFO_AUTH}    ${READ_ONLY_AUTH}
    ${device}    Select Account Authority    ${DEVICE_AUTH}    ${EDITABLE_AUTH}
    ${device_policy}    Select Account Authority    ${DEVICE_POLICY_AUTH}    ${READ_ONLY_AUTH}
    ${package_policy}    Select Account Authority    ${PACKAGE_POLICY_AUTH}    ${READ_ONLY_AUTH}
    Click Account Save
    Verify Successful Toaster    ${user_input}
    Verify User User Type    ${user_input}
    Verify Saved Authority    ${user_input}    ${package}    ${device}    ${device_policy}    ${package_policy}

(SRPHGBEQA-T10607) [Account] General type user should be able to change Read/Write permission to Device Group Policy only
    Navigate To Module    ${ACCOUNT}    
    ${user_input}    Input User ID        srph_automation_account
    Click Search
    Click Ellipsis
    Click Edit Account
    ${package}    Select Account Authority    ${PACKAGE_INFO_AUTH}    ${READ_ONLY_AUTH}
    ${device}    Select Account Authority    ${DEVICE_AUTH}    ${READ_ONLY_AUTH}
    ${device_policy}    Select Account Authority    ${DEVICE_POLICY_AUTH}    ${EDITABLE_AUTH}
    ${package_policy}    Select Account Authority    ${PACKAGE_POLICY_AUTH}    ${READ_ONLY_AUTH}
    Click Account Save
    Verify Successful Toaster    ${user_input}
    Verify User User Type    ${user_input}
    Verify Saved Authority    ${user_input}    ${package}    ${device}    ${device_policy}    ${package_policy}

(SRPHGBEQA-T10608) [Account] General type user should be able to change Read/Write permission to Package Policy only
    Navigate To Module    ${ACCOUNT}    
    ${user_input}    Input User ID        srph_automation_account
    Click Search
    Click Ellipsis
    Click Edit Account
    ${package}    Select Account Authority    ${PACKAGE_INFO_AUTH}    ${READ_ONLY_AUTH}
    ${device}    Select Account Authority    ${DEVICE_AUTH}    ${READ_ONLY_AUTH}
    ${device_policy}    Select Account Authority    ${DEVICE_POLICY_AUTH}    ${READ_ONLY_AUTH}
    ${package_policy}    Select Account Authority    ${PACKAGE_POLICY_AUTH}    ${EDITABLE_AUTH}
    Click Account Save
    Verify Successful Toaster    ${user_input}
    Verify User User Type    ${user_input}
    Verify Saved Authority    ${user_input}    ${package}    ${device}    ${device_policy}    ${package_policy}

(SRPHGBEQA-T10611) [Account] Reset OTP Modal components should be displayed
    Navigate To Module    ${ACCOUNT}    
    ${user_input}    Input User ID        srph_automation_account
    Click Search
    Click Ellipsis
    Click Reset OTP Account
    Verify Account Reset OTP Modal
    Click Account Cancel

(SRPHGBEQA-T10612) [Account] Reset OTP should be able to perform successfully
    Navigate To Module    ${ACCOUNT}    
    ${user_input}    Input User ID        srph_automation_account
    Click Search
    ${account_otp}    Get Account OTP
    Click Ellipsis
    Click Reset OTP Account
    Click Account Reset
    Verify OTP has Changed    ${account_otp}

(SRPHGBEQA-T10613) [Account] Reset Password Modal components should be displayed
    Navigate To Module    ${ACCOUNT}    
    ${user_input}    Input User ID        srph_automation_account
    Click Search
    Click Ellipsis
    Click Reset Password Account
    Verify Account Reset Password Modal
    Click Cancel Button

(SRPHGBEQA-T10614) [Account] Reset Password should be able to perform successfully
    ${password}    Get Random Password
    set_suite_variable    ${password}
    Navigate To Module    ${ACCOUNT}    
    Input User ID        srph_automation_account
    Click Search
    Click Ellipsis
    Click Reset Password Account
    Input Account Password    ${password}
    Input Account Confirm Password    ${password}
    Click Reset Password Save
    Verify Reset Password Success Toaster

(SRPHGBEQA-T10615) [Account] Reset Password using same password should not be allowed
    Navigate To Module    ${ACCOUNT}    
    Input User ID        srph_automation_account
    Click Search
    Click Ellipsis
    Click Reset Password Account
    Input Account Password    ${password}
    Input Account Confirm Password    ${password}
    Click Reset Password Save
    Verify Reset Password Unsuccess Toaster

(SRPHGBEQA-T10616) [Account] Unlock/Lock Modal Components should be displayed
    Navigate To Module    ${ACCOUNT}    
    Input User ID        srph_automation_account
    Click Search
    Click Ellipsis
    Click Lock Unlock Account    LOCK
    Verify Lock Unlock Modal
    Click Lock Unlock No Button

(SRPHGBEQA-T10617) [Account] User should be able to lock account
    Navigate To Module    ${ACCOUNT}    
    Input User ID        srph_automation_account
    Click Search
    Click Ellipsis
    Click Lock Unlock Account    LOCK
    Click Lock Unlock Yes Button
    Click Ellipsis
    Verify Locked Account
    #Teardown
    Click Lock Unlock Account    UNLOCK
    Click Lock Unlock No Button

(SRPHGBEQA-T10618) [Account] User should be able to unlock account
    Navigate To Module    ${ACCOUNT}    
    Input User ID        srph_automation_account
    Click Search
    Click Ellipsis
    Click Lock Unlock Account    UNLOCK
    Click Lock Unlock Yes Button
    Click Ellipsis
    Verify Unlocked Account
    #Teardown
    Click Lock Unlock Account    LOCK
    Click Lock Unlock No Button
    