Feature: Edit User
  As a registered user
  I want to be able to edit
  my user information

  Scenario: I sign in and edit my account
    Given I am logged in
    When I edit my account details
    Then I should see an account edited message
