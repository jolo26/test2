*** Comments ***
Please place your login page actions here.


*** Variables ***
${input_package_name}                               //input[@name='packageName']
${input_device_group}                               //input[@name='deviceGroupName']
${category_selected}                                //li/span[text() = 'value']
${row_result_table}                                 //tr[@data-testid='table-body-row']

${device_group_case_insensitive_result_table}       //tr[count]/td[@data-testid='table-body-cell'][2][contains(text(), 'value')]
${device_group_first_result_table}                  //tr[1]/td[@data-testid='table-body-cell'][2][contains(text(), 'value')]
${device_group_case_result_table}                   //tr[count]/td[@data-testid='table-body-cell'][4]

${label_main}                                       //h1[text()='Device Group Policy']
${label_main_history}                               //h1[text()='History / Device Group policy']
${btn_delete}                                       //button/div[text()='Delete']
${btn_bulk_delete}                                  //button/div[text()='Bulk Delete']
${btn_add_json}                                     //button/div[text()='Add Json']
${btn_Add}                                          //button/div[text()='Add']
${btn_Settings}                                     //button[@data-testid='table-settings-trigger-button']
${header_device_group}                              //tr/th[2]/span[text()='Device Group']
${header_devices}                                   //tr/th[3]/span[text()='Device(s)']
${header_packages}                                  //tr/th[4]/span[text()='Package(s)']
${header_spa}                                       //tr/th[7]/span[text()='Game Performance SPA']
${header_resolution}                                //tr/th[8]/span[text()='Resolution']
${header_updated}                                   //tr/th[5]/span[text()='Updated']
${header_framebooster}                              //tr/th[9]/span[text()='FrameBooster']
