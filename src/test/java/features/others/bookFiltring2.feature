Feature: Book filtering

  Background:
    * url baseUrl

  Scenario Outline: book filtering based on type
    Given path 'books'
    When method get
    Then status 200
    * def filteredResponse = karate.jsonPath(response, "$[?(@.type == '"+ <type> +"')].type")
    And print filteredResponse
    And match filteredResponse == "#[] #string? _ == <type>"
    Examples:
      | type          |
      | 'fiction'     |
      | 'non-fiction' |
