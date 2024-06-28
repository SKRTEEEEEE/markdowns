# Arrays y mas.
## Funciones y objetos p2
### Type indexing
#### Type indexing "nominal"

```typescript
type HeroProperties = {
    isActive: boolean;
    address: {
        planet: string;
        city: string;
    };
};

const addressHero: HeroProperties["address"] = {
    planet: "Earth",
    city: "New York"
};
```

En este ejemplo, `HeroProperties["address"]` se utiliza para definir el tipo de la constante `addressHero`, asegurando que cumpla con la estructura específica de la propiedad `address` dentro del tipo `HeroProperties`.

#### Type indexing "figurado"

```typescript
type HeroStats = {
    [key: string]: string | number | boolean | undefined;
};

let hero: HeroStats = {
    name: "Superman",
    age: 35,
    powers: ["flight", "super strength"],
    isEvil: false
};
```

En este ejemplo, `HeroStats` define un type alias que permite propiedades de cualquier nombre (`string`) con valores que pueden ser `string`, `number`, `boolean` o `undefined`. Es una forma de crear un tipo flexible para estructuras de datos donde las propiedades exactas pueden variar.

##### Comparativa de ambos usos

**Nominal:**
- **Estructura específica**: Es útil cuando conoces de antemano la estructura exacta de una propiedad dentro de un tipo más grande (`HeroProperties` en este caso).
- **Seguridad de tipos**: Proporciona seguridad de tipos al asegurar que `addressHero` cumpla con la estructura esperada de `address`.

**Figurado:**
- **Flexibilidad**: Permite definir tipos para estructuras de datos dinámicas donde las propiedades pueden tener nombres variables y tipos diversos (`string`, `number`, `boolean`, `undefined`).
- **Escenarios dinámicos**: Útil cuando trabajas con datos cuya estructura puede variar o no es completamente conocida de antemano.

### Type from value `typeof` 

En TypeScript, `typeof` es una herramienta poderosa que permite crear tipos estáticos a partir de valores existentes en tiempo de compilación. Esto proporciona un mecanismo eficaz para definir tipos que reflejen las propiedades y métodos disponibles en objetos y funciones concretas.

#### Ejemplo básico con `typeof`

```typescript
const car = {
    brand: "Toyota",
    model: "Camry",
    year: 2020
};

type Car = typeof car;

// Car es equivalente a {
//   brand: string;
//   model: string;
//   year: number;
// }

let myCar: Car = {
    brand: "Honda",
    model: "Accord",
    year: 2018
};
```

En este ejemplo:
- `typeof car` crea un tipo `Car` que es equivalente a `{ brand: string; model: string; year: number; }`.
- `myCar` es una variable que cumple con el tipo `Car`, asegurando que todas las propiedades coincidan con las definidas en `car`.


##### Beneficios de utilizar `typeof`

- **Inferencia de tipos estáticos**: Permite inferir y definir tipos estáticos basados en el contenido de variables y funciones existentes.
  
- **Mantenimiento simplificado**: Al utilizar `typeof`, los tipos se actualizan automáticamente si cambian las propiedades o la firma de una función.

- **Evita duplicaciones**: Reduce la duplicación de código al definir tipos de objetos y funciones utilizando la misma fuente de verdad.



#### Otros usos de `typeof`

1. **Captura de tipos de objetos existentes**

```typescript
const user = {
    name: "Alice",
    age: 30,
    isActive: true
};

type User = typeof user;

let newUser: User = {
    name: "Bob",
    age: 25,
    isActive: false
};
```

2. **Definición de constantes tipo**

```typescript
const CONFIG = {
    apiUrl: "https://api.example.com",
    timeout: 5000
} as const;

type AppConfig = typeof CONFIG;

let appSettings: AppConfig = {
    apiUrl: "https://api.another-example.com", // Error: El tipo 'https://api.another-example.com' no es assignable a type 'https://api.example.com'
    timeout: 3000
};
```

