# Almacenamiento Azure
Ejemplos de códigos para acceder a almacenes de datos Azure

## Almacén de blobs
El notebook "**blobapi**" contiene un ejemplo de creación/borrado/uso de contenedores y blobs. 

## Bases de datos Azure SQL
El notebook "**sql**" contiene un ejemplo de consultas sobre una BD Microsoft SQL Azure, usando pyodbc. Requiere un controlador ODBC, que en Windows viene pre-instalado. 

## RETO: SQL server + Apache Superset
Lo primero es crear la BD SQL tal como se indica en el guión, incorporando los datos de ejemplo. Es la misma base de datos usada en el notebook "sql". 

La imagen de Superset del repositorio oficial (Docker Hub) no incluye controladores de acceso para la mayoría de las bases de datos que Superset acepta. Esto quiere decir que es necesario instalarlos. La mejor forma de hacerlo es creando una imagen de Superset a medida, basada en la oficial.

1. Se crea un **Dockerfile** para, sobre la imagen oficial, instalar las dependencias: el paquete python "**pymssql**" con el controlador para acceder a SQL Server. 
2. De paso, se pueden realizar las operaciones recomendadas (sin incluir la carga de ejemplos): "superset fab...", "superset db upgrade" y "superset init"
3. Se crea la imagen personalizada con "docker build . -t ssuperset"
4. Con "docker run" se lanza un contenedor con la nueva versión de superset, "ssuperset"

Para probarlo, en Docker Hub está disponible una imagen "acpmialj/ipmd:ssuperset" creada según los pasos indicados. Se ejecuta con 
```
docker run --rm -d -p 8080:8088 --name superset acpmialj/ipmd:ssuperset
```
Con el contenedor en marcha, se accede abriendo en el navegador http://localhost:8080. Acceder con "admin" "admin". 

Desde Superset, es necesario añadir la base de datos. En los tipos ofrecidos, elegir "Other", y el "**SQLAlchemy URI**", tal como se indica en [la documentación oficial de Superset](https://superset.apache.org/docs/databases/sql-server/). 
```
mssql+pymssql://<Username>:<Password>@<database server>/<Database Name>
```


