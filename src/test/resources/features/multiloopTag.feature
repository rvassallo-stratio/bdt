Feature: Feature used in testing multiloop tag aspect

  Scenario: wipe 1 test file.
    Given I run 'rm -f testMultiloopOutput1.txt' locally

  @multiloop(AGENT_LIST=>AGENT1_NAME)
  Scenario: write <AGENT1_NAME> a file the final result of the scenario.
    Given I run 'echo "<AGENT1_NAME>" >> testMultiloopOutput1.txt' locally

  Scenario: verify 1 file content.
    Given I run 'wc -l testMultiloopOutput1.txt' locally
    Then the command output contains '2'

  Scenario: wipe 2 test file.
    Given I run 'rm -f testMultiloopOutput2.txt' locally

  @multiloop(AGENT_LIST=>AGENT1_NAME,AGENT_LIST=>AGENT2_NAME)
  Scenario: write <AGENT1_NAME>,<AGENT2_NAME> a file the final result of the scenario.
    Given I run 'echo "<AGENT1_NAME>,<AGENT2_NAME>" >> testMultiloopOutput2.txt' locally

  Scenario: verify 2 file content.
    Given I run 'wc -l testMultiloopOutput2.txt' locally
    Then the command output contains '4'

  Scenario: wipe 3 test file.
      Given I run 'rm -f testMultiloopOutput3.txt' locally

  @multiloop(AGENT_LIST=>AGENT1_NAME,AGENT_LIST=>AGENT2_NAME,AGENT_LIST=>AGENT3_NAME)
  Scenario: write <AGENT1_NAME>,<AGENT2_NAME>,<AGENT3_NAME> a file the final result of the scenario.
    Given I run 'echo "<AGENT1_NAME>,<AGENT2_NAME>,<AGENT3_NAME>" >> testMultiloopOutput3.txt' locally

  Scenario: verify 3 file content.
    Given I run 'wc -l testMultiloopOutput3.txt' locally
    Then the command output contains '8'

#  @multiloop(AGENT1_LIST=>AGENT1_NAME,AGENT2_LIST=>AGENT2_NAME)
#  Scenario: This is an omitted scenario so it contains a failing assert
#    Given I run '[ "SHOULDNT_RUN" = "FAIL OTHERWISE" ]' locally

  @skipOnEnv(AGENT_LIST)
  Scenario: This scenario should be omitted.
    Given I run '[ "!{VAR_NOT_DEFINED}" = "{"a":{}}" ]' locally

  @runOnEnv(AGENT_LIST)
  Scenario: This scenario should be executed.
    Given I run '[ "SHOULD_RUN" = "SHOULD_RUN" ]' locally

  @runOnEnv(AGENT_LIST)
  @multiloop(AGENT_LIST=>AGENT1_NAME,AGENT_LIST=>AGENT2_NAME)
  Scenario: With scenarios outlines and datatables
    Given I create file 'testSOATtag<AGENT2_NAME>B.json' based on 'schemas/simple<AGENT1_NAME>.json' as 'json' with:
      | $.a | REPLACE | @{JSON.schemas/empty.json}     | object   |
    Given I save '@{JSON.testSOATtag<AGENT2_NAME>B.json}' in variable 'VAR'
    Then I run '[ "!{VAR}" = "{"a":{}}" ]' locally

  @runOnEnv(NO_VAR)
  @multiloop(NO_VAR=>VAR_NAME)
  Scenario: With scenarios outlines and datatables
    Given I create file 'testSOATtag<VAR_NAME.id>B.json' based on 'schemas/simple<VAR_NAME>.json' as 'json' with:
      | $.a | REPLACE | @{JSON.schemas/empty.json}     | object   |
    Given I save '@{JSON.testSOATtag<VAR_NAME.id>B.json}' in variable 'VAR'
    Then I run '[ "!{VAR}" = "{"a":{}}" ]' locally

