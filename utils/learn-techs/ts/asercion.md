# Enums y Aserciones

## Enums
En TypeScript, un enum (abreviatura de "enumeration") es una característica que permite definir un conjunto de nombres simbólicos para representar un conjunto de valores. Los enums son una forma de crear grupos de constantes con nombres significativos, lo que hace que el código sea más legible y fácil de mantener.
### Uso de Enums

Los enums se utilizan principalmente para representar un conjunto fijo de opciones, como los días de la semana, los estados de una aplicación, los roles de usuario, entre otros. Al utilizar enums, se mejora la legibilidad del código y se reduce la posibilidad de errores al reemplazar valores numéricos o de cadena "mágicos" con nombres significativos.

#### Tipos de Enums

En TypeScript, se pueden definir enums numéricos y enums de cadenas.

##### Enums Numéricos

Los enums numéricos asignan automáticamente valores numéricos a sus miembros, comenzando desde 0 por defecto. Se puede especificar un valor inicial para cambiar este comportamiento.

```typescript
enum Direction {
    Up,      // 0
    Down,    // 1
    Left,    // 2
    Right    // 3
}

console.log(Direction.Up);    // 0
console.log(Direction.Down);  // 1
console.log(Direction.Left);  // 2
console.log(Direction.Right); // 3

// Cambiar el valor inicial
enum CustomDirection {
    Up = 10,
    Down,    // 11
    Left,    // 12
    Right    // 13
}

console.log(CustomDirection.Up);    // 10
console.log(CustomDirection.Down);  // 11
console.log(CustomDirection.Left);  // 12
console.log(CustomDirection.Right); // 13
```

##### Enums de Cadenas

Los enums de cadenas asignan valores de cadena a sus miembros. A diferencia de los enums numéricos, cada miembro de un enum de cadenas debe ser inicializado con una cadena específica.

```typescript
enum Color {
    Red = "RED",
    Green = "GREEN",
    Blue = "BLUE"
}

console.log(Color.Red);   // "RED"
console.log(Color.Green); // "GREEN"
console.log(Color.Blue);  // "BLUE"
```

#### Acceso a Miembros de Enums

Puedes acceder a los miembros de un enum utilizando la notación de punto.

```typescript
enum Status {
    Active,
    Inactive,
    Pending
}

let currentStatus: Status = Status.Active;

if (currentStatus === Status.Active) {
    console.log("El estado actual es Activo");
}
```

Los enums en TypeScript también permiten el acceso inverso, es decir, puedes obtener el nombre del miembro a partir de su valor.

```typescript
enum Days {
    Sunday,
    Monday,
    Tuesday,
    Wednesday,
    Thursday,
    Friday,
    Saturday
}

let dayName: string = Days[0];
console.log(dayName); // "Sunday"
```

#### Enums Computados y Constantes

TypeScript permite la definición de enums que combinan miembros computados y constantes. Los miembros computados son aquellos cuyo valor se calcula en tiempo de compilación, mientras que los miembros constantes tienen valores definidos explícitamente.

```typescript
enum FileAccess {
    None,           // 0
    Read = 1 << 1,  // 2
    Write = 1 << 2, // 4
    ReadWrite = Read | Write, // 6
    G = "123".length // 3
}

console.log(FileAccess.None);      // 0
console.log(FileAccess.Read);      // 2
console.log(FileAccess.Write);     // 4
console.log(FileAccess.ReadWrite); // 6
console.log(FileAccess.G);         // 3
```

Los miembros computados y constantes se pueden mezclar en un enum. Sin embargo, hay ciertas restricciones:

1. Los miembros computados deben venir después de los miembros inicializados explícitamente.
2. Los miembros inicializados con una constante pueden ser referenciados en otros miembros computados.

```typescript
enum MixedEnum {
    A = 1,
    B,
    C = 2 * A
}

console.log(MixedEnum.A); // 1
console.log(MixedEnum.B); // 2
console.log(MixedEnum.C); // 2
```
### Compilación de Enums

