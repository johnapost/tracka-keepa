[ ![Codeship Status for johnapost/tracka-keepa](https://codeship.com/projects/4c85bbe0-9151-0132-34f5-6e434ff849c7/status?branch=master)](https://codeship.com/projects/61691)

What is Tracka Keepa?
=====================

Tracka Keepa is a time keeping web application. Specific features will include a task interruption tracker, physical button integration and anything else that comes to mind. I expect the project will develop a personality as development progresses.

Getting Started
---------------

Don't forget to start your mongodb server.

    npm install
    npm start

You can now visit ```http://localhost:4000``` to view the app.

This leaves a node api server and a python http-server up as background processes. Kill port 4000 and port 3000, respectively, to stop those processes.

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
