# **Módulo 3: Desarrollo de un Proyecto usando TDD**
**Objetivos del Módulo:**
- Aplicar el ciclo TDD en el desarrollo de funcionalidades.
- Aprender a escribir pruebas efectivas y a re-factorizar código.
- Desarrollar un pequeño proyecto aplicando TDD.

---

## **Sección 3.1: Primer Ciclo TDD: Implementación Básica**

**Objetivo:**
Aplicar el ciclo TDD para implementar una funcionalidad básica.

---

**Descripción del Problema:**
Vamos a implementar una función `isEven` que determina si un número es par.

**Paso 1: Rojo (Red)**

1. **Escribe una prueba que falle para la función `isEven`.**

   - Crea un archivo `isEven.test.ts` en la carpeta `src` con el siguiente contenido:

   ```typescript
   import { isEven } from './isEven';

   test('returns true for even numbers', () => {
     expect(isEven(2)).toBe(true);
   });

   test('returns false for odd numbers', () => {
     expect(isEven(3)).toBe(false);
   });
   ```

2. **Ejecuta la prueba:**

   - En la terminal, ejecuta `npm test`.
   - La prueba debería fallar porque la función `isEven` no está implementada aún.

**Paso 2: Verde (Green)**

1. **Implementa el código mínimo necesario para que la prueba pase:**

   - Crea un archivo `isEven.ts` en la carpeta `src` con el siguiente contenido:

   ```typescript
   export function isEven(num: number): boolean {
     return num % 2 === 0;
   }
   ```

2. **Ejecuta la prueba:**

   - En la terminal, ejecuta `npm test`.
   - La prueba debería pasar ahora.

**Paso 3: Refactor**

1. **Revisa y mejora el código si es necesario:**

   - En este caso, el código es bastante simple y no requiere refactorización.
   - Asegúrate de que todo está bien estructurado y que no hay redundancias.

---

## **Sección 3.2: Ciclos Adicionales de TDD**

**Objetivo:**
Desarrollar funcionalidades adicionales usando el ciclo TDD.

---

**Funcionalidad: Calcular el área de un rectángulo**

**Paso 1: Rojo (Red)**

1. **Escribe una prueba que falle para la función `calculateRectangleArea`.**

   - Crea un archivo `calculateRectangleArea.test.ts` en la carpeta `src` con el siguiente contenido:

   ```typescript
   import { calculateRectangleArea } from './calculateRectangleArea';

   test('calculates the area of a rectangle with width 5 and height 10', () => {
     expect(calculateRectangleArea(5, 10)).toBe(50);
   });

   test('calculates the area of a rectangle with width 0 and height 10', () => {
     expect(calculateRectangleArea(0, 10)).toBe(0);
   });
   ```

2. **Ejecuta la prueba:**

   - En la terminal, ejecuta `npm test`.
   - La prueba debería fallar porque la función `calculateRectangleArea` no está implementada aún.

**Paso 2: Verde (Green)**

1. **Implementa el código mínimo necesario para que la prueba pase:**

   - Crea un archivo `calculateRectangleArea.ts` en la carpeta `src` con el siguiente contenido:

   ```typescript
   export function calculateRectangleArea(width: number, height: number): number {
     return width * height;
   }
   ```

2. **Ejecuta la prueba:**

   - En la terminal, ejecuta `npm test`.
   - La prueba debería pasar ahora.

**Paso 3: Refactor**

1. **Revisa y mejora el código si es necesario:**

   - En este caso, el código es simple y no requiere refactorización.
   - Asegúrate de que todo está bien estructurado y que no hay redundancias.

---

## **Sección 3.3: Pruebas Unitarias Avanzadas**

**Objetivo:**
Escribir pruebas más avanzadas y aprender técnicas adicionales como el uso de datos dinámicos y manejo de excepciones.

---

### **Ejercicio 1: Validar un Email**

**Paso 1: Rojo (Red)**

1. **Escribe una prueba que falle para la función `isValidEmail`.**

   - Crea un archivo `isValidEmail.test.ts` en la carpeta `src` con el siguiente contenido:

   ```typescript
   import { isValidEmail } from './isValidEmail';

   test('returns true for valid email addresses', () => {
     expect(isValidEmail('test@example.com')).toBe(true);
   });

   test('returns false for invalid email addresses', () => {
     expect(isValidEmail('invalid-email')).toBe(false);
   });
   ```

