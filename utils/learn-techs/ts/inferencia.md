# Tipos y Inferencia

## Tipos

En TypeScript, los tipos son esenciales para definir la forma y el comportamiento de nuestros datos. A continuación, exploraremos los tipos básicos disponibles en TypeScript:

### Tipos Básicos

1. **number**: Representa tanto números enteros como de punto flotante.
2. **string**: Representa datos textuales, como cadenas de caracteres.
3. **boolean**: Representa valores lógicos de verdadero o falso.
4. **null y undefined**: Tipos que tienen sus propios valores `null` y `undefined`, respectivamente.
5. **any**: Es un tipo dinámico que puede contener cualquier tipo de valor y se utiliza cuando la variable puede cambiar de tipo durante la ejecución.
6. **unknown**: Similar a `any`, pero más seguro ya que no se puede hacer nada con un valor de tipo `unknown` hasta que se haga una comprobación de tipo o una conversión explícita.
7. **void**: Indica la ausencia de tipo y se usa típicamente en funciones que no devuelven ningún valor.
8. **never**: Representa el tipo de valores que nunca ocurren, como funciones que lanzan excepciones o bucles infinitos.

## Inferencia

La inferencia de tipos es una característica clave en TypeScript que permite al compilador deducir automáticamente los tipos basados en el contexto. Esto mejora la legibilidad del código y reduce la necesidad de especificar tipos explícitamente en ciertas situaciones.

### Funcionamiento de la Inferencia

La inferencia de tipos en TypeScript opera de la siguiente manera:

- **Inferencia de tipo para variables**: TypeScript puede deducir el tipo de una variable según el valor que se le asigna inicialmente.
  
  ```typescript
  let age = 30; // TypeScript infiere que age es de tipo number
  let name = "Alice"; // TypeScript infiere que name es de tipo string
  let isActive = true; // TypeScript infiere que isActive es de tipo boolean
  ```

- **Inferencia de tipo en funciones**: TypeScript también puede inferir el tipo de retorno de una función basándose en el tipo de los valores de retorno.

  ```typescript
  function add(a: number, b: number) {
      return a + b; // TypeScript infiere que la función devuelve un número
  }

  let result = add(5, 3); // result será de tipo number según la inferencia
  console.log(result); // Salida: 8
  ```

#### Herencia de Inferencias
La herencia de inferencias se refiere a la capacidad de TypeScript para propagar automáticamente los tipos a través de las operaciones. Por ejemplo, cuando se suman dos números y se asignan a una nueva variable, TypeScript infiere el tipo de la variable resultante basándose en los tipos de las variables originales.

```typescript

let x = 10;
let y = 5;
let sum = x + y; // TypeScript infiere que sum es de tipo number
console.log(sum); // Salida: 15
```
En este caso, sum se infiere como number debido a que TypeScript hereda el tipo de x y y, que son números.

### Cuándo especificar tipos explícitamente

Aunque la inferencia de tipos es poderosa, hay casos donde es necesario especificar tipos explícitamente para garantizar la correcta utilización del código y mejorar la claridad:

#### Funciones
- **PARÁMETROS DE FUNCIÓN**: Es importante especificar tipos explícitamente en los parámetros de función para asegurar que la función se use correctamente y para documentar su comportamiento esperado.

  ```typescript
  function greet(name: string): void {
      console.log(`Hello, ${name}!`);
  }
  
  greet("Alice"); // Es necesario especificar que name es de tipo string
  ```

  **Explicación**: Al especificar `name` como `string`, TypeScript garantiza que solo se pueden pasar valores de tipo `string` a la función `greet`, mejorando la seguridad y la documentación del código.

