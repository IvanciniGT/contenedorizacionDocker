# Contenedores

Entorno aislado donde ejecutar procesos en un host con SO Linux.

Que tiene ese entorno que lo hace aislado?
√ Su propia configuración de red -> IP(s)
√ Su propio FileSystem
√ Sus propias variables de entorno
- Limitación de acceso al hardware

Un contenedor se genera desde una Imagen de Contenedor

# Imagen de contenedor

Un fichero comprimido que contiene una serie de programas ya instalados y configurados.
Habitualmente siguiendo una estructura de FS típica de UNIX®.

También incluye:
- Configuración básica que se aplica a la hora de generarse un contenedor desde la imagen:
    - por ejemplo: comando que debe ejecutarse al inicio
    - otro ejemplo: Variables de entorno con valores por defecto
- Información adicional (SOLO INFORMACION) acerca de cómo usar la imagen
    - por ejemplo, que volumenes deberia montar
    - por ejemplo, que puertos usan por defecto los programas que allí dentro correo....

# Herramientas que permiten, crear, borra y operar con imágenes y contenedores:

- Docker engine
- Containerd
- Podman (Redhat)
- CRIO

# Docker engine

Arquitectura:

- Para hablar con docker qué usamos? Un cliente de linea de comandos: "docker"
- Con quién habla ese cli?           Un demonio que opera continuamente en segundo plano: "dockerd"
                                     Está instalado como servicio
- A su vez, la mayor parte de las operaciones que hace dockerd, realmente son realizadas por? "containerd"
- Para arrancar un contenedor se utiliza otro programa (Un proceso por cada contenedor que levanto) "runc"

# Cli de docker

Sintaxis:

$ docker <TIPO-DE-OBJETO> <OPERACION> <ARGS> = Muchos comandos tienen un alias (que no nos despiste)

TIPO-DE-OBJETO: image       container       network     volume      secret
OPERACION       list        list            list        list        list
                build       create          create      create      create
                rm          rm              rm          rm          rm
                inspect     inspect         inspect     inspect     inspect
                            start
                            stop
                            restart
                            exec
                            commit (NI DE COÑA)

# Sistema de archivos de un contenedor

Esta montado por la superposición de varias capas:

Capa 0, base: Capa de la IMAGEN:
                    No es modificable, solo lectura. No admite ningún cambio
                    Se comparte entre todos los contenedores creados desde la misma imagen
Capa 1:       Capa propia del CONTENEDOR:
                    En ella se almacenan todos los cambios (a priori) que haga en el filesystem
                    Su vida está asociada a la vida del contenedor.
                        Se crea con el contenedor, pero también se elimina con el contenedor. Implicación:
                            IMPORTANTE: Si borro un contenedor pierdo todos los cambios producidos alli dentro.
                                        Eso me interesa? Depende.
                                        Pero "siempre" precisaré de que ciertos datos tengan persistencia trás morir un contenedor.
                                        Para estos casos, utilizamos volumenes.
Capas n:      Volumenes:
                    Capas adicionales que se inyectan (montan) en el fs del contenedor, y que tienen persistencia tras morir el contenedor
                    Donde guarda docker realmente los datos almacenados en estas capas/volumenes?
                        - Host
                        - Cloud
                        - NFS

# Comenzando a hablar de redes en docker....

Al instalar docker => se genera una red lógica dentro del host (similar a la de loopback). 
    Por defecto en que tramo de red trabaja esa red: 172.17.0.0/16
    El host (que actua de gateway en esa red), obtiene la IP: 172.17.0.1
    
    Docker permite crear nuevas redes... pero esa ya viene por defecto.
    Y si no toco nada, cosa habitual, los contenedores que vaya creando se irán pinchando en esa red.

# Al arrancar un contenedor, ocurre:

- Se le asigna una IP en la red que le toque (qur si no digo nada, será la por defecto)
- Se ejecuta un proceso tipo runc
- Que a su vez levanta un proceso según este configurado en el contenedor (que a priori se hereda esa info de la imagen)

A nivel del host, si miro los procesos:
    RUNC                          -> PID(runc)
    PROCESO PROPIO DEL CONTENEDOR -> PID(propio) -> PPID(runc)
    OTROS PROCESOS                -> PID(propio) -> PPID(PROCESO PROPIO DEL CONTENEDOR)
    ¿Cúal es el proceso 1 en una maquina UNIX? Init... el que se encarga de levantar otros procesos

