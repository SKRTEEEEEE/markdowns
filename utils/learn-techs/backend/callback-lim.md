# Funciones callback "limitadoras"

En esta sección vamos a profundizar en dos tipos de funciones callback muy utilizadas para controlar la frecuencia de ejecución de funciones: debounce y throttle. Estas funciones son fundamentales en el desarrollo de aplicaciones web y en entornos donde la optimización del rendimiento es crucial.

**Debounce** se centra en asegurar que una función no se ejecute hasta que haya pasado un cierto período de tiempo desde la última vez que fue invocada. Es ideal para manejar eventos que pueden dispararse frecuentemente, como la escritura en campos de búsqueda o el desplazamiento en páginas web.

**Throttle**, por otro lado, limita la frecuencia con la que una función puede ser ejecutada durante un intervalo de tiempo específico. Esto es útil para controlar la cantidad de veces que una función puede ser llamada en respuesta a eventos repetitivos, como el redimensionamiento de la ventana del navegador o la emisión de eventos de scroll.

A lo largo de esta sección, exploraremos cómo implementar y utilizar estas funciones de manera efectiva en diferentes contextos de desarrollo, tanto en el frontend como en el backend, para mejorar el rendimiento y la experiencia del usuario en nuestras aplicaciones.


## Funciones debounce

Las funciones `debounce` son una técnica para controlar cuántas veces se permite que una función se ejecute en un período de tiempo determinado. Esto es especialmente útil para mejorar el rendimiento y evitar llamadas innecesarias a funciones que pueden ser costosas en términos de recursos.

### Introducción

Cuando se utiliza `debounce`, se asegura que la función en cuestión solo se ejecute después de que haya pasado un cierto período de tiempo sin que se haya llamado a la función nuevamente. Esto es particularmente útil en escenarios como la búsqueda en tiempo real o la gestión de eventos del usuario que pueden dispararse con frecuencia.


### Función `debounce`

La función `debounce` tomará una función (`func`) y un tiempo de espera (`wait`). Retrasará la ejecución de `func` hasta que hayan pasado `wait` milisegundos desde la última vez que se llamó.

```javascript
function debounce(func, wait) {
  let timeout;

  return function(...args) {
    clearTimeout(timeout);
    timeout = setTimeout(() => func.apply(this, args), wait);
  };
}
```

#### Uso de la Función `debounce`

Para demostrar cómo funciona, vamos a utilizarla con un ejemplo práctico. Vamos a crear una función que se ejecutará cuando el usuario redimensione la ventana del navegador, pero utilizaremos `debounce` para asegurarnos de que no se llame demasiadas veces.

##### Ejemplo HTML

Crea un archivo HTML para probar nuestra función:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Debounce Example</title>
</head>
<body>
  <h1>Resize the window and check the console</h1>
  <script src="debounce.js"></script>
  <script>
    function handleResize() {
      console.log('Window resized:', new Date());
    }

    const debouncedResize = debounce(handleResize, 500);

    window.addEventListener('resize', debouncedResize);
  </script>
</body>
</html>
```

##### Archivo `debounce.js`

Crea el archivo `debounce.js` con el siguiente contenido:

```javascript
function debounce(func, wait) {
  let timeout;

  return function(...args) {
    clearTimeout(timeout);
    timeout = setTimeout(() => func.apply(this, args), wait);
  };
}
```

#### Explicación

1. **Función `debounce`**:
   - **`timeout`**: Variable para almacenar el ID del temporizador.
   - **`return function(...args)`**: Retornamos una nueva función que tomará los argumentos.
   - **`clearTimeout(timeout)`**: Cancelamos cualquier temporizador en curso.
   - **`timeout = setTimeout(() => func.apply(this, args), wait)`**: Iniciamos un nuevo temporizador para llamar a `func` después de `wait` milisegundos, aplicando el contexto (`this`) y los argumentos (`args`) correctos.

2. **Uso de la Función `debounce`**:
   - Creamos una función `handleResize` que se llama cada vez que se redimensiona la ventana.
   - Creamos una versión "debounced" de `handleResize` llamada `debouncedResize` con un retraso de 500 milisegundos.
   - Añadimos un event listener al evento `resize` de la ventana que llama a `debouncedResize`.

Cuando redimensionas la ventana, la función `handleResize` no se llama inmediatamente sino después de 500 milisegundos desde la última vez que se redimensionó la ventana. Esto evita llamadas excesivas a la función durante el redimensionamiento continuo.

Este es un ejemplo simple y efectivo de cómo usar una función `debounce` en JavaScript.

### Otros Ejemplos

#### Ejemplo en JavaScript

```javascript
function debounce(func, delay) {
  let timer;
  return function() {
    const context = this;
    const args = arguments;
    clearTimeout(timer);
    timer = setTimeout(() => {
      func.apply(context, args);
    }, delay);
  };
}