#### Enums en JavaScript

Cuando se compilan enums en TypeScript, se generan objetos en JavaScript. Vamos a ver un ejemplo y su correspondiente compilación a JavaScript.

**TypeScript:**

```typescript
enum Direction {
    Up,
    Down,
    Left,
    Right
}
```

**JavaScript compilado:**

```javascript
"use strict";
var Direction;
(function (Direction) {
    Direction[Direction["Up"] = 0] = "Up";
    Direction[Direction["Down"] = 1] = "Down";
    Direction[Direction["Left"] = 2] = "Left";
    Direction[Direction["Right"] = 3] = "Right";
})(Direction || (Direction = {}));
```

En este código generado, `Direction` se convierte en un objeto con propiedades que mapean tanto el nombre del miembro como su valor.

#### `const` Enums

Los `const` enums permiten a TypeScript optimizar el código generado eliminando la definición del objeto enum y sustituyendo directamente los valores de los miembros en el código.

**TypeScript:**

```typescript
const enum Direction {
    Up,
    Down,
    Left,
    Right
}

let dir = Direction.Up;
```

**JavaScript compilado:**

```javascript
"use strict";
let dir = 0 /* Direction.Up */;
```

Aquí, el compilador sustituye directamente `Direction.Up` por su valor `0`, lo que resulta en un código más eficiente.

#### `const` Enums vs Enums

##### Indicar el Tipo

Una diferencia importante entre `const` enums y enums normales es cómo afectan al tipo de las variables y cómo se resuelven durante la compilación.

**TypeScript con enum normal:**

```typescript
enum Size {
    Small,
    Medium,
    Large
}

let mySize: Size = Size.Medium;
```

**JavaScript compilado:**

```javascript
"use strict";
var Size;
(function (Size) {
    Size[Size["Small"] = 0] = "Small";
    Size[Size["Medium"] = 1] = "Medium";
    Size[Size["Large"] = 2] = "Large";
})(Size || (Size = {}));

let mySize = Size.Medium;
```

En este caso, `Size` se convierte en un objeto en el código JavaScript, lo que permite que `mySize` se asigne como `Size.Medium`.

**TypeScript con `const` enum:**

```typescript
const enum Size {
    Small,
    Medium,
    Large
}

let mySize: Size = Size.Medium;
```

**JavaScript compilado:**

```javascript
"use strict";
let mySize = 1 /* Size.Medium */;
```

Con `const` enum, el compilador reemplaza directamente `Size.Medium` con su valor `1`.

##### Enums para "Consumo Externo"

Cuando un enum va a ser utilizado fuera del módulo o la librería donde se define, es mejor utilizar enums normales en lugar de `const` enums. Esto es porque los `const` enums no generan código JavaScript, y por lo tanto, los consumidores del módulo no tendrían acceso a los nombres de los miembros del enum.

**Ejemplo de enum normal para consumo externo:**

```typescript
// library.ts
export enum Status {
    Success,
    Failure,
    Pending
}

// consumer.ts
import { Status } from './library';

console.log(Status.Success);  // Output: 0
```

**JavaScript compilado de library.ts:**

```javascript
"use strict";
exports.__esModule = true;
exports.Status = void 0;
var Status;
(function (Status) {
    Status[Status["Success"] = 0] = "Success";
    Status[Status["Failure"] = 1] = "Failure";
    Status[Status["Pending"] = 2] = "Pending";
})(Status = exports.Status || (exports.Status = {}));
```

En este caso, `Status` es accesible en `consumer.ts` con todos sus miembros.

**Ejemplo de `const` enum (no recomendado para consumo externo):**

```typescript
// library.ts
export const enum Status {
    Success,
    Failure,
    Pending
}

// consumer.ts
import { Status } from './library';

console.log(Status.Success);  // Error: no se puede encontrar el nombre 'Status'.
```

**JavaScript compilado de library.ts:**

```javascript
"use strict";
exports.__esModule = true;
exports.Status = void 0;
// Los const enums no generan código JavaScript
```

