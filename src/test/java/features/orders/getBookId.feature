Feature: Get books ID

  Background:
    * url baseUrl

  @booksIds
  Scenario: Getting the available book IDS
    Given path 'books'
    When method get
    Then status 200
    And def availableIds = karate.jsonPath(response,"$[?(@.id)].id")
    And print availableIds

  @availableBookId
  Scenario: Getting an available id
    Given def getAnIdExistIn =
    """
    function(ids){
      const min = 0;
      const max = ids.length - 1;
      const index = Math.floor(Math.random() * (max - min + 1) + min);
      return ids[index];
    }
    """
    And def booksIdsScenario = call read("getBookId.feature@booksIds")
    Then def availableId = getAnIdExistIn(booksIdsScenario.availableIds)
    And print availableId

  @unavailableBookId
  Scenario: Getting an unavailable id
    Given def getIdNotExistIn =
    """
    function(ids){
      const maxNumber = Math.max(...ids);
      return parseInt(maxNumber + 1);
    }
    """
    And def booksIdsScenario = call read("getBookId.feature@booksIds")
    Then def unavailableId = getIdNotExistIn(booksIdsScenario.availableIds)
    And print unavailableId