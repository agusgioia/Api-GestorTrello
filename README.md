# Backend - Trello Clone API

Este es el backend del proyecto **Trello Clone**, desarrollado con **Spring Boot** y **Java 21**, que expone una API REST para gestionar tableros, listas y tarjetas (cards). Utiliza **Firebase Firestore** como base de datos, accediendo de forma segura mediante el **Firebase Admin SDK**.

## Tecnologías utilizadas

- Java 21  
- Spring Boot 3  
- Firebase Admin SDK  
- Firestore (Base de datos NoSQL)  
- Maven  
- Docker  

## Configuración

### Variables de entorno

La aplicación utiliza una única variable de entorno para configurar el acceso a Firestore:

- `FIREBASE_CREDENTIALS_BASE64`: contiene el contenido archivo JSON de credenciales de Firebase.

## Construcción y ejecución

### Con Maven

```bash
./mvnw clean package -DskipTests
java -jar target/app.jar
```

### Con Docker

```Dockerfile
# Etapa de construcción
FROM eclipse-temurin:21-jdk AS build

WORKDIR /app
COPY . .
RUN chmod +x mvnw
RUN ./mvnw clean package -DskipTests

# Etapa final
FROM eclipse-temurin:21-jdk

WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
```

Construcción y ejecución del contenedor:

```bash
docker build -t trello-backend .
docker run -p 8080:8080 -e FIREBASE_CREDENTIALS_BASE64="TU_VALOR_BASE64" trello-backend
```

## Endpoints principales

| Método | Endpoint                                              | Descripción                             |
|--------|-------------------------------------------------------|-----------------------------------------|
| GET    | `/api/boards`                                         | Obtener todos los tableros              |
| GET    | `/api/boards/{id}`                                    | Obtener un tablero por id               |
| GET    | `/api/boards/user/{id}`                               | Obtener todos los tableros de un usuario|
| POST   | `/api/boards`                                         | Crear un nuevo tablero                  |
| PUT    | `/api/boards/{id}`                                    | Actualizar un tablero existente         |
| DELETE | `/api/boards/{id}`                                    | Eliminar un tablero                     |
| POST   | `/api/boards/{id}/lists`                              | Crear una nueva lista en un tablero     |
| DELETE | `/api/boards/{id}/lists/{listTitle}`                  | Eliminar una lista de un tablero        |
| POST   | `/api/boards/{id}/lists/{listTitle}/cards`            | Crear una tarjeta en una lista          |
| DELETE | `/api/boards/{id}/lists/{listTitle}/cards/{cardTitle}`| Eliminar una tarjeta de una lista       |

## Seguridad y buenas prácticas

- No subas credenciales ni datos sensibles al repositorio.
- Usá únicamente variables de entorno para las claves.
- Configurá adecuadamente las reglas de seguridad de Firestore para producción.

## Despliegue

Este backend puede desplegarse en plataformas como **Render**, **Railway**, **Heroku**, etc. Solo necesitás:

- Definir `FIREBASE_CREDENTIALS_BASE64` como variable de entorno en el entorno de despliegue.
- Exponer el puerto 8080 o el configurado en la aplicación.

