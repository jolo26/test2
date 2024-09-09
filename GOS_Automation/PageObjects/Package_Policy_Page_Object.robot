*** Comments ***
Please place your login page actions here.


*** Variables ***
${input_package_name}                                   //input[@name='packageName']
${input_device_group}                                   //input[@name='deviceGroupName']
${category_selected}                                    //li/span[text() = 'value']
${row_result_table}                                     //tr[@data-testid='table-body-row']

${package_name_result_table}                            //tr[count]/td[@data-testid='table-body-cell'][4][contains(text(),'value')]
${package_first_result_table}                           //tr[1]/td[@data-testid='table-body-cell'][3][contains(text(),'value')]
${package_name_case_insensitive_result_table}           //tr[count]/td[@data-testid='table-body-cell'][3]/text()[translate(., 'UPPER', 'lower'), 'value']
${package_name_case_sensitive_equal_result_table}       //tr[count]/td[@data-testid='table-body-cell'][3][text() = 'value']
${package_name_case_sensitive_begins_result_table}      //tr[count]/td[@data-testid='table-body-cell'][3][contains(text(), 'value')]
${device_group_case_insensitive_result_table}           //tr[count]/td[@data-testid='table-body-cell'][4]/text()[translate(., 'UPPER', 'lower'), 'value']
${device_group_case_result_table}                       //tr[count]/td[@data-testid='table-body-cell'][4]

${label_main}                                           //h1[text()='Package Policy']
${label_package_name}                                   //label[text()='Package Name']
${label_device_group}                                   //form/label[text()='Device Group']
${header_package}                                       //tr/th[3]/span[text()='Package']
${header_title}                                         //tr/th[2]/span[text()='Title']
${header_device_group_name}                             //tr/th[4]/span[text()='Device Group Name']
${header_spa}                                           //tr/th[6]/span[text()='Game Performance SPA']
${header_resolution}                                    //tr/th[7]/span[text()='Resolution']
${header_updated}                                       //tr/th[5]/span[text()='Updated']
${header_framebooster}                                  //tr/th[8]/span[text()='FrameBooster']
