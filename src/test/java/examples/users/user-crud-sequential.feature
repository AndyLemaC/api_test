Feature: CRUD de Usuario Secuencial - Petstore API

  Background:
    * url baseUrl
    * def payloads = read('classpath:examples/users/user-payloads.json')
    * def uuid = java.util.UUID.randomUUID() + ''
    * def username = 'user_' + uuid
    * def user = eval('JSON.parse(JSON.stringify(payloads.createUser))')
    * def updatedUser = eval('JSON.parse(JSON.stringify(payloads.updatedUser))')
    * set user.username = username
    * set updatedUser.username = username

  Scenario: CRUD completo para un usuario
    # 0 - Verificar que la API está activa usando un endpoint más confiable
    * url baseUrl + '/store/inventory'
    When method get
    Then status 200
    * print 'API está activa'

    # Resetear la URL base para los próximos pasos
    * url baseUrl

    # 1 - Crear un nuevo usuario
    Given path 'user'
    And request user
    When method post
    Then status 200
    * print 'Usuario creado:', user.username
    And match response.message == user.id.toString()
    # Pausa larga para asegurar que la API procese la creación
    * karate.pause(20000)

    # 2 - Verificar la creación con reintentos robustos
    * configure retry = { count: 20, interval: 3000 }
    * path 'user', user.username
    * retry until responseStatus == 200
    * method get
    * print 'Usuario encontrado después de reintentos:', response.username
    * match response.username == user.username
    * match response.email == user.email

    # 3 - Actualizar el usuario
    * path 'user', user.username
    * request updatedUser
    * method put
    * status 200
    * match response.message == updatedUser.id.toString()
    # Pausa larga para asegurar que la API procese la actualización
    * karate.pause(20000)

    # 4 - Verificar la actualización con reintentos robustos
    * configure retry = { count: 20, interval: 3000 }
    * path 'user', updatedUser.username
    * retry until responseStatus == 200
    * method get
    * print 'Usuario actualizado encontrado después de reintentos:', response.username
    * match response.firstName == updatedUser.firstName
    * match response.email == updatedUser.email

    # 5 - Eliminar el usuario
    * path 'user', updatedUser.username
    * method delete
    * status 200
    * match response.message == updatedUser.username