// Ejemplo de uso
const processSearch = debounce(function(query) {
  // Simular búsqueda con la cadena de consulta
  console.log(`Buscando: ${query}`);
}, 500);

// Simulación de entrada de usuario
processSearch('JavaScript');
processSearch('React');
processSearch('Node.js');

// Solo se imprimirá "Buscando: Node.js" después de 500ms desde la última llamada
```

En este ejemplo:

- La función `debounce` toma una función `func` y un tiempo de retardo `delay`.
- Dentro de la función devuelta (closure), se utiliza `setTimeout` para asegurar que `func` solo se ejecute después de que haya pasado el tiempo especificado `delay` desde la última llamada.
- Esto permite manejar llamadas repetidas a `processSearch` y ejecutar la búsqueda solo cuando el usuario haya dejado de escribir durante 500ms.

#### Ejemplo en TypeScript

```typescript
function debounce<T extends (...args: any[]) => void>(func: T, delay: number) {
  let timer: NodeJS.Timeout;
  return function(this: ThisParameterType<T>, ...args: Parameters<T>) {
    const context = this;
    clearTimeout(timer);
    timer = setTimeout(() => {
      func.apply(context, args);
    }, delay);
  };
}

// Ejemplo de uso
const processInput = debounce((input: string) => {
  console.log(`Input procesado: ${input}`);
}, 300);

// Simulación de entrada de usuario
processInput('Primero');
processInput('Segundo');
processInput('Tercero');

// Solo se imprimirá "Input procesado: Tercero" después de 300ms desde la última llamada
```

En TypeScript, utilizamos genéricos para asegurar que `debounce` funcione con cualquier tipo de función y sus argumentos. Esto mejora la seguridad de tipos y la robustez del código.

### Por qué usar `debounce`

- **Mejora del rendimiento**: Evita la ejecución excesiva de funciones, lo que puede mejorar significativamente el rendimiento de la aplicación.
- **Control de eventos**: Útil para controlar eventos que pueden dispararse frecuentemente, como eventos de scroll o redimensionamiento de ventana.
- **Manejo de interacciones del usuario**: Ayuda a manejar interacciones del usuario como búsquedas en tiempo real o autocompletados, donde la respuesta solo debe darse después de que el usuario haya dejado de interactuar temporalmente.

En resumen, las funciones `debounce` son una herramienta esencial en el kit de herramientas de cualquier desarrollador para mejorar la responsividad y el rendimiento de aplicaciones web. Permiten controlar con precisión la frecuencia de ejecución de funciones basadas en eventos, asegurando una experiencia de usuario más fluida y eficiente.




### `apply()` en función `debounce()`

Recordemos primero la implementación básica de una función `debounce` en JavaScript:

```javascript
function debounce(func, wait) {
  let timeout;

  return function(...args) {
    clearTimeout(timeout);
    timeout = setTimeout(() => {
      func.apply(this, args);
    }, wait);
  };
}
```

#### Explicación de `.apply()` en `debounce`

En el contexto de la función `debounce`, `.apply()` se usa para asegurar que la función `func` se ejecute con el contexto (`this`) adecuado y con los argumentos correctos después de que pase el período de espera `wait`.

##### Por qué usar `.apply()` en `debounce`:

1. **Contexto (`this`)**: En JavaScript, el valor de `this` dentro de una función puede variar dependiendo de cómo se llama la función. Cuando usamos `.apply()`, podemos especificar explícitamente el contexto en el cual queremos que se ejecute la función `func`.

2. **Argumentos**: `.apply()` nos permite pasar un array de argumentos (`args` en este caso) a la función `func`. Esto es útil porque `debounce` puede ser utilizado con funciones que aceptan diferentes números y tipos de argumentos.

##### Ejemplo de Uso Simple

Supongamos que queremos crear una función `handleInput` que se debounce cada vez que se produce un evento de `input` en un campo de texto. Vamos a usar `.apply()` para asegurarnos de que `handleInput` tenga el contexto correcto y reciba los argumentos adecuados (por ejemplo, el valor del campo de texto).

```javascript
// Función que se ejecuta cuando hay un cambio en el input
function handleInput(event) {
  console.log('Input value:', event.target.value);
}

