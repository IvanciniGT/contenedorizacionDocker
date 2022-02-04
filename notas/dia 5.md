
HOST:

C1: Tomcat: IP1:8080 -> 8080
C2: Tomcat: IP2:8080 -> 8081
C3: Tomcat: IP3:8080 -> 8082
C4: Tomcat: IP4:8080 -> 8083
C5: Tomcat: IP5:8080 -> 8084

Puedo tenerlo? Cada uno tiene su IP... Perfecto

Contenedor1 que dentro tenga: IPContenedor
    Tomcat1:8080
    Tomcat2:8080
Esto lo vamos a hacer alguna vez en la vida? NO

Docker.... ContainerD... Podman (Pods manager)

Producción -> Kubernetes < Pod
    - Escalabilidad
    - Alta disponibilidad
    
4 clusters: 50 máquinas + Cloud IBM
App1 < Copias ?
App2
App3
App4
....




-SOA-
Servicios y Microservicios Web

Conocer el saldo de mi cuenta...?
    Telefono... IVC
    App telefono Android
    App Telefono Iphone
    Web
    Cajero
    Ventanilla.... sucursal... app Empleados
    
    1 programa que consulta saldo
    
    Sistemas: Compuesto por multitud de servicios



# Pod

Conjunto de contenedores, que:
    * Escalan 1 a 1
    * Se instalan en la misma maquina física
    * Pueden compartir volumenes
    - Comparten configuración de red


Maquinas:
    Maquina 1
        POD                                                         ElasticSearch C1
        Weblogic C1                                                 ElasticSearch C2    < Kibana
            access.log  > RAM (2 archivos en rotación de 50Kbs)     ElasticSearch C3
            app.log     > RAM                                       ElasticSearch C4
        FluentD/Filebeat C1                                         ElasticSearch C5
        
    Maquina 2
        POD
            Weblogic C2
                access.log
                app.log
            FluentD/Filebeat
        
    Maquina 3 < PUF
        POD
            Weblogic C3 NO RESPONDE
                access.log
                app.log
            FluentD/Filebeat
        
    Maquina 4
        POD < IP
            Weblogic C4
                access.log
                app.log
            FluentD/Filebeat C4 < localhost:7001
    
    Maquina 5 PUF
        POD < IP
            Weblogic C5
                access.log
                app.log
            FluentD/Filebeat
        
    Maquina 6
        Weblogic C5
            access.log
            app.log
        FluentD/Filebeat < Contenedor sidecar

Sistema externo de almacenamiento en red, con redundancia y tolerancia a fallos
    Cloud
    Cabina
    NFS/RAID

Log?



DOCKER. CASOS DE USO.
------------------------------------------------
Entornos de desarrollo. Instalar software
Generar imagenes de contenedor para su uso donde sea.
    -> Esas imágenes deben soportar la arquitectura de Kubernetes
Ejecución de comandos
    Playbook de ansible -> C Ansible-> Tiro a la basura
                           C Terraform 

-----


docker
    - Crear contenedores
    - Crear imagenes de contenedor Dockerfile
docker-compose
    - Crear contenedores < Podiamos solicitar la creación de una imagen Dockerfile

docker swarm < Intento por parte de Docker Inc. para tener una herramienta lista para entornos de prod.
                DESASTRE !!! La herramienta es kubernetes
                
----
INSTALACION DE ES

Maestro 1           Maestro 2               Maestro 3
 |                      |                       |
 ------------------------------------------------    Red privada de backend
 |          |           |                 |
Data1      Data2     Coordinador        Ingesta
                        |                 |
                        -------------------         Red de frontend
                                |
                              Nginx   - Proxy reverso
                                |
                                ------------------------------ Red pública

PC 
15 contenedores... todo es privado
1 contenedor nginx -> Exporto el puerto

 ---------------------------------------------  Red "física" 
 |  |                 |                  |   |
Maquina 1           Maquina 2           Maquina 3
 |  |-Master 1        |-Master 3         |   |
 |  |-Master 2        |-Data 2           Ingesta 1
 |  |-Data 1              
 |  |
 |-Coordinador 1
 
 
Limites de acceso a HW por parte de Docker / Kubernetes 
- CPU . Las configuro a nivel del contenedor... Tranquilamente
- Memoria . No es el contenedor.. es la app... proceso. Esto será una medida de extrema seguridad
 
Weblogic:  1 ejecucion con 32 Gbs de RAM y 8 CPUS
           2 ejecucion con 16 Gbs de RAM y 4 CPUS Ventajas: Escalado , H/A

Piezas controladas de Software/HW
    Levantar contenedores dentro de un kubernetes 16Gbs de RAM y 4 CPUs > Atender X peticiones/min
                                                    ^            ^
                                                    --------------
Si weblogic, quiere usar más CPU, docker / kubernetes no le deja... le cierra el grifo.. app va lenta
    VELOCIDAD ^
    
    CANTIDAD  V
Si weblogic, quiere coger más memoria? Tumba el contenedor y lo reinicia

Le dejo al contenedor 1.5 cpus

4 cpus: proceso puede usar 2
CPU 1 < 800 ms
CPU 2 < 700 ms
CPU 3
CPU 4

--cpus=2
--cpu-shares=1500 (milicores) 1.5 seg de uso de cpu / segundo: 75%


Maquina con 32 Gbs de RAM... Weblogic? 3 gbs SO 26.. 24 Problemas ....
Hard limit - 20 Gbs cruja.    SALVAVIDAS
Weblogic <<<<< 20 Gbs
    HEAD JVM < Weblogic 
    
Oracle Database : 8 Gbs de RAM
                Tiene en uso los 8 Gbs

---------------
HEAD JVM -Xms3000m -Xmx3000m
---------------
resources: Contenedor De tipo A
    limits:  CON DOCKER CONFIGURAMOS LIMITS a no ser que trabajemos con SWARM, cosa que no va a ocurrir
        cpus: 2.  Tranquilamente para controlar el comportamiento de mi app
        memory: 3 Gbs< Medida de seguridad extrema. El valor bueno, dentro del proceso
    reservations: (es lo que se garantiza al contenedor que va a tener disponible)
        cpus: 1
        memory: 3 Gbs<
        

Cluster la instalación de un contenedor de tipo A        
    Maquina 1. 4 cpus, 6 Gbs de ram - 3, 3 (se descuentas las reservas) - 2, 0
        A1X A1 A2
    Maquina 2. 2 Cpus, 6 Gbs ram
