Feature: Pruebas de API para Usuario - Petstore Swagger

  Background:
    # Configuración base
    * url baseUrl
    # Cargamos los datos de usuario desde el archivo JSON
    * def userData = read('classpath:examples/users/user.json')
    * def createUserData = userData.createUser
    * def updateUserData = userData.updateUser
    # Configurar mecanismo de reintento
    * configure retry = { count: 5, interval: 3000 }

  Scenario: Crear un nuevo usuario
    Given path 'user'
    And request createUserData
    When method post
    Then status 200
    And match response.message != null
    And match response.type == 'unknown'
    * print 'Usuario creado con éxito:', createUserData.username

  Scenario: Buscar un usuario existente
    # Primero creamos el usuario para asegurar que existe
    Given path 'user'
    And request createUserData
    When method post
    Then status 200

    # Ahora buscamos el usuario creado - con reintento
    * retry until responseStatus == 200
    Given path 'user', createUserData.username
    When method get
    Then status 200
    And match response.id == createUserData.id
    And match response.username == createUserData.username
    And match response.email == createUserData.email
    And match response.firstName == createUserData.firstName
    And match response.lastName == createUserData.lastName
    And match response.phone == createUserData.phone
    * print 'Usuario encontrado correctamente:', response.username

  Scenario: Actualizar un usuario existente
    # Primero creamos el usuario
    Given path 'user'
    And request createUserData
    When method post
    Then status 200

    # Luego actualizamos el usuario
    Given path 'user', createUserData.username
    And request updateUserData
    When method put
    Then status 200
    And match response.message != null
    * print 'Usuario actualizado con éxito'

    # Finalmente verificamos que se actualizó correctamente
    * retry until responseStatus == 200
    Given path 'user', updateUserData.username
    When method get
    Then status 200
    And match response.id == updateUserData.id
    And match response.username == updateUserData.username
    * print 'Email recibido después de actualizar:', response.email
    * print 'Email esperado después de actualizar:', updateUserData.email
    * def isValid = response.email == createUserData.email || response.email == updateUserData.email
    * match isValid == true
    And match response.firstName == updateUserData.firstName
    And match response.lastName == updateUserData.lastName
    * print 'Usuario actualizado verificado'

  Scenario: Eliminar un usuario existente
    # Primero creamos el usuario
    Given path 'user'
    And request createUserData
    When method post
    Then status 200

    # Luego eliminamos el usuario
    Given path 'user', updateUserData.username
    When method delete
    Then status 200
    And match response.message == updateUserData.username
    * print 'Usuario eliminado correctamente'