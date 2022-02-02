# Ordenes para generar la imagen nueva mia

# Imagen de la que parto
FROM fedora:latest      

    # Docker va a crear un contenedor con esta imagen.
    # En él va a ejecutar / Configurar lo que le pida...
    # Finalmente hará un commit de ese contenedor y le pondrá un tag
    # Docker va a mantener ese contenedor vivo mientras hacemos nuestro trabajo (configuramos nuestra nueva imagen)
    
# Ejecutar comandos en el contenedor temporal desde el que se creará la imagen
# RUN comando
RUN yum install nginx -y
COPY ./nginx.conf /etc/nginx/nginx.conf
RUN yum install git -y
RUN git clone https://github.com/IvanciniGT/webEjemploAnsible.git /web
# RUN /bin/cp -rf /laweb/* /usr/share/nginx/html

CMD ["nginx","-g","daemon off;"]

# Configuraciones con valores por defecto

# Info para el que le interese
EXPOSE 81
VOLUME ["/web"]
LABEL VERSION_DE_MI_APP=1.17
LABEL Otros="Este app va sin garantia de ningun tipo. Si te falla... pues es lo que hay. Buscate la vida !!!!"

# Deprecated
MAINTAINER Ivan Osuna <ivan.osuna.ayuste@gmail.com> 
LABEL maintainer="Ivan Osuna <ivan.osuna.ayuste@gmail.com>"