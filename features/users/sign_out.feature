Feature: Sign Out
  To protect user account from unauthorized access
  A signed in user
  Should be able to sign out

  Scenario: User signs out
    Given Im logged in
    When I sign out
    Then I should see a signed out message
    When I return to the sight
    Then I should be signed out