3. **Copiar tipos de funciones**

```typescript
function multiply(a: number, b: number): number {
    return a * b;
}

type MathOperation = typeof multiply;

let operation: MathOperation = function(a, b) {
    return a + b; // Error: Tipo 'number' no es assignable a type 'number'
};
```

### Type from function

En TypeScript, `ReturnType` es una utilidad integrada que permite inferir y crear tipos basados en el tipo de retorno de una función existente en tiempo de compilación. Esto proporciona una forma eficaz de definir tipos estáticos basados en lo que una función devuelve.

#### Ejemplo básico con `ReturnType`

```typescript
function getUser() {
    return {
        name: "Alice",
        age: 30,
        isAdmin: false
    };
}

type User = ReturnType<typeof getUser>;

let currentUser: User = {
    name: "Bob",
    age: 25,
    isAdmin: true
};
```

En este ejemplo:
- `ReturnType<typeof getUser>` captura el tipo de retorno de la función `getUser`, que en este caso es `{ name: string; age: number; isAdmin: boolean; }`.
- `currentUser` es una variable que cumple con el tipo `User`, asegurando que tenga las mismas propiedades y tipos que el tipo de retorno de `getUser`.

#### Uso de `ReturnType` con funciones diferentes

```typescript
function generateId() {
    return Math.random().toString(36).substr(2, 9);
}

type Id = ReturnType<typeof generateId>;

let userId: Id = "abc123";
```

En este caso:
- `ReturnType<typeof generateId>` infiere el tipo de retorno de la función `generateId`, que es `string` en este ejemplo.
- `userId` es una variable de tipo `Id`, que ahora es simplemente un `string` debido a la función `generateId`.

#### Beneficios de utilizar `ReturnType`

- **Precisión de tipos**: Permite definir tipos estáticos precisos basados en el tipo de retorno de una función existente.
  
- **Refactorización segura**: Facilita la refactorización del código al actualizar automáticamente los tipos si cambia el tipo de retorno de la función.

- **Documentación del código**: Mejora la legibilidad y la documentación del código al proporcionar información clara sobre los tipos de datos que se manejan.

#### Comparativa con `typeof`

- **`typeof`**: Captura el tipo de una variable o propiedad existente en tiempo de compilación.
  
- **`ReturnType`**: Captura el tipo de retorno de una función existente en tiempo de compilación.

Ambas utilidades son complementarias y se utilizan para diferentes propósitos: `typeof` para variables y propiedades, y `ReturnType` para funciones y métodos.

#### Otros usos de `ReturnType`

1. **Funciones con retorno condicional**

```typescript
function getMessage(isError: boolean) {
    if (isError) {
        return { type: "error", message: "Error occurred" };
    } else {
        return { type: "info", message: "Operation successful" };
    }
}

type Message = ReturnType<typeof getMessage>;

let result: Message = {
    type: "info",
    message: "Operation successful"
};
```

2. **Funciones con retorno de tipos complejos**

```typescript
function getPerson() {
    return {
        name: "Alice",
        age: 30,
        address: {
            city: "New York",
            country: "USA"
        }
    };
}

type Person = ReturnType<typeof getPerson>;

let person: Person = {
    name: "Bob",
    age: 25,
    address: {
        city: "Los Angeles",
        country: "USA"
    }
};
```

3. **Uso con métodos de clases**

```typescript
class Calculator {
    add(a: number, b: number): number {
        return a + b;
    }

    multiply(a: number, b: number): number {
        return a * b;
    }
}

type Operation = ReturnType<Calculator["add"]>;

let result: Operation = 10;
```

### Type Utilities introducción

En TypeScript, las **Type Utilities** son un conjunto de utilidades integradas que proporcionan funciones para manipular y transformar tipos existentes. Estas utilidades son útiles para realizar operaciones comunes en tipos de datos y mejorar la flexibilidad y mantenibilidad del código.

#### Ejemplos de Type Utilities

