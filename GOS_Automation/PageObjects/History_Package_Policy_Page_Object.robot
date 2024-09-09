*** Comments ***
Please place your login page actions here.


*** Variables ***
${label_package_policy_history}                         //h1[text()='History / Package policy']
${device_group_result_table}                            //tr[count]/td[@data-testid='table-body-cell'][1][contains(text(), 'value')]
${header_history_title}                                 //tr/th[1]/span[text()='Game title']
${header_history_package}                               //tr/th[2]/span[text()='Package']
${header_history_device_group_name}                     //tr/th[3]/span[text()='Device Group Name']
${header_history_history_comment}                       //tr/th[6]/span[text()='History Comment']
${header_history_updated}                               //tr/th[4]/span[text()='Updated']
${header_history_created}                               //tr/th[5]/span[text()='Created']

${package_name_case_insensitive_result_table}           //tr[count]/td[@data-testid='table-body-cell'][2]/text()[translate(., 'UPPER', 'lower'), 'value']
${package_case_sensitive_equal_result_table}            //tr[count]/td[@data-testid='table-body-cell'][2][text() = 'value']
${package_first_result_table}                           //tr[1]/td[@data-testid='table-body-cell'][2][contains(text(), 'value')]
${package_name_case_sensitive_begins_result_table}      //tr[count]/td[@data-testid='table-body-cell'][2][contains(text(), 'value')]
${device_group_case_result_table}                       //tr[count]/td[@data-testid='table-body-cell'][3][text() = 'value']
