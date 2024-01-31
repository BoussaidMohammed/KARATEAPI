# To create an order we must have a valid token, for that we call validTokenFeature in background
# To get the available and the unavailable books Ids we called a feature for that is the getBookIdFeature.
#
#
Feature: Create orders

  Background:
    * url baseUrl
    * def validTokenFeature = callonce read('validToken.feature@GetAValidToken')
    * def token = validTokenFeature.token

  Scenario: successful orders with available books
    #* print token.accessToken
    * def availableBookIdScenario = call read("getBookId.feature@availableBookId")
    Given path 'orders'
    And header Authorization = token.accessToken
    And request {bookId : #(availableBookIdScenario.availableId) , customerName : "Mohammed" }
    When method post
    Then status 201


  Scenario: unsuccessful orders with unavailable books
    * def unavailableBookIdScenario = call read("getBookId.feature@unavailableBookId")
    Given path 'orders'
    And header Authorization = token.accessToken
    And request {bookId : #(unavailableBookIdScenario.unavailableId) , customerName : "Mohammed" }
    When method post
    Then status 404
    And match response contains {"error" : "#string"}