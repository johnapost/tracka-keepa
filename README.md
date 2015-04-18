[ ![Codeship Status for johnapost/tracka-keepa](https://codeship.com/projects/4c85bbe0-9151-0132-34f5-6e434ff849c7/status?branch=master)](https://codeship.com/projects/61691)

### What is Tracka Keepa ###

Tracka Keepa is a time keeping web application. Specific features will include a task interruption tracker, physical button integration and anything else that comes to mind. I expect the project will develop a personality as development progresses.

## Getting Started ##

    npm install
    gulp

## Tests ##

Tests are run with Protractor and Cucumber. WebDriver must be running in order for the tests to run. Gulp must be running in order to provide a server for the tests.

Terminal 1

    npm install protractor cucumber -g
    webdriver-manager update
    webdriver-manager start

Terminal 2

    gulp --bdd