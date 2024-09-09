*** Comments ***
Please place your login page actions here.


*** Variables ***
${package_first_result_table}                           //tr[1]/td[@data-testid='table-body-cell'][4][contains(text(),'value')]
${category_result_table_history}                        //tr[count]/td[@data-testid='table-body-cell'][1]/div[text() = 'value']
${store_result_table_history}                           //tr[count]/td[@data-testid='table-body-cell'][5]/div[text() = 'value']

${title_result_table_history}                           //tr[count]/td[@data-testid='table-body-cell'][2][contains(translate(text(), 'UPPER', 'lower'), 'value')]
${title_first_result_table_history}                     //tr[1]/td[@data-testid='table-body-cell'][2][contains(text(),'value')]
${package_name_result_table_history}                    //tr[count]/td[@data-testid='table-body-cell'][3][contains(text(),'value')]
${package_name_case_sensitive_result_table_history}     //tr[count]/td[@data-testid='table-body-cell'][3][contains(translate(text(), 'UPPER', 'lower'), 'value')]
