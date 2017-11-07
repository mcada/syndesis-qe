# Created by jludvice at 29.3.17
@smoke
Feature: Connections CRUD test
  # Enter feature description here

  Background:
    Given clean application state

  Scenario: CREATE and DELETE connection happy path
    When "Camilla" navigates to the "Connections" page
    And click on the "Create Connection" button
    And Camilla selects the "Twitter" connection
    Then she is presented with the "Validate" button    

    When she fills "Twitter Listener" connection details
    Then click on the "Validate" button
    Then she can see "Twitter has been successfully validated" in alert-success notification

    Then scroll "top" "right"
    And click on the "Next" button
    And type "my sample twitter connection" into connection name
    And type "this connection is awesome" into connection description
    And click on the "Create" button
    Then Camilla is presented with the Syndesis page "Connections"

    When Camilla selects the "my sample twitter connection" connection
    Then Camilla is presented with "my sample twitter connection" connection details

    When "Camilla" navigates to the "Connections" page
    Then Camilla is presented with the Syndesis page "Connections"

    When Camilla deletes the "my sample twitter connection" connection
    # delete was not fast enough some times so sleep is necessary
    Then she stays there for "2000" ms
    Then Camilla can not see "my sample twitter connection" connection anymore

  Scenario: Test whether connections kebab menu works as it should
    When "Camilla" navigates to the "Connections" page
    #TODO is there any connection? If there are no default connections there is nothing
    #     so we should add at least one connection first
    And click on the "Create Connection" button
    And Camilla selects the "Twitter" connection
    Then she is presented with the "Validate" button    
    When she fills "Twitter Listener" connection details
    # no validation as its not necessary for this scenario

    Then scroll "top" "right"
    And click on the "Next" button
    And type "my sample twitter connection" into connection name
    And type "this connection is awesome" into connection description
    And click on the "Create" button
    Then Camilla is presented with the Syndesis page "Connections"



    # now we know there is at least one connection
    And clicks on the kebab menu icon of each available connection
    Then she can see unveiled kebab menu of all connections, each of this menu consist of "View", "Edit" and "Delete" actions


    # garbage collection
    When "Camilla" navigates to the "Connections" page
    Then Camilla is presented with the Syndesis page "Connections"

    When Camilla deletes the "my sample twitter connection" connection
    Then she stays there for "2000" ms
    Then Camilla can not see "my sample twitter connection" connection anymore


    #TODO create scenario for view and edit options from kebab menu
  @wtf
  Scenario: Test that view and edit options work from kebab menu
    When "Camilla" navigates to the "Connections" page
    And click on the "Create Connection" button
    And Camilla selects the "Twitter" connection
    Then she is presented with the "Validate" button    

    When she fills "Twitter Listener" connection details
    Then click on the "Validate" button
    Then she can see "Twitter has been successfully validated" in alert-success notification

    Then scroll "top" "right"
    And click on the "Next" button
    And type "my sample twitter connection" into connection name
    And type "this connection is awesome" into connection description
    And click on the "Create" button
    Then Camilla is presented with the Syndesis page "Connections"

    When clicks on the "Edit" kebab menu button of "my sample twitter connection"
    Then she is presented with connection details page

    When "Camilla" navigates to the "Connections" page
    Then Camilla is presented with the Syndesis page "Connections"

    When clicks on the "View" kebab menu button of "my sample twitter connection"
    Then she is presented with connection details page

    When "Camilla" navigates to the "Connections" page
    Then Camilla is presented with the Syndesis page "Connections"

    When Camilla deletes the "my sample twitter connection" connection
    # delete was not fast enough some times so sleep is necessary
    Then she stays there for "2000" ms
    Then Camilla can not see "my sample twitter connection" connection anymore