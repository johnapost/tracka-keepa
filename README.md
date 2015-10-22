[![Codeship Status for johnapost/tracka-keepa](https://codeship.com/projects/4c85bbe0-9151-0132-34f5-6e434ff849c7/status?branch=master)](https://codeship.com/projects/61691)
[![Code Climate](https://codeclimate.com/github/johnapost/tracka-keepa/badges/gpa.svg)](https://codeclimate.com/github/johnapost/tracka-keepa)
[![Test Coverage](https://codeclimate.com/github/johnapost/tracka-keepa/badges/coverage.svg)](https://codeclimate.com/github/johnapost/tracka-keepa/coverage)

What is Tracka Keepa?
=====================

Tracka Keepa is a time keeping web application. Specific features will include a task interruption tracker, physical button integration and anything else that comes to mind. I expect the project will develop a personality as development progresses.

Getting Started
---------------

Don't forget to start your mongodb server.

    npm install
    gulp del && gulp

You can now visit ```http://localhost:4000``` to view the app.

Directory Structure
-------------------

    root
    |-dist
    |-gulp
    |-server
    | |-controllers
    | |-models
    | |-auth.coffee
    | |-config.coffee
    | |-db.coffee
    | |-main.coffee
    | `-server.js
    `-src
      |-components
      | `-component
      |   |-component.coffee
      |   |-component.jade
      |   `-component.scss
      |-partials
      | `-head.jade
      |-views
      | `-index.jade
      |-_mixins.scss
      |-app.coffee
      `-app.scss

Tests
-----

Simply ```npm test``` in order to run the suite.

* Client unit tests: Karma and Jasmine
* Server unit tests: TBD
* E2E tests: NightwatchJS

Contributing
------------

Pull requests welcome.
