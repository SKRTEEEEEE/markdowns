

# **Módulo 1: Fundamentos de TDD**

## **Sección 1: Conceptos básicos de TDD**

### **1.1 Conceptos básicos de TDD**

**Objetivos de esta sección:**
- Entender qué es el Test-Driven Development (TDD).
- Aprender sobre el ciclo TDD: Rojo-Verde-Refactor.
- Conocer los beneficios de aplicar TDD en el desarrollo de software.

---

**Qué es TDD:**

Test-Driven Development (Desarrollo Guiado por Pruebas) es una metodología de desarrollo de software en la cual se escriben las pruebas antes de escribir el código que implementa la funcionalidad. Esta práctica asegura que el código sea continuamente testado y que cumpla con los requisitos desde el inicio.

---

**El ciclo TDD:**

El ciclo TDD se divide en tres pasos principales:

1. **Rojo (Red):**
   - Escribe una prueba que falle. Esta prueba define una nueva funcionalidad o una mejora.
   - Ejecuta la prueba y asegúrate de que falla. Esto confirma que la prueba está bien escrita y que la funcionalidad no existe aún.

2. **Verde (Green):**
   - Escribe el código mínimo necesario para que la prueba pase.
   - Ejecuta la prueba y asegúrate de que pasa.

3. **Refactor:**
   - Refactoriza el código para mejorar su estructura sin cambiar su comportamiento.
   - Asegúrate de que todas las pruebas siguen pasando después de la refactorización.

Este ciclo se repite para cada pequeña funcionalidad o cambio que se desee implementar.

---

**Beneficios de TDD:**

- **Código más limpio y mantenible:** La refactorización continua lleva a un código mejor estructurado.
- **Menos errores:** Las pruebas continuas ayudan a detectar errores temprano en el proceso de desarrollo.
- **Documentación viva:** Las pruebas actúan como documentación para el código.
- **Facilita el cambio:** Refactorizar y añadir nuevas funcionalidades es más fácil y seguro.

---

## **Sección 2: Primer pruebas con JEST**

Vamos a realizar un ejercicio práctico para entender cómo funciona el ciclo TDD.

**Descripción del problema:**
Vamos a implementar una función `sum` que toma dos números y devuelve su suma.

**Paso 1: Rojo (Red)**

1. Crea un nuevo proyecto de Node.js con TypeScript.
2. Instala Jest como framework de pruebas.
3. Configura Jest para TypeScript.
4. Escribe una prueba que falle para la función `sum`.

**Instrucciones:**

1. **Configura tu proyecto:**
   - Abre Visual Studio Code y crea una nueva carpeta para tu proyecto.
   - Abre una terminal en la carpeta del proyecto y ejecuta los siguientes comandos:

```bash
npm init -y
npm install typescript jest @types/jest ts-jest --save-dev
npx tsc --init
npx ts-jest config:init
```

2. **Configura Jest:**
   - En el archivo `package.json`, añade el siguiente script bajo `"scripts"`:

```json
"scripts": {
  "test": "jest"
}
```

3. **Configura TypeScript:**
   - Asegúrate de que tu archivo `tsconfig.json` incluye las siguientes configuraciones:

```json
{
  "compilerOptions": {
    "module": "commonjs",
    "target": "es6",
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  },
  "include": ["src"],
  "exclude": ["node_modules"]
}
```

4. **Crea la estructura de carpetas:**
   - Crea una carpeta `src` en la raíz del proyecto.
   - Dentro de `src`, crea un archivo `sum.ts` y un archivo de pruebas `sum.test.ts`.

5. **Escribe la prueba que falle:**
   - En `sum.test.ts`, escribe la siguiente prueba:

```typescript
import { sum } from './sum';

test('adds 1 + 2 to equal 3', () => {
  expect(sum(1, 2)).toBe(3);
});
```

6. **Ejecuta la prueba:**
   - En la terminal, ejecuta `npm test`.
   - La prueba debería fallar porque aún no hemos implementado la función `sum`.

**Paso 2: Verde (Green)**

1. **Implementa el código mínimo:**
   - En `sum.ts`, implementa la función `sum`:

```typescript
export function sum(a: number, b: number): number {
  return a + b;
}
```

2. **Ejecuta la prueba:**
   - En la terminal, ejecuta `npm test`.
   - La prueba debería pasar ahora.

**Paso 3: Refactor**

1. **Revisa el código:**
   - En este caso, el código es bastante simple y no requiere re-factorización.
   - Asegúrate de que todo está bien estructurado y que no hay redundancias.

---

**Conclusión de la Sección:**

Has aprendido los conceptos básicos de TDD y has aplicado el ciclo TDD en un ejemplo práctico simple. Continúa practicando este ciclo para cada nueva funcionalidad que desees implementar en tus proyectos.

---

## **Practica: Preguntas y ejercicios adicionales.**

1. **Ejercicio: Multiplicación**
   - Escribe pruebas y el código para una función `multiply` que multiplique dos números.

2. **Pregunta:**
   - ¿Por qué es importante que la prueba falle primero en el ciclo TDD?

---
