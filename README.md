# Almacenamiento Azure
Ejemplos de códigos para acceder a almacenes de datos Azure

## SQL server + Apache Superset
Lo primero es crear la BD SQL tal como se indica en el guión, incorporando los datos de ejemplo.

La imagen de Superset del repositorio oficial no incluye controladores de acceso para la mayoría de las bases de datos que Superset acepta. Esto quiere decir que es necesario instalarlos. La mejor forma de hacerlo es creando una imagen de Superset a medida, basada en la oficial.

1. Se crea un Dockerfile para, baándose en la imagen oficial, instalar las dependencias. De paso, se pueden realizar las operaciones recomendadas (sin incluir la carga de ejemplos)
2. Se crea la imagen con "docker build . -t ssuperset"
3. Con "docker run" se lanza un contenedor con la nueva versión de superset, "ssuperset"

En Docker Hub está disponible "acpmialj/ipmd:ssuperset". Se ejecuta con 
```
docker run --rm -d -p 8080:8088 --name superset acpmialj/ipmd:ssuperset
```
Abrir en el navegador http://localhost:8080, acceder con "admin" "admin". 

