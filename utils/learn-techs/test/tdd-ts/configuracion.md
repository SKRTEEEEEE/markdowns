# **Módulo 2: Configuración del entorno de desarrollo**

**Objetivos del Módulo:**
- Configurar TypeScript en un proyecto.
- Configurar Jest para TypeScript.
- Integrar TypeScript y Jest con Visual Studio Code.
- Asegurar una configuración óptima para un flujo de trabajo eficiente.

---

## **Sección 2.1: Configuración de TypeScript**

**Objetivo:**
Configurar TypeScript en un proyecto para aprovechar todas sus características, como el tipado estático y la verificación de tipos.

---

**Paso 1: Inicializar un proyecto de TypeScript**

1. **Crear el proyecto:**
   - Abre Visual Studio Code y crea una nueva carpeta para tu proyecto.
   - Abre una terminal en la carpeta del proyecto y ejecuta:

```bash
npm init -y
npm install typescript --save-dev
npx tsc --init
```

2. **Configurar `tsconfig.json`:**
   - El comando `npx tsc --init` genera un archivo `tsconfig.json`. Configura las siguientes opciones importantes:

```json
{
  "compilerOptions": {
    "target": "es6",                         /* ES5 es la versión más antigua compatible */
    "module": "commonjs",                    /* Usa CommonJS para compatibilidad con Node.js */
    "outDir": "./dist",                      /* Carpeta de salida para los archivos compilados */
    "rootDir": "./src",                      /* Carpeta raíz de los archivos fuente */
    "strict": true,                          /* Habilitar todas las comprobaciones estrictas */
    "esModuleInterop": true,                 /* Habilitar interoperabilidad de ES módulos */
    "skipLibCheck": true,                    /* Omitir comprobación de tipos de archivos de declaración */
    "forceConsistentCasingInFileNames": true /* Enforzar consistencia en nombres de archivos */
  },
  "include": ["src"],                        /* Incluir todos los archivos dentro de 'src' */
  "exclude": ["node_modules"]                /* Excluir la carpeta 'node_modules' */
}
```

3. **Crear estructura de carpetas:**
   - Crea una carpeta `src` en la raíz del proyecto.
   - Dentro de `src`, crea un archivo `index.ts`.

---

## **Sección 2.2: Configuración de Jest para TypeScript**

**Objetivo:**
Configurar Jest para que funcione con TypeScript y permita realizar pruebas unitarias eficientemente.

---

**Paso 2: Instalar y configurar Jest**

1. **Instalar Jest y sus tipos:**

```bash
npm install jest @types/jest ts-jest --save-dev
npx ts-jest config:init
```

2. **Configurar Jest:**
   - El comando `npx ts-jest config:init` genera un archivo `jest.config.js`. Asegúrate de que tenga las siguientes configuraciones:

```javascript
module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  testPathIgnorePatterns: ['/node_modules/', '/dist/'],
  moduleFileExtensions: ['ts', 'js'],
  transform: {
    '^.+\\.ts$': 'ts-jest'
  }
};
```

3. **Actualizar `package.json`:**
   - Añade el siguiente script bajo `"scripts"`:

```json
"scripts": {
  "test": "jest"
}
```

---

## **Sección 2.3: Integración con Visual Studio Code**

**Objetivo:**
Configurar Visual Studio Code para un desarrollo eficiente con TypeScript y Jest.

---

**Paso 3: Instalar extensiones recomendadas**

1. **Extensiones esenciales:**
   - **ESLint**: Proporciona análisis estático de código.
   - **Prettier**: Formateador de código.
   - **Jest**: Soporte para ejecutar y depurar pruebas de Jest.
   - **TypeScript**: Soporte para TypeScript.

2. **Configuración de ESLint:**
   - Instalar ESLint:

```bash
npm install eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin --save-dev
npx eslint --init
```

   - Configurar `.eslintrc.json`:

```json
{
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "project": "./tsconfig.json"
  },
  "plugins": ["@typescript-eslint"],
  "extends": [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended",
    "prettier"
  ],
  "rules": {
    // Añadir reglas personalizadas aquí
  }
}
```

3. **Configuración de Prettier:**
   - Instalar Prettier:

```bash
npm install prettier eslint-config-prettier eslint-plugin-prettier --save-dev
```

   - Crear un archivo `.prettierrc` con la configuración deseada:

```json
{
  "singleQuote": true,
  "semi": true,
  "trailingComma": "es5"
}
```

   - Añadir Prettier a las configuraciones de ESLint:

```json
"extends": [
  "eslint:recommended",
  "plugin:@typescript-eslint/recommended",
  "prettier",
  "plugin:prettier/recommended"
],
"plugins": ["prettier"]
```

---

**Paso 4: Configurar tareas y depuración en VSC**

1. **Configurar tareas para ejecutar pruebas:**
   - En `package.json`, añade el script de prueba:

```json
"scripts": {
  "test": "jest",
  "test:watch": "jest --watch"
}
```

2. **Configurar depuración:**
   - Crea un archivo `launch.json` en la carpeta `.vscode` y configura la depuración para Jest:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Jest Tests",
      "program": "${workspaceFolder}/node_modules/.bin/jest",
      "args": ["--runInBand"],
      "console": "integratedTerminal",
      "internalConsoleOptions": "neverOpen",
      "skipFiles": ["<node_internals>/**/*.js"],
      "runtimeArgs": ["--preserve-symlinks"]
    }
  ]
}
```

---

## **Practica: Configuración y prueba inicial**

**Objetivo:**
Configurar un proyecto TypeScript con Jest y ejecutar una prueba inicial para verificar la configuración.

---

**Instrucciones:**

1. **Configura el proyecto:**
   - Sigue los pasos descritos anteriormente para configurar TypeScript y Jest en tu proyecto.
   
2. **Escribe una prueba simple:**
   - Crea un archivo `area.test.ts` en `src` con el siguiente contenido:

```typescript
import { calculateArea } from './area';

test('calculates the area of a rectangle with width 5 and height 10', () => {
  expect(calculateArea(5, 10)).toBe(50);
});

test('calculates the area of a rectangle with width 0 and height 10', () => {
  expect(calculateArea(0, 10)).toBe(0);
});
```
    - En este punto la prueba debe fallar.

3. **Implementa la función:**
   - Crea un archivo `area.ts` en `src` con el siguiente contenido:

```typescript
export function calculateArea(width: number, height: number): number {
  return width * height;
}
```

4. **Ejecuta la prueba:**
   - En la terminal, ejecuta `npm test` para verificar que la prueba pasa.

---

**Conclusión de la Sección:**

Has configurado un proyecto TypeScript con Jest y Visual Studio Code, y has ejecutado una prueba inicial para asegurar que todo funciona correctamente. Continúa configurando ESLint y Prettier para mantener la calidad del código y el formato consistente.

---

### **Preguntas y ejercicios adicionales:**

1. **Ejercicio: Configuración de ESLint y Prettier**
   - Configura ESLint y Prettier en tu proyecto.
   - Asegúrate de que el código sigue las reglas definidas y está correctamente formateado.

2. **Pregunta:**
   - ¿Por qué es importante integrar TypeScript, Jest y herramientas de linters en el entorno de desarrollo?

---

Este módulo proporciona una configuración completa del entorno de desarrollo, asegurando que puedas trabajar eficientemente con TypeScript y Jest en Visual Studio Code.