A continuación, exploraremos varias utilidades comunes y cómo se utilizan en TypeScript.

##### `Partial<T>`

`Partial<T>` es una utilidad que convierte todas las propiedades de un tipo `T` en opcionales, permitiendo crear tipos parciales a partir de tipos existentes.

```typescript
type User = {
    name: string;
    age: number;
    isAdmin: boolean;
};

function updateUser(user: Partial<User>): void {
    // Actualizar solo las propiedades proporcionadas en 'user'
    // No se requiere proporcionar todas las propiedades de 'User'
}

let partialUser: Partial<User> = { age: 31 };
updateUser(partialUser);
```

En este ejemplo, `Partial<User>` permite crear un tipo donde todas las propiedades de `User` son opcionales, lo que facilita la actualización parcial de objetos `User`.

##### `Required<T>`

`Required<T>` es una utilidad que convierte todas las propiedades opcionales de un tipo `T` en requeridas, creando un nuevo tipo donde todas las propiedades son obligatorias.

```typescript
type PartialUser = {
    name?: string;
    age?: number;
    isAdmin?: boolean;
};

type FullUser = Required<PartialUser>;

let fullUser: FullUser = {
    name: "Alice",
    age: 30,
    isAdmin: false
};
```

En este caso, `Required<PartialUser>` garantiza que todas las propiedades de `PartialUser` sean obligatorias en `FullUser`, proporcionando un tipo completo sin propiedades opcionales.

##### `Readonly<T>`

`Readonly<T>` es una utilidad que convierte todas las propiedades de un tipo `T` en de solo lectura, evitando que se modifiquen después de la inicialización.

```typescript
type Hero = {
    name: string;
    age: number;
};

let hero: Readonly<Hero> = {
    name: "Batman",
    age: 40
};

hero.age = 41; // Error: No se puede asignar a 'age' porque 'hero' es de solo lectura
```

En este ejemplo, `Readonly<Hero>` asegura que todas las propiedades de `Hero` sean de solo lectura, lo que previene modificaciones accidentales después de la inicialización.

##### `Record<K, T>`

`Record<K, T>` es una utilidad que crea un tipo con claves de tipo `K` y valores de tipo `T`. Es útil para definir tipos que representan diccionarios o mapas con claves específicas.

```typescript
type Fruit = "apple" | "banana" | "orange";
type PriceList = Record<Fruit, number>;

const prices: PriceList = {
    apple: 1.25,
    banana: 0.75,
    orange: 1.00
};
```

En este ejemplo, `Record<Fruit, number>` define un tipo `PriceList` donde las claves son tipos de frutas (`Fruit`) y los valores son números que representan los precios correspondientes.

#### Exploración de otras Type Utilities

Además de las utilidades mencionadas (`Partial`, `Required`, `Readonly`, `Record`), TypeScript ofrece muchas otras utilidades integradas que facilitan la manipulación y transformación de tipos:

- `Pick<T, K>`: Selecciona un conjunto de propiedades (`K`) de un tipo (`T`).
- `Omit<T, K>`: Omite un conjunto de propiedades (`K`) de un tipo (`T`).
- `Exclude<T, U>`: Filtra tipos `T` excluyendo aquellos que son asignables a `U`.
- `Extract<T, U>`: Filtra tipos `T` que son asignables a `U`.
- `NonNullable<T>`: Elimina `null` y `undefined` de un tipo `T`.
- `Parameters<T>`: Obtiene los tipos de parámetros de una función `T`.
- `ReturnType<T>`: Obtiene el tipo de retorno de una función `T`.

#### Beneficios de utilizar Type Utilities

- **Reutilización de código**: Evita la repetición de definiciones de tipos comunes.
- **Seguridad de tipo**: Mejora la precisión y la seguridad del código al trabajar con tipos.
- **Facilidad de mantenimiento**: Simplifica la actualización y refactorización del código al centralizar la definición de tipos complejos.



## Arrays y parecidos

### Arrays

