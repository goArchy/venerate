Feature: In order to get access to protected parts of the sight
  As a new user
  I should be able to sign up

  Background:
    Given I am not logged in

  Scenario: User signs up with valid data
    When I signup with valid user data
    Then I should see a successful sign up message

  Scenario: User signs up with invalid email
    When I sign in with an invalid email
    Then I should see an invalid email error message

  Scenario: User signs up with out password
    When I sign in without a password
    Then I should see a missing password message

  Scenario: User signs up with out password confirmation
    When I sign in without a password confirmation
    Then I should see a missing password confirmation message

  Scenario: User signs up with mismatched password and confirmation
    When I sign in with a mismatched password confirmation
    Then I should see a mismatched passwords message


