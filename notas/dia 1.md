# Qué es un Contenedor?

Es un entorno aislado de ejecución de procesos dentro de un SO Linux.
Aislado en cuanto a qué?
- Su propia configuración de red -> Su propia IP(s)
- Su propio FileSystem
- Limitación de acceso al hardware de la máquina
- Sus propias variables de entorno

## Los contenedores funcionan solo en LINUX? 
    SI, ya que se ban en funcionalidades del KERNEL DE LINUX.
## Docker desktop for Windows o MacOS?
    En windows auto. se crea una VM con hyperV con un kernel de Linux que ejecuta contenedores...
    En MacOS igual

## Cual es el kernel SO más usado en el mundo? Con diferencia aberrante sobre el siguiente? LINUX <<
Android = Linux

# Qué herramientas conoceis que nos ayudan a gestionar (crear, borrar)/ejecutar contenedores

Docker Linux (Windows, MacOS), Podman, Crio, ContainerD

## Qué es Openshift?  Distribución de Kubernetes de Redhat
## Qué es Kubernetes? Gestor de gestores de contenedores, en cluster.



## Sobre la configuración de red...

### NIC?

Network interface card... tarjeta de red: FISICA: HARDWARE

### Interfaz de red?

Una conexión a una red : SOFTWARE

### Hay relación entre una interfaz de red (lógico) y una NIC (hardware)? En ocasiones
Cuantas interfaces de red puedo tener sobre un NIC? La que quiera. Virtualización de red.
Cuantas NICs puede tener por detrás una interfaz de red? La que quiera entre 0 y montonones...
- Puedo tener una interfaz que no opere sobre un red física... en cuyo caso no necesito un NIC
- Puedo tener una interfaz de red que por detras tenga un BOND de 2 o más NICs. Más ancho de bancha y H/A
Cuantas interfaces de red suele tener al menos un computador?
- Ethernet (física): Conexión a red física  -> 172... 192.168...
- Loopback:          Red lógica que existe solamente dentro de nuestra computadora  127.0.0.1 (<- localhost)

# Y esto de los contenedores... para qué vale?
Es el estandar a día de hoy para DISTRIBUIR, INSTALAR y OPERAR ciertos tipos de software.
Esto ha cambiado el mundo de la producción y operación de software.
- Entregable de un desarrollador -> Imagen de contenedor
- Un sysadmin debe saber como instalar y operar contenedores

# Esto es nuevo? 2013 < Formalmente
Llevamos en el camino de la contenedorización desde hace más de 40 años.

## Tipos de software

* Servicios < Servidores
* Demonios
* Scripts
* Comando
* Libreria
-----------------
- Aplicaciones (Photoshop, Word)
- Driver
- SO

# Cómo distribuimos software previo contenedores

MacOS   -> Tienda... dmg (Instalador de un programa)
Windows -> Tienda... exe. iso (Instalador de un programa)
Linux   -> Tienda (repositorio de software)... que son gestionados por:
    gestor de paquetes: 
        Debian / Ubuntu : apt, apt-get
        Redhat:           yum, rpm
        Fedora:           dnf
        
# Con contenedores:

El software se distribuye mediante IMAGENES DE CONTENEDOR. Funcionan en cualquier LINUX... sin problema

## IMAGEN DE CONTENEDOR

Un triste fichero TAR (ZIP), con unas configuraciones y recomendaciones en cuanto a su uso.
Que viene ahí comprimido? Viene un software instalado, YA INSTALADO Y CONFIGURADO por alguien.
Configuraciones:
    - Cual es el comando que se debe ejecutar automaticamente por docker cuando se solicite un start 
      de un contenedor basado en este imagen

## Instalarlo

### Modelo tradicional
    
     App1  |  App2              Problemas/Inconvenientes: 
    ----------------                - Uso compartido del hierro.. App1 se vuelve loca y se pone a usar el 100% CPU. 
          SO                            --> App1 deja de responder.. y app2... y app3 todo se cae.
    ----------------                - Estandarización.... a ver como se ha instalado y configurado ??
        HIERRO                      - Pueden app1 y app2 tener dependencias de librerias incompatibles? versiones distintas? configuraciones distintas?
                                    - Seguridad? Usuarios.. SELinux AppArmor.... 

### Maquinas virtuales
    
    ----------------            Problemas / Inconvenientes:
      APP1  | APP2                  - Incremento del uso de recursos: HDD, CPU, RAM
    ----------------                - Rendimiento de las apps? BAJA
      SO    | SO                    - Más puntos de fallo... Muchos SO que pueden dar problemas
    ----------------                - Configuración mucho más compleja
      MV 1. | MV 2                  - No estandarizado
    ----------------
       hypervisor:    hyperv, kvm, virtualbox, vmware, citrix
    ----------------
          SO
    ----------------
        HIERRO

### Contenedores
    
     App1. | App2 + App3
    ----------------
     C1.   |  C2
    ----------------
      gestor/ejecutor de contenedores: docker, podman, crio, containerd
    ----------------
       SO Linux
    ----------------
        HIERRO
    
    Los contenedores me resuelven todos los problemas que teníamos cuando trabajamos :
    - con instalaciones tradicionales (sobre el hierro)
    - con maquinas virtuales
    
    El mundo de los contenedores estandariza TODO: Distribución; Los mismo para cualquier SO. 
                                             INSTALACION y CONFIGURACION:   Me da igual estar instalando un serv BBDD, WEB, APPs, TODO LO HAGO IGUAL
                                             OPERACION BASICA DE ESOS SIETEMAS:  Me da igual estar operando un serv BBDD, WEB, APPs, TODO LO HAGO IGUAL
