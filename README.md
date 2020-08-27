# CnV Testing Suite

The integration test automation suite allows writing tests in Gherkin format
 with backing code that translates natural language phrases into tests.
 To do this we are using [CucumberJS](https://github.com/cucumber/cucumber-js)
 along with the [Veggies](https://github.com/ekino/veggies) extension.


### What you will need
* node v8.12.0

### First run
1. Ensure you have set the environment variables
    * TEST_ENV - \[ local | dev | staging ]
    * TESTRAIL_USERNAME - user name for accessing TestRail
    * TESTRAIL_PASSWORD - password for the TestRail account
    * NODE_TLS_REJECT_UNAUTHORIZED=0

2. Run `npm install` to ensure you have all the project's dependencies
3. Run `npm test` to check that the current tests run properly in your environment

### To add new tests
1. Create a directory for the feature you want to test.
2. Add a new featureName.feature file in the new directory
3. Write your scenarios. See the errorReport feature for an example on authenticated calls and chaining requests
4. Add any fixtures you may need to supply data to your tests.

#### Available expressions
Expressions provided by the veggies library. Important to note, http api is one portion of the Veggies project.  Other expressions are available and documented on the [Vegges project page](https://ekino.github.io/veggies/) as well as updated documentation.  The expressions below are an unofficial list, but are here for convenience.
```yaml    
Given:
  - /^(?:I )?set request headers$/
  - /^(?:I )?assign request headers$/
  - /^(?:I )?set ([a-zA-Z0-9-]+) request header to (.+)$/
  - /^(?:I )?clear request headers/
  - /^(?:I )?set request json body$/
  - /^(?:I )?set request json body from (.+)$/
  - /^(?:I )?set request form body$/
  - /^(?:I )?set request form body from (.+)$/
  - /^(?:I )?clear request body$/
  - /^(?:I )?set request query$/
  - /^(?:I )?pick response json (.+) as (.+)$/
  - /^(?:I )?enable cookies$/
  - /^(?:I )?disable cookies$/
  - /^(?:I )?set cookie from (.+)$/
  - /^(?:I )?clear request cookies$/

When:
  - /^(?:I )?reset http client$/
  - /^(?:I )?(GET|POST|PUT|DELETE) (.+)$/
  - /^(?:I )?dump response body$/
  - /^(?:I )?dump response headers$/
  - /^(?:I )?dump response cookies$/

Then:
  - /^response status code should be ([1-5][0-9][0-9])$/
  - /^response status should be (.+)$/
  - /^response should (not )?have an? (.+) cookie$/
  - /^response (.+) cookie should (not )?be secure$/
  - /^response (.+) cookie should (not )?be http only$/
  - /^response (.+) cookie domain should (not )?be (.+)$/
  - /^(?:I )?json response should (fully )?match$/
  - /^(?:I )?should receive a collection of ([0-9]+) items?(?: for path )?(.+)?$/
  - /^response should match fixture (.+)$/
  - /^response header (.+) should (not )?(equal|contain|match) (.+)$/
```

Some custom definitions that we have built are found in the [definitions.js](https://github.com/proquest/rw3-api-acceptance-tests/blob/master/support/definitions.js) file.
```yaml
Given:
 - /^(?:I )?pick response body as (.+)$/
 - /^[Aa]n authenticated user named (.+) with password (.+) in (.+)$/
 - /^[Tt]he variable (.+) is (not )(.+)$/
 - /^[[Tt]he response must complete in (\d+) seconds$/
Then:
 - /^[Tt]he response completed in time$/  //requires the given step that sets time to complete the call
```

### Integrating with TestRail
This project has the capability of updating test cases stored in TestRail.

To associate a feature to a test case, you will need to:
1. Modify the config/cucumber_testrail.yml file to point at your test suite and plan, test suites do not have to be added to the test plan in order to work.
    * project_id: Found on the project home page, prefixed by a 'P', use the number only, no prefix
    * project_symbol: This is for identifying which suites your test cases are attached to.  This should be unique by test suite.
    * section_id: [Optional} the section id in TestRail
    * testplan_id: The associated test plan.  This can be different by test suite or use the same one.
2. Tag your scenarios
    * In TestRail, find the test case that you want to associate to a scenario in your feature file.  The ID is prefixed with a C, again, use only the numeric portion.
    * In the feature file, associate your scenario to a test case using a cucumber tag.  The tag should be in the format: @TestRail-{project_symbol}-{test case id}


### Executing tests

From a command line, run:

`npm test`

This will create the reports directory. To push these reports to TestRail, run:

`npm run report`
