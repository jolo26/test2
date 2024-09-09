# RobotFramework-TestFramework
This framework is used solely for the purpose of test automation using Robot Framework

## Suggested Execution Flow
1. Run the Setup.robot Tasks first. `robot Tasks\Setup.robot`
2. Run the Tests using pabot. `pabot --testlevelsplit --processes 4 Tests`
3. Run the Teardown.robot Tasks last. `robot Tasks\Teardown.robot`

## How API Keywords Work
Please refer to https://github.sec.samsung.net/SRPH/robotframework-srphautomationlibrary for the details.