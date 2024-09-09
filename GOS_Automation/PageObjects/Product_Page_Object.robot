
*** Variables ***

${row_result_table}                                 //tr[@data-testid='table-body-row']
${device_name_result_table}                         //tr[count]/td[@data-testid='table-body-cell'][3]/text()[contains(translate(., 'UPPER', 'lower'), 'value')]
${product_name_result_table}                        //tr[count]/td[@data-testid='table-body-cell'][1]/text()[contains(translate(., 'UPPER', 'lower'), 'value')]
${product_first_result_table}                       //tr[1]/td[@data-testid='table-body-cell'][1][contains(text(),'value')]
${device_group_name_result_table}                   //tr[count]/td[@data-testid='table-body-cell'][2]/text()[contains(translate(., 'UPPER', 'lower'), 'value')]
${device_model_name_result_table}                   //tr[count]/td[@data-testid='table-body-cell'][4]/text()[contains(translate(., 'UPPER', 'lower'), 'value')]

${label_main}                                       //h1[text()='Device / Product Manager']
${search_field_dropdown}                            //div[@class='tw-flex tw-flex-auto tw-max-w-full']/span[text() = 'Product Name']
${input_search_field}                               //div/input[@name='query']
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