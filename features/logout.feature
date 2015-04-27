Feature: Unauthenticate from Tracka-Keepa
  Users are able to logout from their account.

Scenario: User can logout
  When I visit the homepage
  And I login to my account with valid credentials
  And I logout from my account
  Then I should see the login card
  And the login form should be cleared