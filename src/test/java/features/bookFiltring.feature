Feature: Book filtering

  Background:
    * url baseUrl

  Scenario Outline: book filtering based on type <type>
    Given path 'books'
    #And params {type : <type>}
    When method get
    Then status 200
    And print response
    And match each response[*].type contains <type>
    And match response[*].type == '#[] #string? _ == <type>'
    Examples:
      | type          |
      | "fiction"     |
      | "non-fiction" |

