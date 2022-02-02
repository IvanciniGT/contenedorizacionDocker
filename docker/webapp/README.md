https://github.com/IvanciniGT/automatizacionTesting.git

mi-web-service
                pom.xml < Archivo de configuracion de maven: Empaquetador de apps JAVA
                    Empaquetado se hace mediante un war.
                        -> Archivo con extensión "mi-web-service.war"
                                VV
                            Servidor de apps JAVA: Servidor web... pero más listo
                                                                    sabe ejecutar apps web java
                                                                        configurar BBDD...
                                Servidores apps JAVA: Weblogic, >>Tomcat<<, Websphere, Liberty, JBoss
                                                      ********              *********  *******
                                Imagen de Tomcat que ofrece la gente de bitnami: bitnami/tomcat
    Estando en la carpta de un proyecto java (donde haya un archivo pom.xml), podemos ejecutar un comando:
        mvn package -> Empaquetar un codigo fuente de un proyeto JAVA -> En nuestro caso .war
                        target/mi-web-service.war
        
        bitnami/tomcat < Esta imagen lleva tomcat...
            Pero... que otras herramientas necesito usar?
                git
                maven? Si no están... habrá que instalarlas
                java
                
Dockerfile multistage:
Es un fichero Dockerfile... que no genera 1 imagen de contenedor desde 1 contenedor....
                            Genera 1 imagen de conteendor desde muchos conteendores que se van creando para ir haciendo tareas concretas