// Aplicamos debounce a handleInput con un retraso de 500ms
const debouncedHandleInput = debounce(handleInput, 500);

// Añadimos un event listener al input para llamar a debouncedHandleInput
const inputField = document.getElementById('inputField');
inputField.addEventListener('input', function(event) {
  debouncedHandleInput.apply(this, [event]); // this será el elemento input
});
```

En este ejemplo:
- `handleInput` es la función que queremos debouncear. Toma un evento (`event`) como argumento, que contendrá información sobre el cambio en el input.
- `debouncedHandleInput` es la versión debounced de `handleInput`.
- Usamos `.apply(this, [event])` dentro del event listener del input. Esto asegura que cuando se ejecute `debouncedHandleInput`, se ejecute con el contexto (`this`) del elemento input y el argumento `event` que contiene el valor actual del input.

¡Claro! Vamos a crear un ejemplo de la función `debounce` sin usar el operador de propagación (`...args`). En su lugar, utilizaremos `arguments`, que es una variable especial en JavaScript que contiene todos los argumentos pasados a una función.

##### Ejemplo `debounce` sin `...args`

```javascript
function debounce(func, wait) {
  let timeout;

  return function() {
    let context = this; // Capturamos el contexto actual
    let args = arguments; // Capturamos los argumentos pasados a la función debounce

    clearTimeout(timeout);

    timeout = setTimeout(function() {
      func.apply(context, args); // Llamamos a func con el contexto y los argumentos capturados
    }, wait);
  };
}
```


En esta versión:

- `arguments`: Es un objeto similar a un array que contiene todos los argumentos pasados a la función `debounce`. En lugar de usar `...args` para capturar los argumentos como un array, usamos `arguments`, que es una forma más antigua pero igualmente efectiva.

- `context`: Guardamos el contexto (`this`) actual en una variable `context` para asegurarnos de que la función `func` se ejecute en el contexto correcto cuando se invoque.

- `func.apply(context, args)`: Usamos `.apply()` para llamar a la función `func` con el contexto `context` y los argumentos `args`. Esto garantiza que `func` se ejecute con los argumentos correctos después de que haya pasado el tiempo de espera `wait`.

**Ejemplo de Uso**

Vamos a crear un ejemplo similar al anterior, donde debounceamos una función que muestra un mensaje cuando se realiza un clic en un botón.

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Debounce Example</title>
</head>
<body>
  <button id="clickButton">Click Me!</button>
  <script>
    // Función que se ejecuta cuando se hace clic en el botón
    function handleClick(event) {
      console.log('Button clicked:', event.target.textContent);
    }

    // Aplicamos debounce a handleClick con un retraso de 500ms
    const debouncedClickHandler = debounce(handleClick, 500);

    // Añadimos un event listener al botón para llamar a debouncedClickHandler
    const clickButton = document.getElementById('clickButton');
    clickButton.addEventListener('click', function(event) {
      debouncedClickHandler.apply(this, arguments); // this será el botón y arguments será el evento
    });
  </script>
</body>
</html>
```

En este ejemplo:

- `handleClick`: Es la función que queremos debouncear. Toma un evento (`event`) como argumento, que contiene información sobre el clic en el botón.

- `debouncedClickHandler`: Es la versión debounced de `handleClick`.

- `debouncedClickHandler.apply(this, arguments)`: Llamamos a `debouncedClickHandler` con el contexto (`this`) del botón y el argumento `arguments` que contiene el evento clic. Esto asegura que cuando se ejecute `debouncedClickHandler`, se haga con el contexto correcto y los argumentos adecuados.

## `debounce()` vs `throttle()`

