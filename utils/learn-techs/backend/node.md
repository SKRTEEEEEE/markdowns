##Versiones

`Versions` de los paquetes npm en la sección de dependencias de su archivo package.json siguen lo que se llama Control de versiones semántico (SemVer), un estándar de la industria para el control de versiones de software que tiene como objetivo facilitar la gestión de dependencias. Las bibliotecas, marcos u otras herramientas publicadas en npm deben usar SemVer para comunicar claramente qué tipo de cambios pueden esperar los proyectos si se actualizan.

Conocer SemVer puede resultar útil cuando desarrollas software que utiliza dependencias externas (lo que casi siempre haces). Un día, su comprensión de estos números le evitará introducir accidentalmente cambios importantes en su proyecto sin comprender por qué las cosas que funcionaron ayer de repente no funcionan hoy. Así funciona el Versionado Semántico según el sitio web oficial:
```json
"package": "MAJOR.MINOR.PATCH"
```

La versión PRINCIPAL debería incrementarse cuando realiza cambios de API incompatibles. La versión MENOR debería incrementarse cuando agrega funcionalidad de manera compatible con versiones anteriores. La versión de PATCH debería incrementarse cuando realice correcciones de errores compatibles con versiones anteriores. Esto significa que los PATCH son correcciones de errores y los MINOR agregan nuevas funciones, pero ninguno de ellos rompe lo que funcionaba antes. Finalmente, los MAJOR agregan cambios que no funcionarán con versiones anteriores.

En el último desafío, le dijiste a npm que solo incluyera una versión específica de un paquete. Esa es una forma útil de congelar sus dependencias si necesita asegurarse de que las diferentes partes de su proyecto sigan siendo compatibles entre sí. Pero en la mayoría de los casos de uso, no querrás perderte las correcciones de errores, ya que a menudo incluyen parches de seguridad importantes y (con suerte) no estropean nada al hacerlo.

Para permitir que una dependencia de npm se actualice a la última versión de PATCH, puede anteponer la versión de la dependencia con el ~carácter de tilde (). A continuación se muestra un ejemplo de cómo permitir actualizaciones de cualquier `1.3.x`versión.

```json
"package": "~1.3.8"
```

