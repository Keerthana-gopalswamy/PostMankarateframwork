Feature: Testing GraphQL API using postman request url in karate framework

Background:
  * url baseurl

  # Gives the request in the text format
Scenario: Using post request to retrives the response and make an assertion
  Given text query =
"""
  query Hello {
    hello(person: { name: "Karate framework" })
}


"""
  And request {query: "#(query)"}
  When method POST
  Then status 200
  Then print response 
  And match response.data.hello contains 'Karate'
  Then response.name == "Karate framework"

  # Gives the request directly to the GIVEN 
Scenario:Using post request retrives the response print the headers
  Given request
  """
    {
      "query":" query Hello {
    hello
    request {
        headers
    }
}"
    }
  """
  
  When method POST
  Then status 200
  Then print response

Scenario:Using post request to create a mutation and retrives the response 
  Given text mutation =
  """
    mutation CreatePerson {
    createPerson(person: { name: "karatemutation" }) {
        id
        age
        name
    }
}

  """
    And request {query: "#(mutation)"}
  When method POST
  Then status 200
  Then print response
  Then response.data.createPerson.name =="karatemutation"


Scenario:Using post request to retrives the response and subscription
  Given text subscription =
  """
subscription Greetings {
    greetings
}

  """
    And request {query: "#(subscription)"}
    When method POST
    Then status 200
    Then print response
    Then response.data == "Zdravo"
    