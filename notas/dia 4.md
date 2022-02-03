# Docker compose Sonarqube
Community
BBDD externa



# Nuestra webapp
--> Imagen
/app/mi-web-service.war

# Al crear el contenedor. 
Que pasa si montamos un volumen en /app?
Reemplazo la carpeta /app que venía en la imagen con la mia.... Este era nuestro objetivo? 
# Si lo es, guay!
# Esa no era mi objetivo... 
# El objetivo es que la persona pudiera ver el contenido de esa carpeta



FS Contenedor:
Capa Volumen                              /exportada
Capa 1:
Capa 0: Imagen
                        /app/archivo.war
                        ^ Lo puedan ver desde fuera: LO UNICO QUE PUEDO HACER ES MONTAR UN VOLUMEN
                        
Pero si monto un volumen... sobreescripo capa0... con el volumen