Los arrays en TypeScript son estructuras de datos que permiten almacenar colecciones de elementos, ya sean del mismo tipo o de tipos diferentes. A continuación, exploraremos cómo TypeScript maneja los arrays y algunas características importantes.

#### Arrays de Tipos Primitivos

Podemos definir arrays que contengan elementos de un solo tipo utilizando la sintaxis `Tipo[]` o `Array<Tipo>`:

```typescript
const languages: string[] = ["JavaScript", "TypeScript", "Java"];
const numbers: Array<number> = [1, 2, 3];
```

En este caso, `languages` es un array que contiene cadenas de texto (`string`), y `numbers` es un array que contiene números (`number`). TypeScript deduce automáticamente el tipo de los elementos en función de los valores proporcionados.

#### Arrays con Tipos Union

Es posible definir arrays que contengan elementos de múltiples tipos mediante uniones de tipos:

```typescript
const mixedArray: (string | number | boolean)[] = ["Hello", 123, true];
```

En `mixedArray`, podemos almacenar elementos que son cadenas de texto, números o booleanos. Esta flexibilidad es útil cuando necesitamos manejar datos heterogéneos dentro de un mismo array.

#### Arrays de Objetos

Para definir arrays que contengan objetos con una estructura específica, podemos utilizar tipos definidos previamente:

```typescript
type Product = {
    name: string;
    price: number;
};

const products: Product[] = [
    { name: "Laptop", price: 1200 },
    { name: "Mouse", price: 30 }
];
```

En este ejemplo, `products` es un array que contiene objetos de tipo `Product`, donde cada objeto tiene propiedades `name` y `price`.

##### Inferencia en Arrays

**Operaciones y Métodos de Array**

TypeScript admite todos los métodos estándar de JavaScript que operan en arrays, como `map`, `filter`, `reduce`, `forEach`, etc. Estos métodos pueden ser utilizados de manera segura gracias a la inferencia de tipos:

```typescript
const numbers: number[] = [1, 2, 3, 4, 5];

// Ejemplo de uso del método 'filter' para números pares
const evenNumbers: number[] = numbers.filter(num => num % 2 === 0);
```

#### Arrays Genéricos

Es posible definir funciones que operen con arrays genéricos, lo cual es útil cuando necesitamos trabajar con diferentes tipos de datos de manera flexible:

```typescript
function printArray<T>(arr: T[]): void {
    arr.forEach(item => console.log(item));
}

const names: string[] = ["Alice", "Bob", "Charlie"];
printArray(names); // Imprime cada elemento del array 'names'
```

En este caso, `printArray` es una función genérica que acepta un array de tipo `T` y lo imprime en la consola.

#### Arrays Genéricos vs any

##### Uso de `<T>` (Tipo genérico)

- **Propósito**: `<T>` se utiliza para crear funciones, clases o interfaces que pueden trabajar con cualquier tipo de dato de manera flexible y segura.
- **Inferencia de tipos**: TypeScript puede inferir el tipo exacto basado en el contexto en el que se utiliza la función genérica.
- **Seguridad de tipos**: Al usar `<T>`, TypeScript proporciona verificación de tipos en tiempo de compilación, lo que evita errores relacionados con tipos incorrectos y promueve la reutilización del código de manera segura.

**Ejemplo:**

```typescript
function imprimirObj<T>(objeto: T): void {
    console.log(objeto);
}

const hero = { name: "Iron Man", age: 40 };

imprimirObj(hero); // TypeScript infiere que hero es de tipo { name: string; age: number; }
```

En este ejemplo, TypeScript infiere automáticamente que `hero` es de tipo `{ name: string; age: number; }` y ajusta el tipo `T` en la función `imprimirObj` en consecuencia. Esto asegura que solo se pueda pasar un objeto del mismo tipo que `hero` a la función `imprimirObj`.

##### Uso de `any`

