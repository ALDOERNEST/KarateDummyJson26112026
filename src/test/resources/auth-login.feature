Feature: DummyJSON authentication login

  Background:
    * url baseUrl
    * path 'auth', 'login'
    * header Content-Type = 'application/json'

  @auth @success @valid-credentials
  Scenario: Login with valid credentials
    Given request
      """
      {
        "username": "emilys",
        "password": "emilyspass"
      }
      """
    When method post
    Then status 200
    And match response.username == 'emilys'
    And match response.id == '#number'
    And match response.accessToken == '#string'
    And match response.refreshToken == '#string'
    And match response.email == '#string'
    And match response.firstName == '#string'
    And match response.lastName == '#string'
    And match response.gender == '#string'
    And match response.image == '#string'

  @auth @failure @invalid-password
  Scenario: Login with an incorrect password
    Given request
      """
      {
        "username": "emilys",
        "password": "incorrect-password"
      }
      """
    When method post
    Then status 400
    And match response.message == 'Invalid credentials'

  @auth @failure @missing-username
  Scenario: Login without a username
    Given request
      """
      {
        "password": "emilyspass"
      }
      """
    When method post
    Then status 400
    And match response.message == 'Username and password required'

  @auth @failure @missing-password
  Scenario: Login without a password
    Given request
      """
      {
        "username": "emilys"
      }
      """
    When method post
    Then status 400
    And match response.message == 'Username and password required'

  @auth @failure @missing-credentials
  Scenario: Login without credentials
    Given request {}
    When method post
    Then status 400
    And match response.message == 'Username and password required'

  @auth @failure @empty-credentials
  Scenario: Login with empty username and password
    Given request
      """
      {
        "username": "",
        "password": ""
      }
      """
    When method post
    Then status 400
    And match response.message == 'Username and password required'

  @auth @failure @invalid-username-type
  Scenario: Login with a username that is not a string
    Given request
      """
      {
        "username": 123,
        "password": "emilyspass"
      }
      """
    When method post
    Then status 400
    And match response.message == 'Username is not valid'

  @auth @failure @invalid-password-type
  Scenario: Login with a password that is not the expected value
    Given request
      """
      {
        "username": "emilys",
        "password": 123
      }
      """
    When method post
    Then status 400
    And match response.message == 'Invalid credentials'

  @auth @failure @unknown-user
  Scenario: Login with an unknown username
    Given request
      """
      {
        "username": "unknown-user",
        "password": "some-password"
      }
      """
    When method post
    Then status 400
    And match response.message == 'Invalid credentials'
