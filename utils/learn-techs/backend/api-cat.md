# API categories
## ¿Qué es una API?

**API** significa **Application Programming Interface** o **Interfaz de Programación de Aplicaciones**. Es un conjunto de definiciones y protocolos que permite que diferentes aplicaciones de software se comuniquen entre sí. Las APIs especifican cómo los componentes de software deben interactuar y permiten a los desarrolladores usar funciones de otro software, sin tener que escribir el código desde cero. Por ejemplo, una API de un servicio meteorológico puede permitir que tu aplicación obtenga datos del clima actual sin tener que recopilar la información por tu cuenta.
## API RESTful
[More info about REST](https://www.restapitutorial.com/)


### ¿Qué es una API REST?

**API REST** (Representational State Transfer) es un tipo específico de API que sigue principios y restricciones del estilo de arquitectura REST, que se basa en el protocolo HTTP. Las principales características de una API REST incluyen:

1. **Cliente-Servidor**: La arquitectura está dividida en cliente y servidor, lo que permite que ambos evolucionen de manera independiente.
2. **Sin Estado (Stateless)**: Cada solicitud del cliente al servidor debe contener toda la información necesaria para entender y procesar la solicitud. El servidor no almacena ninguna información sobre el estado del cliente entre solicitudes.
3. **Cacheable**: Las respuestas de una API REST pueden ser cacheadas por los clientes para mejorar el rendimiento.
4. **Interfaz Uniforme**: Las operaciones en los recursos (datos) se realizan utilizando un conjunto uniforme de métodos HTTP (GET, POST, PUT, DELETE, etc.).

### ¿Qué es una API RESTful?

**API RESTful** se refiere a una API que está diseñada y sigue los principios de REST. Es una forma de implementar una API REST de manera correcta y completa. Para que una API se considere RESTful, debe cumplir con las siguientes características:

1. **Uso de URIs para Recursos**: Los recursos deben ser identificables a través de URIs (Uniform Resource Identifiers).
2. **Métodos HTTP**: Debe utilizar métodos HTTP estándar para realizar operaciones con los recursos (por ejemplo, GET para obtener un recurso, POST para crear uno nuevo, PUT para actualizar uno existente, DELETE para eliminar uno).
3. **Intercambio de Representaciones**: Los recursos se representan y transfieren en un formato estándar, como JSON o XML.
4. **Stateless**: Las interacciones deben ser sin estado, es decir, cada solicitud debe ser independiente y contener toda la información necesaria para ser entendida y procesada por el servidor.

En resumen:
- **API**: Interfaz para que aplicaciones se comuniquen entre sí.
- **API REST**: Un tipo de API que sigue los principios de la arquitectura REST.
- **API RESTful**: Una API que implementa y sigue completamente los principios REST.

## Otros tipos de API

### 1. **SOAP (Simple Object Access Protocol)**
- **Descripción**: Es un protocolo basado en XML para intercambiar información en el contexto de servicios web.
- **Características**: Altamente estructurado, usa mensajes XML para las solicitudes y respuestas, puede utilizar múltiples protocolos de transporte, como HTTP, SMTP, TCP.
- **Ejemplo**: Servicios web de pago como PayPal a menudo usan SOAP para transacciones financieras.

### 2. **GraphQL**
- **Descripción**: Es un lenguaje de consulta para APIs que permite a los clientes solicitar exactamente los datos que necesitan.
- **Características**: Ofrece una mayor flexibilidad y eficiencia al permitir que los clientes especifiquen la estructura de la respuesta.
- **Ejemplo**: Facebook usa GraphQL para su API, permitiendo a los desarrolladores de aplicaciones solicitar únicamente los datos que necesitan.

### 3. **gRPC (gRPC Remote Procedure Call)**
- **Descripción**: Es un sistema de llamada a procedimiento remoto (RPC) desarrollado por Google que utiliza HTTP/2 para el transporte, Protobuf para la serialización de mensajes y ofrece características como autenticación, balanceo de carga y más.
- **Características**: Altamente eficiente y adecuado para comunicaciones entre microservicios.
- **Ejemplo**: Google Cloud Platform utiliza gRPC para la comunicación entre sus servicios.

### 4. **XML-RPC**
- **Descripción**: Es un protocolo de llamada a procedimiento remoto que utiliza XML para codificar sus llamadas y HTTP como protocolo de transporte.
- **Características**: Similar a SOAP pero más simple y menos extendido.
- **Ejemplo**: Algunos sistemas de blogs, como WordPress, usan XML-RPC para su API de gestión de contenido.

### 5. **CORBA (Common Object Request Broker Architecture)**
- **Descripción**: Es una especificación desarrollada por la OMG (Object Management Group) que permite a las piezas de software escritas en diferentes lenguajes y que se ejecutan en diferentes plataformas trabajar juntas.
- **Características**: Soporta múltiples lenguajes de programación, sistemas operativos y tipos de transporte.
- **Ejemplo**: Algunos sistemas de telecomunicaciones y financieros utilizan CORBA para la integración de sistemas heterogéneos.

### 6. **OData (Open Data Protocol)**
- **Descripción**: Es un protocolo desarrollado por Microsoft que permite crear y consumir APIs de manera simple y estandarizada.
- **Características**: Basado en tecnologías web como HTTP, AtomPub, y JSON, permite la consulta y manipulación de datos mediante URLs.
- **Ejemplo**: Microsoft Dynamics y SharePoint utilizan OData para sus APIs de datos.

### 7. **JSON-RPC**
- **Descripción**: Es un protocolo simple que usa JSON para codificar las llamadas a procedimientos remotos.
- **Características**: Ligero y fácil de usar, similar a XML-RPC pero usa JSON.
- **Ejemplo**: Se puede encontrar en aplicaciones de billetera de criptomonedas como Bitcoin Core.
