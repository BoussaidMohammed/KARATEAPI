Feature: this feature ensure that the file validToken.json containing a valid token

  Background:
    * url baseUrl
  @GetAValidToken
  Scenario: verifying if a token is valid or not
    * def token = read('../validToken.json')
    Given path 'orders'
    And header Authorization = token.accessToken
    When method get
    Then eval
    """
    if (responseStatus == 401) {
      karate.call("../authentification.feature")
      token = karate.read('../validToken.json')
      karate.log("the new token is", token.accessToken)
    }
    else karate.log("the token is valid")
    """


