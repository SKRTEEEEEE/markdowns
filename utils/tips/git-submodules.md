# Github submodules


## Vinculación con submodules

1. Asume que ya tienes dos repositorios:
   - `tu-sitio-web`: El repositorio que contiene el código de tu sitio web.
   - `tu-contenido-blog`: El repositorio que contiene tus archivos de blog (MDX, etc.).

2. En tu repositorio `tu-sitio-web`, añade el submódulo:

   ```bash
   cd path/to/tu-sitio-web
   git submodule add https://github.com/tu-usuario/tu-contenido-blog.git content
   ```

   Esto creará una carpeta `content` en tu repositorio `tu-sitio-web` que es un submódulo que apunta a `tu-contenido-blog`.

3. Haz commit de los cambios:

   ```bash
   git add .
   git commit -m "Añadido submódulo para contenido del blog"
   ```

4. Actualiza tu configuración de Velite para que apunte a la carpeta `content`:

   ```typescript
   export default defineConfig({
     root: "content",
     // ... resto de tu configuración
   });
   ```

5. Cuando alguien clone tu repositorio `tu-sitio-web`, necesitarán inicializar y actualizar el submódulo:

   ```bash
   git clone https://github.com/tu-usuario/tu-sitio-web.git
   cd tu-sitio-web
   git submodule init
   git submodule update
   ```

6. Para actualizar el contenido en el futuro:

   ```bash
   cd path/to/tu-sitio-web/content
   git pull origin main
   cd ..
   git add content
   git commit -m "Actualizado contenido del blog"
   ```

Ventajas de este enfoque:

1. Mantienes el contenido y el código del sitio separados pero vinculados.
2. Puedes actualizar el contenido independientemente del código del sitio.
3. Otras personas pueden contribuir fácilmente al contenido sin necesidad de acceso al código del sitio.
4. Puedes versionar el contenido y el sitio por separado.

Consideraciones:

- Asegúrate de que tu proceso de despliegue (si lo tienes) esté configurado para inicializar y actualizar submódulos.
- Si usas servicios de despliegue continuo como Vercel o Netlify, puede que necesites configurarlos para que manejen correctamente los submódulos.

### Posibles errores
#### Error carpeta github
El error que estás viendo indica que ya existe un directorio o archivo llamado 'resources' en tu repositorio git. Esto puede deberse a varias razones:

1. Ya has añadido este submódulo anteriormente.
2. Tienes un directorio o archivo llamado 'resources' que ya está siendo rastreado por git.
3. Has intentado añadir el submódulo antes y el proceso se interrumpió, dejando residuos.

Para resolver esto, puedes intentar lo siguiente:

1. Primero, verifica si ya tienes el submódulo:

   ```
   git submodule status
   ```

   Si ves 'resources' listado, significa que ya está añadido como submódulo.

2. Si no es un submódulo, verifica si existe como un directorio o archivo normal:

   ```
   ls -la | grep resources
   ```

3. Si existe como un directorio normal y quieres reemplazarlo con el submódulo, primero necesitas eliminarlo:

   ```
   git rm -r resources
   git commit -m "Removed resources directory to prepare for submodule"
   ```

4. Si quieres añadir el submódulo en una ubicación diferente, puedes especificar la ruta:

   ```
   git submodule add https://github.com/SKRTEEEEEE/resources.git path/to/resources
   ```

5. Si nada de lo anterior funciona, puede que haya residuos de un intento anterior de añadir el submódulo. Puedes intentar limpiarlos:

   ```
   git rm -r --cached resources
   rm -rf .git/modules/resources
   ```

   Luego, intenta añadir el submódulo nuevamente.

Después de resolver el problema, intenta añadir el submódulo nuevamente:

```
git submodule add https://github.com/SKRTEEEEEE/resources.git resources
```

Si sigues teniendo problemas, por favor proporciona más detalles sobre el contenido de tu directorio 'resources' actual y el resultado de `git status`.