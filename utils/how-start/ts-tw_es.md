# Iniciando con Proyectos Node.js `ts-tw` template.

## Instalación de Dependencias

Primero, asegúrate de tener Node.js y npm instalados en tu máquina. Luego, instala las dependencias necesarias para tu proyecto:

```bash
npm install
```

Asegúrate de configurar tu archivo `.env` o `.env.local` si es necesario para tu entorno de desarrollo.

## Compilación
**Si en el README principal NO hay especificaciones:**
### Compilación de TypeScript
Para compilar tu código TypeScript a JavaScript, utiliza el TypeScript Compiler (tsc). Asegúrate de tener TypeScript instalado como una dependencia de desarrollo:

```bash
npx tsc
```

Esto compilará todos los archivos TypeScript en tu proyecto según la configuración especificada en `tsconfig.json`. Si deseas compilar automáticamente cuando se realicen cambios, usa:

```bash
npx tsc --watch
```
### Compilación de TailwindCss
Para compilar tu código para interpretar tus classes de Tailwind, ejecuta el comando:


```bash
npm run build:css
```
_Este comando usa la bandera --watch para compilar el Tailwind._ 
### Compilación conjunta
Para compilar todo el código (TailwindCss y TypeScript), ejecuta el comando:

```bash
npm run build
```
_Este comando usa la bandera --watch para compilar el Tailwind y TypeScript._ 
## Iniciar el Servidor de Desarrollo
**Si en el README principal NO hay especificaciones:**

Para iniciar el servidor de desarrollo de tu aplicación Node.js y verla en acción, ejecuta:

```bash
node dist/server
```

O utiliza el siguiente comando para utilizarlo con la bander `--watch`:

```bash
npm run start:server
```

_Reemplaza `dist/server` con la ruta de tu archivo principal compilado, dependiendo de cómo hayas configurado tu `tsconfig.json`._

## Compilar e iniciar el Servidor
Para compilar TypeScript y TailwindCss, e ejecutar el servidor, ejecuta:

```bash
npm run dev
```

## Aprender Más

Para aprender mas sobre estas tecnologías y otras, puedes visitar el repositorio de [Recursos](https://github.com/SKRTEEEEEE/markdowns), donde encontraras información sobre las tecnologías utilizadas.

## Despliegue

Para desplegar tu aplicación Node.js compilada, considera las siguientes opciones:

### Opción 1: Despliegue Manual

Si prefieres un enfoque manual, puedes subir los archivos compilados (`*.js`, `*.json`, `*.html`, etc.) a tu servidor de producción y asegurarte de que cualquier configuración de entorno necesaria esté correctamente configurada.

### Opción 2: Plataformas de Despliegue Automatizado

Utiliza plataformas como:

- **Heroku**: Permite desplegar aplicaciones Node.js con facilidad y soporta configuraciones personalizadas para proyectos TypeScript.

- **AWS Elastic Beanstalk**: Ofrece despliegue y escalado automático para aplicaciones Node.js con soporte para configuraciones de TypeScript.

Asegúrate de seguir la documentación específica de cada plataforma para integrar correctamente tu proyecto TypeScript.
