# `next-themes`
## Índex
### **Módulo 1: Introducción a `next-themes`**
1. **¿Qué es `next-themes`?**
   - Breve descripción.
   - Casos de uso comunes.
2. **Instalación y configuración básica**
   - Requisitos previos.
   - Instalación de la biblioteca.
   - Configuración básica en un proyecto Next.js.

### **Módulo 2: Integración y módulos
1. **CSS/SCSS**
   - Configuración CSS para `next-themes`
   - Técnicas de aplicación de clases y estilos dinámicos según el tema.
   - Integración de `next-themes` con CSS/SCSS
2. **Tailwind Css**
   - Configuración Tailwind Css para `next-themes`
   - Técnicas de aplicación de clases y estilos dinámicos según el tema.
   - Integración de `next-themes` con Tailwind Css.
3. **Modos o subtemas** 
   - Definición de modos o subtemas.
   - Configuración de Tailwind CSS.
   - Configuración de Variables Globales en CSS/SCSS.
   - Aplicación de Temas y Modos en la Interfaz


### **Módulo 3: Características avanzadas de `next-themes`**
1. **Detección automática del tema del sistema**
   - Cómo detectar y aplicar el tema según las preferencias del sistema operativo del usuario.
2. **Temas personalizados dinámicos**
   - Creación de temas personalizados en tiempo real.
   - Ejemplo de un selector de colores dinámico.
3. **Manejo de temas en componentes individuales**
   - Aplicación de diferentes temas a componentes específicos.
   - Ejemplo práctico con componentes modulares.

### **Módulo 4: Mejores prácticas y optimización**
1. **Rendimiento y accesibilidad**
   - Optimización de la carga de temas.
   - Consideraciones de accesibilidad (colores, contrastes, etc.).
2. **Manejo de fallbacks y errores**
   - Qué hacer cuando `next-themes` no funciona como se espera.
   - Soluciones comunes a problemas frecuentes.
#### **Extra**: [**Repositorio información oficial**](https://github.com/pacocoursey/next-themes)
## Módulo 1: Introducción a `next-themes`

### 1.1. **¿Qué es `next-themes`?**
`next-themes` es una biblioteca diseñada específicamente para aplicaciones Next.js que facilita la gestión de temas (como claro y oscuro) dentro de una aplicación. Es compatible con Server-Side Rendering (SSR), lo que asegura que el tema se aplique correctamente incluso en el renderizado del lado del servidor.

**Características principales:**
- **Cambio de tema en tiempo real**: Los usuarios pueden cambiar entre temas sin necesidad de recargar la página.
- **Persistencia del tema**: La preferencia del tema se guarda en `localStorage` por defecto, lo que permite recordar la configuración del usuario.
- **Compatibilidad con SSR**: `next-themes` se integra fácilmente con SSR, garantizando que el tema se aplique de manera adecuada durante la renderización inicial.
- **Detección automática del tema del sistema**: `next-themes` puede detectar y aplicar el tema basado en las preferencias del sistema operativo del usuario.

### 1.2. **Instalación y configuración básica**

#### 1.2.1. **Requisitos previos**
Para este curso, se asume que tienes un conocimiento básico de Next.js 14 y React. También deberías tener un entorno de desarrollo configurado con Node.js y npm (o yarn).

#### 1.2.2. **Instalación de `next-themes`**
Primero, instalamos `next-themes` en nuestro proyecto Next.js:

```bash
npm install next-themes
```

O si usas `yarn`:

```bash
yarn add next-themes
```

#### 1.2.3. **Configuración básica con App Router y SSR**
A continuación, configuraremos `next-themes` para trabajar con el nuevo App Router de Next.js y aseguraremos que funcione correctamente con SSR.

