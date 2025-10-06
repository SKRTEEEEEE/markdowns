# Guía práctica: Ejecutar proyectos TypeScript con ESM y CommonJS

Cuando trabajas con **TypeScript**, una de las decisiones clave es elegir entre los dos sistemas de módulos de Node.js: **ESM (ECMAScript Modules)** o **CommonJS (CJS)**.
Esta decisión afecta **cómo ejecutas tu proyecto**, qué herramientas puedes usar y qué errores te puedes encontrar.

En este documento encontrarás una explicación clara, las diferencias, y qué combinaciones de herramientas usar en cada caso.

---

## 📦 1. CommonJS (CJS)

Es el sistema **clásico de Node.js**.
Archivos usan `require()` y `module.exports`, aunque con TypeScript normalmente usamos `import/export` y se compilan a CommonJS detrás de escena.

### Configuración típica

**package.json**:

```json
{
  "type": "commonjs"
}
```

**tsconfig.json**:

```json
{
  "compilerOptions": {
    "module": "CommonJS",
    "target": "ES2022",
    "esModuleInterop": true,
    "moduleResolution": "node"
  }
}
```

### Herramientas recomendadas

* ✅ **`ts-node`** → para ejecutar un archivo TypeScript directamente.

  ```bash
  npx ts-node src/index.ts
  ```

* ✅ **`ts-node-dev`** → para desarrollo con autoreload (similar a nodemon).

  ```bash
  npx ts-node-dev --respawn src/index.ts
  ```

* ✅ **jest / ts-jest** → funcionan nativamente con CJS.

### Ventajas

* Más estable, ampliamente soportado.
* Menos errores con dependencias antiguas.
* Perfecto si vas a usar `ts-node-dev` o `jest` sin dolores de cabeza.

### Inconvenientes

* Es el pasado: el futuro de Node.js es **ESM**.
* Puede ser un lío mezclar con librerías modernas escritas solo para ESM.

---

## 📦 2. ECMAScript Modules (ESM)

Es el sistema **moderno** de JavaScript y el estándar oficial.
Usa `import/export` **de forma nativa**, sin require.

### Configuración típica

**package.json**:

```json
{
  "type": "module"
}
```

**tsconfig.json**:

```json
{
  "compilerOptions": {
    "module": "ESNext",
    "target": "ES2022",
    "moduleResolution": "nodenext"
  }
}
```

### Herramientas recomendadas

* ✅ **Node.js con loader oficial**
  Ejecutar directamente con:

  ```bash
  node --loader ts-node/esm src/index.ts
  ```

  (o usando un script en `package.json`).

* ✅ **tsx** (recomendado 🚀)
  Una alternativa moderna, rápida y con autoreload:

  ```bash
  npx tsx watch src/index.ts
  ```

### Herramientas que **NO** encajan bien

* ❌ `ts-node-dev` → no soporta ESM, aunque intentes con `--esm` te dará errores como:

  ```
  Must use import to load ES Module
  ```

### Ventajas

* Compatible con el ecosistema moderno de Node.js.
* Soporte directo de librerías recientes.
* Más alineado con estándares JS.

### Inconvenientes

* Algunas librerías/test frameworks no están bien adaptados todavía.
* Necesitas usar loaders (`--loader ts-node/esm`) o herramientas modernas (`tsx`).

---

## 🚀 3. Resumen rápido

| Opción       | Configuración en `package.json`    | Herramientas recomendadas          | Cuándo usarlo                                               |
| ------------ | ---------------------------------- | ---------------------------------- | ----------------------------------------------------------- |
| **CommonJS** | `"type": "commonjs"` (o sin campo) | `ts-node`, `ts-node-dev`           | Si quieres autoreload estable y compatibilidad amplia.      |
| **ESM**      | `"type": "module"`                 | `node --loader ts-node/esm`, `tsx` | Si tu proyecto es moderno o dependes de librerías solo ESM. |

---

## ✅ Recomendación práctica

* Si estás empezando un proyecto **nuevo y moderno** → usa **ESM + `tsx`**.

  ```bash
  npx tsx watch src/index.ts
  ```

  Te olvidas de loaders raros y deprecaciones.

* Si trabajas con **infraestructura más clásica o legacy** → usa **CommonJS + `ts-node-dev`**.

  ```bash
  npx ts-node-dev --respawn src/index.ts
  ```

---

👉 Conclusión:

* **ESM → Node.js/tsx**
* **CommonJS → ts-node/ts-node-dev**

