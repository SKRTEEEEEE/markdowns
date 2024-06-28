# Funciones y objetos
## Tipado y inferencia en funciones
### Tipos para Funciones

En TypeScript, definir tipos para las funciones es crucial para mejorar la claridad y robustez del código, permitiendo al compilador detectar posibles errores antes de que el código se ejecute. A continuación, exploramos algunos de los tipos más comunes que se utilizan en el contexto de funciones.

#### `void`

El tipo `void` se utiliza cuando una función no devuelve un valor significativo. Sin embargo, es importante señalar que, aunque una función con tipo `void` no debería devolver valores útiles, puede devolver `undefined`. De hecho, técnicamente puede tener una declaración de retorno, pero el valor retornado será ignorado por los consumidores de la función. Este tipo es útil para funciones cuyo propósito es realizar una acción sin proporcionar una salida concreta.

```typescript
function logMessage(message: string): void {
    console.log(message);
    return; // Devolver un valor aquí no produce un error, pero el valor es ignorado.
}

logMessage("Hello, TypeScript!"); // Salida: Hello, TypeScript!
```

En el ejemplo anterior, aunque la función `logMessage` realiza una acción (imprimir un mensaje) y tiene una declaración de retorno, no devuelve ningún valor significativo, lo que la hace un buen candidato para el tipo `void`.

```typescript
function logMessage(message: string): void {
    console.log(message);
    return 3; // Aunque esto no produce un error, el valor '3' es ignorado.
}

logMessage("Hello, TypeScript!"); // Salida: Hello, TypeScript!
```

En este ejemplo, `logMessage` devuelve un valor numérico, pero el compilador de TypeScript ignora el valor retornado porque el tipo de retorno es `void`.

#### `never`

El tipo `never` indica que una función no retorna un valor porque lanza una excepción o entra en un bucle infinito. Es útil para funciones que terminan de manera abrupta o que no pueden terminar normalmente.

```typescript
function throwError(errorMsg: string): never {
    throw new Error(errorMsg);
}

// La siguiente función nunca termina:
function infiniteLoop(): never {
    while (true) {
        console.log("Looping forever...");
    }
}
```

En estos ejemplos, `throwError` lanza una excepción y `infiniteLoop` entra en un bucle infinito, ambos escenarios donde la función nunca retorna un valor.

#### `unknown`

El tipo `unknown` es una opción más segura que `any` cuando el tipo de retorno es desconocido. Antes de usar el valor, debes verificar su tipo, lo que proporciona una mayor seguridad y prevención de errores en tiempo de ejecución.

```typescript
function fetchData(): unknown {
    return fetch("https://api.example.com/data");
}

let data: unknown = fetchData();
if (typeof data === "string") {
    console.log(data.toUpperCase()); // Seguro de usar como string
}
```

En este ejemplo, `fetchData` devuelve un tipo `unknown`. Antes de manipular `data`, verificamos su tipo para asegurarnos de que es seguro usarlo como una cadena.



### Inferencia en el Retorno de Funciones

La inferencia de tipos en el retorno de funciones es una característica poderosa de TypeScript que permite al compilador deducir automáticamente el tipo de valor que una función devolverá, basándose en su implementación. Esto puede simplificar el código al reducir la necesidad de especificar explícitamente los tipos de retorno.

#### ¿Cómo Funciona la Inferencia de Retorno?

Cuando se define una función en TypeScript, el compilador analiza el cuerpo de la función para determinar el tipo de valor que se devolverá. Basándose en las operaciones realizadas y los valores retornados, TypeScript infiere el tipo de retorno.

#### Ejemplo Básico de Inferencia de Retorno

Consideremos la siguiente función que suma dos números:

```typescript
function add(a: number, b: number) {
    return a + b; // TypeScript infiere que el tipo de retorno es number
}

let result = add(10, 5);
console.log(result); // Salida: 15
```

En este ejemplo, aunque no se especifica explícitamente el tipo de retorno, TypeScript infiere que la función `add` devuelve un valor de tipo `number` porque la operación de suma devuelve un número.

#### Inferencia en Funciones con Condicionales

La inferencia de tipos también funciona en funciones con declaraciones condicionales. TypeScript infiere el tipo de retorno en función de todas las posibles ramas de ejecución.

```typescript
function getResult(condition: boolean) {
    if (condition) {
        return "Success";
    } else {
        return 0;
    }
}

let result = getResult(true); // result será de tipo string | number
console.log(result); // Salida: Success
```

