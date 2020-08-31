@http_api @users
Feature: This feature will be used to validate the retrevial of
user information.

@list
Scenario: List of current Users
  Given I set request query
  | page | 2 |
  And The response must complete in 2 seconds
  When I GET /users?
  And dump response body
  Then json response should match
  | field    | matcher | value |
  | page     | match   | 2     |
  | per_page | match   | 6     |
  | total    | match   | 12    |


@single
Scenario: List a single user
  When I GET /users/11
  And The response must complete in 2 seconds
  And dump response body
  Then json response should match
  | field      | matcher | value                    |
  | data.id    | match   | 11                       |
  | data.email | match   | george.edwards@reqres.in |
  | ad.company | match   | StatusCode Weekly        |

@nosingle
Scenario: Single user Not found
  When I GET /users/23
  Then response should match fixture singleNotFound
  And response status code should be 404

@newuser
Scenario: Create New User
  Given The response must complete in 4 seconds
  And set request json body from newuser
  When I POST /users
  Then json response should match
  | field | matcher | value   |
  | name  | match   | Lincoln |
  | job   | match   | leader  |
  | id    | present |         |
  And response status code should be 400

@updateuser
Scenario: Update user
  Given set request json body from updateuser
  When I PUT /users/2
  Then json response should match
  | field     | matcher | value             |
  | name      | match   | Lincoln           |
  | job       | match   | Great Emancipator |
  | updatedAt | present |                   |
  And The response must complete in 4 seconds
  And response status code should be 200