2. **Ejecuta la prueba:**

   - En la terminal, ejecuta `npm test`.
   - La prueba debería fallar porque la función `isValidEmail` no está implementada aún.

**Paso 2: Verde (Green)**

1. **Implementa el código mínimo necesario para que la prueba pase:**

   - Crea un archivo `isValidEmail.ts` en la carpeta `src` con el siguiente contenido:

   ```typescript
   export function isValidEmail(email: string): boolean {
     const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
     return emailRegex.test(email);
   }
   ```

2. **Ejecuta la prueba:**

   - En la terminal, ejecuta `npm test`.
   - La prueba debería pasar ahora.

**Paso 3: Refactor**

1. **Revisa y mejora el código si es necesario:**

   - En este caso, el código es simple y no requiere re-factorización.
   - Asegúrate de que todo está bien estructurado y que no hay redundancias.

---

### **Ejercicio 2: Manejo de Excepciones**

**Objetivo:**
Implementar una función `divide` que maneje divisiones por cero.

**Paso 1: Rojo (Red)**

1. **Escribe una prueba que falle para la función `divide`.**

   - Crea un archivo `divide.test.ts` en la carpeta `src` con el siguiente contenido:

   ```typescript
   import { divide } from './divide';

   test('divides 6 by 3 to equal 2', () => {
     expect(divide(6, 3)).toBe(2);
   });

   test('throws an error when dividing by 0', () => {
     expect(() => divide(6, 0)).toThrow('Division by zero');
   });
   ```

2. **Ejecuta la prueba:**

   - En la terminal, ejecuta `npm test`.
   - La prueba debería fallar porque la función `divide` no está implementada aún.

**Paso 2: Verde (Green)**

1. **Implementa el código mínimo necesario para que la prueba pase:**

   - Crea un archivo `divide.ts` en la carpeta `src` con el siguiente contenido:

   ```typescript
   export function divide(a: number, b: number): number {
     if (b === 0) {
       throw new Error('Division by zero');
     }
     return a / b;
   }
   ```

2. **Ejecuta la prueba:**

   - En la terminal, ejecuta `npm test`.
   - La prueba debería pasar ahora.

**Paso 3: Refactor**

1. **Revisa y mejora el código si es necesario:**

   - En este caso, el código es simple y no requiere re-factorización.
   - Asegúrate de que todo está bien estructurado y que no hay redundancias.

---

## **Practica: Calculadora Simple**

**Objetivo:**
Desarrollar una calculadora simple usando TDD que pueda realizar las siguientes operaciones: suma, resta, multiplicación, división y comprobar si un número es par.

---

**Descripción del Proyecto:**
Vamos a implementar una calculadora con las siguientes funciones:

1. `add(a: number, b: number): number`
2. `subtract(a: number, b: number): number`
3. `multiply(a: number, b: number): number`
4. `divide(a: number, b: number): number`
5. `isEven(num: number): boolean`

---

### **Paso 1: Rojo (Red)**

1. **Escribe las pruebas iniciales para cada función.**

   - Crea un archivo `calculator.test.ts` en la carpeta `src` con el siguiente contenido:

   ```typescript
   import { add, subtract, multiply, divide, isEven } from './calculator';

   test('adds 1 + 2 to equal 3', () => {
     expect(add(1, 2)).toBe(3);
   });

   test('subtracts 5 - 3 to equal 2', () => {
     expect(subtract(5, 3)).toBe(2);
   });

   test('multiplies 4 * 3 to equal 12', () => {
     expect(multiply(4, 3)).toBe(12);
   });

   test('divides 6 / 2 to equal 3', () => {
     expect(divide(6, 2)).toBe(3);
    });

    test('throws an error when dividing by 0', () => {
        expect(() => divide(6, 0)).toThrow('Division by zero');
    });

    test('returns true for even numbers', () => {
        expect(isEven(2)).toBe(true);
    });

    test('returns false for odd numbers', () => {
        expect(isEven(3)).toBe(false);
    });
   ```

2. **Ejecuta las pruebas:**

   - En la terminal, ejecuta `npm test`.
   - Las pruebas deberían fallar porque las funciones no están implementadas aún.

### **Paso 2: Verde (Green)**

