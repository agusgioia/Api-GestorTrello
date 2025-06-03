# Etapa de construcción
FROM eclipse-temurin:21-jdk AS build

WORKDIR /app

# Copiar dependencias y código fuente
COPY . .

# Empaquetar la app, salteando los tests (si es necesario)
RUN ./mvnw clean package -DskipTests

# Etapa final: imagen para producción
FROM eclipse-temurin:21-jdk

WORKDIR /app

# Copiar el JAR desde el build
COPY --from=build /app/target/*.jar app.jar

# Exponer el puerto (ajustar si tu app corre en otro puerto)
EXPOSE 8080

# Comando para ejecutar
CMD ["java", "-jar", "app.jar"]
