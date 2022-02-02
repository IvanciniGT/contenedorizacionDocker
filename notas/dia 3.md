Tras crearnos el contenedor de fedora: INSTALAR UNA APP NUESTRA con nuestra configuracion
1 - Instalar nginx
2 - Instalar git
3 - Descargar un repo con una web
4 - Copiar la web a la carpeta de nginx

-> Exportar / Convertir ese contenedor en una imagen de contenedor
$ docker commit # Nos generaba una imagen que luego modificamos poniendole un nombre de repo y tag
$ docker tag <ID> repo:tag

-> Para distribuirla teniamos 2 opciones:
- Subirla a un repo de imagenes de contenedor tipo docker-hub: 
    docker push
- Exportarla como .tar
    docker image save <<<
    - Posteriormente ese tar lo mandamos a laguien que debe hacer un $ docker image import

CONCLUSION A LA QUE LLEGAMOS DE ESTO.... RUINA !!!! No lo hacemos ni de coña. NOS OLVIDAMOS DE ESTO

Este es un procedimiento manual... querriamos automatizarlo. Eso lo podríamos hacer con el comando:
$ docker build

Docker build trabaja desde unos ficheros propios de docker denominados: Dockerfile







docker RUN:
 docker image pull IMAGEN
 docker container create IMAGEN
 docker start CONTENEDOR
 docker attach CONTENEDOR < La terminal quedaría bloqueada a la espera de que el contenedor acabe
                            y en esa terminal se iria mostrando el log del contenedor
                            El attach lo podemos evitar con el parametro -d --detach
                            
                            
                            




Movimiento en pro de la automatización: DEVOPS
    
                JENKINS
desarrollador -> gitlab -> Auto. pase pruebas y si todo ok -> pase prod (20 minutos) sin intervención humana

Alquien que sepa mucho de Weblogic... y sea capaz de automatizar el trabajo de instalación:
Dar instrucciones a un Kubernetes de como hacer todo eso:
    Montar imagenes de contenedor: DOCKERFILE
        Weblogic configurado
        Conectar mi app Con mi BBDD

Kubernetes:
    Arrancar un weblogic
    Instalar un weblogic nuevo y meterlo en un dominio
    Montar un cluster dentro del weblogicNi sube una app al weblogic
    Ni crea una BBDD dentro del weblogic