En este caso, TypeScript infiere que el tipo de retorno de `getResult` es `string | number` porque la función puede devolver un `string` o un `number` dependiendo de la condición.

#### Inferencia en Funciones de Flecha

Las funciones de flecha también se benefician de la inferencia de tipos. Aquí hay un ejemplo:

```typescript
const multiply = (x: number, y: number) => x * y; // TypeScript infiere que el tipo de retorno es number

let product = multiply(4, 5);
console.log(product); // Salida: 20
```

TypeScript infiere que la función `multiply` devuelve un `number` porque la operación de multiplicación produce un valor numérico.

#### Inferencia en Funciones Asíncronas

Para funciones asíncronas, TypeScript infiere que el tipo de retorno es `Promise<T>`, donde `T` es el tipo del valor que se devuelve dentro del `async` function.

```typescript
async function fetchData() {
    let response = await fetch("https://api.example.com/data");
    let data = await response.json();
    return data; // TypeScript infiere que el tipo de retorno es Promise<any>
}

fetchData().then(data => {
    console.log(data);
});
```

En este ejemplo, TypeScript infiere que `fetchData` devuelve una `Promise` porque la función utiliza `async` y `await`.

### Especificar Tipos de Retorno Explícitamente

Aunque la inferencia de tipos es útil, en algunos casos es recomendable especificar los tipos de retorno explícitamente para mejorar la claridad y el mantenimiento del código. Aquí hay un ejemplo:

```typescript
function divide(a: number, b: number): number {
    if (b === 0) {
        throw new Error("División por cero");
    }
    return a / b;
}

let quotient = divide(10, 2);
console.log(quotient); // Salida: 5
```

En este caso, especificar el tipo de retorno como `number` deja claro que la función `divide` siempre debe devolver un número, proporcionando una documentación implícita y asegurando que cualquier cambio futuro mantenga este contrato.


#### Tipado de Arrow Functions

Las **Arrow Functions** en TypeScript permiten definir funciones de manera más concisa y con una sintaxis simplificada. A continuación, se muestra cómo se realiza el tipado para las Arrow Functions:

##### Ejemplo 1

```typescript
const sumar = (a: number, b: number): number => {
    return a + b;
}
```

En este caso:

- `const sumar` define una función llamada `sumar`.
- `(a: number, b: number): number` especifica los tipos de los parámetros `a` y `b`, y el tipo de retorno de la función es `number`.

##### Ejemplo 2

```typescript
const restar: (a: number, b: number) => number = (a, b) => {
    return a - b;
}
```

En este ejemplo:

- `const restar: (a: number, b: number) => number` es una forma alternativa de declarar la Arrow Function `restar`. Aquí se especifica explícitamente que `restar` es una función que toma dos parámetros `a` y `b` de tipo `number`, y devuelve un valor de tipo `number`.
- `(a, b) => { return a - b; }` define la implementación de la función `restar`, donde `a` y `b` son parámetros de tipo `number`, y la función devuelve la resta de `a` y `b`.

### Tipado de Funciones "Callback"

Las funciones "callback" son una parte fundamental de la programación en JavaScript y TypeScript, especialmente en el manejo de operaciones asíncronas y eventos. En TypeScript, es crucial especificar correctamente los tipos para las funciones "callback" para garantizar la robustez y la claridad del código.

#### ¿Qué es una Función "Callback"?

Una función "callback" es una función que se pasa como argumento a otra función y se ejecuta después de que esa función termine su tarea. Estas funciones son esenciales para manejar eventos, ejecutar código después de operaciones asíncronas y mejorar la modularidad del código.

#### Ejemplo Básico de Función "Callback"

Consideremos una función `sayHiFromFunction` que acepta una función "callback" como argumento y la invoca:

```typescript
const sayHiFromFunction = (callback) => {
    callback("Miguel");
}

sayHiFromFunction((name) => {
    console.log(`Hola ${name}`);
});
```

En este ejemplo, `sayHiFromFunction` es una función que toma una función "callback" como `callback`. Luego, invoca `callback` con el argumento `"Miguel"`. La función "callback" que se proporciona simplemente imprime un saludo utilizando el nombre recibido como argumento.

#### Tipos para Funciones "Callback"

Es esencial especificar los tipos para las funciones "callback" tanto para los parámetros de entrada como para los tipos de retorno. Esto permite al compilador de TypeScript realizar verificaciones estáticas de tipo y evitar errores de tipo en tiempo de ejecución.

