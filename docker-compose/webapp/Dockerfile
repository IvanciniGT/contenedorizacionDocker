# BIENVENIDOS A LOS PROYECTOS DOCKERFILE MULTISTAGE !!!!!!!!
# Ponermos como usuario root (o cualquier otro) en mi contenedor, desde el que voy a generar la imagen

# FASE 1: Descargo el proyecto de git
FROM bitnami/git:latest AS clonador

#ARG REPO_URL=https://github.com/IvanciniGT/automatizacionTesting.git
ARG REPO_URL
ARG PROJECT_FOLDER

RUN echo Usando la url: $REPO_URL
RUN echo Buscando el proyecto: $PROJECT_FOLDER
RUN git clone $REPO_URL /tmp/proyecto

# Instalamos el software necesario
FROM maven:3.8.4-jdk-11 AS empaquetador
ARG PROJECT_FOLDER
COPY --from=clonador /tmp/proyecto /miproyecto
RUN cd /miproyecto/$PROJECT_FOLDER && mvn package

# Desplegar la app en toomcat
FROM bitnami/tomcat:latest
# existe app-original?? La tendre que crear
ARG REPO_URL
ARG PROJECT_FOLDER
ARG TOMCAT_PORT=8080

USER root

RUN mkdir -p /app-original
COPY --from=empaquetador /miproyecto/mi-web-service/target/mi-web-service.war /app-original
RUN chmod 755 -R /app-original

COPY ./init.sh /
RUN chmod 755 /init.sh
VOLUME ["/app"]

USER 1001
ENV PROJECT_FOLDER=$PROJECT_FOLDER
ENV REPO_URL=$REPO_URL

EXPOSE $TOMCAT_PORT

CMD ["/bin/sh","-c","/init.sh"]
# Cuando arranque un contenedor creado desde esta imagen:
# [ -z "$(ls carpeta)" ]
# 1 Mirar si la carpeta app esta vacia. 1ª ejecucion
#       -> Cargamos ahi nuestra app
# 2 No esta vacia... Dejamos lo que hay

# CAMBIOS:
# CMD: que implemente la logica de arriba.. Y despues de esa lógica que hará el comando?
    # Lanzar el tomcat con el script de bitnami

# Crear ese script