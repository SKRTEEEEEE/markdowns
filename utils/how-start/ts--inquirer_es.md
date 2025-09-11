# Getting Started con Node.js `ts--inquirer` Template

## Instalación de Dependencias

Primero, asegúrate de tener **Node.js** y **npm** instalados en tu máquina. Luego, instala las dependencias necesarias para tu proyecto:

```bash
npm install
```

> Este comando instalará tanto las dependencias de producción (`inquirer`) como las dev (`typescript`, `jest`, `ts-jest`, `@types/jest`, `ts-node`).

Si tu proyecto requiere configuración de entorno, crea un archivo `.env` o `.env.local` en la raíz.

---

## Compilación de TypeScript

Para compilar tu código TypeScript a JavaScript, utiliza el compilador TypeScript:

```bash
npx tsc
```

Esto generará los archivos compilados en la carpeta `dist/` según lo definido en `tsconfig.json`.

Si quieres **compilación automática al guardar cambios**, utiliza:

```bash
npx tsc --watch
```

---

## Ejecutar la CLI

Para ejecutar la aplicación CLI directamente con **ts-node** (sin compilar manualmente):

```bash
npm start
```

Esto ejecutará el archivo principal `src/index.ts` y mostrará las preguntas interactivas definidas con `inquirer`.

---

## Testing

Este template ya viene configurado con **Jest + ts-jest**:

* Ejecutar todos los tests:

```bash
npm test
```

* Ejecutar tests en modo watch (ideal durante desarrollo):

```bash
npm run test:watch
```

* Ejecutar solo tests E2E:

```bash
npm run test:e2e
```

> Los tests incluyen:
>
> * **Domain** → tests de entidades (`Project`)
> * **Application** → tests de casos de uso (`ProjectService`)
> * **Infrastructure** → tests E2E simulando la CLI con respuestas mockeadas

---

## Desarrollo Conjunto (Compilar + CLI)

Si quieres ejecutar la CLI y ver cambios rápidos mientras editas, puedes combinar `tsc --watch` con `npm start` en otra terminal:

```bash
npx tsc --watch
npm start
```

---

## Aprender Más

Para profundizar en **Node.js, TypeScript, Jest o Inquirer**, revisa:

* [TypeScript](https://www.typescriptlang.org/)
* [Jest](https://jestjs.io/)
* [Inquirer](https://www.npmjs.com/package/inquirer)

---

## Despliegue

Al tratarse de un proyecto **CLI**, el despliegue normalmente consiste en:

* Subir la carpeta del proyecto a un repositorio GitHub o servidor.
* Instalar dependencias con `npm install`.
* Ejecutar `npm start` en la máquina destino.

> Si quieres distribuirlo globalmente como CLI, considera usar `npm link` o publicar en npm.

