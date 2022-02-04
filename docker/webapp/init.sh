# Cuando arranque un contenedor creado desde esta imagen:
if [ -z "$(ls /app-original)" ]; then
# 1 Mirar si la carpeta app esta vacia. 1ª ejecucion
#       -> Cargamos ahi nuestra app
    echo "Montando la app por primera vez"
    cp /app-original/* /app
    #sed -i "S/[[TOMCAT_PORT]]/$TOMCAT_PORT/g" /opt/bitnami/tomcat/conf/server.xml
# 2 No esta vacia... Dejamos lo que hay
else
    echo "Usando app existente"
fi

/opt/bitnami/scripts/tomcat/run.sh