- **Propósito**: `any` es un tipo especial en TypeScript que puede representar cualquier tipo de dato, incluidos primitivos y objetos.
- **Inferencia de tipos**: Cuando se utiliza `any`, TypeScript no realiza verificaciones de tipo en tiempo de compilación para ese valor.
- **Flexibilidad**: `any` permite tratar un valor de cualquier tipo sin restricciones de tipo estático.

**Ejemplo:**

```typescript
function imprimirAny(objeto: any): void {
    console.log(objeto);
}

const anyObj = { foo: "bar" };

imprimirAny(anyObj); // Se acepta cualquier tipo de objeto, TypeScript no realiza verificaciones de tipo
```

En este caso, `anyObj` puede ser cualquier tipo de objeto, y TypeScript no proporciona garantías de tipo estático cuando se pasa a la función `imprimirAny`.

##### Diferencias clave

- **Seguridad de tipos**: Con `<T>`, TypeScript proporciona seguridad de tipos al mantener la coherencia entre el tipo del parámetro genérico y el tipo del argumento pasado a la función. Con `any`, se pierde esta seguridad de tipos.
- **Inferencia vs. falta de inferencia**: `<T>` permite la inferencia de tipos, lo que significa que TypeScript puede deducir el tipo según el contexto. `any` no proporciona inferencia de tipos; cualquier tipo de objeto puede pasar sin verificación.
- **Tipado estático**: `<T>` sigue siendo parte del tipado estático fuerte de TypeScript, mientras que `any` es una especie de escape del sistema de tipos estáticos.

### Matrices 

En TypeScript, las matrices (o arrays multidimensionales) son estructuras de datos que permiten almacenar colecciones de elementos ordenados con tipos específicos. A diferencia de JavaScript estándar, TypeScript proporciona verificación de tipos estáticos durante la compilación, lo cual mejora la seguridad y la claridad del código.

#### Definición de Matrices

Para definir una matriz en TypeScript, se utiliza la notación de corchetes dobles `[][]` para indicar una matriz bidimensional.

**Ejemplo básico de una matriz:**

```typescript
let matriz: number[][] = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
];
```

En este ejemplo, `matriz` es una matriz de números (`number[][]`) con 3 filas y 3 columnas. Cada elemento de la matriz es accesible utilizando índices de fila y columna.

#### Tipos Personalizados en Matrices

En TypeScript, también es posible definir matrices que contengan tipos personalizados, como matrices de objetos con estructuras específicas.

**Ejemplo con tipo personalizado:**

```typescript
type Persona = {
    nombre: string;
    edad: number;
};

let personas: Persona[][] = [
    [{ nombre: "Alice", edad: 30 }, { nombre: "Bob", edad: 25 }],
    [{ nombre: "Charlie", edad: 40 }, { nombre: "David", edad: 35 }]
];

console.log(personas[0][0].nombre); // Accede al nombre de la primera persona en la primera fila: Alice
```

En este ejemplo, `personas` es una matriz de objetos tipo `Persona`. Cada elemento de la matriz es un objeto con propiedades `nombre` y `edad`.

#### Ventajas de las Matrices en TypeScript

- **Verificación de tipos estática**: TypeScript verifica los tipos de datos durante la compilación, evitando errores comunes de acceso a elementos fuera de los límites de la matriz.
  
- **Soporte para tipos personalizados**: Las matrices en TypeScript pueden contener elementos de tipos personalizados definidos por el usuario, como objetos con estructuras específicas.

- **Organización y eficiencia**: Permiten organizar datos en forma de filas y columnas, facilitando operaciones como búsqueda, ordenamiento y filtrado de datos.

### Tuplas
En TypeScript, las tuplas son estructuras de datos que permiten expresar un arreglo fijo de elementos con tipos específicos conocidos, donde cada elemento puede tener un tipo diferente. A diferencia de los arrays, las tuplas tienen un número fijo de elementos y cada elemento puede tener un tipo diferente. Aquí te explico más sobre las tuplas en TypeScript:

#### Definición de Tuplas

Para definir una tupla en TypeScript, se utiliza una sintaxis similar a la de un array, pero se especifican los tipos de cada elemento entre corchetes `[]` en el orden deseado.

**Ejemplo básico de tupla:**

```typescript
let tupla: [string, number] = ["Hola", 42];
```

En este ejemplo, `tupla` es una tupla que contiene un string en la primera posición y un número en la segunda posición. Esto significa que el primer elemento debe ser siempre un string y el segundo elemento debe ser siempre un número.

#### Acceso a los Elementos de una Tupla

Para acceder a los elementos de una tupla, se utilizan índices numéricos, comenzando desde `0` para el primer elemento.

**Ejemplo de acceso a elementos de tupla:**

```typescript
console.log(tupla[0]); // Output: "Hola"
console.log(tupla[1]); // Output: 42
```

#### Modificación de Elementos en una Tupla

Las tuplas en TypeScript permiten modificar elementos individuales siempre y cuando se respete el tipo especificado para cada posición.

**Ejemplo de modificación de elementos de tupla:**

```typescript
tupla[0] = "Adiós"; // Modificación del primer elemento
tupla[1] = 100;     // Modificación del segundo elemento

console.log(tupla); // Output: ["Adiós", 100]
```

#### Restricciones y Beneficios de las Tuplas

- **Tipado estático**: TypeScript verifica y garantiza que los tipos de datos en cada posición de la tupla sean coherentes en tiempo de compilación.
  
- **Elementos fijos**: A diferencia de los arrays, las tuplas tienen un número fijo de elementos y cada posición puede tener un tipo diferente, lo que permite una estructura de datos más precisa y específica para casos donde se conoce de antemano el tipo y la cantidad de elementos.

- **Uso de patrones específicos**: Las tuplas son útiles cuando se necesita una estructura de datos que mantenga un orden fijo y donde cada elemento tenga un tipo particular, como en casos de representación de coordenadas (x, y) o datos estructurados con tipos diferentes pero específicos.

En TypeScript, las matrices de tuplas son arreglos que contienen tuplas como elementos. Esto combina las características de las tuplas (elementos con tipos específicos y fijos) con las de los arrays (colecciones ordenadas de elementos). Aquí te explico cómo funcionan las matrices de tuplas y cómo se pueden utilizar:

Entendido, aquí está la explicación revisada para clarificar la diferencia entre una tupla regular y una tupla `readonly` en TypeScript:

