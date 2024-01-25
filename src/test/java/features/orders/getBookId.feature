Feature: Get books ID

  Background:
    * url baseUrl
    * def getAnIdExistsIn =
    """
    function(ids){
      if(ids.length > 0){
        const min = 0;
        const max = ids.length - 1;
        const index = Math.floor(Math.random() * (max - min + 1) + min);
        return ids[index];
      }
      return -1;
    }
    """

  @booksIds
  Scenario: Getting the available book IDS
    Given path 'books'
    When method get
    Then status 200
    And def availableBooksIds = karate.jsonPath(response,"$[?(@.available == true)].id")
    And def unavailableBooksIds = karate.jsonPath(response,"$[?(@.available == false)].id")
    And print availableBooksIds
    And print unavailableBooksIds

  @availableBookId
  Scenario: Getting an available id
    Given def booksIdsScenario = call read("getBookId.feature@booksIds")
    Then def availableId = getAnIdExistsIn(booksIdsScenario.availableBooksIds)
    And print availableId

  @unavailableBookId
  Scenario: Getting an unavailable id
    Given def booksIdsScenario = call read("getBookId.feature@booksIds")
    Then def unavailableId = getAnIdExistsIn(booksIdsScenario.unavailableBooksIds)
    And print unavailableId