```typescript
// Función que acepta una función callback que recibe un string
function greet(callback: (name: string) => void) {
    callback("Alice");
}

// Función callback que imprime un saludo
greet((name) => {
    console.log(`Hola, ${name}!`);
});

// Función que acepta una función callback que devuelve un número
function sumNumbers(numbers: number[], callback: (result: number) => void) {
    let sum = numbers.reduce((acc, curr) => acc + curr, 0);
    callback(sum);
}

// Función callback que muestra el resultado de la suma
let numbers = [1, 2, 3, 4, 5];
sumNumbers(numbers, (result) => {
    console.log(`La suma de los números es: ${result}`);
});
```

En el primer ejemplo, `greet` acepta una función "callback" que toma un nombre (`name`) como parámetro y no devuelve nada (`void`). En el segundo ejemplo, `sumNumbers` toma una función "callback" que toma un resultado (`result`) como parámetro y tampoco devuelve nada (`void`).

#### Usos Comunes de Funciones "Callback"

Las funciones "callback" son comúnmente utilizadas en:

- Manejo de eventos asíncronos.
- Operaciones de iteración sobre colecciones de datos.
- Funcionalidades de manejo de errores y excepciones.
- Implementación de patrones de diseño como Observadores y Promesas.

#### Beneficios del Tipado en Funciones "Callback"

Al especificar tipos adecuados para funciones "callback":

- Se mejora la legibilidad y la documentación del código.
- Se facilita la detección temprana de errores de tipo.
- Se garantiza el cumplimiento de los contratos de funciones "callback" esperadas.

### Uso de `Function`: Mala Práctica (El `any` de las funciones)

En TypeScript, el tipo `Function` se refiere a cualquier función JavaScript sin especificar sus parámetros y tipo de retorno. Es un tipo genérico que puede aceptar cualquier función como valor, pero no proporciona información sobre los parámetros que la función espera ni sobre lo que devuelve. Esto hace que su uso sea considerado una mala práctica en la mayoría de los casos debido a la falta de seguridad y claridad que introduce en el código.

#### Ejemplo de Uso Incorrecto de `Function`

```typescript
let func: Function;

func = (x, y) => {
    return x + y;
};

func("Hello", 5); // No hay errores de tipo, pero no es claro qué tipo de función se espera
```

En este ejemplo, `func` se declara como tipo `Function`, lo que permite asignar cualquier función a esta variable, independientemente de sus parámetros y tipo de retorno. En tiempo de compilación, TypeScript no proporciona advertencias ni errores sobre el uso incorrecto de tipos, lo que puede llevar a errores difíciles de depurar en tiempo de ejecución.

#### Problemas de Usar `Function`

1. **Falta de Tipado y Seguridad**: Al usar `Function`, se pierde la ventaja principal de TypeScript que es la verificación estática de tipos. Esto significa que el compilador no puede garantizar que se están pasando los argumentos correctos a la función ni que se está tratando el valor de retorno correctamente.

2. **Dificultad para Mantener y Depurar**: Debido a la falta de información sobre los tipos, el código que utiliza `Function` es más difícil de mantener y depurar. Los errores relacionados con los tipos pueden pasar desapercibidos hasta que se ejecuten en tiempo de ejecución.

3. **Menos Documentación y Entendimiento**: Es importante documentar y entender claramente qué tipos de funciones espera un código. El uso de `Function` no proporciona esta documentación ni claridad, lo que puede confundir a otros desarrolladores que trabajen en el mismo código.

## Tipado de objetos

### Pascal Case

En TypeScript y en muchos otros lenguajes de programación, Pascal Case se refiere a la convención de nombrar entidades compuestas por varias palabras donde cada palabra comienza con mayúscula y no hay espacios ni guiones entre ellas. Esta convención es comúnmente utilizada para nombrar clases, interfaces, tipos y en general cualquier estructura de datos que sea un objeto o una instancia de un tipo.

#### Uso en TypeScript

En TypeScript, Pascal Case es especialmente relevante al definir tipos de datos estructurados como interfaces o type aliases. Al seguir esta convención, se facilita la lectura y comprensión del código, ya que los nombres de las entidades se vuelven más descriptivos y distinguibles.

#### Ejemplo de uso

```typescript
type Hero = {
    name: string;
    age: number;
    powers: string[];
};
```

En este ejemplo, `Hero` es un tipo definido utilizando Pascal Case. Este tipo describe las propiedades de un superhéroe, incluyendo su nombre, edad y habilidades (almacenadas en un array de strings). Al usar Pascal Case para nombrar el tipo `Hero`, se sigue una práctica estándar que ayuda a identificar rápidamente que se está trabajando con un tipo de datos estructurado.