1. **Configura el `ThemeProvider` en el Layout principal:**

   En Next.js 14 con App Router, los layouts se configuran de manera centralizada en la carpeta `app`. Vamos a envolver todo nuestro layout en el `ThemeProvider` de `next-themes`.

   ```javascript
   // app/layout.js o app/layout.tsx

   import { ThemeProvider } from 'next-themes';
   import './globals.css';

   export const metadata = {
     title: 'Mi App',
     description: 'Ejemplo con next-themes en Next.js 14',
   };

   export default function RootLayout({ children }) {
     return (
       <html lang="es">
         <body>
           <ThemeProvider attribute="class" defaultTheme="system" enableSystem>
             {children}
           </ThemeProvider>
         </body>
       </html>
     );
   }
   ```

   **Explicación:**
   - **`ThemeProvider`**: Este componente se coloca en el layout raíz para asegurarse de que el tema esté disponible en toda la aplicación.
   - **`attribute="class"`**: Indica que el tema se aplicará usando clases CSS (`className`), útil para frameworks como Tailwind CSS.
   - **`defaultTheme="system"`**: Configura el tema por defecto para que siga las preferencias del sistema operativo del usuario.
   - **`enableSystem`**: Permite que el tema siga automáticamente las preferencias del sistema (claro/oscuro).

2. **Uso en páginas y componentes:**

   Con esta configuración, todos los componentes y páginas de tu aplicación pueden acceder al tema actual y cambiarlo si es necesario. Aquí tienes un ejemplo de cómo usarlo en un componente:

   ```javascript
   // app/page.js o app/page.tsx

   'use client';

   import { useTheme } from 'next-themes';

   export default function HomePage() {
     const { theme, setTheme } = useTheme();

     return (
       <div>
         <h1>Bienvenido a mi aplicación</h1>
         <p>El tema actual es: {theme}</p>
         <button onClick={() => setTheme('light')}>Modo Claro</button>
         <button onClick={() => setTheme('dark')}>Modo Oscuro</button>
         <button onClick={() => setTheme('system')}>Sistema</button>
       </div>
     );
   }
   ```

   **Explicación:**
   - **`useTheme()`**: Hook que proporciona el tema actual y una función para cambiarlo (`setTheme`).
   - **Temas**: Puedes cambiar entre `light`, `dark` y `system` usando los botones. Esto actualizará el tema en tiempo real.

3. **SSR y precarga del tema:**

   Aunque `next-themes` maneja bien la renderización del lado del servidor, es importante saber que el tema se aplica inmediatamente después de que el JavaScript se carga en el cliente. Esto significa que es posible que durante la carga inicial se vea un flash de contenido sin estilo (FOUC). Para minimizar esto, puedes aplicar un estilo predeterminado de carga en el servidor:

   ```css
   /* globals.css */

   [data-theme='light'] {
     --background-color: #fff;
     --text-color: #000;
   }

   [data-theme='dark'] {
     --background-color: #000;
     --text-color: #fff;
   }

   html {
     background-color: var(--background-color);
     color: var(--text-color);
   }
   ```

   Esto asegura que mientras se carga la aplicación, el fondo y el texto tengan un estilo básico que coincida con el tema seleccionado.

### 1.3 **Configuración de Múltiples Temas**

En esta parte del curso, configuraremos varios temas personalizados y aprenderemos cómo permitir que los usuarios elijan entre ellos. 

#### 1.3.1. **Definiendo Temas Personalizados**
Primero, necesitas definir los temas en tu archivo CSS global o en un archivo de variables CSS si usas Tailwind CSS, SCSS o cualquier otra herramienta de estilos. Aquí te muestro cómo hacerlo usando CSS puro con variables CSS.

```css
/* globals.css */

:root {
  --background-color: #ffffff;
  --text-color: #000000;
}

[data-theme='dark'] {
  --background-color: #000000;
  --text-color: #ffffff;
}

[data-theme='light'] {
  --background-color: #ffffff;
  --text-color: #000000;
}

[data-theme='solarized'] {
  --background-color: #fdf6e3;
  --text-color: #657b83;
}

[data-theme='dracula'] {
  --background-color: #282a36;
  --text-color: #f8f8f2;
}

html {
  background-color: var(--background-color);
  color: var(--text-color);
}
```

**Explicación:**
- **`:root`**: Define las variables CSS predeterminadas.
- **`[data-theme='...']`**: Define las variables CSS para cada tema. Aquí hemos añadido dos temas personalizados: `solarized` y `dracula`.

#### 1.3.2. **Aplicando Temas en la Aplicación**
Con los temas definidos, ajustaremos nuestra aplicación para que permita a los usuarios cambiar entre estos temas personalizados.