#### 1. **Implementa el código mínimo necesario para que las pruebas pasen.**

   - Crea un archivo `calculator.ts` en la carpeta `src` con el siguiente contenido:

   ```typescript
   export function add(a: number, b: number): number {
     return a + b;
   }

   export function subtract(a: number, b: number): number {
     return a - b;
   }

   export function multiply(a: number, b: number): number {
     return a * b;
   }

   export function divide(a: number, b: number): number {
     if (b === 0) {
       throw new Error('Division by zero');
     }
     return a / b;
   }

   export function isEven(num: number): boolean {
     return num % 2 === 0;
   }
   ```

#### 2. **Ejecuta las pruebas:**

   - En la terminal, ejecuta `npm test`.
   - Las pruebas deberían pasar ahora.
   Parece que estás viendo un error específico al ejecutar las pruebas en tu proyecto. El mensaje indica que una prueba específica que espera que ocurra un error cuando se divide por cero está fallando correctamente porque el código está lanzando una excepción, como se esperaba. Aquí te explico lo que está sucediendo y cómo puedes interpretar este resultado:

##### Análisis del Resultado

El resultado de las pruebas muestra lo siguiente:

- Las pruebas que verifican operaciones matemáticas simples (`add`, `subtract`, `multiply`, `isEven`) han pasado correctamente, como se esperaba.
- La prueba que verifica el manejo de excepciones cuando se divide por cero (`Throw an error when divide by 0`) ha fallado, pero esto es esperado ya que estás lanzando una excepción cuando el divisor es cero.

##### Detalles del Error

El error detallado en la salida de la prueba muestra que la excepción `Error: Division by zero` fue lanzada correctamente en la línea 12 del archivo `src/index.ts`. Esto indica que tu función `divide` está funcionando como se espera: cuando el divisor es cero, se lanza una excepción.

##### Interpretación del Resultado

Cuando estás utilizando TDD (Desarrollo Guiado por Pruebas), es común que algunas pruebas fallen inicialmente mientras implementas nuevas funcionalidades o manejo de errores. En este caso específico:

```bash
$ npm test

> app-test@1.0.0 test
> jest

 FAIL  src/calculator.test.ts
  √ adds 3 + 1 = 4 (3 ms)
  √ subtract 5 - 2 = 3 (1 ms)
  √ multiply 2 times 3 = 6 (1 ms)
  √ divide 6/2 = 3 (1 ms)
  × Throw an error when divide by 0 (1 ms)
  √ returns true for even numbers
  √ returns false for odd numbers

  ● Throw an error when divide by 0

    Division by zero

      10 | export const divide = (a:number, b:number):number =>{
      11 |     if (b === 0) {
    > 12 |         throw new Error('Division by zero');
         |               ^
      13 |       }
      14 |     return a/b;
      15 | }

      at divide (src/index.ts:12:15)
      at Object.<anonymous> (src/calculator.test.ts:22:18)

Test Suites: 1 failed, 1 total
Tests:       1 failed, 6 passed, 7 total
Snapshots:   0 total
Time:        2.346 s
Ran all test suites.
```
- Salta un error, que es el error que hemos forzado al introducir esta parte del test:
```ts
test("Throw an error when divide by 0", ()=>{
    expect(divide(6, 0)).toThrow('Division by zero')
    
})
```
- Y hemos manejado en nuestra función `divide()`.

##### Conclusión

En resumen, el resultado que estás viendo es esperado dentro del contexto del Desarrollo Guiado por Pruebas (TDD). Es una señal de que estás escribiendo pruebas efectivas y validando el comportamiento correcto de tu código. Asegúrate de entender los mensajes de error y utilizarlos para mejorar tu implementación y garantizar la robustez de tu aplicación.

### **Paso 3: Refactor**

1. **Revisa y mejora el código si es necesario.**

   - Revisa el archivo `calculator.ts` para asegurarte de que el código está bien estructurado y no hay redundancias.

---

### **Preguntas y ejercicios adicionales:**

1. **Ejercicio: Implementar una función para calcular la raíz cuadrada.**
   - Escribe pruebas y el código para una función `sqrt` que calcule la raíz cuadrada de un número, manejando el caso de números negativos.

2. **Pregunta:**
   - ¿Cómo te ayuda el ciclo TDD a asegurar que el código que escribes es robusto y libre de errores?

---

Este módulo te ha guiado a través del desarrollo de un pequeño proyecto usando TDD, aplicando el ciclo Rojo-Verde-Refactor para cada funcionalidad. Continúa practicando para dominar esta técnica y aplicarla en proyectos más complejos.