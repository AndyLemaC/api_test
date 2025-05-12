
Feature: Reintenta GET usuario

  Scenario:
    * def userPath = '/user/' + username

    # Importante: No utilizamos variables aquí para evitar problemas de conversión
    # Colocamos directamente los valores literales en la configuración
    * configure retry = { count: 10, interval: 3000 }

    # La indentación es CRÍTICA - dos espacios por nivel
    # Observa que las líneas siguientes DEBEN estar indentadas
    * retry until responseStatus == 200
    Given path userPath
    When method get

    # Verificamos resultado después del último intento
    * def statusOk = responseStatus == 200
    * if (!statusOk) karate.log('Usuario no encontrado tras múltiples intentos. URL:', userPath)

    Then assert statusOk
    * def result = { response: response, responseStatus: responseStatus }