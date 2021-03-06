# @sustainer: mastepan@redhat.com

@ui
@doc-tutorial
@oauth
@twitter
@salesforce
@datamapper
@integrations-twitter-to-salesforce
Feature: Integration - Twitter to Salesforce

  Background: Clean application state
    Given clean application state
    And delete contact from SF with email: "integrations-twitter-to-salesforce-ui"
    And clean all tweets in twitter_talky account
    And log into the Syndesis
    And navigate to the "Settings" page
    And fills all oauth settings
    And create connections using oauth
      | Twitter    | Twitter Listener |
      | Salesforce | QE Salesforce    |

  Scenario: Create
    # create integration
    When navigate to the "Home" page
    And click on the "Create Integration" link to create a new integration.
    Then check visibility of visual integration editor
    And check that position of connection to fill is "Start"

    # select twitter connection
    When select the "Twitter Listener" connection
    And select "Mention" integration action
    And click on the "Next" button
    Then check that position of connection to fill is "Finish"

    # select salesforce connection
    When select the "QE Salesforce" connection
    And select "Create or update record" integration action
    And fill in values by element data-testid
      | sobjectname      | Contact |
    And click on the "Next" button
    And force fill in values by element data-testid
      | sobjectidname    | TwitterScreenName__c |
    And click on the "Done" button

    # add data mapper step
    When add integration step on position "0"
    And select "Data Mapper" integration step
    Then check visibility of data mapper ui

    When create data mapper mappings
      | user.screenName | TwitterScreenName__c |
      | text            | Description          |
      | user.name       | FirstName; LastName  |

    And define constant "integrations-twitter-to-salesforce" of type "String" in data mapper
    And open data bucket "Constants"
    And create data mapper mappings
      | integrations-twitter-to-salesforce | Email |

    And scroll "top" "right"
    And click on the "Done" button

    # add basic filter step
    And add integration step on position "0"
    And select "Basic Filter" integration step
    Then check visibility of "Basic Filter" step configuration page
    And check that basic filter step path input options contains "text" option
    When fill in the configuration page for "Basic Filter" step with "ANY of the following, text, contains, #syndesis4ever" parameter
    And click on the "Done" button

     # add advanced filter step
    And add integration step on position "1"
    And select "Advanced Filter" integration step
    Then check visibility of "Advanced Filter" step configuration page
    When fill in the configuration page for "Advanced Filter" step with "${body.text} contains '#e2e'" parameter
    And click on the "Done" button

    # finish and save integration
    And click on the "Save" link
    And set integration name "Twitter to Salesforce E2E"
    And publish integration
    Then Integration "Twitter to Salesforce E2E" is present in integrations list
    And wait until integration "Twitter to Salesforce E2E" gets into "Running" state

    When tweet a message from twitter_talky to "Twitter Listener" with text "test #syndesis4ever"
    Then check SF "does not contain" contact with a email: "integrations-twitter-to-salesforce"

    When tweet a message from twitter_talky to "Twitter Listener" with text "test #e2e"
    Then check SF "does not contain" contact with a email: "integrations-twitter-to-salesforce"

    When tweet a message from twitter_talky to "Twitter Listener" with text "test #e2e #syndesis4ever"
    Then check SF "contains" contact with a email: "integrations-twitter-to-salesforce"
    And check that contact from SF with last name: "integrations-twitter-to-salesforce" has description "test #e2e #syndesis4ever @syndesis_listen"

    # clean-up in salesforce
    When delete contact from SF with last name: "integrations-twitter-to-salesforce-ui"
