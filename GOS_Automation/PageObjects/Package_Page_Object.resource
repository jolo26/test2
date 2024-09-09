*** VARIABLES ***
# ${category_dropdown}    //div/span[text() = 'All']
${CATEGORY_SELECTED}                            //li/span[text() = 'value']
${CATEGORY_RESULT_TABLE}                        //tr[count]/td[@data-testid='table-body-cell']/span[text() = 'value']
${STORE_RESULT_TABLE}                           //tr[count]/td[@data-testid='table-body-cell']/div[text() = 'value']
${TITLE_RESULT_TABLE}                           //tr[count]/td[@data-testid='table-body-cell'][3][contains(translate(text(), 'UPPER', 'lower'), 'value')]
${TITLE_FIRST_RESULT_TABLE}                     //tr[1]/td[@data-testid='table-body-cell'][3][contains(text(),'value')]
${PACKAGE_NAME_FIRST_RESULT_TABLE}              //tr[1]/td[@data-testid='table-body-cell'][4][contains(text(),'value')]
${PACKAGE_NAME_RESULT_TABLE}                    //tr[count]/td[@data-testid='table-body-cell'][4][contains(text(),'value')]
${PACKAGE_NAME_CASE_SENSITIVE_RESULT_TABLE}     //tr[count]/td[@data-testid='table-body-cell'][4][contains(translate(text(), 'UPPER', 'lower'), 'value')]

${LABEL_PACKAGE}                                //h1[text()='Package']
${INPUT_SEARCH_FIELD}                           //div/input[@name='query']
${BTN_CASE_SENSITIVE}                           //button[@title='Match case active']
${BTN_DELETE}                                   //div[@data-folded='false']//button[@data-test='delete-button']
${BTN_MOVE}                                     //div[@data-folded='false']//button[@data-test='move-button']
${BTN_ADD}                                      //div[@data-folded='false']//button[@data-test='add-button']

# ADD
${INPUT_PACKAGE_NAME_ADD}                       //input[@data-testid = 'input-name']
${INPUT_DEVELOPER_ADD}                          //input[@data-testid = 'input-seller']
${INPUT_COMMENT_ADD}                            //input[@data-testid = 'input-comment']
${INPUT_TITLE_ADD}                              //input[@data-testid = 'input-applicationName']
${INPUT_STORE_ADD}                              //select[@data-testid = 'input-storeField-store']
${RADIO_CATEGORY}                               //input[@id='category']

# MOVE
${MOVE_CATEGORY}                                //label[@for='category_selected']
${INPUT_COMMENT_MOVE}                           //input[@name = 'comment']
${BTN_MOVE_MODAL}                               //button[text()='Move']

# CHECKBOX
${CHECKBOX_PACKAGE}                             //button[@data-testid='table-checkbox']


*** COMMENTS ***
Please place your login page actions here.