### Diferencia entre Tupla Regular y Tupla `readonly` en TypeScript
[**ISSUE Problema "Descrito"**](https://github.com/microsoft/TypeScript/issues/6325)

En TypeScript, una tupla es una estructura de datos que permite almacenar una colección fija de elementos de tipos específicos. Sin embargo, hay una distinción importante entre una tupla regular y una tupla `readonly`, que afecta cómo puedes interactuar con ellas, especialmente al intentar modificar sus elementos.

#### Metodos que "destruyen" la tupla sin el readonly
```
Array#push
Array#pop
Array#shift
Array#unshift
Array#splice
```

#### Tupla Regular

Una tupla regular en TypeScript se define utilizando corchetes `[]` y especificando los tipos de sus elementos entre los corchetes.

```typescript
type RGB = [number, number, number];

const colorRGB: RGB = [255, 0, 255];
```

En este ejemplo, `RGB` es una tupla que representa un color en formato RGB. Puedes acceder y modificar los elementos de esta tupla utilizando índices numéricos, como harías con un array normal.

```typescript
console.log(colorRGB[0]); // 255
colorRGB[1] = 128; // Modificación permitida
```
##### Ejemplo de `push` en una Tupla

Una consecuencia directa de la mutabilidad en las tuplas es que puedes utilizar métodos que mutan el tamaño del array, como `push`, y esto puede inducir a errores.

```typescript
const colorEstricto: RGB = [255, 0, 255];
colorEstricto.push(128); // Works: When probably you think should not.
```

#### Tupla `readonly`

Por otro lado, una tupla `readonly` se define añadiendo la palabra clave `readonly` antes de la declaración de la tupla. Esto indica que los valores dentro de la tupla no pueden ser modificados después de su inicialización.

```typescript
type RGBEstricto = readonly [number, number, number];

const colorEstricto: RGBEstricto = [255, 0, 255];
```

En el caso de `RGBEstricto`, TypeScript no permite modificar directamente ninguno de los elementos después de la inicialización.

```typescript
console.log(colorEstricto[0]); // 255
colorEstricto[1] = 128; // Error: Cannot assign to '0' because it is a read-only property.
```
##### Ejemplo de Error con `push` en una Tupla `readonly`

Una consecuencia directa de la inmutabilidad en las tuplas `readonly` es que no puedes utilizar métodos que mutan el tamaño del array, como `push`, ya que esto contradice su naturaleza de ser inmutable después de la inicialización.

```typescript
const colorEstricto: RGBEstricto = [255, 0, 255];
colorEstricto.push(128); // Error: Property 'push' does not exist on type 'readonly [number, number, number]'.
```

#### Diferencia Clave: Modificación de Elementos

La diferencia fundamental entre una tupla regular y una tupla `readonly` radica en la capacidad de modificar sus elementos después de la inicialización:

- **Tupla Regular**: Permite modificar los elementos individualmente después de la inicialización.
- **Tupla `readonly`**: Prohíbe la modificación de los elementos después de la inicialización para garantizar la inmutabilidad de los datos.



### Matrices de tuplas
#### Definición de Matrices de Tuplas

Para definir una matriz de tuplas en TypeScript, se utiliza una sintaxis donde se especifica el tipo de cada tupla dentro del array. Cada tupla puede contener elementos con tipos diferentes y tiene un número fijo de elementos, al igual que las tuplas individuales.

**Ejemplo básico de matriz de tuplas:**

```typescript
let matriz: [string, number][] = [
    ["Alice", 30],
    ["Bob", 25],
    ["Charlie", 40]
];
```

En este ejemplo, `matriz` es una matriz que contiene tuplas donde cada tupla tiene un string en la primera posición y un número en la segunda posición. Cada tupla dentro de la matriz sigue el patrón definido por `[string, number]`.

#### Acceso a Elementos en Matrices de Tuplas

Para acceder a los elementos de una matriz de tuplas, se utilizan índices tanto para la tupla externa (matriz) como para la tupla interna (elementos individuales dentro de la matriz).

**Ejemplo de acceso a elementos en una matriz de tuplas:**

```typescript
console.log(matriz[0]);       // Output: ["Alice", 30]
console.log(matriz[1][0]);    // Output: "Bob"
console.log(matriz[2][1]);    // Output: 40
```

En el primer `console.log`, se obtiene la primera tupla completa (`["Alice", 30]`). En el segundo `console.log`, se accede al primer elemento (`"Bob"`) de la segunda tupla dentro de la matriz. En el tercer `console.log`, se accede al segundo elemento (`40`) de la tercera tupla dentro de la matriz.



#### Restricciones y Beneficios de las Matrices de Tuplas

- **Tipado estático y estructura definida**: TypeScript garantiza que cada elemento dentro de una matriz de tuplas tenga el tipo correcto y que la estructura de la matriz (número de elementos y tipos) se mantenga coherente en tiempo de compilación.

- **Versatilidad en la representación de datos**: Las matrices de tuplas son útiles cuando se necesitan colecciones ordenadas de datos donde cada elemento tiene una estructura específica y conocida de antemano, como en el caso de registros con campos distintos pero definidos.

- **Mejora en la claridad y mantenibilidad**: Al utilizar matrices de tuplas, se mejora la claridad del código al definir explícitamente la estructura de los datos y se facilita la mantenibilidad al evitar errores relacionados con tipos de datos incorrectos o inesperados.

