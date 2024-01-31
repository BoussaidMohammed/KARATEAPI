# Create new user and generate new token and put it to a file to later use.
# To put the token in a file, we create a Writer java class for that and we call that class using Java.type() method
# makeString is used to generate a new random string, we use it to create each time a new user, therefore a new token
# 
Feature: Verifying authentication

  Background:
    * url baseUrl

  Scenario: Check if the token exists after registration
    * def makeString =
    """
    function (length) {
      const charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
      let result = "";
      const charsetLength = charset.length;
      for (let i = 0; i < length; i++) {
        const randomIndex = Math.floor(Math.random() * charsetLength);
        result += charset.charAt(randomIndex);
      }
      return result;
    }
    """
    * def requestBody = {}
    * set requestBody.clientName = makeString(10)
    * set requestBody.clientEmail = makeString(10) + "@gmail.com"
    Given path 'api-clients'
    #And print requestBody
    And request requestBody
    When method post
    And match response contains {"accessToken" : "#present"}
    #And match response.accessToken == '#string'
    Then status 201
    * def responseBody = '{ "accessToken" : "'+ response.accessToken+ '" }'
    * def writer =  Java.type("utilities.Writer")
    * writer.write("features/validToken.json", responseBody)