La diferencia entre `debounce` y `throttle` radica en cómo limitan la cantidad de veces que una función puede ser ejecutada en un período de tiempo:

### Debounce

- **Definición**: La función `debounce` retrasa la ejecución de la función hasta después de un período de inactividad. Esto significa que la función solo se ejecutará una vez después de que no haya sido llamada durante un tiempo específico.
- **Uso típico**: Ideal para situaciones en las que deseas que una función se ejecute solo después de que una serie de eventos haya terminado, como en los casos de autocompletado de búsqueda o redimensionamiento de ventanas.
- **Comportamiento**: Si se llama repetidamente a la función debounced dentro del período de espera, el temporizador se reinicia cada vez y la función solo se ejecuta una vez al final del período de espera.

### Throttle

- **Definición**: La función `throttle` garantiza que una función se ejecuta no más de una vez en un período de tiempo específico. Esto significa que la función se ejecutará a intervalos regulares durante el período de tiempo.
- **Uso típico**: Ideal para situaciones en las que deseas limitar la cantidad de veces que una función se ejecuta continuamente, como en el caso del desplazamiento de la página, arrastrar y soltar, o eventos de clic.
- **Comportamiento**: Si se llama repetidamente a la función throttled, solo se ejecutará una vez cada período de tiempo especificado.

### Ejemplos

#### Debounce

```typescript
function debounce(func: Function, wait: number) {
  let timeout: ReturnType<typeof setTimeout>;
  
  return function(...args: any[]) {
    clearTimeout(timeout);
    timeout = setTimeout(() => func.apply(this, args), wait);
  };
}

// Ejemplo de uso:
const debouncedFunc = debounce(() => console.log('Debounced!'), 1000);

debouncedFunc(); // Llamada inicial
debouncedFunc(); // Se reinicia el temporizador
debouncedFunc(); // Se reinicia el temporizador
// 'Debounced!' se registrará solo una vez, 1 segundo después de la última llamada
```

#### Throttle

```typescript
function throttle(func: Function, limit: number) {
  let inThrottle: boolean;
  
  return function(this: any, ...args: any[]) {
    if (!inThrottle) {
      func.apply(this, args);
      inThrottle = true;
      setTimeout(() => inThrottle = false, limit);
    }
  };
}

// Ejemplo de uso:
const throttledFunc = throttle(() => console.log('Throttled!'), 1000);

throttledFunc(); // Se ejecuta inmediatamente
throttledFunc(); // Ignorado
throttledFunc(); // Ignorado
// 'Throttled!' se registrará solo una vez cada segundo
```

### Comparación

- **Debounce**: Ejecuta la función solo una vez después de que las llamadas hayan cesado por un tiempo específico.
- **Throttle**: Ejecuta la función a intervalos regulares durante un período de tiempo, limitando la cantidad de ejecuciones en ese período.

En resumen, usa `debounce` cuando desees que una función se ejecute solo después de un período de inactividad y `throttle` cuando desees limitar la frecuencia de ejecución de una función a intervalos regulares.

¡Claro! Vamos a hablar sobre la función throttle.

## Función throttle

### Introducción
La función throttle es una técnica utilizada en programación para limitar la frecuencia con la que una función puede ser ejecutada. Esto es útil cuando queremos asegurar que una función no se ejecute más de una vez en un período de tiempo específico, aunque sea llamada múltiples veces.

#### Ventajas y desventajas
**Ventajas:**
- Controla la frecuencia de ejecución de una función.
- Útil para mejorar el rendimiento al evitar llamadas excesivas.

**Inconvenientes:**
- Puede introducir un pequeño retraso en la ejecución de la función.
- Puede ser complejo de implementar correctamente en algunos casos.

#### Cuándo usar
- Cuando se necesita limitar la frecuencia de ejecución de una función en respuesta a eventos como el scroll, resize, o pulsaciones de teclado para mejorar el rendimiento y evitar cargas innecesarias.

### Ejemplos prácticos "cliente"

#### Ejemplo JS **Incompleto**
Un ejemplo simple, incompleto, en JavaScript para entender el throttle:

```javascript
function throttle(func, delay) {
  let lastExecuted = 0;
  return function() {
    const now = Date.now();
    if (now - lastExecuted > delay) {
      func.apply(this, arguments);
      lastExecuted = now;
    }
  };
}

// Uso del throttle
function handleScroll() {
  console.log("Scrolled!");
}

const throttledScroll = throttle(handleScroll, 200);

window.addEventListener("scroll", throttledScroll);
```

#### Ejemplo TypeScript **incompleto**
Un ejemplo simple, incompleto(no funciona al 100%), en TypeScript para entender el throttle:

```typescript
function throttle(func: Function, delay: number) {
  let lastExecuted = 0;
  return function(this: any) {
    const now = Date.now();
    if (now - lastExecuted > delay) {
      func.apply(this, arguments);
      lastExecuted = now;
    }
  };
}

// Uso del throttle
function handleScroll() {
  console.log("Scrolled!");
}

const throttledScroll = throttle(handleScroll, 200);

window.addEventListener("scroll", throttledScroll);
```

**En estos primeros ejemplos, la funcion throttle nos podria dar error ya que:**
- `● throttle › should call the callback again after the throttle period`
- `● throttle function › should call the function twice if delay has passed`

#### Ejemplo JS estándar
Un ejemplo más estándar en JavaScript usando un enfoque más completo:

```javascript
function throttle(func, delay) {
  let last = 0;
  return (...args) => {
    const now = Date.now();
    if (now - last < delay) return
    last = now;
    return func(...args);
  };
}

// Uso del throttle
function handleResize() {
  console.log("Resized!");
}

const throttledResize = throttle(handleResize, 300);

window.addEventListener("resize", throttledResize);
```

#### Ejemplo TypeScript estándar
Un ejemplo estándar en TypeScript usando un enfoque más completo:

```typescript
function throttle(func: FuncType, delay: number) {
  let last = 0;
  return (...args: any[]) => {
    const now = Date.now();
    if (now - last < delay) return
    last = now;
    return func(...args);
  };
}
// Uso del throttle
function handleResize() {
  console.log("Resized!");
}

const throttledResize = throttle(handleResize, 300);

window.addEventListener("resize", throttledResize);
```

¡Entendido! Vamos a centrarnos en ejemplos prácticos de la función throttle en Node.js, adaptados para su uso en el servidor.

### Uso en Node.js

#### Introducción
La función throttle en Node.js puede ser útil para manejar eventos intensivos o llamadas a funciones que necesitan ser limitadas en su frecuencia de ejecución, especialmente en aplicaciones que manejan muchas peticiones concurrentes.

##### Ventajas y desventajas
**Ventajas:**
- Controla la frecuencia de ejecución de funciones en entornos de servidor.
- Útil para evitar sobrecargas en el servidor al limitar la velocidad de respuesta.

**Inconvenientes:**
- Puede añadir complejidad y requerir una gestión cuidadosa de los contextos de ejecución.
- La implementación incorrecta puede afectar el rendimiento.

##### Cuándo usar
- En Node.js, throttle es especialmente útil para manejar eventos intensivos como escritura en bases de datos, acceso a API externas, o procesamiento de datos en tiempo real, donde la frecuencia de ejecución debe ser controlada para evitar problemas de rendimiento.

#### Ejemplo Node.js simple
Un ejemplo simple en Node.js para entender el throttle:

```javascript
// Ejemplo de throttle en Node.js

// Simulación de una función que hace una operación intensiva
function intensiveOperation(param) {
  console.log(`Executing intensive operation with param: ${param}`);
}

// Función throttle para limitar la ejecución de intensiveOperation a una vez cada 500ms
function throttle(func, delay) {
  let last = 0;
  return (...args) => {
    const now = Date.now();
    if (now - last < delay) return
    last = now;
    return func(...args);
  };
}

// Uso del throttle en Node.js
const throttledOperation = throttle(intensiveOperation, 500);

// Simulación de llamadas intensivas (ejemplo: peticiones HTTP)
function simulateRequests() {
  for (let i = 1; i <= 5; i++) {
    setTimeout(() => {
      throttledOperation(i);
    }, i * 100); // Simular llamadas cada 100ms
  }
}

simulateRequests();
```

En este ejemplo, `throttle` se utiliza para limitar la ejecución de `intensiveOperation` a una vez cada 500ms. Esto puede ser útil, por ejemplo, para controlar la frecuencia con la que se realizan operaciones intensivas en una aplicación Node.js, como acceso a bases de datos o llamadas a API externas.