#### Ventajas de Pascal Case

- **Legibilidad mejorada**: Los nombres compuestos son más legibles cuando se escriben con la primera letra de cada palabra en mayúscula.
- **Consistencia**: Al seguir una convención de nomenclatura como Pascal Case, se mantiene la consistencia dentro del código y entre proyectos.
- **Integración con herramientas**: Muchas herramientas de desarrollo y editores de código ofrecen sugerencias automáticas y completado basadas en convenciones como Pascal Case.

#### Uso de Pascal Case

1. **Interfaces y Type Aliases:**
   - **Interfaces:** Cuando definimos una interfaz para describir la forma de un objeto en TypeScript, se utiliza Pascal Case para el nombre de la interfaz.
   
     ```typescript
     interface User {
         firstName: string;
         lastName: string;
         age: number;
     }
     ```

   - **Type Aliases:** Similarmente, al definir alias para tipos complejos, se utiliza Pascal Case para nombrar el tipo.
   
     ```typescript
     type Point = {
         x: number;
         y: number;
     };
     ```


#### Razones para utilizar Pascal Case

- **Legibilidad Mejorada:** Al utilizar Pascal Case, cada palabra en el nombre está claramente separada por mayúsculas, lo que facilita la lectura y comprensión del código.
  
- **Consistencia:** Seguir una convención de nomenclatura como Pascal Case ayuda a mantener la consistencia en el código base y entre diferentes proyectos, lo que hace más fácil para los desarrolladores entender y mantener el código.

- **Integración con Herramientas:** Muchas herramientas de desarrollo y editores de código ofrecen características como autocompletado y sugerencias basadas en la convención de Pascal Case, lo que mejora la productividad y reduce errores.

En resumen, Pascal Case se utiliza en TypeScript para nombrar interfaces, type aliases, pero también en clases, constantes y enumeraciones (_igual que en js_). Esta práctica ayuda a mejorar la organización y la legibilidad del código, facilitando el mantenimiento y la colaboración entre desarrolladores.

### Type Alias en TypeScript

En TypeScript, los **Type Alias** (alias de tipo) son una característica fundamental que permite definir nombres alternativos para tipos existentes. Esto proporciona claridad, legibilidad y facilita la reutilización de tipos complejos dentro del código. A continuación, exploraremos cómo se utilizan los Type Alias y discutiremos la inferencia de tipos en funciones en comparación con el tipado directo de objetos en funciones.

#### Definición de Type Alias

Un Type Alias se define usando la palabra clave `type` seguida del nombre del alias y la definición del tipo:

```typescript
type Point = {
    x: number;
    y: number;
};
```

En este ejemplo, `Point` se convierte en un alias para un objeto con propiedades `x` y `y`, ambas de tipo `number`.

#### Beneficios de usar Type Alias

1. **Claridad y Legibilidad:**
   - Asignar nombres descriptivos mejora la comprensión del código y facilita la comunicación de la intención del tipo.

2. **Reutilización de Tipos:**
   - Permite definir tipos complejos una vez y reutilizarlos en múltiples partes del código.

3. **Mantenibilidad:**
   - Facilita la modificación y mantenimiento del código al centralizar la definición de tipos complejos.

#### Inferencia de Tipos en Funciones vs Tipado Directo de Objetos en Funciones

La inferencia de tipos en TypeScript juega un papel crucial al trabajar con funciones que aceptan objetos como parámetros. Compararemos cómo TypeScript infiere los tipos cuando se utiliza un Type Alias versus cuando se especifica directamente el tipo del objeto en la función.

##### Usando Type Alias

```typescript
type User = {
    name: string;
    age: number;
};

function printUserInfo(user: User) {
    console.log(`Name: ${user.name}, Age: ${user.age}`);
}

let myUser: User = { name: "Alice", age: 30 };
printUserInfo(myUser); // TypeScript infiere que myUser es de tipo User
```

En este caso, `User` es un Type Alias que define la estructura del objeto `user`. Cuando `myUser` se pasa como argumento a `printUserInfo`, TypeScript infiere automáticamente que `myUser` debe ser de tipo `User`, según la definición del Type Alias.

##### Tipado Directo de Objetos en Funciones