Como `const` enum no genera código JavaScript, los consumidores no pueden acceder a `Status`.

##### Diferencias Productivas

1. **Tamaño del código**:
    - **Enums normales**: Generan objetos en el código JavaScript, lo que aumenta el tamaño del archivo generado.
    - **`const` enums**: Sustituyen directamente los valores de los miembros en el código, lo que reduce el tamaño del archivo generado.

2. **Accesibilidad**:
    - **Enums normales**: Son accesibles externamente y se pueden exportar/importar entre módulos.
    - **`const` enums**: No generan objetos en JavaScript, por lo que no son accesibles externamente. Son ideales para uso interno donde se requiere optimización del tamaño del código.

3. **Legibilidad del código**:
    - **Enums normales**: Mantienen la legibilidad en el código JavaScript generado, ya que los nombres de los miembros se conservan.
    - **`const` enums**: Mejoran la eficiencia del código, pero pueden afectar la legibilidad del código generado al sustituir directamente los valores de los miembros.

## Aserciones de tipos

### Aserción simple

#### ¿Por qué es necesario?

Las aserciones de tipo en TypeScript son necesarias cuando el compilador no puede inferir correctamente el tipo de una variable. Esto suele ocurrir cuando se trabaja con APIs del DOM, datos dinámicos o bibliotecas externas. Las aserciones ayudan a evitar errores de compilación y permiten acceder a propiedades y métodos específicos del tipo esperado, asegurando que el código se comporte como se desea.

#### Ejemplo simple

##### Sin aserción

En este ejemplo, obtenemos un elemento del DOM usando `querySelector`. Sin una aserción, el compilador no puede determinar si el elemento es un `HTMLInputElement`, y por lo tanto no permite acceder a propiedades específicas de `HTMLInputElement`.

```typescript
const inputElement = document.querySelector("input");

// null si no lo encuentra
// Element si lo encuentra

if (inputElement !== null) {
    const value = inputElement.value; //❌ -> Error: La propiedad 'value' no existe en el tipo 'Element'.
}
```

##### Con aserción

Utilizando una aserción de tipo, podemos indicar al compilador que `inputElement` es un `HTMLInputElement`, lo que permite acceder a sus propiedades específicas.

```typescript
const inputElement = document.querySelector("input") as HTMLInputElement;

if (inputElement !== null) {
    const value = inputElement.value;
}
```

En este caso, `as HTMLInputElement` le dice al compilador que trate `inputElement` como un `HTMLInputElement`.

##### Inconvenientes de la aserción

Aunque las aserciones de tipo pueden ser útiles, también pueden introducir problemas si se utilizan incorrectamente. En el ejemplo anterior, si `querySelector` no encuentra un elemento `input`, `inputElement` será `null` y la aserción aún tratará de acceder a `inputElement.value`, lo que puede resultar en un error en tiempo de ejecución. Esto nos lleva a la necesidad de comprobaciones condicionales adecuadas.

#### Comprobación "condicional"

Las aserciones de tipo no deben reemplazar las comprobaciones condicionales cuando existe la posibilidad de que el valor sea `null` o de un tipo diferente. Es importante combinar aserciones de tipo con comprobaciones adecuadas para garantizar la seguridad del tipo en tiempo de ejecución.

##### Ejemplo de comprobación condicional con aserción

```typescript
const inputElement = document.querySelector("input");

if (inputElement) {
    const inputElementAsInput = inputElement as HTMLInputElement;
    const value = inputElementAsInput.value;
} else {
    console.error("El elemento no es un input.");
}
```

En este ejemplo, comprobamos si `inputElement` no es `null` antes de realizar la aserción de tipo. Esta verificación asegura que solo accedemos a propiedades específicas de `HTMLInputElement` cuando `inputElement` es efectivamente de ese tipo, evitando errores en tiempo de ejecución. Sin embargo, hacer la aserción dentro del `if` no es la mejor práctica ya que puede llevar a errores si no se hace correctamente. Esto nos introduce al siguiente tema, donde exploraremos una manera más segura y clara de hacer estas comprobaciones.

