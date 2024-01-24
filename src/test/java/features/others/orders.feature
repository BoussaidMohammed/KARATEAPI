Feature: Create orders

  Background:
    * url baseUrl
    * def token = callonce read '../validToken.json'

  Scenario Outline: successful orders with available books
    * print token.accessToken
    Given path 'orders'
    And header Authorization = token.accessToken
    And request {bookId : <bookId> , customerName : <customerName> }
    When method post
    Then status 201
    Examples:
      | read('validOrders.csv') |

  Scenario Outline: unsuccessful orders with unavailable books
    * print token.accessToken
    Given path 'orders'
    And header Authorization = token.accessToken
    And request {bookId : <bookId> , customerName : <customerName> }
    When method post
    Then status 400
    And match response contains {"error" : "#string"}
    #And match response contains {"error" : "Invalid or missing bookId."}
    Examples:
      | read('invalidOrders.csv') |
