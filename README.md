## Performance testing tool for Digitransit services

This repository can be used to performance test services inside or outside the environment with Siege. Test requests are defined in files and it is possible to define different headers to be used for requests for each file. By default, tests are run once every day but it's possible to configure them to run more often or seldomly.

## Configuration

There are multiple ways to configure how and what is being tested by defining env variables.
* TEST_INTERVAL defines how often tests are being run. Default value is 1 (i.e. once per day)
* TEST_TIME defines at what time of the day tests are being run (in UTC). Default is 23:00:00
* CONCURRENT_USERS defines how many concurrent users siege uses for testing. Default is 10.
* SIEGE_TIME defines for how long siege tests requests from one file
* FILES_AND_HEADERS defines the files that are being tested from test_files directory and optionally headers to be used for specific files. Files (and their headers) are separated by commas without extra space inbetween. For example, FILES_AND_HEADERS='urls.txt --content-type "application/graphql",other_urls.txt -H "Content-Type: text/json"'

