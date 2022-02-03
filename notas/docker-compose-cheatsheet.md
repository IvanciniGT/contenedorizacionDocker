sudo apt-get install docker-compose -y

# El fichero de Docker-compose puede llamarse:
    docker-compose.yml
    docker-compose.yaml

# Crear (solo si no existen o si han cambiado) 
# y arrancar los contenedores definidos en un fichero docker-compose

$ docker-compose up
    -d  Modo detached (en segundo plano)
    -f  Indicarle un fichero concreto docker-compose.yaml... 
        caso que el nuestro no se llame así o esté en otra ruta

PROTIP: La primera vez que ejecuteis un docker-compose NO PONGAIS el -d. 
        Así vemos que arranca bien
        Si arranca bien, lo puedo parar y ya arrancarlo con la poción -d

# Detener y borrar los contenedores de un fichero docker-compose

$ docker-compose down
    -f  Indicarle un fichero concreto docker-compose.yaml... 
        caso que el nuestro no se llame así o esté en otra ruta

# Detener los contenedores de un fichero docker-compose

$ docker-compose stop
    -f  Indicarle un fichero concreto docker-compose.yaml... 
        caso que el nuestro no se llame así o esté en otra ruta

