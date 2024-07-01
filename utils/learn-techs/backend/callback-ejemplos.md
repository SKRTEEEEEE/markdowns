# Funciones callback principales

Perfecto, vamos a crear una sección sobre funciones `debounce`. Las funciones `debounce` son útiles para limitar la frecuencia con la que una función puede ejecutarse, especialmente útiles en situaciones como manejo de eventos de scroll, redimensionamiento de ventana, o cualquier interacción donde la ejecución repetida pueda causar problemas de rendimiento.

## Funciones debounce

Las funciones `debounce` son una técnica para controlar cuántas veces se permite que una función se ejecute en un período de tiempo determinado. Esto es especialmente útil para mejorar el rendimiento y evitar llamadas innecesarias a funciones que pueden ser costosas en términos de recursos.

### Introducción

Cuando se utiliza `debounce`, se asegura que la función en cuestión solo se ejecute después de que haya pasado un cierto período de tiempo sin que se haya llamado a la función nuevamente. Esto es particularmente útil en escenarios como la búsqueda en tiempo real o la gestión de eventos del usuario que pueden dispararse con frecuencia.

### Ejemplos

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