### `instanceof`

#### ¿Qué es y por qué es necesario?

El operador `instanceof` en JavaScript y TypeScript se utiliza para verificar si un objeto es una instancia de una clase o de una función constructora. Esto es importante en TypeScript porque nos permite realizar comprobaciones de tipo en tiempo de ejecución, lo que puede ser crucial para garantizar que nuestros programas funcionen correctamente y evitar errores.

#### Inferencia con TypeScript

TypeScript es capaz de inferir automáticamente el tipo de una variable después de usar `instanceof`. Esto significa que, tras una comprobación con `instanceof`, TypeScript "sabe" el tipo del objeto dentro del bloque de código correspondiente, lo que nos permite usar las propiedades y métodos de ese tipo de manera segura.

#### Ejemplo simple

##### Explicación

Supongamos que tenemos una función que recibe un argumento que puede ser un `Date` o un `Error`. Queremos tratar estos tipos de manera diferente basándonos en su tipo.

```typescript
function handleInput(input: Date | Error) {
    if (input instanceof Date) {
        console.log("It's a Date:", input.toISOString());
    } else if (input instanceof Error) {
        console.log("It's an Error:", input.message);
    }
}

const myDate = new Date();
const myError = new Error("Something went wrong");

handleInput(myDate); // It's a Date: 2024-06-28T12:34:56.789Z
handleInput(myError); // It's an Error: Something went wrong
```

En este ejemplo, `instanceof` se utiliza para verificar si `input` es una instancia de `Date` o `Error`. Dependiendo del resultado, TypeScript permite el acceso seguro a los métodos y propiedades correspondientes a cada tipo.

#### `instanceof` vs `typeof`

##### `typeof` -> para tipos primitivos

El operador `typeof` se utiliza para verificar el tipo de datos primitivos en JavaScript y TypeScript. Estos tipos incluyen `string`, `boolean`, `number`, `undefined`, `object`, `function`, y `symbol`.

```typescript
let value = "Hello";
if (typeof value === "string") {
    console.log("It's a string");
} else if (typeof value === "number") {
    console.log("It's a number");
}
```

##### `instanceof` -> para instancias

El operador `instanceof` se utiliza para verificar si un objeto es una instancia de una clase o función constructora. Esto es útil para tipos de datos complejos como instancias de clases y objetos específicos.

```typescript
let date = new Date();
if (date instanceof Date) {
    console.log("It's a Date instance");
}
```

En resumen:

- `typeof` es adecuado para verificar tipos primitivos como `string`, `number`, `boolean`, etc.
- `instanceof` es adecuado para verificar instancias de clases o funciones constructoras, como `Date`, `Array`, `Error`, y clases personalizadas.

Estos operadores son complementarios y se utilizan en diferentes escenarios para realizar comprobaciones de tipos en TypeScript y JavaScript.

## Aserciones de fetch
Entendido, aquí tienes una versión adaptada del ejemplo anterior utilizando TypeScript sin la definición de tipo en un archivo `.d.ts`:

## Aserciones de fetch

### ¿Qué son y por qué usarlas?

Las aserciones de tipos en el contexto de `fetch` son técnicas utilizadas para asegurar que los datos recuperados a través de una solicitud `fetch` cumplan con el formato y tipo esperado. Esto es esencial en TypeScript para garantizar la coherencia de los datos recibidos, especialmente cuando se interactúa con API externas.

Cuando realizamos una solicitud `fetch` en TypeScript, generalmente seguimos estos pasos:

1. **Realizar la solicitud:** Usamos `fetch` para hacer una solicitud HTTP a una API externa.
   
2. **Verificar la respuesta:** Comprobamos si la respuesta de la solicitud fue exitosa (`response.ok`).
   
3. **Parsear la respuesta:** Convertimos la respuesta en el formato deseado (`JSON`, `text`, etc.).
   
