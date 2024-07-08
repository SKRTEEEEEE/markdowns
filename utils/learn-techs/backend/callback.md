
# Funciones callback

## Introducción

Las funciones callback son funciones que se pasan como argumentos a otras funciones y se ejecutan después de que se complete una operación. Son fundamentales en JavaScript y TypeScript para manejar operaciones asíncronas, como eventos, temporizadores, y solicitudes de red.

### ¿Por qué son importantes las funciones callback?

1. **Asincronía**: Permiten que el código siga ejecutándose mientras se espera que se completen operaciones como solicitudes HTTP.
2. **Modularidad**: Facilitan la creación de código reutilizable y más fácil de mantener.
3. **Manejo de eventos**: Son esenciales para responder a eventos del usuario, como clics de botón o entradas de teclado.

## Ejemplos

### Ejemplo en JavaScript

Supongamos que queremos simular una operación asíncrona como una solicitud a un servidor. Usaremos `setTimeout` para esto.

```javascript
function fetchData(callback) {
  setTimeout(() => {
    const data = { name: 'John Doe', age: 30 };
    callback(data);
  }, 2000);
}

function displayData(data) {
  console.log('Fetched Data:', data);
}

fetchData(displayData);
```

En este ejemplo, `fetchData` acepta una función `callback` que se llama cuando los datos están disponibles. `displayData` es la función callback que maneja los datos.

### Ejemplo en TypeScript

El mismo ejemplo se puede escribir en TypeScript con tipos más específicos.

```typescript
type Data = { name: string; age: number };

function fetchData(callback: (data: Data) => void): void {
  setTimeout(() => {
    const data: Data = { name: 'John Doe', age: 30 };
    callback(data);
  }, 2000);
}

function displayData(data: Data): void {
  console.log('Fetched Data:', data);
}

fetchData(displayData);
```

En TypeScript, definimos un tipo `Data` para asegurar que nuestra función callback recibe el tipo correcto de datos.

## Decorador Unario

El decorador unario es una función que transforma cualquier función dada en una función unaria, es decir, una función que toma un solo argumento. Esto es útil cuando queremos adaptar funciones que normalmente toman más de un argumento para que funcionen adecuadamente con funciones de orden superior como `map`, `filter`, `reduce`, entre otras.

### Implementación del Decorador Unario

Veamos la implementación básica del decorador unario en JavaScript:

```javascript
const unary = (fn) => {
  return (...args) => fn(args[0]);
};
```

Esta función `unary` toma una función `fn` y devuelve una nueva función que asegura que `fn` solo reciba el primer argumento pasado.

### Ejemplo de Uso

Vamos a aplicar el decorador unario al ejemplo anterior de convertir un array de strings en un array de números usando `map` y `parseInt`.

#### JavaScript

```javascript
const unary = (fn) => {
  return (...args) => fn(args[0]);
};

const parseAndMap = ["1", "2", "3"].map(unary(parseInt));
console.log(parseAndMap); // [1, 2, 3]
```

En este ejemplo, `unary(parseInt)` asegura que `parseInt` solo reciba el primer argumento de `map`, que es el elemento actual del array.

#### TypeScript

En TypeScript, podemos definir tipos explícitos para asegurar la correcta tipificación de nuestras funciones.

```typescript
const unary = <T, R>(fn: (arg: T) => R) => {
  return (args: T[]) => fn(args[0]);
};

const parseAndMap: number[] = ["1", "2", "3"].map(unary(parseInt));
console.log(parseAndMap); // [1, 2, 3]
```

Aquí, `<T, R>` especifica los tipos de entrada y salida de la función `fn`, asegurando que el tipo de `parseAndMap` sea `number[]`.

## Funciones de Orden Superior y High Order Components (HOC) en React

### Relación con Funciones de Orden Superior (HOF)

Las funciones de orden superior son funciones que toman una o más funciones como argumentos y/o devuelven una función como resultado. En el contexto de JavaScript y TypeScript, son fundamentales para manejar abstracciones complejas y promover la reutilización de código.

### High Order Components (HOC) en React

En React, un HOC es una función que toma un componente y devuelve un nuevo componente con propiedades o funcionalidades adicionales. Es una técnica poderosa para la composición de componentes y la lógica compartida en la interfaz de usuario.

#### Ejemplo de Uso de HOC en React

Aquí hay un ejemplo simplificado de cómo usar un HOC en React con el componente `AutoSizer` de la biblioteca `react-virtualized`:

```jsx
import React from 'react';
import { AutoSizer } from 'react-virtualized';
import StudentTableComponent from './StudentTableComponent';

class StudentsPage extends React.Component {
  render() {
    return (
      <div>
        <h1>Students</h1>
        <AutoSizer disableHeight={true}>
          {({ width }) => <StudentTableComponent width={width} studentList={this.props.studentList} />}
        </AutoSizer>
        <a href="/dashboard">Go back to dashboard</a>
      </div>
    );
  }
}

export default StudentsPage;
```

En este ejemplo:

