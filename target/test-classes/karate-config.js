function fn() {
  var env = karate.env; // Obtiene el entorno desde la propiedad del sistema 'karate.env'
  karate.log('karate.env sistema:', env);

  // Configuración base
  var config = {
    baseUrl: 'https://petstore.swagger.io/v2'
  };

  // Configuraciones adicionales
  karate.configure('connectTimeout', 30000);
  karate.configure('readTimeout', 60000);
  karate.configure('logPrettyRequest', true);
  karate.configure('logPrettyResponse', true);

  // Variables globales
  var userId = 987654321;

  // Se añaden al objeto de configuración
  config.userId = userId;

  return config;
}

