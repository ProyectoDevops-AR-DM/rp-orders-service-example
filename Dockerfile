# Usar una imagen base de OpenJDK
FROM openjdk:11-jre-slim

# Crear un grupo y un usuario no root
RUN groupadd -r ordersgroup && useradd -r -g ordersgroup -m -s /bin/sh ordersuser

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar el archivo JAR de la aplicación al contenedor
COPY target/orders-service-example-0.0.1-SNAPSHOT-spring-boot.jar /app/orders-service-example.jar

# Cambiar la propiedad del archivo JAR para el nuevo usuario
RUN chown ordersuser:ordersgroup orders-service-example.jar

# Cambiar al nuevo usuario no root
USER ordersuser

# Definir el ENTRYPOINT para que use la variable de entorno pasada en tiempo de ejecución
ENTRYPOINT ["sh", "-c", "java -jar orders-service-example.jar $APP_ARGS"]

# Por defecto, la variable de entorno APP_ARGS estará vacía, pero puede ser sobreescrita en tiempo de ejecución