- `AutoSizer` es un HOC que toma un componente hijo (`StudentTableComponent`) y le proporciona el ancho disponible para renderizarse.
- La función pasada a `AutoSizer` recibe un objeto con propiedades proporcionadas por `AutoSizer`, como `width`, que se utiliza para ajustar el tamaño del componente `StudentTableComponent`.

### Aplicaciones de los HOC

- **Reutilización de lógica**: Pueden encapsular lógica común, como la manipulación de datos o la gestión de estado, para ser utilizada por varios componentes.
- **Enriquecimiento de componentes**: Agregan propiedades o comportamientos adicionales a los componentes existentes sin modificar su implementación original.
- **Composición flexible**: Facilitan la composición de componentes complejos a partir de componentes más simples.

En resumen, tanto los decoradores unarios como las funciones de orden superior y los HOC en React son herramientas poderosas que facilitan la composición y la reutilización de código en JavaScript y TypeScript, promoviendo un código más modular y mantenible.

Claro, voy a expandir la sección sobre currying, explorando más en profundidad qué es, cómo funciona, por qué es útil y proporcionando ejemplos tanto en JavaScript como en TypeScript.

## Currying

El currying es una técnica en programación funcional donde una función que toma varios argumentos se transforma en una secuencia de funciones que toman un solo argumento. Esto permite una mayor flexibilidad en la aplicación parcial de funciones y la composición de funciones.

### Ejemplo Introductorio en JavaScript

Veamos un ejemplo sencillo de cómo funciona el currying en JavaScript:

```javascript
// Función no currificada
function add(a, b) {
  return a + b;
}

console.log(add(2, 3)); // 5

// Función currificada
function curryAdd(a) {
  return function(b) {
    return a + b;
  };
}

const add2 = curryAdd(2);
console.log(add2(3)); // 5
```

En este ejemplo:

- `add` es una función tradicional que toma dos argumentos y devuelve su suma.
- `curryAdd` es una función que toma un primer argumento `a` y devuelve una función que toma un segundo argumento `b` y retorna la suma de `a + b`.
- Al llamar a `curryAdd(2)`, obtenemos una nueva función `add2` que suma `2` a cualquier número pasado como argumento.

### Ejemplo en TypeScript

En TypeScript, podemos definir tipos específicos para cada argumento y el valor de retorno de nuestras funciones curried.

```typescript
// Función currificada en TypeScript
function curryMultiply(a: number) {
  return function(b: number): number {
    return a * b;
  };
}

const multiplyBy2 = curryMultiply(2);
console.log(multiplyBy2(3)); // 6
```

Aquí, `curryMultiply` toma un argumento `a` de tipo `number` y devuelve una función que toma un argumento `b` de tipo `number`, garantizando que la multiplicación se realice correctamente.

### Ventajas del Currying

- **Aplicación parcial**: Permite aplicar una función a algunos de sus argumentos y obtener una nueva función que espera los argumentos restantes.
- **Composición de funciones**: Facilita la composición de funciones al encadenar funciones más pequeñas.
- **Reutilización de código**: Promueve la reutilización de funciones al crear funciones más específicas a partir de funciones más generales.

### Ejemplo de Composición con Currying

El currying es particularmente útil cuando queremos crear funciones compuestas a partir de funciones más pequeñas. Por ejemplo, podemos usar currying para crear una función que calcule el área de diferentes formas geométricas:

```javascript
function curryArea(shape) {
  return function(dim1) {
    return function(dim2) {
      if (shape === 'rectangle') {
        return dim1 * dim2;
      } else if (shape === 'square') {
        return dim1 * dim1;
      } else if (shape === 'circle') {
        return Math.PI * dim1 * dim1;
      } else {
        throw new Error('Unsupported shape');
      }
    };
  };
}

const rectangleArea = curryArea('rectangle');
const squareArea = curryArea('square');
const circleArea = curryArea('circle');

console.log(rectangleArea(3)(4)); // 12
console.log(squareArea(5)); // 25
console.log(circleArea(2)); // ~12.566
```

### Currying en Bibliotecas Funcionales

En bibliotecas como Lodash y Ramda, el currying está integrado y facilita la manipulación de datos y la creación de funciones compuestas de manera más elegante y concisa.

En resumen, el currying es una técnica poderosa en programación funcional que nos permite crear funciones más específicas a partir de funciones más generales, facilitando la aplicación parcial y la composición de funciones. Es especialmente útil cuando se trabaja con funciones de orden superior y se desea mejorar la modularidad y la reutilización del código.
Por supuesto, vamos a reestructurar la sección para profundizar en el uso de Ramda, enfocándonos en las funciones más utilizadas para manipulación de arrays y objetos, así como proporcionando ejemplos más simples antes de abordar la validación de datos.

## Uso de Ramda para Operaciones Funcionales

Ramda es una biblioteca funcional para JavaScript que proporciona muchas funciones útiles para trabajar con datos de manera funcional. A continuación, exploraremos algunas de las funciones más utilizadas de Ramda y cómo pueden aplicarse en ejemplos concretos.