```typescript
function printUserInfoDirect(user: { name: string; age: number }) {
    console.log(`Name: ${user.name}, Age: ${user.age}`);
}

let anotherUser = { name: "Bob", age: 25 };
printUserInfoDirect(anotherUser); // TypeScript infiere que anotherUser es de tipo { name: string; age: number; }
```

En este ejemplo, se especifica directamente el tipo del objeto `user` como `{ name: string; age: number; }` en la función `printUserInfoDirect`. TypeScript infiere el tipo de `anotherUser` como `{ name: string; age: number; }` basándose en la estructura del objeto proporcionado.

#### Ventajas de Utilizar Type Alias en Funciones

- **Mejora la Legibilidad:** Los Type Alias proporcionan nombres descriptivos que hacen que el código sea más legible y comprensible.
  
- **Facilita la Refactorización:** Al centralizar la definición de tipos complejos, facilita la refactorización y la modificación del código.

- **Promueve la Consistencia:** Ayuda a mantener la consistencia en el uso de tipos a lo largo del código.
### Optional Properties en TypeScript

En TypeScript, las **optional properties** (propiedades opcionales) permiten definir propiedades en interfaces y tipos que pueden existir o no en un objeto. Esto ofrece flexibilidad al trabajar con estructuras de datos donde ciertas propiedades pueden ser opcionales o no estar presentes.

#### Definición de Propiedades Opcionales

En TypeScript, una propiedad se declara como opcional añadiendo `?` después del nombre de la propiedad en una interfaz o en un type alias:

```typescript
interface User {
    name: string;
    age?: number; // Propiedad age es opcional
}

let user1: User = { name: "Alice" }; // age es opcional
let user2: User = { name: "Bob", age: 25 }; // age es proporcionado
```

En este ejemplo, `age` es una propiedad opcional en la interfaz `User`. Esto significa que un objeto de tipo `User` puede tener o no la propiedad `age`.

#### Beneficios de las Propiedades Opcionales

1. **Flexibilidad:** Permite definir estructuras de datos donde algunas propiedades no son obligatorias.

2. **Compatibilidad con Datos Incompletos:** Facilita el manejo de datos donde no todas las propiedades son conocidas o están disponibles.

3. **Refactorización Sencilla:** Ayuda a agregar nuevas propiedades opcionales sin modificar todos los lugares donde se utiliza la interfaz o el tipo.

#### Optional Chaining Operator (`?.`)

El **Optional Chaining Operator** (`?.`) es una característica de JavaScript y TypeScript que permite acceder a propiedades de un objeto sin tener que validar explícitamente si el objeto o alguna de sus propiedades son `null` o `undefined`.

En TypeScript, el uso del Optional Chaining Operator se ve como sigue:

```typescript
interface User {
    name: string;
    age?: number;
    address?: {
        city: string;
        postalCode?: string; // postalCode es opcional
    };
}

let user1: User = {
    name: "Alice",
    address: {
        city: "New York",
    }
};

console.log(user1.address?.postalCode); // Accediendo a postalCode de manera segura con Optional Chaining
```

En este ejemplo, `user1.address?.postalCode` accede a la propiedad `postalCode` solo si `user1.address` no es `null` ni `undefined`. Si `address` no tiene una propiedad `postalCode`, el resultado será `undefined` en lugar de causar un error de acceso a una propiedad inexistente.

#### Ventajas del Optional Chaining Operator

- **Evita Errores de Acceso a Propiedades Nulas:** Permite acceder a propiedades profundas de un objeto de manera segura, evitando errores si alguna propiedad intermedia es `null` o `undefined`.

- **Código Más Conciso y Limpio:** Simplifica el código al eliminar la necesidad de validaciones manuales (`if` statements) para propiedades opcionales.

- **Mejora la Experiencia de Usuario:** Ayuda a manejar casos donde no todas las propiedades de un objeto están definidas, mejorando la robustez y la experiencia del usuario.

Entendido, vamos a reestructurar la sección sobre mutabilidad e inmutabilidad en TypeScript, siguiendo la estructura detallada que me proporcionaste. Vamos a enfocarnos en los puntos clave de manera más detallada y estructurada.

### Mutabilidad

#### Mutabilidad vs Inmutabilidad

En TypeScript, la **mutabilidad** y la **inmutabilidad** son conceptos importantes que afectan cómo se pueden modificar los objetos después de su creación. 

**Mutabilidad**:
La mutabilidad implica la capacidad de cambiar el estado de un objeto después de su creación. En TypeScript, los objetos son mutables por defecto, lo que significa que sus propiedades pueden modificarse después de su inicialización.

