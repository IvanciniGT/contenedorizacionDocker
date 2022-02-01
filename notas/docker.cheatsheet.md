$ docker <TIPO-DE-OBJETO> <COMANDO> <ARGS>

Tipos de objeto:
    - container
                          create 
                          rm
                          list
                          inspect
                          start
                          stop
                          restart
    - image
                          build
                          pull
                          push
                          list
                          inspect
                          rm
    - network
                          create
                          list
                          rm
                          inspect
    - volume
    - secret

# IMAGENES DE CONTENEDORES: image

## Listar las imagenes de contenedores que tengo descargadas en mi máquina
CANONICA                                                                    ALIAS
                                                                                
$ docker image list                                                         $ docker images

## Borrar imagen de contenedor

$ docker image rm <ID>                                                      $ docker rmi <ID>

## Descargar una imagen de contenedor de un repo de imágenes

$ docker image pull software:version                                        $ docker pull repo:tag
                    repo:tag              TAG: Se refiere a la versión del software y a cómo se ha instalado
        Si no pongo un tag... docker busca en auto el tag "latest"
            No en todos los repos existe el tag latest
            
# CONTENEDORES

## Crear un contenedor

$ docker container create <ARGS> IMAGEN(repo:tag) <COMANDO>
    ARGS:
            --name NOMBRE
            -p     IP-HOST:PUERTO-HOST:PUERTO-CONTENEDOR     Redirecciones de puertos a nivel del host < Exposición de servicios
                   ******* Es opcional. Su valor por defecto: 0.0.0.0 Todas las IPs del host
            -v     RUTA-HOST:RUTA-CONTENEDOR        < volumenes
            -e     VARIABLE-ENTORNO=VALOR
    COMANDO: Proceso que debe ejecutarse al hacer un docker start, es decir al arrancar el contenedor
             Por defecto si no pongo nada, se toma el de la imagen
## Arrancar un contenedor

$ docker container start (ID o NOMBRE del contenedor)                      $ docker start (ID o NOMBRE del contenedor)    

## Parar un contenedor

$ docker container stop (ID o NOMBRE del contenedor)                       $ docker stop (ID o NOMBRE del contenedor)    

## Listado de los contenedores que tengo en ejecución

$ docker container list                                                    $ docker ps 

## Listado de los contenedores que tengo tanto ejecución como parados

$ docker container list --all                                              $ docker ps --all

## Borrar un contenedor

$ docker container rm (ID o nombre)                                        $ docker rm (ID o nombre)    

## Obtener todos los metadatos / información de un contenedor

$ docker container inspect (ID o NOMBRE)

## Ejecutar procesos que me de la gana dentro de un contenedor

$ docker exec (ID o NOMBRE) commando que quiero ejecutar
                            -it 
                            
## Ver el log de un contenedor

$ docker container logs (ID o NOMBRE) 

# REDES EN DOCKER

$ docket network list