### Instalación

Para usar Ramda en un proyecto JavaScript, puedes instalarlo a través de npm:

```bash
npm install ramda
```

### Ejemplos de Uso con Ramda

#### 1. Composición de Funciones

Ramda facilita la composición de funciones con `R.compose` o `R.pipe`, permitiendo ejecutar funciones en secuencia.

```javascript
const R = require('ramda');

// Ejemplo de composición de funciones
const square = (x) => x * x;
const addOne = (x) => x + 1;

const squareAndAddOne = R.compose(addOne, square);

console.log(squareAndAddOne(3)); // Output: 10 (square(3) + 1)
```

#### 2. Manipulación de Arrays

Ramda proporciona funciones para manipular y transformar arrays de manera funcional, como `R.map`, `R.filter`, `R.reduce`, entre otras.

```javascript
const R = require('ramda');

const numbers = [1, 2, 3, 4, 5];

// Ejemplo de uso de R.map y R.filter
const doubleEvens = R.pipe(
  R.filter((x) => x % 2 === 0), // Filtrar números pares
  R.map((x) => x * 2) // Duplicar cada número par
);

console.log(doubleEvens(numbers)); // Output: [4, 8]
```

#### 3. Trabajo con Objetos

Ramda ofrece funciones para trabajar con objetos de manera funcional, facilitando la manipulación inmutable de propiedades de objetos.

- `R.prop`: Obtiene el valor de una propiedad específica de un objeto.
- `R.assoc`: Asocia un valor a una propiedad específica de un objeto.
- `R.pick`: Retorna un nuevo objeto con las propiedades seleccionadas de un objeto dado.

```javascript
const R = require('ramda');

const user = {
  name: 'Alice',
  age: 30,
  address: {
    city: 'Wonderland',
    country: 'Neverland'
  }
};

// Ejemplo de uso de R.pick
const userInfo = R.pick(['name', 'age'], user);
console.log(userInfo); // Output: { name: 'Alice', age: 30 }
```

#### 4. Validación de Datos

Ramda ofrece funciones para validar datos y componer validadores de manera funcional y declarativa.

```javascript
const R = require('ramda');

// Ejemplo de validación de datos con Ramda
const isAdult = (age) => age >= 18;
const validateAge = R.ifElse(
  R.compose(R.is(Number), R.prop('age')),
  R.ifElse(R.compose(isAdult, R.prop('age'))),
  () => 'Invalid age'
);

const person1 = { name: 'Alice', age: 25 };
const person2 = { name: 'Bob', age: 'not a number' };

console.log(validateAge(person1)); // Output: true
console.log(validateAge(person2)); // Output: 'Invalid age'
```
## `.apply()`

El método `.apply()` en JavaScript es una función incorporada que se utiliza para llamar a una función con un valor `this` y un array o un objeto iterable como argumentos. Básicamente, te permite llamar a una función con un contexto específico y pasar un array (o un objeto iterable convertido a array) como sus argumentos.

### Sintaxis

```javascript
func.apply(thisArg, [argsArray])
```

- `func`: La función a la cual se va a llamar.
- `thisArg`: El valor de `this` dentro de la función `func` cuando se ejecuta.
- `argsArray`: Un array o un objeto iterable cuyos elementos serán pasados como argumentos a `func`.

### Funcionamiento

Cuando utilizas `.apply()`, la función `func` se ejecuta con el valor de `this` establecido como `thisArg`. Esto es útil cuando quieres ejecutar una función en un contexto específico que no es el contexto habitual donde se definía la función.

El segundo argumento, `argsArray`, es opcional. Si se proporciona, los elementos de este array (o iterable) se pasan como argumentos a la función `func`. Si no se proporciona, la función se llama sin argumentos.

### Ejemplos de Uso

#### Ejemplo 1: Usar `.apply()` para llamar a una función con un array de argumentos

```javascript
function sum(a, b) {
  return a + b;
}

const args = [1, 2];

const result = sum.apply(null, args);
console.log(result); // Output: 3
```

En este ejemplo:
- `sum` es una función que toma dos argumentos `a` y `b` y devuelve su suma.
- `args` es un array `[1, 2]`.
- `sum.apply(null, args)` llama a la función `sum` con `null` como contexto (`this`), y los elementos de `args` (que son `1` y `2`) se pasan como los argumentos `a` y `b`, respectivamente.

#### Ejemplo 2: Usar `.apply()` para ejecutar métodos de objetos con un array de argumentos

```javascript
const obj = {
  name: 'John',
  greet: function(greeting) {
    return `${greeting}, ${this.name}!`;
  }
};

const args = ['Hello'];

const result = obj.greet.apply(obj, args);
console.log(result); // Output: Hello, John!
```

En este ejemplo:
- `obj` es un objeto que tiene una propiedad `name` y un método `greet`.
- `args` es un array con el string `'Hello'`.
- `obj.greet.apply(obj, args)` llama al método `greet` del objeto `obj`, con `obj` como contexto (`this`) y `'Hello'` como argumento `greeting`.