Que pasa si miro eso mismo a nivel del contenedor?
    Veo el proceso runc?                    NO, este proceso no corre dentro del contenedor, sino directamente a nivel del HOST
    Veo el proceso Propio del contenedor?   SI... con que ID = 1
    Otros procesos Con sus respectivos ids... que no coincidirán con los del HOST
    
----------------------------------------------------------------------------------------------------------------------------------------

IMPORTANTE: La ejecución del contenedor va ligada a su proceso 1

Al hacer un stop de un contenedor se manda una señal SIG_TERM al PID 1
Si no contesta en un periodo de tiempo ... se manda un SIGKILL (timeout)

Con el comando docker logs, podemos ver los "logs del contenedor"
De donde sale eso?  El log de un contenedor se interpreta (o se saca) del stdout y stderr 
                    del proceso 1 que corre en el contenedor

Habitualmente si arranco un servicio en un hierro... ese servicio corre en SEGUNDO PLANO
                                                     Y sus logs son guardados en ficheros

Ese proceso en segundo plano tiene stdout y un stderr? Si...

Cuando trabajamos con contenedores, el proceso 1, se lanza siempre en FOREGROUND, en primer plano, bloqueando.

----------------------------------------------------------------------------------------------------------------------------------------

Escenarios en lo que pensais que borramos un contenedor?
- cuando ya no lo necesite nunca mais:
    - El servicio ofrecido por el contenedor ya no es necesario en la empresa
    - Escalabilidad: Operaciones de escalado (clusters)
- cuando se quede corrupto/pillado
- cuando quiera actualizar software
- optimizar el cluster de maquinas físico

Los datos los pierdo... eso no lo quiero... o si... pero si no lo quiero que hago?
    Para esto existen los volumenes.

Toda imagen de contenedor me va a informar de en que carpetas guarda los datos que requieren de persistencia.
    Donde encuentro esa información? Docker hub... donde? Documentación de la imagen... quien ha escrito eso? Personas... más vale que hayan tenido el día...
                                                          
Cuando creo un contenedor tengo que asegurarme de ponerle (montarle) los volumenes adecuados para las carpetas que me indiquen. 
IMPORTANTE: SOLO SE PUEDE HACER AL CREAR EL CONTENEDOR... ESTO NO ES MODIFICABLE.


Contenedor Mysql:
    proceso de tipo msqld
            VVVV
    /var/lib/mysql (para guardar los datos de la BBDD)    >         Volumen HOST /datos/mysql
    
    Si en un momento dado borro el contenedor, puedo crear después uno nuevo, al que le monto el mismo volumen

Esto es una buena política?
- Depende... del entorno... Si estoy jugando en mi equipo... bueno...
- En un entorno de producción, quiero los datos en el HDD de un server? Ni de coña... Si el HDD peta? Si el server peta?
- Los datos los tendre en un almacenamiento con persistencia y tolerancia a fallos: Cloud, Cabina de almacenamiento, NFS (multiples tarjetas de red y RAID)

# REDES y exposición de servicios

Quien puede acceder al puerto 80 de un nginx que tenga en un contenedor en mi host? Solo quien esté en la misma red... y esto en la práctica, quienes son?
- El anfitrion (host)
- El resto de contenedores

Red de mi empresa ------------------------------------------------------------------------------------------------------------ 192.168.1.0/24
                                | (192.168.1.100)                    | (192.168.1.101)
                                PC 1                                 PC 2 
                                | (172.17.0.2)
                                |
                                |- Nginx 172.17.0.2:80
                                |
                                red de docker  172.17.0.0/16

El host 172.17.0.1, está en la misma red de docker... y por tanto si hace un ping al 172.17.0.2 llega sin problemas y curl al puerto 80 de esa IP                                
PC 2 puede contectar con mi contenedor? PING 172.17.0.2 ? No ni de coña.. con están en la misma red
¿Cómo puedo resolver esto... y que el PC2 llegue al puerto 80 del nginx(del contenedor)?
Redirección de puerto (NAT)
    192.168.1.101 -> 192.168.1.100
                        :8080       -> 172.17.0.2:80 ¿Quien se come esta redirección? el host, que está conectado a ambas redes.. sin problema
                        
IPs de mi HOST?
- 127.0.0.1     loopback
- 172.31.4.245  ethernet
- 172.17.0.1    docker

