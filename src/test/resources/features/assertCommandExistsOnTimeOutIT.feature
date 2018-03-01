Feature: assertCommandExistsOnTimeOutIT - Check command output with exit status

  Background: Connect to bootstrap machine
    Given I open a ssh connection to '${SSH}' with user 'root' and password 'stratio'

  Scenario: Check command output with correct expresion and exist status=0
    Then in less than '50' seconds, checking each '10' seconds, the command output 'echo 2018 | grep -e "[0-9]\{4\}" | wc -l' contains '1' with exit status '0'

  Scenario: Check with output  with incorrect expresion and exist status status!=0
    Then in less than '50' seconds, checking each '10' seconds, the command output 'echo 2018 | grep -e "^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{.*}}$ | wc -l' contains '1' with exit status '1'

  Scenario: Check command output without exit status
    Then in less than '50' seconds, checking each '10' seconds, the command output 'echo 2018 | grep -e "[0-9]\{4\}" | wc -l' contains '1'