```typescript
let person = {
    name: "Alice",
    age: 30
};

person.age = 31; // Modificación de la propiedad age
console.log(person); // Output: { name: "Alice", age: 31 }
```

En este ejemplo, la propiedad `age` del objeto `person` se actualiza de `30` a `31` después de su creación.

**Inmutabilidad**:
La inmutabilidad implica que una vez que un objeto ha sido creado, no se puede modificar su estado. Esto proporciona una garantía de que el objeto permanece inalterado, lo cual puede ser útil en varios escenarios, como la programación funcional o en contextos donde la estabilidad del estado es crucial.

#### `readonly`

En TypeScript, podemos utilizar la palabra clave `readonly` para marcar propiedades individuales de un objeto como inmutables. Esto significa que estas propiedades no se pueden modificar después de la inicialización del objeto.

```typescript
type Hero = {
    readonly id?: number,
    name: string,
    age: number,
    isActive?: boolean
};

let hero: Hero = {
    name: "Thor",
    age: 1500,
    isActive: true
};

hero.age = 1501; // Error: No se puede asignar a 'age' porque es una propiedad de solo lectura
```

En este ejemplo, `id` está marcado como `readonly`, por lo tanto, no se puede asignar un nuevo valor después de la inicialización del objeto `hero`. TypeScript mostrará un error en tiempo de compilación si intentamos modificar una propiedad `readonly`.

#### Inmutabilidad en Funciones

Cuando pasamos objetos con propiedades `readonly` como argumentos a funciones, TypeScript garantiza que estas propiedades no se puedan modificar dentro de la función, a menos que se realice una copia explícita del objeto o se use algún método específico para modificarlo.

```typescript
function createHero(hero: Hero): Hero {
    const { name, age } = hero;
    return { name, age, isActive: true };
}

const thor: Hero = createHero(hero);

thor.id = 83219832197123; // Error: No se puede asignar a 'id' porque es una propiedad de solo lectura
```

En este caso, `thor` es una nueva instancia de `Hero` devuelta por la función `createHero`. Aunque `thor` es una copia del objeto `hero`, TypeScript preserva la inmutabilidad de `id`, mostrando un error si intentamos modificarlo.

#### `Object.freeze` en JavaScript

En JavaScript (y por ende en TypeScript), `Object.freeze` es un método que se utiliza para hacer un objeto completamente inmutable. Al congelar un objeto con `Object.freeze`, se previene cualquier modificación de sus propiedades existentes y no se pueden añadir ni eliminar nuevas propiedades.

```typescript
let hero = {
    name: "Thor",
    age: 1500,
    isActive: true
};

Object.freeze(hero); // Hace el objeto hero completamente inmutable

hero.age = 1501; // No se producirá ningún error en tiempo de compilación de TypeScript, pero no se actualizará 'age'
```

Cuando un objeto se congela con `Object.freeze`, cualquier intento de modificar sus propiedades existentes no provocará un error en tiempo de compilación de TypeScript, pero la modificación no se realizará. Este método es útil para garantizar que los objetos permanezcan inmutables en aplicaciones donde la estabilidad del estado es crucial.

#### Consideraciones Finales

- **Beneficios de la inmutabilidad**: La inmutabilidad puede mejorar la claridad del código y evitar errores relacionados con la modificación accidental de datos.
  
- **Rendimiento**: La inmutabilidad puede requerir más memoria debido a la creación de copias de objetos en lugar de modificar los existentes. Es importante evaluar el equilibrio entre claridad y rendimiento en cada caso de uso.

- **Elección entre `readonly` y `Object.freeze`**: `readonly` se aplica a propiedades individuales para hacerlas inmutables, mientras que `Object.freeze` se aplica al objeto completo. La elección depende de la necesidad específica de inmutabilidad en el diseño de la aplicación.

Usar `readonly` y `Object.freeze` adecuadamente en TypeScript puede contribuir significativamente a la robustez y la estabilidad del código, especialmente en aplicaciones donde la integridad del estado del objeto es crucial.

### Conjuntos de tipos
#### Union Types
**Uso del `|` (pipe), equivalente al OR**

El operador `|` se utiliza para crear unión entre tipos. Esto permite definir un tipo que puede ser uno de varios tipos específicos. Veamos un ejemplo sencillo:

```typescript
type ID = number | string;

let userId: ID = 12345;  // userId puede ser un número
let postId: ID = "abcde";  // postId puede ser una cadena de caracteres
```

