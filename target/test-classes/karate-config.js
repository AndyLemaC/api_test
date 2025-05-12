function fn() {
  // Configurar registro detallado
  karate.configure('logPrettyRequest', true);
  karate.configure('logPrettyResponse', true);

  var config = {
    baseUrl: 'https://petstore.swagger.io/v2',
    // Tiempos de espera aumentados considerablemente
    readTimeout: 120000,     // 2 minutos
    connectTimeout: 60000,   // 1 minuto
    // Configuración de reintentos global - valores base
    retry: { count: 15, interval: 5000 },
    // Configuraciones adicionales para mejor registro
    printEnabled: true
  };

  return config;
}