4. **Asegurar el tipo de datos:** Utilizamos aserciones de tipo (`as Tipo`) para especificar cómo debe interpretarse la respuesta.

#### Ejemplo práctico simple

Supongamos que estamos obteniendo datos de una API que devuelve objetos con una estructura específica. En nuestro código principal, definimos manualmente el tipo esperado de los datos recibidos:

```typescript
interface Post {
    userId: number;
    id: number;
    title: string;
    body: string;
}

async function fetchPosts(): Promise<Post[]> {
    const response = await fetch('https://jsonplaceholder.typicode.com/posts');
    if (!response.ok) {
        throw new Error(`¡Error HTTP! Estado: ${response.status}`);
    }
    
    const posts = await response.json() as Post[];
    return posts;
}

fetchPosts().then(posts => {
    console.log(posts);
}).catch(error => {
    console.error('Error al obtener los posts:', error);
});
```

En este ejemplo:

- `Post` es una interfaz que describe la estructura de cada objeto devuelto por la API.
  
- Usamos `as Post[]` después de `response.json()` para indicar a TypeScript que interprete los datos como un array de objetos de tipo `Post`.
  
- Esto asegura que cualquier manipulación o acceso a `posts` esté tipado adecuadamente según nuestra definición.

#### Importancia de las aserciones de tipos

Las aserciones de tipos en `fetch` son cruciales porque:

- **Seguridad y precisión:** Garantizan que los datos manipulados en la aplicación estén estructurados correctamente, evitando errores de tipo durante la ejecución.
  
- **Documentación y mantenimiento:** Facilitan la comprensión del código al documentar explícitamente las expectativas sobre los datos recibidos de una API.
  
- **Facilitan el desarrollo:** Ayudan a los desarrolladores a trabajar con datos complejos de manera más segura y eficiente, reduciendo el riesgo de errores.

### Introducción practica
Vamos a trabajar un ejemplo practico usando la api de github, cojiendo el repositorio de JS por ejemplo: `const API_URL = "https://api.github.com/search/repositories?q=javascript"`
#### .mts
Al tratar de hacer el fetch(), nos aparece un error de ts.

    'await' expressions are only allowed at the top level of a file when that file is a module, but this file has no imports or exports. Consider adding an empty 'export {}' to make this file a module.ts(1375)
    ⚠ Error (TS1375)  | 
    expressions are only allowed at the top level of a file when that file is a module, but this file has no imports or exports. Consider adding an empty 
    to make this file a module.

Este error nos indica que necesita ser un modulo para usar expresiones `await` "en el nivel superior de un modulo".
Para transformarlo a modulo podemos usar la extensión `.mts`.
El archivo `.ts` de "forma nativa" no podemos usar import y export (_igual que con node.js y ´.js´_). 
    Hay que tener en cuenta que la mayoría de empaquetadores (Vite, etc...) te permiten usar módulos en `.ts` de forma nativa

```typescript
// Error con .ts de "forma nativa"
const API_URL = "https://api.github.com/search/repositories?q=javascript"
const res = await fetch(API_URL) //❌ await
```
#### Ejemplo 
##### Ejemplo sin tipar

```typescript
// Aserción de fetch
const API_URL = "https://api.github.com/search/repositories?q=javascript"
const res = await fetch(API_URL)

if(!res.ok)throw new Error("Error en la petición")
const data = await res.json()
const repos = data.items.map(repo => console.log(repo))
```

En este punto sabe que `res:Response`, pero no es capaz de inferir en la respuesta, podríamos tratar de tipas diciendo genéricamente que va a devolver, pero esto no acabara de tipar correctamente.

```typescript
type APIResponse = {
    items: object[]
}
const API_URL = "https://api.github.com/search/repositories?q=javascript"
const res = await fetch(API_URL)

if(!res.ok)throw new Error("Error en la petición")
const data = await res.json() as APIResponse
const repos = data.items.map(repo => console.log(repo))
```

