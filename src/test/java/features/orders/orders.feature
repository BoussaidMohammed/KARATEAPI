Feature: Create orders

  Background:
    * url baseUrl
    * def validTokenFeature = callonce read('validToken.feature@GetAValidToken')
    * def token = validTokenFeature.token

  Scenario: successful orders with available books
    * print token.accessToken
    * def availableIdFeature = call read("getBookId.feature@availableBookId")
    Given path 'orders'
    And header Authorization = token.accessToken
    And request {bookId : #(availableIdFeature.availableId) , customerName : "Mohammed" }
    When method post
    Then status 201


  Scenario: unsuccessful orders with unavailable books
    * def unavailableIdFeature = call read("getBookId.feature@unavailableBookId")
    Given path 'orders'
    And header Authorization = token.accessToken
    And request {bookId : #(unavailableIdFeature.unavailableId) , customerName : "Mohammed" }
    When method post
    Then status 400
    And match response contains {"error" : "#string"}
