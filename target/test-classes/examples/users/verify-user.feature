Feature: User Verifier

  Scenario:
    * url baseUrl
    * path '/user', username
    * method get
    * def exists = responseStatus == 200 ? true : false