En este ejemplo, `ID` es un tipo que puede ser tanto `number` como `string`. Esto permite manejar diferentes tipos de identificadores de manera flexible.

#### Intersection types
**Uso del `&` (ampersand), equivalente al AND**

El operador `&` se utiliza para crear intersección entre tipos. Esto significa que el tipo resultante incluirá todas las propiedades de los tipos interseccionados. A diferencia de la unión (`|`), que acepta uno de varios tipos, la intersección (`&`) acepta todos los tipos especificados. Aquí tienes un ejemplo:

```typescript
type Usuario = {
    id: number;
    nombre: string;
};

type Admin = {
    id: number;
    role: string;
};

type UsuarioAdmin = Usuario & Admin;

let usuarioAdmin: UsuarioAdmin = {
    id: 1,
    nombre: "Juan",
    role: "admin"
};
```

En este caso, `UsuarioAdmin` es un tipo que incluye todas las propiedades de `Usuario` y `Admin`, lo cual es útil cuando necesitamos definir un tipo que combine características específicas de ambos roles.

##### Problemas con Intersection types

Un problema potencial al usar el operador `&` es que si dos tipos intersecados tienen propiedades con el mismo nombre pero tipos diferentes, TypeScript generará un error. Esto se debe a que la intersección exige que las propiedades con el mismo nombre tengan el mismo tipo en ambos tipos intersecados.

```typescript
type A = {
    prop: number;
};

type B = {
    prop: string;
};

// Error: 'prop' está definido en tipos múltiples.
type C = A & B;
```

En el ejemplo anterior, TypeScript produce un error porque `A` y `B` tienen una propiedad `prop`, pero con tipos diferentes (`number` y `string`, respectivamente).

#### Template Union Types

Los **Template Literals** permiten definir tipos que combinan cadenas de texto de manera estática, utilizando la sintaxis de comillas invertidas (`backticks`) en TypeScript. Esto es útil para crear tipos que siguen un patrón específico de cadenas de texto.

```typescript
type HeroId = `${string}-${string}-${string}-${string}-${string}`;
type HexColor = `#${string}`;

let heroId: HeroId = "abc-def-ghi-jkl-mno";
let hexColor: HexColor = "#ff0000";
```

En este ejemplo, `HeroId` es un tipo que sigue el patrón de una cadena formada por cinco segmentos separados por guiones (`-`). Del mismo modo, `HexColor` es un tipo que representa colores hexadecimales precedidos por `#`.

#### Beneficios de los Template Union Types

- **Flexibilidad**: Permite definir tipos que pueden aceptar varios tipos diferentes.
- **Precisión**: Mejora la precisión del código al limitar los tipos aceptables a un conjunto específico.
- **Legibilidad**: Facilita la comprensión del código al definir tipos de datos que siguen patrones o estructuras predefinidas.

Los Template Union Types son una herramienta poderosa en TypeScript para manejar diferentes casos de uso donde se requiere combinar tipos de manera flexible y precisa. Esto facilita la escritura de código robusto y seguro en aplicaciones TypeScript.

## Ejercicios

### Ejercicios Prácticos

#### Ejercicio 1: Uso de Tipos

Escribe una función en TypeScript llamada `printHeroInfo` que tome un parámetro de tipo `Hero` y lo imprima en la consola. El objeto `Hero` debe tener las siguientes propiedades:

- `id`: opcional de tipo `number`.
- `name`: de tipo `string`.
- `age`: de tipo `number`.
- `isActive`: opcional de tipo `boolean`.

##### Solución Esperada

```typescript
type Hero = {
    id?: number;
    name: string;
    age: number;
    isActive?: boolean;
};

function printHeroInfo(hero: Hero): void {
    console.log(`Hero: ${hero.name}, Age: ${hero.age}`);
    if (hero.id !== undefined) {
        console.log(`ID: ${hero.id}`);
    }
    if (hero.isActive !== undefined) {
        console.log(`Active: ${hero.isActive}`);
    }
}

// Ejemplo de uso
const ironMan: Hero = {
    name: "Iron Man",
    age: 40,
    isActive: true
};

printHeroInfo(ironMan);
// Salida esperada:
// Hero: Iron Man, Age: 40
// Active: true
```

#### Ejercicio 2: Miniaplicación de Gestión de Empleados

Crea una miniaplicación en TypeScript para gestionar empleados de una empresa. Debes definir un tipo `Employee` con las siguientes propiedades:

