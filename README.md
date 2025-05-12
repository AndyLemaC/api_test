# 🧪 Proyecto de Automatización de API con Karate DSL - Petstore

Este proyecto automatiza pruebas sobre la API pública de [Petstore Swagger](https://petstore.swagger.io/) utilizando **Karate DSL**.

---

## ✅ Requisitos Previos

- Java JDK 11 o superior  
- Maven 3.6.3 o superior  
- IntelliJ IDEA (recomendado)

---

## ⚙️ Configuración del Entorno de Desarrollo

### 1️⃣ Clonar el Repositorio

```bash
git clone https://github.com/tu-usuario/petstore-api-automation.git
cd petstore-api-automation
```

### 2️⃣ Configurar IntelliJ IDEA

Instalar los siguientes plugins:

- Maven Integration  
- Cucumber (Gherkin)  
- Karate Plugin

### 3️⃣ Importar el Proyecto

1. Abrir IntelliJ IDEA  
2. Seleccionar **"Open"** y elegir el archivo `pom.xml`  
3. Marcar la opción **"Open as Project"**

---

## ▶️ Ejecución de Pruebas

### Desde IntelliJ IDEA

1. Navegar a `src/test/java/petstore/runners/UserTestRunner.java`  
2. Hacer clic derecho y seleccionar **"Run UserTestRunner"**

### Desde Línea de Comandos

```bash
# Ejecutar todas las pruebas
mvn clean test

# Ejecutar pruebas con tags y reporte detallado
mvn clean test -Dkarate.options="--tags ~@ignore"
```

---

## 🗂️ Estructura del Proyecto

```
petstore-api-test/
├── src/
│   └── test/
│       ├── java/
│       │   ├── karate-config.js               # Configuración global de Karate (ubicación correcta)
│       │   └── examples/
│       │       └── users/
│       │           ├── user-test.feature      # Escenarios de prueba
│       │           └── UsersRunnerTest.java   # Runner de pruebas
│       └── resources/
│           └── examples/
│               └── users/
│                   └── user.json              # Datos de prueba
├── target/                                     # Carpeta generada por Maven
├── logback-test.xml                            # Configuración de logs
├── pom.xml                                     # Archivo de configuración Maven
└── README.md                                   # Instrucciones del proyecto

```

---

## ❓ Resolución de Problemas

- Asegúrate de tener Java 11+ correctamente configurado.
- Verifica que Maven puede descargar todas las dependencias (revisa tu conexión a internet o el proxy).
- Revisa la consola de salida para mensajes de error específicos.

---

## 📊 Reportes de Pruebas

Los reportes se generan automáticamente en:

```
target/karate-reports/
```

Para ver los resultados detallados, abre:

```
target/karate-reports/karate-summary.html
```