Docker inc.      < 
                    Lo hicieron muy bien
                    Opensource
                    Funcionan sin necesidad de trucar el kernel de linux
                    Llegaron en el momento adecuado (SUERTE !!!) < RedHay, Microsoft, IBM, Amazon (AWS)
                    Sentar los estándares (contenedor, imagen de contedor)
    Docker engine ... comunmente denominado docker
    Docker-compose
    Docker swarm... Esto no se ussa en mundo... Intento de la gente de docker de tener una herramienta para entornos de producción
                    Operar en cluster < KUBERNETES LO HACE GUAY
    Docker hub ?? El mayor repositorio de repositorios de imagenes de contenedor del mundo... hay más... yo en mi empresa puedo tener el mio.
                  Redhat me da el suyo propio.
                  
Sistemas de control de versión : git > gitlab

Microsoft > Cloud, Opensource
    .net Framework -> .net Core < apps des en entorno Windows C++, c# asp. VB -> Windows, Linux, MacOs

git < Github (Opensource)


# docker engine

## Arquitectura
    Server: dockerd
        Hace entre otros:
            Crear imágenes de contenedor
            Hacer login contra repositorios de imágenes de contenedor
            Búsquedas sobre repositorios de imágenes de contenedor
            
            Gestionar contenedores e Imágenes de contenedor -> Containerd < Recomendado si trabajo con Kubernetes
                Descargar y borrar imágenes de contenedor
                Crear contenedores y borrarlos
                Ejecutarlos < runc
    
    Cliente de linea de comandos: docker
    
docker -> dockerd -> containerd -> runc

# Que pasa cuando descargo una IMAGEN DE CONTENEDOR (docker pull)
- Descargar la imagen del repositorio
- Descomprimir la imagen
    - /var/lib/docker/image

Pido hacer un pull de httpd:latest... que carpetas y archivos voy a encontrar allí dentro?
/bin        Comandos ejecutables
/sbin
/var        Datos de programas (ficheros de datos de una bbdd... las webs de un serv web... logs)
/etc        Configuraciones
/opt        Instalaciones de software
/tmp        Temporal
/home       Carpetas de usuarios
/root       Carpeta del usuario root
----------------------------------------------------------
HOST
/bin        Comandos ejecutables
/sbin
/var        Datos de programas (ficheros de datos de una bbdd... las webs de un serv web... logs)
    /lib
        /docker
            /containers
                /ID DEL CONTENEDOR <<<<
                        No se puede escribir en ella... ni hacer ningun cambio... bloqueado
                    /etc
                        apache/httpd.conf
                    /var
                        apache/logs/dia1.log
                        apache/www < Link simbolico a la carpeta /datos(host)
                        
            /image      VVV
                ... (/httpd)    > Como engaño a un proceso para hacer creer que el ROOT del FS es otro? chroot
                        /bin        Comandos ejecutables
                            rm
                            ls
                            touch
                            mkdir
                            sh
                            bash
                            fish
                            zsh
                        /sbin
                        /var        Datos de programas (ficheros de datos de una bbdd... las webs de un serv web... logs)
                            apache/www
                        /etc        Configuraciones
                            apache/httpd.conf
                        /opt        Instalaciones de software
                            apache/httpd binary
                        /tmp        Temporal
                        /home       Carpetas de usuarios
                        /root       Carpeta del usuario root
                
/etc        Configuraciones
/opt        Instalaciones de software
/tmp        Temporal
/home       Carpetas de usuarios
/root       Carpeta del usuario root


Al arrancar un contenedor... ha pillado una IP . UOOOO !!!!!
Y enima puedo atacarla... UOOOOUOOOO !!!!!

De donde es esa IP? 172.17.0.2 ???? De qué red?
De una red lógica (como concepto similar a la red de loopback) que docker ha creado cuando hemos instalado docker
Por defecto la red de docker trabaja en : 172.17.0.0/16
                                            172.17.0.1 < Ya la tiene alguien... el host, yo 
                                            172.17.0.2   miapache
Mi host tiene 3 IP:
    - 127.0.0.1     Interfaz loopback       << Esta red existe solo dentro de mi computadora.
    - 172.31.4.245  Red amazon / ethernet
    - 172.17.0.1    Red docker              << Esta red existe solo dentro de mi computadora.
    
------------------------------------------------------------
2 contenedores
    miapache
    miapache2
Cada contenedor tiene su propio FS

Dentro de cada contenedor puedo ejecutar el apache (httpd)

Cuantas veces tengo por ahi en el HDD del host el fichero binario httpd? 1
    Comparten binario... donde está el binario? En la capa de la imagen 
    
############################################################################################################
## QUE ES EL FILE SYSTEM DE UN CONTENEDOR... COMO SE MONTA ESE FILE SYSTEM A NIVEL DE CONTENEDOR?

El filesystem de los contenedores se monta mediante la superposicion de capas:

Cuando un proceso se ejecuta dentro del contenedor, ve la SUPERPOSICION DE TODAS ESTAS CAPAS:
    VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV
NUEVAS CAPAS AQUI ARRIBA
VOLUMENES 
    TAL CARPETA DEL HOST        Se monte dentro del FS del contenedor como TAL RUTA
    /datos    --->       /var/
                            apache/www

CAPA DE CONTENEDOR: 1                           MODIFICACIONES
                        /var            /etc
                            apache/          apache/httpd.conf
                                log/dia1.log

CAPA BASE: 0 < Imagen del contenedor: INALTERABLE
    /bin        /sbin   /var            /etc                    /opt        /tmp        /home
        rm                  apache/          apache/httpd.conf       apache/httpd
        ls                      
        touch
        mkdir
        sh
        bash
        fish
        zsh
        
        
Servidor nfs                        Computador X
/export/carpeta1    ----------->        /datos        