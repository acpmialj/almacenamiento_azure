# Almacenamiento Azure
Ejemplos de códigos para acceder a almacenes de datos Azure

## SQL server + Apache Superset
Lo primero es crear la BD SQL tal como se indica en el guión, incorporando los datos de ejemplo.

La imagen de Superset del repositorio oficial no incluye controladores de acceso para la mayoría de las bases de datos que Superset acepta. Esto quiere decir que es necesario instalarlos. La mejor forma de hacerlo es creando una imagen de Superset a medida, basada en la oficial.

1. Se crea un Dockerfile para, basándose en la imagen oficial, instalar las dependencias: el paquete python "pymssql" con el controlador para acceder a SQL Server. 
2. De paso, se pueden realizar las operaciones recomendadas (sin incluir la carga de ejemplos): "superset fab...", "superset db upgrade" y "superset init"
3. Se crea la imagen con "docker build . -t ssuperset"
4. Con "docker run" se lanza un contenedor con la nueva versión de superset, "ssuperset"

Para probarlo, en Docker Hub está disponible la imagen "acpmialj/ipmd:ssuperset". Se ejecuta con 
```
docker run --rm -d -p 8080:8088 --name superset acpmialj/ipmd:ssuperset
```
Abrir en el navegador http://localhost:8080, acceder con "admin" "admin". 

4. Desde Superset, es necesario añadir una base de datos. En los tipos ofrecidos, elegir "Other".
5. Es necesario facilitar el "SQLAlchemy URI"