```javascript
// app/page.js o app/page.tsx

'use client';

import { useTheme } from 'next-themes';

export default function HomePage() {
  const { theme, setTheme } = useTheme();

  return (
    <div>
      <h1>Selecciona un tema:</h1>
      <p>El tema actual es: {theme}</p>
      <button onClick={() => setTheme('light')}>Modo Claro</button>
      <button onClick={() => setTheme('dark')}>Modo Oscuro</button>
      <button onClick={() => setTheme('solarized')}>Solarized</button>
      <button onClick={() => setTheme('dracula')}>Dracula</button>
      <button onClick={() => setTheme('system')}>Sistema</button>
    </div>
  );
}
```

**Explicación:**
- **Temas personalizados (`solarized`, `dracula`)**: Ahora tienes botones que permiten a los usuarios seleccionar entre los temas personalizados que definimos anteriormente.
- **`setTheme('solarized')` y `setTheme('dracula')`**: Estas funciones cambian el tema a los nuevos valores definidos en CSS.

#### 1.3.3. **Persistencia y SSR con Temas Personalizados**
Con `next-themes`, la persistencia de los temas personalizados funciona de manera similar a la de los temas estándar. Los temas seleccionados se guardan en `localStorage`, y `next-themes` aplicará automáticamente el tema elegido en las visitas posteriores del usuario.

No obstante, recuerda que durante la SSR, podrías experimentar un FOUC (Flash of Unstyled Content). Puedes minimizarlo con la configuración previa de estilos que ya hemos visto, asegurando que el servidor aplique un tema básico antes de que el JavaScript cargue en el cliente.

#### 1.3.4. **Mejorando la experiencia de usuario**
Para ofrecer una experiencia de usuario más fluida, considera agregar transiciones entre los cambios de tema. Puedes hacerlo fácilmente con CSS:

```css
/* globals.css */

html {
  transition: background-color 0.3s, color 0.3s;
}

body {
  margin: 0;
  padding: 0;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, 'Noto Sans', sans-serif;
  line-height: 1.5;
}
```

Este código agregará una transición suave de 0.3 segundos entre los cambios de tema, mejorando la percepción visual cuando los usuarios cambian de un tema a otro.

## Módulo 2: Integración y modos

### **2.1 Configuración de `next-themes` con CSS**

En esta sección, veremos cómo configurar `next-themes` utilizando solo CSS. Este enfoque es ideal si prefieres trabajar con estilos CSS nativos y no estás utilizando un framework de utilidades como Tailwind CSS. También es útil para tener un control más granular y específico sobre los estilos de tu aplicación.

#### **2.1.1 Configuración CSS en `globals.css`**

##### **Configuración Básica**

Para implementar el soporte de temas con CSS, primero debes definir tus variables de estilo en el archivo `globals.css`. Estas variables se agrupan bajo atributos como `data-theme`, que se asignan dinámicamente en el documento HTML según el tema seleccionado.

```css
/* globals.css */

/* Tema Claro */
[data-theme="light"] {
  --background: #ffffff;
  --foreground: #000000;
  --primary: #1a202c;
  --secondary: #718096;
  --accent: #3182ce;
  --muted: #f7fafc;
}

/* Tema Oscuro */
[data-theme="dark"] {
  --background: #1a202c;
  --foreground: #f7fafc;
  --primary: #edf2f7;
  --secondary: #a0aec0;
  --accent: #63b3ed;
  --muted: #2d3748;
}
```

En este ejemplo, los temas se definen mediante variables CSS personalizadas que cambian según el valor del atributo `data-theme` en el elemento HTML.

##### **Otras Técnicas con `next-themes` y CSS**

Además de la configuración básica, existen técnicas adicionales que puedes utilizar para mejorar la experiencia de usuario:

- **Aplicación Condicional de Estilos**: Puedes aplicar diferentes estilos condicionales según el tema utilizando selectores avanzados de CSS. Por ejemplo, podrías cambiar la apariencia de componentes individuales como botones o formularios basándote en el tema activo.

- **Uso de Animaciones para Cambios de Tema**: Puedes añadir animaciones para que el cambio de tema sea más fluido y atractivo. Esto se logra combinando transiciones CSS con la activación de temas a través de `next-themes`.

  ```css
  [data-theme="dark"] body {
    transition: background-color 0.5s ease-in-out;
  }
  ```

### **2.2 Configuración de `next-themes` con Tailwind CSS**