#### Ejemplo TypeScript en Node.js
Un ejemplo en TypeScript para usar throttle en Node.js:

```typescript
// Ejemplo de throttle en Node.js con TypeScript

// Simulación de una función que hace una operación intensiva
function intensiveOperation(param: number) {
  console.log(`Executing intensive operation with param: ${param}`);
}

// Función throttle para limitar la ejecución de intensiveOperation a una vez cada 500ms
function throttle(func: FuncType, delay: number) {
  let last = 0;
  return (...args: any[]) => {
    const now = Date.now();
    if (now - last < delay) return
    last = now;
    return func(...args);
  };
}

// Uso del throttle en Node.js con TypeScript
const throttledOperation = throttle(intensiveOperation, 500);

// Simulación de llamadas intensivas (ejemplo: peticiones HTTP)
function simulateRequests() {
  for (let i = 1; i <= 5; i++) {
    setTimeout(() => {
      throttledOperation(i);
    }, i * 100); // Simular llamadas cada 100ms
  }
}

simulateRequests();
```

Este ejemplo en TypeScript muestra cómo se puede implementar la función `throttle` en Node.js, asegurando que `intensiveOperation` no se ejecute más de una vez cada 500ms, incluso cuando se realizan múltiples llamadas a `throttledOperation`.
Entendido, vamos a crear dos ejemplos adicionales más estándares y optimizados, sin depender directamente de `Date` u otros métodos que puedan afectar la precisión o la complejidad del código.

#### Ejemplo estándar en Node.js

```javascript
// Ejemplo estándar de throttle en Node.js sin usar Date

// Simulación de una función que hace una operación intensiva
function intensiveOperation(param) {
  console.log(`Executing intensive operation with param: ${param}`);
}

// Función throttle para limitar la ejecución de intensiveOperation a una vez cada 500ms
function throttle(func, delay) {
  let throttling = false;
  return function(...args) {
    if (!throttling) {
      func.apply(this, args);
      throttling = true;
      setTimeout(() => {
        throttling = false;
      }, delay);
    }
  };
}

// Uso del throttle en Node.js
const throttledOperation = throttle(intensiveOperation, 500);

// Simulación de llamadas intensivas (ejemplo: peticiones HTTP)
function simulateRequests() {
  for (let i = 1; i <= 5; i++) {
    setTimeout(() => {
      throttledOperation(i);
    }, i * 100); // Simular llamadas cada 100ms
  }
}

simulateRequests();
```

En este ejemplo, `throttle` se implementa utilizando un flag `throttling` para controlar si la función `intensiveOperation` puede ejecutarse o no. Esto evita el uso de `Date` y se basa en un temporizador con `setTimeout` para establecer el tiempo de espera entre ejecuciones.

##### Ejemplo estándar con TypeScript

```typescript
// Ejemplo estándar de throttle en Node.js con TypeScript sin usar Date

// Simulación de una función que hace una operación intensiva
function intensiveOperation(param: number) {
  console.log(`Executing intensive operation with param: ${param}`);
}

// Función throttle para limitar la ejecución de intensiveOperation a una vez cada 500ms
function throttle(func: Function, delay: number) {
  let throttling = false;
  return function(this: any, ...args: any[]) {
    if (!throttling) {
      func.apply(this, args);
      throttling = true;
      setTimeout(() => {
        throttling = false;
      }, delay);
    }
  };
}

// Uso del throttle en Node.js con TypeScript
const throttledOperation = throttle(intensiveOperation, 500);

// Simulación de llamadas intensivas (ejemplo: peticiones HTTP)
function simulateRequests() {
  for (let i = 1; i <= 5; i++) {
    setTimeout(() => {
      throttledOperation(i);
    }, i * 100); // Simular llamadas cada 100ms
  }
}

simulateRequests();
```

Este ejemplo en TypeScript refleja la misma lógica que el ejemplo en JavaScript estándar, utilizando un flag `throttling` y `setTimeout` para implementar el throttle sin depender de `Date`. Esto asegura un comportamiento más predecible y menos propenso a errores relacionados con la gestión del tiempo en aplicaciones Node.js.

