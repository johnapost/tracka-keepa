Feature: Authenticate with Tracka-Keepa

Scenario: User can login
  When I visit the homepage
  And I login to my account with valid credentials
  Then I should see my dashboard

Scenario: User cannot login
  When I visit the homepage
  And I login to my account with invalid credentials
  Then I should see an error message