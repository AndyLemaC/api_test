
Feature: CRUD de Usuario - Petstore API

  Background:
    * url baseUrl
    * def payloads = read('classpath:examples/users/user-payloads.json')
    * def uuid = java.util.UUID.randomUUID() + ''
    * def username = 'user_' + uuid
    * def user = eval('JSON.parse(JSON.stringify(payloads.createUser))')
    * def updatedUser = eval('JSON.parse(JSON.stringify(payloads.updatedUser))')
    * set user.username = username
    * set updatedUser.username = username

    # Función para verificar disponibilidad - devuelve true/false
    * def verificarUsuario =
      """
      function(nombre) {
        var respuesta = karate.call('classpath:examples/users/verify-user.feature', { username: nombre });
        return respuesta.exists;
      }
      """

  @healthcheck
  Scenario: 0 - Validar API activa
    * url baseUrl + '/store/inventory'
    When method get
    Then status 200
    * print 'API está activa'
    # Reseteamos la URL base para los siguientes escenarios
    * url baseUrl

  @create
  Scenario: 1 - Crear un nuevo usuario
    Given path 'user'
    And request user
    When method post
    Then status 200
    * print 'Usuario creado:', user.username
    And match response.message == user.id.toString()
    # Pausa crucial después de crear - aumentada a 20 segundos
    * karate.pause(20000)

  @read
  Scenario: 2 - Buscar el usuario creado
    # Mejora el feature de reintento para que use el mismo enfoque que el secuencial
    * configure retry = { count: 20, interval: 3000 }
    * path 'user', user.username
    * retry until responseStatus == 200
    * method get
    * print 'Usuario encontrado después de reintentos:', response.username
    * match response.username == user.username
    * match response.email == user.email

  @update
  Scenario: 3 - Actualizar el nombre y correo del usuario
    Given path 'user', user.username
    And request updatedUser
    When method put
    Then status 200
    And match response.message == updatedUser.id.toString()
    # Pausa crucial después de actualizar - aumentada a 20 segundos
    * karate.pause(20000)

  @read
  Scenario: 4 - Verificar los datos del usuario actualizado
    # Mejora el feature de reintento para que use el mismo enfoque que el secuencial
    * configure retry = { count: 20, interval: 3000 }
    * path 'user', updatedUser.username
    * retry until responseStatus == 200
    * method get
    * print 'Usuario actualizado encontrado después de reintentos:', response.username
    * match response.firstName == updatedUser.firstName
    * match response.email == updatedUser.email

  @delete
  Scenario: 5 - Eliminar el usuario
    Given path 'user', updatedUser.username
    When method delete
    Then status 200
    And match response.message == updatedUser.username