- **OBJETOS COMO PARÁMETROS DE FUNCIÓN**: A veces es necesario especificar tipos para lo cual, tenemos dos formas sin tipar estrictamente el objeto(Interfaz). Estas son:

    **Ejemplo clásico**:
    ```typescript
    function printInfo({ name, age, employed }: { name: string, age: number, employed: boolean }): void {
        let message = employed ? `Hola ${name}, tienes ${age} años y eres empleado.` : `Hola ${name}, tienes ${age} años.`;
        console.log(message);
    }

    // Llamada a la función
    printInfo({ name: "Juan", age: 30, employed: true });
    ```
    **Ejemplo des-estructuración**:
    ```typescript
    function printInfo(persona: { name: string, age: number, employed: boolean }): void {
        const {name, age, employed} = persona;
        let message = employed ? `Hola ${name}, tienes ${age} años y eres empleado.` : `Hola ${name}, tienes ${age} años.`;
        console.log(message);
    }

    // Llamada a la función
    printInfo({ name: "Juan", age: 30, employed: true });
    ```

    **Explicación**:
    En TypeScript, cuando especificamos los tipos para los parámetros de una función que recibe un objeto, debemos seguir una sintaxis específica para evitar conflictos y asegurar que TypeScript entienda correctamente las intenciones del desarrollador.

    ##### Confusión con la sintaxis de asignación de objetos en JavaScript

    JavaScript permite definir y asignar propiedades a un objeto de la siguiente manera:

    ```javascript
    let persona = { name: "Alice", age: 30 };
    ```

    Aquí, `name` y `age` son nombres de propiedades del objeto `persona`, y sus valores están siendo asignados a `"Alice"` y `30` respectivamente. Esta es una sintaxis válida en JavaScript para crear y asignar propiedades a un objeto.

    ##### Problemas con la sintaxis en TypeScript

    Sin embargo, en TypeScript, cuando definimos los tipos de los parámetros de una función que espera recibir un objeto con propiedades específicas, la sintaxis `name: string, age: number` no tiene el mismo significado y puede llevar a confusión. Veamos por qué:

    1. **Ambigüedad en la intención**: En TypeScript, cuando vemos `name: string, age: number`, podría interpretarse como intentar definir propiedades `name` y `age` en un objeto. Esto no es correcto porque en realidad estamos tratando de especificar los tipos de las propiedades `name` y `age` que esperamos en el objeto que se pasa como argumento a la función.

    2. **Sintaxis correcta en TypeScript**: Para especificar correctamente los tipos esperados para las propiedades de un objeto en los parámetros de una función, debemos usar la sintaxis adecuada de TypeScript:

    ```typescript
    function saludar({ name, age }: { name: string, age: number }) {
        // Cuerpo de la función
    }
    ```

    Aquí, `{ name, age }: { name: string, age: number }` indica que esperamos un objeto que tenga propiedades `name` y `age`, y que `name` debe ser de tipo `string` y `age` debe ser de tipo `number`.

    3. **Evitar confusiones**: Al usar la sintaxis correcta, evitamos confusiones sobre si estamos definiendo propiedades o especificando tipos. TypeScript necesita saber claramente cuándo estamos definiendo tipos para verificar y garantizar la seguridad de tipo en tiempo de compilación.


#### Resultados variables

- **DATOS DINÁMICOS O EXTERNOS**: Cuando se trabaja con datos cuyos tipos pueden cambiar o no están completamente definidos, es fundamental usar tipos explícitos en lugar de `any` para manejar estos casos de manera segura y prevenir errores.

  ```typescript
  let dynamicData: unknown = fetchData(); // Utilizamos unknown cuando los tipos no son completamente conocidos
  
  if (typeof dynamicData === "string") {
      console.log(`Datos obtenidos: ${dynamicData.toUpperCase()}`);
  } else {
      console.log(`Tipo de datos no reconocido`);
  }
  ```

  **Explicación**: Al utilizar `unknown` en lugar de `any`, TypeScript permite manejar tipos dinámicos de manera más segura, ya que obliga a realizar verificaciones de tipo antes de operar con los datos, reduciendo la posibilidad de errores.

### Razones por las que especificar tipos
Especificando tipos explícitamente en estos casos no solo mejora la claridad del código, sino que también ayuda a TypeScript a realizar verificaciones estáticas de tipo de manera efectiva, proporcionando una base sólida para el desarrollo robusto y mantenible. Aquí están las principales razones para especificar tipos explícitamente:

- **Documentación y legibilidad**: Los tipos explícitos documentan claramente el comportamiento esperado de las funciones y variables, facilitando la comprensión del código para otros desarrolladores y para el mantenimiento futuro.

- **Prevención de errores**: Ayuda a detectar errores de tipo en tiempo de compilación, evitando problemas que podrían surgir en tiempo de ejecución.

- **Compatibilidad y seguridad**: Asegura que el código sea compatible con las expectativas de tipos y ofrece una mayor seguridad al manipular datos, especialmente en entornos donde los tipos pueden cambiar dinámicamente o ser desconocidos.

## Tipos y Inferencia en Práctica

A continuación, veremos ejemplos prácticos que demuestran el uso de tipos y la inferencia en TypeScript, así como el uso del operador `typeof` y otros métodos para trabajar con tipos.


### Uso de typeof en TypeScript

El operador `typeof` en TypeScript se utiliza para obtener el tipo estático de una variable o una expresión en tiempo de compilación. Esto es útil para realizar verificaciones de tipo o para condicionar comportamientos basados en el tipo de datos.

#### Introducción al Operador typeof

En TypeScript, `typeof` no debe confundirse con su uso en JavaScript, donde se utiliza principalmente para obtener el tipo de datos en tiempo de ejecución. En cambio, en TypeScript, `typeof` es una característica que ayuda a verificar y trabajar con tipos de datos en tiempo de compilación, mejorando la seguridad y la precisión del código.

#### Ejemplos de Uso de typeof

A continuación, se presentan algunos ejemplos claros de cómo se utiliza `typeof` en TypeScript:

1. **Verificación de Tipos y Asignaciones Seguras:**

```typescript
let message = "Hello";
let typeOfMessage: typeof message;

typeOfMessage = "Hi"; // Error de compilación: "Hi" no es asignable a tipo "string"
```

En este ejemplo, `typeof message` indica que `typeOfMessage` debe ser del mismo tipo que `message`, que es `string`. Asignar `"Hi"` a `typeOfMessage` generará un error de compilación porque `"Hi"` no es del tipo `string`.

2. **Condicional basado en el Tipo de Datos:**

```typescript
function processData(data: string | number) {
    if (typeof data === "string") {
        console.log(`Datos de tipo cadena: ${data}`);
    } else if (typeof data === "number") {
        console.log(`Datos de tipo número: ${data}`);
    } else {
        console.log(`Tipo de datos desconocido`);
    }
}

processData("Hello"); // Salida esperada: Datos de tipo cadena: Hello
processData(123); // Salida esperada: Datos de tipo número: 123
processData(true); // Salida esperada: Tipo de datos desconocido
```

En esta función `processData`, el uso de `typeof` permite identificar si `data` es una cadena (`"string"`) o un número (`"number"`). Esto ayuda a estructurar el código para manejar diferentes tipos de datos de manera segura.

#### Conclusiones

El uso de `typeof` en TypeScript es una herramienta poderosa para trabajar con tipos de datos de manera estática durante la compilación. Ayuda a mejorar la robustez del código al proporcionar verificaciones de tipo seguras y permitir comportamientos condicionales basados en el tipo de datos recibido.

Utilizando `typeof` de manera adecuada, puedes escribir código más claro y seguro en TypeScript, aprovechando las características del lenguaje para manejar tipos de datos de manera eficiente.

### Ejemplos de Uso de Tipos explícitos

```typescript
// Ejemplo con tipos explícitos
let age: number = 30;
let name: string = "John";
let isActive: boolean = true;
let data: any = "Hello";

// Función con tipos explícitos
function greet(person: string): string {
    return `Hello, ${person}!`;
}

console.log(greet(name)); // Salida: Hello, John!

// Uso de tipos null y undefined
let value1: null = null;
let value2: undefined = undefined;

// Función que puede devolver cualquier tipo
function processData(input: any): void {
    if (typeof input === "number") {
        console.log(`Received number: ${input}`);
    } else if (typeof input === "string") {
        console.log(`Received string: ${input}`);
    } else {
        console.log("Received unknown type");
    }
}

processData(123); // Salida: Received number: 123
processData("Hello"); // Salida: Received string: Hello
processData(true); // Salida: Received unknown type
```