Cuando utilizas `next-themes` junto con Tailwind CSS, aprovechas el poder de las utilidades de Tailwind para manejar los temas de manera más eficiente y flexible. Tailwind ofrece un conjunto de herramientas que simplifican la configuración y permiten un desarrollo rápido y dinámico.

#### **2.2.1 Configuración de Tailwind para Soporte de Temas**

##### **Configuración Inicial en `tailwind.config.js`**

En lugar de depender exclusivamente de atributos como `data-theme`, Tailwind te permite manejar los temas directamente a través de clases utilitarias. Para habilitar esto, necesitas configurar el modo oscuro en tu archivo `tailwind.config.js`:

```js
// tailwind.config.js
module.exports = {
  darkMode: 'class', // usa 'class' para manejar el modo oscuro con Tailwind
  theme: {
    extend: {
      colors: {
        background: 'var(--background)',
        foreground: 'var(--foreground)',
        primary: 'var(--primary)',
        secondary: 'var(--secondary)',
        accent: 'var(--accent)',
        muted: 'var(--muted)',
      },
    },
  },
  plugins: [],
}
```

Aquí, la configuración de `darkMode: 'class'` indica que Tailwind aplicará estilos oscuros cuando la clase `dark` esté presente en el elemento raíz de tu HTML. Esto permite un control más directo y eficiente sobre cómo y cuándo se aplican los estilos temáticos.

##### **Aplicación de Estilos Temáticos con Tailwind**

Una vez configurado, puedes aplicar estilos basados en el tema utilizando las clases de Tailwind. Por ejemplo:

```html
<div class="bg-background text-foreground">
  <!-- Contenido -->
</div>

```

Dependiendo de si la clase `dark` está presente o no en el `html`, los colores de fondo (`bg-background`) y texto (`text-foreground`) cambiarán según las variables definidas.

##### **Técnicas Avanzadas con Tailwind y `next-themes`**

- **Combinación de Temas y Responsive Design**: Tailwind facilita la aplicación de estilos temáticos junto con estilos responsivos. Puedes combinar fácilmente clases de tema con clases de diseño responsivo.

  ```html
  <div class="bg-background md:bg-primary lg:bg-secondary">
    <!-- Contenido -->
  </div>
  ```

- **Uso de Modificadores de Estado**: Tailwind permite combinar modificadores de estado como `hover`, `focus`, etc., con clases temáticas. Esto es útil para crear interfaces interactivas que respondan no solo al tema activo sino también a las acciones del usuario.

  ```html
  <button class="bg-accent hover:bg-primary text-foreground">
    Clic Aquí
  </button>
  ```


#### **2.2.2. Integración con librerías**
##### [NextUI](https://nextui.org/docs/customization/dark-mode)
##### [Shadcn UI](https://ui.shadcn.com/docs/dark-mode/next)

### **2.3. Modos o subtemas

#### **2.3.1. Definición de Modos o Subtemas**

Los "modos" en este contexto se refieren a subtemas dentro de un tema global (como "claro" y "oscuro"). Estos subtemas o modos permiten a los usuarios personalizar la experiencia visual de una aplicación, eligiendo no solo entre claro y oscuro, sino también seleccionando esquemas de color específicos dentro de esos temas.

#### **2.3.2. Configuración de Tailwind CSS

Para aplicar estos modos y temas de manera eficiente en tu proyecto, puedes aprovechar la capacidad de Tailwind CSS de extender sus configuraciones y utilizar variables CSS para definir colores dinámicos. Aquí te mostramos cómo configurarlo:

##### **Paso 1: Configuración del `tailwind.config.js`**

Este archivo es crucial para extender las utilidades de Tailwind y hacer uso de las variables CSS para los diferentes modos y temas. La configuración que has proporcionado establece las variables para los colores, que luego se asignan a las diferentes clases de Tailwind.