Esto esta guay para JUGAR !!!!!!!
En un entorno de producción esto sirve? CLUSTER (H/A, Escalabilidad)
                                        BALANCEO DE CARGA

Maquina 1
    Apache 1 - Redireccion de puertos
Maquina 2 PUFFFFFF
Maquina 3
    Apache 3 - Redireccion de puertos
Maquina Reserva 1
    Apache 2 - Redireccion de puertos
Maquina Reserva 2
    Apache 4 - Redireccion de puertos
Maquina 4
    Apache BC -> Maquina 1: Puerto (Apache 1)
                 Maquina Reserva 1: Puerto (Apache 2)
                 Maquina 3: Puerto (Apache 3)
                 Maquina Reserva 2: Puerto (Apache 4)

Como veis el tema? En la práctica, esto se hace automaticamente por un Kubernetes


## EJERCICIO 1
Crear un contenedor de mysql, que: 
    Ya cree por defeto una BBDD, llamada curso
    Un usuario para esa BBDD: usuario
    Con contraseña: password
    Y tambien password como contraseña del usuario ROOT de la BBDD
Accesible desde La red publica de mi maquinaY Con persistencia de los datos
MySQL version 5.6.51

$ docker container create \
    -e MYSQL_ROOT_PASSWORD=password                         # VARIABLES DE ENTORNO: Password usuario root \
    -e MYSQL_DATABASE=curso                                 # VARIABLES DE ENTORNO: Nombre BBDD \
    -e MYSQL_USER=usuario                                   # VARIABLES DE ENTORNO: Nombre usuario \
    -e MYSQL_PASSWORD=password                              # VARIABLES DE ENTORNO: Password usuario \
    -p 172.31.4.245:3306:3306                               # PUERTOS \
    -v ~/environment/datos/mysql:/var/lib/mysql             # VOLUMENES \
    mysql:5.6.51 # IMAGEN 

$ docker container create \
    --name=mimysql \
    -e MYSQL_ROOT_PASSWORD=password \
    -e MYSQL_DATABASE=curso \
    -e MYSQL_USER=usuario \
    -e MYSQL_PASSWORD=password \
    -p 172.31.4.245:3306:3306 \
    -v ~/environment/datos/mysql:/var/lib/mysql \
    mysql:5.6.51 # IMAGEN 
    
-> 5.7    

# Wordpress: Ultima version Apache (viene de serie dentro de la imagen de WP) -> BBDD
    Que opere sobre la BBDD que hemos creado ahi arriba
    Lo exportais en el puerto 8081    

$ docker container create \
    --name=miwp \
    -e WORDPRESS_DB_HOST=ip-172-31-4-245:3306 \
    -e WORDPRESS_DB_NAME=curso \
    -e WORDPRESS_DB_USER=usuario \
    -e WORDPRESS_DB_PASSWORD=password \
    -p 8081:80 \
    -v ~/environment/datos/wp:/var/www/html \
    wordpress # Las versiones :latest NO SE USAN NUNCA JAMAS BAJO PENA CAPITAL EN UN ENTORNO DE PRODUCCION 
              # Si alguien instala la version latest le cortamos las uñas y le metemos las manos en limon pa que escueza
              
              1º Por que actualiza solo
              
    # Funcionaría?
        -e WORDPRESS_DB_HOST=172.17.0.3   SIN PROBLEMA.. por defecto wp va a buscar el puerto 3306
                                          NO LO HARIA EN LA VIDA. PROHIBIDO !!!!!!! Por qué?
                                          Si mañana arranco la moto, esto funciona? Puede !

# Contenedor mysql:
    mysqld
    mysql
    ---------VVVVV Todos esos comandos se sacan de una imagen BASE de contenedor
    bash
    ls
    mkdir
    
    Las imagenes BASE son imaganes que no tienen ningun software instalado, más allá de los comandos 
    básicos que necesito para gestionar un kernel SO: Shell: sh, bash, fish, comandos basico:
        ls, mkdir, touch, echo...
    
    Alpine Tengo esos comandos... sin bash... sh pela'
        ls, mkdir, touch, echo, chmod, chown, sh
    Ubuntu: 
        ls, mkdir, touch, echo, chmod, chown, sh, bash, apt, apt-get
    Fedora: 
        ls, mkdir, touch, echo, chmod, chown, sh, bash, yum, dnf
    
## Ejercicio 3:

Crear y arrancar un contenedor pelao creado a partir de una imagen de fedora.

$ docker container create --name mifedora fedora:latest