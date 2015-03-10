Feature: Authenticate with Tracka-Keepa
  Users are able to register and login to their account.

Scenario: User can register
  When I visit the homepage
  And I register for an account
  Then I should have my account created

Scenario: User can login
  When I visit the homepage
  And I login to my account with valid credentials
  Then I should see my dashboard

Scenario: User cannot login
  When I visit the homepage
  And I login to my account with invalid credentials
  Then I should see an error message