- `id`: de tipo `number`.
- `name`: de tipo `string`.
- `position`: de tipo `string`.
- `salary`: de tipo `number`.

Luego, implementa las siguientes funciones:

1. **Función para agregar empleado**: `addEmployee`. Esta función toma un parámetro de tipo `Employee` y lo agrega a una lista de empleados.

2. **Función para obtener empleado por ID**: `getEmployeeById`. Esta función toma un parámetro `id` de tipo `number` y devuelve el empleado correspondiente si se encuentra en la lista.

3. **Función para calcular el salario total**: `calculateTotalSalary`. Esta función calcula y devuelve la suma total de los salarios de todos los empleados en la lista.

Implementa cada función de manera que utilice los tipos definidos y asegúrate de manejar correctamente los casos donde no se encuentre un empleado o no se agregue uno nuevo.

##### Ejemplo de Uso:

```typescript
type Employee = {
    id: number;
    name: string;
    position: string;
    salary: number;
};

let employees: Employee[] = [];

// Función para agregar empleado
function addEmployee(employee: Employee): void {
    employees.push(employee);
}

// Función para obtener empleado por ID
function getEmployeeById(id: number): Employee | undefined {
    return employees.find(emp => emp.id === id);
}

// Función para calcular salario total
function calculateTotalSalary(): number {
    return employees.reduce((total, emp) => total + emp.salary, 0);
}

// Agregar algunos empleados
addEmployee({ id: 1, name: "John Doe", position: "Developer", salary: 50000 });
addEmployee({ id: 2, name: "Jane Smith", position: "Manager", salary: 70000 });

// Obtener un empleado por ID
const employee = getEmployeeById(1);
if (employee) {
    console.log(`Employee found: ${employee.name}, Position: ${employee.position}`);
} else {
    console.log(`Employee not found.`);
}

// Calcular salario total
const totalSalary = calculateTotalSalary();
console.log(`Total salary of all employees: $${totalSalary}`);
```

### Ejercicios Teóricos
#### Preguntas Teóricas

1. ¿Cuál es la principal diferencia entre `readonly` y `const` en TypeScript cuando se aplican a propiedades de objetos?

2. ¿Por qué es útil el operador `?` en TypeScript cuando se define la estructura de un objeto?

3. Explica cómo TypeScript gestiona la inferencia de tipos cuando se utiliza el operador `typeof` en funciones.

#### Test Teórico

1. ¿Qué es TypeScript?

   - [ ] a) Un lenguaje de programación orientado a objetos.
   - [ ] b) Un superset de JavaScript que añade tipado estático opcional.
   - [ ] c) Una herramienta para compilar código Python a JavaScript.
   - [ ] d) Un framework para desarrollar aplicaciones web.

2. ¿Cuál de las siguientes afirmaciones sobre `any` en TypeScript es cierta?

   - [ ] a) `any` es un tipo de datos que representa un número entero.
   - [ ] b) `any` permite asignar cualquier tipo de valor a una variable.
   - [ ] c) `any` es equivalente a `void` en TypeScript.
   - [ ] d) `any` solo puede ser utilizado en funciones.

3. ¿Qué es el operador `typeof` en TypeScript?

   - [ ] a) Un operador para comprobar si un objeto es del tipo `Function`.
   - [ ] b) Un operador para obtener el tipo de una variable o una expresión en tiempo de compilación.
   - [ ] c) Un operador para realizar comparaciones estrictas entre dos valores.
   - [ ] d) Un operador para convertir tipos de datos a tipos primitivos en TypeScript.

4. ¿Cuál es la diferencia principal entre `null` y `undefined` en TypeScript?

   - [ ] a) `null` indica la ausencia de valor asignado a una variable, mientras que `undefined` representa un valor que no ha sido inicializado.
   - [ ] b) `null` y `undefined` son términos intercambiables en TypeScript.
   - [ ] c) `null` y `undefined` son equivalentes y se pueden usar indistintamente en cualquier contexto.
   - [ ] d) `undefined` se utiliza para objetos y `null` se utiliza para variables primitivas.

5. ¿Por qué es importante utilizar tipos explícitos en TypeScript?

   - [ ] a) Para mejorar el rendimiento del código y reducir el tiempo de ejecución.
   - [ ] b) Para facilitar la lectura y comprensión del código, especialmente en equipos grandes.
   - [ ] c) Para evitar el uso de cualquier tipo de datos (`any`) y mantener un código más seguro.
   - [ ] d) Para permitir la ejecución de código en cualquier entorno sin errores de sintaxis.
