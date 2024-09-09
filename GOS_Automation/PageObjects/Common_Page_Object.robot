*** Comments ***
Please place your login page actions here.


*** Variables ***
${search_btn}                           //button[@type='submit']
${category_drop_down}                   //div[@data-testid='select-category']/button
${store_drop_down}                      //div[@data-testid='select-store']/button
${search_field_drop_down}               //div[@data-testid='select-searchField']/button
${category_drop_down_options}           //div[@data-testid='select-category']/ul/div/li/span[text() = 'value']
${store_drop_down_options}              //div[@data-testid='select-store']/ul/div/li/span[text() = 'value']
${search_field_drop_down_options}       //div[@data-testid='select-searchField']/div/ul/div/li/span[text()='value']
${progress_bar}                         //div[@class='tw-fixed tw-top-[48px] tw-max-h-[4px] tw-z-50 tw-w-full']
${input_field}                          //div/input[@name='query']
${case}                                 //button/*[@data-testid='TextFieldsIcon']/parent::button
${case_sensitive_btn}                   //button[@title='Match case active']
${case_insensitive_btn}                 //button[@title='Match case inactive']
${module}                               //a[@href='hrefloc']
${module_device}                        //button/span[text()='Device']
${module_history}                       //button/span[text()='History']
${no_result}                            //span[@data-testid= "no-data-text"][text()='There is no data to display']
${no_result_img}                        //img[@src= "/assets/NoDataToDisplay-6vhcMzcQ.svg"]
${btn_and}                              //div/label[text()='AND']
${btn_or}                               //div/label[text()='OR']

${input_package_name}                   //input[@name='packageName']
${input_device_group}                   //input[@name='deviceGroupName']

${row_result_table}                     //tr[@data-testid='table-body-row']

${btn_Settings}                         //button[@data-testid='table-settings-trigger-button']

${equals_begins}                        //div[@data-testid='select-containOperation']
${equals}                               //li/span[text() = 'Equals']
${begin_with}                           //li/span[text() = 'Begin with']
${btn_case_sensitive}                   //button[@title='Match case active']
${btn_and}                              //div/label[text()='AND']
${btn_or}                               //div/label[text()='OR']
${btn_delete}                           //button/div[text()='Delete']
${btn_bulk_delete}                      //button/div[text()='Bulk Delete']
${btn_duplicate}                        //button/div[text()='Duplicate']
${btn_add_json}                         //button/div[text()='Add Json']
${btn_add}                              //button[@data-test='add-button']
${select}                               (//div[@data-testid='select-searchField']/button)[1]

# DETAILS
${btn_list}                             //button[@data-test='list-button']
${details_label}                        //div/div[text()='field_label']
${details_label_with_label}             //div/div/label[text()='field_label']
${details_title}                        //span[@class='form-head-operation-menu__label'][text()='title']
${details_history_column_0}             //th[@data-testid='head_cell.0']/span[text()='column']
${details_history_column_1}             //th[@data-testid='head_cell.1']/span[text()='column']
${details_history_column_2}             //th[@data-testid='head_cell.2']/span[text()='column']
${details_history_column_3}             //th[@data-testid='head_cell.3']/span[text()='column']
${details_history_column_4}             //th[@data-testid='head_cell.4']/span[text()='column']
${btn_enable_copying}                   //div[@class='tw-truncate'][text()='Enable copying']
${btn_list}                             //div[@class='tw-truncate'][text()='List']
${btn_duplicate}                        //div[@class='tw-truncate'][text()='Duplicate']
${btn_edit}                             //div[@class='tw-truncate'][text()='Edit']/parent::button
${btn_list_history}                     //button[@class='btn btn-outline-dark form-head-operation-menu__button'][text()='List']

# HISTORY
${details_history_column}               //th[@class='table-head__cell'][text()='column']

# HEADERS
${page_header}                          //h1[text()='value']
${header_category}                      //th/span[text()='Category']
${header_title}                         //th/span[text()='Title']
${header_package}                       //th/span[text()='Package']
${header_developer}                     //th/span[text()='Developer']
${header_store}                         //th/span[text()='Store']
${header_updated}                       //th/span[text()='Updated']
${header_created}                       //th/span[text()='Created']

# SEARCH
${label_category}                       //label[@for='category']
${label_action}                         //label[@for='action']
${label_store}                          //label[@for='store']
${label_search_field}                   //div[@data-testid='select-searchField']
${category_all}                         //div[@data-testid='select-category']/button
${selected_value}                       //li/span[text() = 'value']

# BUTTONS
${btn_cancel}                           //button[@data-test = 'cancel-button']
${btn_save}                             //button[@data-testid = 'submit']

# ERROR_MESSAGE
${error_required_field}                 //div[@class='error-message']/div[contains(text(),"error_message")]
${modal_error_message}                  //p[@data-test='toast-body'][text()='error']

# Data Table Settings
${table_settings_btn}                   (//button[@data-testid='table-settings-trigger-button'])[1]
${able_settings_header}                 //div[@data-testid='modal-title'][text()='Data table settings']
${table_settings_toggle}                //button[@data-testid='wrap-lines-switch']
${table_settings_reset_txt}             //button/div[text()='Reset']
${table_settings_cancel_txt}            //button/div[text()='Cancel']
${table_settings_save_txt}              //button/div[text()='Save']
${table_settings_reset_btn}             //button[@data-testid='table-settings-wrap-lines-reset-button']
${table_settings_cancel_btn}            //button[@data-testid='table-settings-wrap-lines-cancel-button']
${table_settings_save_btn}              //button[@data-testid='table-settings-wrap-lines-save-button']

# BUTTON
${account_cancel_btn}                   //div[text()='Cancel']/parent::button
${account_save_btn}                     //div[text()='Save']/parent::button
${account_reset_btn}                     //div[text()='Reset']/parent::button
