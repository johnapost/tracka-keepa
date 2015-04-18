Feature: Register with Tracka-Keepa
  Users are able to register an account.

Scenario: User can register
  When I visit the homepage
  And I register for an account
  Then I should have my account created