@http_api @login
Feature: This feature will be used to validate the user authenication to the system.
Test to include successful and unsuccessful authentication attempts.

@badLogin
Scenario: Unsuccessful Login
  Given the response must complete in 4 seconds
  And set request json body from badlogin
  When I POST /login
  Then json response should match
  | field | matcher | value            |
  | error | match   | Missing password |
  And response status code should be 400


@missingPassword @regression
  Scenario: Unsuccessful Login
    Given the response must complete in 4 seconds
    And set request json body from badlogin
    When I POST /login
    Then response should match fixture missingPassword
    And response status code should be 400
