# Almacenamiento Azure
Ejemplos de códigos para acceder a almacenes de datos Azure.
En el portal, crear una storage account standard. Elegir 

1. Grupo de recursos (o crear uno nuevo, **ipmdrg**)
2. Nombre de la cuenta, **ipmdsa**
3. Región **West Europe**
4. Rendimiento **Standard**
5. Redundancia **LRS**

Al crear la cuenta También podemos habilitar el espacio de nombres jerárquico, lo que hará que nuestro almacén de blobs se comporte como un **Data Lake**. 

## Almacén de blobs
En el panel principal, donde pone **Blob service**, habilitar el acceso anónimo a blobs. Esto permitirá descargar blobs usando URLs. 

En el menú de la izquierda seleccionar **Data storage** --> **Containers**. Desde allí, añadimos un contenedor con **+ Container**. Lo llamamos **ipmdcontainer**. Seleccionar acceso anónimo a cada blob de forma individual. Hecho esto, se puede usar el portal para subir ficheros como blobs. 

El notebook "**blobapi**" contiene un ejemplo de creación/borrado/uso de contenedores y blobs. 

## Carpetas compartidas
En el menú de la izquierda seleccionar **Data storage** --> **File shares**. Crear una carpeta compartida (**+ File share**) con nombre **ipmdfs**. **IMPORTANTE: en la sección Backup, deshabilitar la casilla "Enable backup"**.

Una vez creado el recurso, podemos pulsar **Connect** y ver scripts de conexión para diferentes sistemas operativos. Si tenemos Windows 11, del script PowerShell podemos extraer estos datos:
```
Carpeta compartida: \\ipmdsa.file.core.windows.net\ipmdfs
Usuario: localhost\ipmdsa
Contraseña: Ppxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx==
```
Para su uso en otros entornos necesitaremos el nombre de cuenta de acceso ("ipmdsa", sin "\adm") y la contraseña. 

Es habitual que el acceso SMB esté limitado por el cortafuegos corporativo. Sin embargo, funcionará a través de una VPN. 

## Bases de datos Azure SQL
El notebook "**sql**" contiene un ejemplo de consultas sobre una BD Microsoft SQL Azure, usando pyodbc. Requiere un controlador ODBC, que en Windows viene pre-instalado. 

## RETO: SQL server + Apache Superset
Lo primero es crear la BD SQL tal como se indica en el guión, con autenticación mediante nombre de usuario / contraseña, e incorporando los datos de ejemplo. Es la misma base de datos usada en el notebook "sql". 

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
Por ejemplo:
```
mssql+pymssql://ipmdadmin:xxxxxx@ipmdsqlserver.database.windows.net/ipmdsql
```
Hecha la conexión a la base de datos, se pueden realizar consultas SQL como, por ejemplo:
```
SELECT TOP 20 pc.Name as CategoryName, p.name as ProductName
FROM SalesLT.ProductCategory pc
JOIN SalesLT.Product p ON pc.productcategoryid = p.productcategoryid
```
Se puede guardar la consulta y representarla como una tabla. 
