
*** Variables ***

${row_result_table}                                 //tr[@data-testid='table-body-row']
${device_name_result_table}                         //tr[count]/td[@data-testid='table-body-cell'][3]/text()[contains(translate(., 'UPPER', 'lower'), 'value')]
${product_name_result_table}                        //tr[count]/td[@data-testid='table-body-cell'][2]/text()[contains(translate(., 'UPPER', 'lower'), 'value')]
${device_group_name_result_table}                   //tr[count]/td[@data-testid='table-body-cell'][1]/text()[contains(translate(., 'UPPER', 'lower'), 'value')]
${device_model_name_result_table}                   //tr[count]/td[@data-testid='table-body-cell'][4]/text()[contains(translate(., 'UPPER', 'lower'), 'value')]

${label_device}                                     //h1[text()='Device / Device Group Manager']
${search_field_dropdown}                            //div[@class='tw-flex tw-flex-auto tw-max-w-full']/span[text() = 'Device Group Name']
${input_search_field}                               //div/input[@name='query']
${btn_delete}                                       //button/div[text()='Delete']
${btn_move}                                         //button/div[text()='Move']
${btn_Add}                                          //button/div[text()='Add']
${btn_Settings}                                     //button[@data-testid='table-settings-trigger-button']
${header_device_name}                               //th/span[text()='Device Name']
${header_product_name}                              //th/span[text()='Product Name']
${header_device_group_name}                         //th/span[text()='Device Group Name']
${header_model_name}                                //th/span[text()='Model Name']
${header_created}                                   //th/span[text()='Created']
${header_updated}                                   //th/span[text()='Updated']

*** Comments ***
Please place your login page actions here.