Con esto, no se queja, pero realmente no estamos tipando, simplemente "_se fia de nosotros_".
#### Quicktype intro
Para esto tenemos herramientas como [QuickType](https://quicktype.io/), que nos tipara las respuestas de api's "externas" de forma sencilla, facilitándole la respuesta de la petición de dicha api.
En el `name` le indicamos el nombre que querremos que tenga nuestro tipado principal.

- Ver su uso en [asercion.mts](/utils/learn-techs/ts/asercion.mts)

Entendido, vamos a profundizar en estas secciones:

### Quicktype

#### Introducción a Quicktype

Quicktype es una herramienta y biblioteca que permite generar definiciones de tipos en TypeScript (y otros lenguajes) a partir de datos JSON. Su principal objetivo es automatizar el proceso de definir tipos de datos complejos, como aquellos que se obtienen de APIs RESTful o archivos JSON, convirtiéndolos en interfaces TypeScript o tipos directamente utilizable en el código.

**¿Por qué utilizar Quicktype?**

- **Ahorro de tiempo:** Elimina la tarea manual de escribir definiciones de tipos complejas para datos JSON, que puede ser propensa a errores y consumir mucho tiempo.
  
- **Precisión:** Genera tipos TypeScript directamente a partir de datos reales, asegurando que los tipos reflejen con precisión la estructura y propiedades de los datos.
  
- **Mantenimiento simplificado:** Facilita la actualización y mantenimiento de tipos a medida que evolucionan los esquemas de datos, ya que Quicktype puede regenerar automáticamente las definiciones de tipos basándose en los nuevos datos de entrada.

#### Compilación

Cuando hablamos de la compilación de TypeScript a JavaScript, la mayoría de las construcciones de TypeScript se eliminan durante la transpilación a JavaScript. Sin embargo, las constantes enumeradas (`const enums`) son una excepción a esta regla, ya que también se eliminan en tiempo de compilación, similar a los enums regulares.

#### TypeScript vs TypeScript Zod

##### TypeScript Zod

TypeScript Zod es una biblioteca que proporciona una forma sencilla y declarativa de definir y validar esquemas de datos en TypeScript. Utiliza un enfoque basado en esquemas para definir tipos de datos complejos y validarlos en tiempo de ejecución.

**Características y ventajas:**

- **Declarativo:** Permite definir estructuras de datos complejas de manera clara y concisa utilizando una API declarativa.
  
- **Validación en tiempo de ejecución:** A diferencia de TypeScript estándar, que se enfoca en la validación y tipado estático en tiempo de compilación, Zod ofrece validación en tiempo de ejecución para garantizar que los datos cumplan con las expectativas del esquema definido.
  
- **Interoperabilidad:** Puede integrarse fácilmente en aplicaciones TypeScript existentes, proporcionando una capa adicional de seguridad y consistencia en la manipulación de datos.

##### Impacto en la compilación a JavaScript

Cuando se utiliza TypeScript Zod, las validaciones y definiciones de esquemas se mantienen en TypeScript y no se traducen directamente a JavaScript durante la transpilación. Esto significa que la lógica de validación y tipado en tiempo de ejecución no afecta la compilación a JavaScript, ya que TypeScript Zod está diseñado para funcionar principalmente en el entorno TypeScript, proporcionando beneficios de seguridad y validación sin sacrificar la compatibilidad con JavaScript estándar.

**Beneficios de usar validaciones TypeScript Zod:**

- **Seguridad de datos:** Asegura que los datos manipulados en la aplicación cumplan con las reglas de validación definidas, reduciendo errores en tiempo de ejecución.
  
- **Mantenimiento simplificado:** Facilita la evolución y el mantenimiento del código al centralizar la definición de esquemas y validaciones en un único lugar, mejorando la consistencia y la claridad del código.
  
- **Mejora la robustez:** Proporciona una capa adicional de defensa contra datos malformados o inesperados, mejorando la robustez y la fiabilidad de la aplicación.