```javascript
import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./src/pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/components/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        input: "var(--input)",
        ring: "var(--ring)",
        background: {
          DEFAULT: "var(--background)",
          transparent: "var(--background-transparent)",
        },
        foreground: "var(--foreground)",
        accent: {
          DEFAULT: "var(--accent)",
          hover: "var(--accent-hover)",
        },
        primary: {
          DEFAULT: "var(--primary)",
          foreground: "var(--primary-foreground)",
          hover: "var(--primary-hover)",
        },
        secondary: {
          DEFAULT: "var(--secondary)",
          foreground: "var(--secondary-foreground)",
        },
        muted: {
          DEFAULT: "var(--muted)",
          foreground: "var(--muted-foreground)",
        },
        border: {
          DEFAULT: "var(--border)",
          accent: "var(--border-accent)",
        },
      },
    },
  },
  plugins: [],
};

export default config;
```

##### **Explicación de la Configuración:**

- **`extend`:** Esta sección te permite extender la configuración predeterminada de Tailwind para incluir nuevas clases basadas en variables CSS.
- **`colors`:** Aquí definimos los colores utilizando variables CSS. Estas variables (`--input`, `--ring`, `--background`, etc.) son asignadas en el archivo global CSS, y su valor cambiará dependiendo del tema y modo seleccionado.

#### **2.3.3. Configuración de Variables Globales en CSS/SCSS**

El siguiente paso es definir las variables CSS para los diferentes temas y modos en un archivo CSS/SCSS global (`globals.css` o `globals.scss`).

##### **Paso 2: Definir Variables en `globals.css`**

Este archivo define los valores de las variables CSS utilizadas en la configuración de Tailwind, permitiendo que los temas y modos se apliquen correctamente cuando se cambia el tema.

```css
/* globals.css */

@tailwind base;
@tailwind components;
@tailwind utilities;

/* Definir temas claros */
[data-theme="light-zinc"] {
  --background: #f8fafc;
  --foreground: #09090b;
  --background-transparent: #f8fafc99;
  --primary: #09090b;
  --primary-foreground: #f8fafc;
  --primary-hover: #09090be6;
  --secondary: #d1d5db;
  --secondary-foreground: #09090b;
  --muted: #27272a;
  --muted-foreground: #18181b;
  --accent: #09090b;
  --accent-hover: #09090be6;
  --border: #09090b;
  --border-accent: #f8fafc;
  --input: #09090b;
  --ring: #09090b;
}

/* Definir temas oscuros */
[data-theme="dark-zinc"] {
  --background: #09090b;
  --foreground: #f8fafc;
  --background-transparent: #09090b99;
  --primary: #f8fafc;
  --primary-foreground: #09090b;
  --primary-hover: #f8fafce6;
  --secondary: #18181b;
  --secondary-foreground: #d1d5db;
  --muted: #d1d5db;
  --muted-foreground: #27272a;
  --accent: #f8fafc;
  --accent-hover: #f8fafce6;
  --border: #f8fafc;
  --border-accent: #f8fafc;
  --input: #f8fafc;
  --ring: #f8fafc;
}

/* Puedes añadir más submodos aquí, como light-orange, dark-red, etc. */
```

##### **Explicación de las Variables:**

- **`--background`, `--foreground`, etc.:** Estas variables definen los colores principales de cada submodo. Cuando el tema se cambia, el valor de estas variables también cambia, y gracias a la configuración en `tailwind.config.js`, Tailwind aplicará automáticamente estos cambios en toda la aplicación.
- **`[data-theme="light-zinc"]`:** Se utiliza para aplicar estas variables CSS cuando el atributo `data-theme` en el HTML es igual a `light-zinc`. De esta manera, podemos cambiar completamente la paleta de colores según el submodo seleccionado.

#### **2.3.4. Aplicación de Temas y Modos en la Interfaz**

Finalmente, debes asegurarte de que tu aplicación pueda cambiar dinámicamente entre estos temas y modos, utilizando el atributo `data-theme` en la etiqueta `html` o `body` de tu documento.

##### **Paso 3: Implementación del Cambio de Temas

En tu componente principal, puedes manejar el cambio de temas y modos utilizando `useTheme` de `next-themes` o gestionando directamente el atributo `data-theme`.

**Ejemplo en un componente React:**

```javascript
import { useTheme } from "next-themes";

export default function ThemeHandler() {
  const { theme, setTheme } = useTheme("light-zinc");

  return (
    <div>
      <button onClick={() => setTheme("light-zinc")}>Light Zinc</button>
      <button onClick={() => setTheme("dark-zinc")}>Dark Zinc</button>
      {/* Otros botones para más submodos */}
    </div>
  );
}
```

