@http_api @debugging
Feature: Users


@debuggingSingleUserExample
Scenario: List a single user
  When I GET /users/11
  And dump response body
  And dump response headers
  And dump response cookies