### Ejemplos de Uso de Tipos inferidos

```typescript
// Ejemplo con tipos inferidos
let age = 30; // TypeScript infiere que age es de tipo number
let name = "John"; // TypeScript infiere que name es de tipo string
let isActive = true; // TypeScript infiere que isActive es de tipo boolean
let data = "Hello"; // TypeScript infiere que data es de tipo string

// Función con tipo de retorno inferido
function greet(person) {
    return `Hello, ${person}!`; // TypeScript infiere que la función devuelve un string
}

console.log(greet(name)); // Salida: Hello, John!

// Uso de tipos null y undefined
let value1 = null; // TypeScript infiere que value1 es de tipo null
let value2 = undefined; // TypeScript infiere que value2 es de tipo undefined

// Función que puede devolver cualquier tipo
function processData(input) {
    if (typeof input === "number") {
        console.log(`Received number: ${input}`);
    } else if (typeof input === "string") {
        console.log(`Received string: ${input}`);
    } else {
        console.log("Received unknown type");
    }
}

processData(123); // Salida: Received number: 123
processData("Hello"); // Salida: Received string: Hello
processData(true); // Salida: Received unknown type
```

#### Explicación

En este ejemplo, TypeScript utiliza la inferencia de tipos para deducir automáticamente los tipos de las variables y los parámetros de función según el valor inicial asignado o el contexto en el que se utilizan:

- **Variables**: `age`, `name`, `isActive`, y `data` tienen tipos inferidos automáticamente como `number`, `string`, `boolean`, y `string` respectivamente.
  
- **Función `greet`**: El parámetro `person` de la función `greet` no tiene un tipo explícito, pero TypeScript infiere que es de tipo `string` basándose en el argumento que se pasa (`name` en este caso). También infiere que la función devuelve un `string`.

- **Tipos `null` y `undefined`**: Las variables `value1` y `value2` son inferidas como `null` y `undefined` respectivamente.

- **Función `processData`**: La función utiliza `typeof` para verificar el tipo de `input` y realiza diferentes acciones en función del tipo inferido (`number`, `string`, u otro).

#### Ventajas de la Inferencia de Tipos

La inferencia de tipos en TypeScript proporciona varios beneficios:

- **Menos código redundante**: No es necesario especificar tipos explícitamente cuando TypeScript puede deducirlos automáticamente.
  
- **Mantenimiento más sencillo**: El código es más fácil de mantener y refactorizar, ya que TypeScript sigue la inferencia de tipos de manera consistente.

- **Mejora la legibilidad**: Al evitar tipos explícitos innecesarios, el código se vuelve más claro y conciso.

Utilizar tipos inferidos cuando sea posible es una práctica recomendada en TypeScript, ya que aprovecha las características del lenguaje para mejorar la eficiencia y claridad del código.

## Ejercicios

### Ejercicios Prácticos

#### Ejercicio 1: Uso de Tipos

Escribe una función en TypeScript llamada `printInfo` que tome dos parámetros: `name` de tipo `string` y `age` de tipo `number`. La función debe imprimir en la consola un mensaje en formato: "Hola, [nombre]. Tienes [edad] años."

##### Solución Esperada

```typescript
function printInfo(name: string, age: number): void {
    console.log(`Hola, ${name}. Tienes ${age} años.`);
}

printInfo("Carlos", 25); // Salida esperada: Hola, Carlos. Tienes 25 años.
```

Para el ejercicio 2, vamos a crear un escenario donde el usuario debe escribir una función que utilice el operador `typeof` y algunos tipos menos comunes como `null`, `void` y `undefined`. Aquí está el ejercicio modificado:

---

#### Ejercicio 2: Uso de Tipos y Operador typeof

Escribe una función en TypeScript llamada `processData` que tome un parámetro llamado `data`. Esta función debe realizar las siguientes acciones:

1. Si `data` es de tipo `string`, imprimir en la consola el mensaje: "Datos de tipo cadena: [data]".
2. Si `data` es de tipo `number`, imprimir en la consola el mensaje: "Datos de tipo número: [data]".
3. Si `data` es de tipo `null`, imprimir en la consola el mensaje: "Datos nulos recibidos".
4. Si `data` es de tipo `undefined`, imprimir en la consola el mensaje: "Datos indefinidos recibidos".
5. Si `data` no coincide con ninguno de estos tipos, imprimir en la consola el mensaje: "Tipo de datos desconocido".

Utiliza el operador `typeof` para determinar el tipo de `data`.

##### Ejemplo de Uso:

```typescript
// Llama a la función processData con diferentes tipos de datos
processData("Hello"); // Salida esperada: Datos de tipo cadena: Hello
processData(123); // Salida esperada: Datos de tipo número: 123
processData(null); // Salida esperada: Datos nulos recibidos
processData(undefined); // Salida esperada: Datos indefinidos recibidos
processData(true); // Salida esperada: Tipo de datos desconocido
```

##### Solución Esperada

```typescript
function processData(data: any): void {
    if (typeof data === "string") {
        console.log(`Datos de tipo cadena: ${data}`);
    } else if (typeof data === "number") {
        console.log(`Datos de tipo número: ${data}`);
    } else if (data === null) {
        console.log(`Datos nulos recibidos`);
    } else if (typeof data === "undefined") {
        console.log(`Datos indefinidos recibidos`);
    } else {
        console.log(`Tipo de datos desconocido`);
    }
}
```

### Ejercicios Teóricos

1. ¿Cuál es la principal diferencia entre `any` y `unknown` en TypeScript?
   - [ ] a) `any` permite cualquier tipo de asignación, mientras que `unknown` requiere una comprobación de tipo antes de la asignación.
   - [ ] b) `any` es más seguro que `unknown` porque permite el uso flexible de variables.
   - [ ] c) `unknown` es más flexible que `any` porque puede aceptar cualquier tipo de asignación sin restricciones.
   - [ ] d) No hay diferencia, `any` y `unknown` son términos intercambiables en TypeScript.

2. ¿Por qué es beneficioso utilizar la inferencia de tipos en TypeScript?
   - [ ] a) Reduce la necesidad de especificar tipos explícitamente, haciendo el código más limpio y legible.
   - [ ] b) Aumenta la complejidad del código al introducir ambigüedad en los tipos.
   - [ ] c) Acelera el tiempo de ejecución del código al eliminar la necesidad de verificaciones de tipos.
   - [ ] d) Ninguna de las anteriores.

3. ¿Qué sucede si intentas asignar `null` a una variable de tipo `number` en TypeScript?
   - [ ] a) Se permite la asignación sin problemas.
   - [ ] b) TypeScript arroja un error de compilación porque `null` no es compatible con `number`.
   - [ ] c) TypeScript convierte automáticamente `null` a `0` antes de la asignación.
   - [ ] d) `null` se convierte en `undefined` automáticamente antes de la asignación.

4. ¿Cuál es el uso principal del tipo `never` en TypeScript?
   - [ ] a) Para representar un valor que nunca se produce.
   - [ ] b) Para definir funciones que nunca devuelven un valor.
   - [ ] c) Para representar cualquier valor o tipo.
   - [ ] d) Para definir variables que pueden contener cualquier tipo de dato.

5. ¿Cómo se pueden definir arrays con tipos específicos en TypeScript?
   - [ ] a) `let arr: Array<any> = [1, 2, 3];`
   - [ ] b) `let arr: Array<number> = [1, 2, 3];`
   - [ ] c) `let arr: any[] = [1, 2, 3];`
   - [ ] d) Todas las anteriores.

