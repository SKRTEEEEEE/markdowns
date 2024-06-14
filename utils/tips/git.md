# Git tips
## Estandar commits
![commits-standard.png](../../img/tips/commits-standard.png "commits-standard.png")
- Estructura general:
![commits-structure.jpg](../../img/tips/commits-structure.jpg)

## Repositorio temporal
Clonar a un repositorio temporal para luego extraer en la carpeta raiz e eliminar la carpeta original(copiada de github con el seguimiento)

_Sirve para copiar repos sin permiso del autor y dejar de seguir_ Para ejecutar correctamente se debe lanzar los codigos en **la carpeta donde se va a crear el proyecto**
- 1 Clona el repositorio en una carpeta temporal.
- 2 Mueve los archivos del repositorio clonado a la ubicación deseada.
- 3 Elimina la carpeta temporal.

```bash
git clone URL_del_repositorio tmp_repo
mv tmp_repo/* .
rm -rf tmp_repo
```

## Git pull especial
Comando para cuando tenemos un repositorio que no tiene un seguimiento y lo queremos subir a continuacion de un repositiorio ya existente
**Ojo, hay que tener commit los archivos**

_Después de ejecutar este comando, Git intentará fusionar las historias de las dos ramas. Sin embargo, ten en cuenta que es posible que tengas que resolver conflictos si existen diferencias significativas entre las ramas._
```bash
git pull origin main --allow-unrelated-histories
```

## Git restore losed Github remote

```bash
git remote add origin nombre_de_tu_repositorio
```

## Git push NEW "rama"
**Hacer el add y commit, despues:**
```bash
git checkout -b nombre_de_tu_rama
git push origin nombre_de_tu_rama
```

## Unfollow a Github
Dejar de seguir al repositorio actual en la nube
```bash
git remote -v
git remote remove nombre_de_tu_repo(origin ...)
```

## Git pull
Traer los cambios del remoto (repositorio nube Github) al local (maquina)

- Abre tu terminal o línea de comandos.
- Navega hasta el directorio de tu repositorio local utilizando el comando `cd`.
- Asegúrate de que estás en la rama correcta utilizando el comando `git branch`. Si no estás en la rama correcta, cambia a la rama adecuada usando `git checkout <nombre_de_rama>`.
- Una vez estés en la rama correcta, utiliza el comando `git pull` para traer los cambios del repositorio remoto a tu repositorio local.

## Eliminar git
### Borrando todo el interior de la carpeta
- Abre la terminal o el símbolo del sistema en tu sistema operativo.
- Navega al directorio que contiene el repositorio local que deseas dejar de seguir.
- Utiliza el comando `rm -rf <nombre_del_repositorio>` para eliminar el directorio del repositorio local y todos sus contenidos.

### Borrando solo el git
_Eliminando el archivo . git_

- Navega al directorio raíz del repositorio local que deseas dejar de seguir.
- Utiliza el comando `rm -rf .git` para eliminar el directorio `.git` y todos sus contenidos.

## Git branch merge
Traerte los cambios de una branch a otra rama _("principal")_.
Para traer los cambios de una rama a otra en Git usando Bash, puedes seguir estos pasos:

### Opción 1: Usando `merge`

1. **Cambia a la rama de destino**:

    ```bash
    git checkout nombre-de-la-rama-destino
    ```

2. **Haz el merge** con la rama de origen:

    ```bash
    git merge nombre-de-la-rama-origen
    ```

3. **Envía los cambios al repositorio remoto**:

    ```bash
    git push origin nombre-de-la-rama-destino
    ```

### Opción 2: Usando `rebase`

1. **Cambia a la rama de destino**:

    ```bash
    git checkout nombre-de-la-rama-destino
    ```

2. **Rebase con la rama de origen**:

    ```bash
    git rebase nombre-de-la-rama-origen
    ```

3. **Envía los cambios al repositorio remoto**:

    ```bash
    git push origin nombre-de-la-rama-destino
    ```

### Ejemplo práctico

Supongamos que tienes dos ramas, `main` y `feature-branch`, y quieres traer los cambios de `feature-branch` a `main`.

#### Usando `merge`:

1. Cambia a la rama `main`:

    ```bash
    git checkout main
    ```

2. Haz el merge con `feature-branch`:

    ```bash
    git merge feature-branch
    ```

3. Envía los cambios al repositorio remoto:

    ```bash
    git push origin main
    ```

#### Usando `rebase`:

1. Cambia a la rama `main`:

    ```bash
    git checkout main
    ```

2. Rebase con `feature-branch`:

    ```bash
    git rebase feature-branch
    ```

3. Envía los cambios al repositorio remoto:

    ```bash
    git push origin main
    ```

Recuerda que, en el caso de `rebase`, si el rebase crea conflictos, necesitarás resolverlos y continuar el rebase con:

```bash
git rebase --continue
```

Y luego hacer el `push` de los cambios.
## Eliminar rama en Github(remoto)
Para eliminar una rama existente en tu repositorio de GitHub (remoto), puedes usar el siguiente comando desde Bash:

1. **Elimina la rama remota**:

    ```bash
    git push origin --delete nombre-de-la-rama
    ```

### Ejemplo práctico

Supongamos que deseas eliminar la rama llamada `feature-branch` del repositorio remoto en GitHub:

```bash
git push origin --delete feature-branch
```

### [Pasos adicionales (opcional)](#eliminar-rama-en-gitlocal)
## Eliminar rama en Git(local)

Para eliminar la rama localmente (en tu máquina), puedes usar:

1. **Cambia a otra rama** (para no estar en la rama que deseas eliminar):

    ```bash
    git checkout main
    ```

2. **Elimina la rama local**:

    ```bash
    git branch -d nombre-de-la-rama
    ```

    Si la rama tiene cambios que no se han fusionado, puedes usar `-D` (mayúscula) para forzar la eliminación:

    ```bash
    git branch -D nombre-de-la-rama
    ```

### Ejemplo práctico

Para eliminar `feature-branch` localmente:

1. Cambia a otra rama:

    ```bash
    git checkout main
    ```

2. Elimina la rama localmente:

    ```bash
    git branch -d feature-branch
    ```

    O forzar la eliminación si tiene cambios no fusionados:

    ```bash
    git branch -D feature-branch
    ```

De esta manera, habrás eliminado la rama tanto del repositorio remoto en GitHub como localmente en tu máquina.

## Eliminar varias ramas en Git(local)
Claro, aquí tienes la explicación corregida para eliminar todas las ramas locales excepto `v01` y `v01.03`:

### Cómo eliminar todas las ramas locales excepto `v01` y `v01.03`

Para eliminar todas las ramas locales excepto `v01` y `v01.03`, puedes usar un script en Bash que lista todas las ramas y luego elimina las que no coinciden con `v01` y `v01.03`.

#### Comando

```bash
git branch | grep -v "^\* \| v01$ \| v01.03$" | xargs git branch -d
```

#### Explicación del comando

1. **Listar todas las ramas locales**:

    ```bash
    git branch
    ```

    Esto muestra todas las ramas locales. La salida se verá algo así:

    ```plaintext
      main
      v01
      v01.01
      v01.01.01
      v01.02
      v01.02.00
      v01.02.1
      v01.02.2
      v01.02.3
    * v01.03
    ```

2. **Filtrar las ramas para excluir `v01` y `v01.03`**:

    ```bash
    grep -v "^\* \| v01$ \| v01.03$"
    ```

    Este filtro excluye:
    - La rama actual (indicada por `*`).
    - La rama `v01`.
    - La rama `v01.03`.

3. **Eliminar las ramas filtradas**:

    ```bash
    xargs git branch -d
    ```

    Este comando toma la salida del filtro anterior y pasa cada nombre de rama al comando `git branch -d` para eliminarla.

#### Paso a paso detallado

1. **Listar todas las ramas**:

    Ejecuta el siguiente comando para listar todas las ramas locales:

    ```bash
    git branch
    ```

2. **Filtrar y eliminar las ramas no deseadas**:

    Ejecuta el siguiente comando para filtrar y eliminar todas las ramas excepto `v01` y `v01.03`:

    ```bash
    git branch | grep -v "^\* \| v01$ \| v01.03$" | xargs git branch -d
    ```

    Este comando eliminará todas las ramas locales excepto `v01` y `v01.03`.

#### Nota adicional

- Si algunas de las ramas tienen cambios no fusionados y necesitas forzar la eliminación, puedes usar `-D` en lugar de `-d`:

    ```bash
    git branch | grep -v "^\* \| v01$ \| v01.03$" | xargs git branch -D
    ```

    Ten cuidado con este comando, ya que eliminará las ramas sin preguntar si tienen cambios no fusionados.

Esto asegura que las ramas `v01` y `v01.03` no se eliminen y todas las demás ramas locales sean eliminadas.



## Git fetch
**Actualizar rama de Git con la rama de Github**
Para traer los cambios que han ocurrido en una rama de un repositorio remoto de GitHub a tu repositorio local, puedes seguir estos pasos:

### Paso 1: Configurar el repositorio remoto

Primero, asegúrate de que tu repositorio local esté configurado para rastrear el repositorio remoto de GitHub.

Si no lo has hecho, añade el repositorio remoto:

```bash
git remote add origin https://github.com/tu-usuario/tu-repositorio.git
```

### Paso 2: Actualizar las referencias remotas

Actualiza la información de las ramas remotas:

```bash
git fetch origin
```

### Paso 3: Integrar los cambios

Dependiendo de si quieres integrar los cambios en tu rama actual o en una rama específica, puedes usar `merge` o `rebase`.

#### Opción 1: Usar `merge`

1. **Cambiar a la rama en la que deseas integrar los cambios** (por ejemplo, `main`):

    ```bash
    git checkout main
    ```

2. **Hacer el merge** de los cambios de la rama remota:

    ```bash
    git merge origin/nombre-de-la-rama
    ```

#### Opción 2: Usar `rebase`

1. **Cambiar a la rama en la que deseas integrar los cambios** (por ejemplo, `main`):

    ```bash
    git checkout main
    ```

2. **Hacer el rebase** de los cambios de la rama remota:

    ```bash
    git rebase origin/nombre-de-la-rama
    ```

### Ejemplo práctico

Supongamos que tienes una rama llamada `feature-branch` en tu repositorio remoto en GitHub, y quieres traer esos cambios a tu rama local `main`.

#### Usar `merge`

1. Cambia a la rama `main`:

    ```bash
    git checkout main
    ```

2. Trae los cambios de la rama remota `feature-branch`:

    ```bash
    git fetch origin
    git merge origin/feature-branch
    ```

#### Usar `rebase`

1. Cambia a la rama `main`:

    ```bash
    git checkout main
    ```

2. Trae los cambios de la rama remota `feature-branch`:

    ```bash
    git fetch origin
    git rebase origin/feature-branch
    ```

### Nota

- Si no tienes la rama local correspondiente, puedes crearla directamente desde la rama remota:

    ```bash
    git checkout -b nombre-de-la-rama-local origin/nombre-de-la-rama-remota
    ```

- Después de hacer `merge` o `rebase`, si deseas actualizar el repositorio remoto con tus cambios locales (en caso de que haya nuevos commits), usa:

    ```bash
    git push origin nombre-de-la-rama
    ```

Siguiendo estos pasos, podrás traer los cambios de una rama de tu repositorio de GitHub a tu repositorio local de manera eficiente.

## Git fetch vs git pull
### Diferencias entre `git fetch` y `git pull`

- **`git fetch`**:
  - `git fetch` actualiza tu repositorio local con los cambios más recientes del repositorio remoto. No fusiona esos cambios en tu rama actual; simplemente actualiza las referencias remotas.
  - Esto te permite revisar los cambios antes de integrarlos.

- **`git pull`**:
  - `git pull` es equivalente a ejecutar `git fetch` seguido de `git merge`. Trae los cambios del repositorio remoto y los fusiona directamente en tu rama actual.

### Cuándo usar `git fetch`

Usar `git fetch` seguido de un comando como `git merge` o `git rebase` te da más control sobre cómo y cuándo integras los cambios. Este enfoque es útil cuando deseas revisar los cambios antes de aplicarlos.

### Ejemplo práctico usando `git fetch`

1. **Actualizar las referencias remotas**:

    ```bash
    git fetch origin
    ```

2. **Revisar los cambios (opcional)**:

    Puedes revisar los cambios que se han traído con `fetch` antes de fusionarlos.

    ```bash
    git log origin/nombre-de-la-rama
    ```

3. **Integrar los cambios**:
    - **Usando `merge`**:

        Cambia a la rama en la que deseas integrar los cambios (por ejemplo, `main`):

        ```bash
        git checkout main
        ```

        Haz el merge con la rama remota:

        ```bash
        git merge origin/nombre-de-la-rama
        ```

    - **Usando `rebase`**:

        Cambia a la rama en la que deseas integrar los cambios (por ejemplo, `main`):

        ```bash
        git checkout main
        ```

        Haz el rebase con la rama remota:

        ```bash
        git rebase origin/nombre-de-la-rama
        ```

### Ejemplo práctico usando `git pull`

Si deseas traer y fusionar los cambios en un solo paso, puedes usar `git pull`.

1. **Cambiar a la rama en la que deseas integrar los cambios** (por ejemplo, `main`):

    ```bash
    git checkout main
    ```

2. **Traer y fusionar los cambios de la rama remota**:

    ```bash
    git pull origin nombre-de-la-rama
    ```

### ¿Cuál usar?

- **`git fetch` seguido de `merge` o `rebase`**:
  - Más control sobre la integración de cambios.
  - Puedes revisar los cambios antes de integrarlos.
  - Útil en entornos de desarrollo colaborativos donde deseas evitar conflictos de integración inesperados.

- **`git pull`**:
  - Más rápido y conveniente si confías en los cambios y deseas fusionarlos directamente.
  - Útil para mantener ramas de desarrollo sincronizadas rápidamente.

Ambos métodos son válidos, y la elección depende de tu flujo de trabajo y necesidades específicas.

## Revertir commit en Git (local)
Para revertir un commit en Git y volver el HEAD a un commit anterior, puedes seguir estos pasos:

### 1. Verificar el commit que deseas deshacer
Primero, asegúrate de cuál es el commit al que quieres regresar el HEAD. En este ejemplo vamos a revertir el commit más reciente _
_"anterior al actual"_ `ef1794f`.

### 2. Usar `git reset` para mover el HEAD
Abre tu terminal y navega hasta el directorio de tu repositorio local. Luego, ejecuta el siguiente comando:

```bash
git reset --hard HEAD^
```

Este comando hará lo siguiente:
- `git reset --hard`: Revertirá el HEAD y el índice al commit especificado.
- `HEAD^`: Este es un atajo para referirse al commit anterior al actual.

Después de ejecutar este comando, el commit `ef1794f` y todos los cambios realizados en él serán eliminados del árbol de confirmaciones y el HEAD se moverá al commit anterior (`e61d56b` en tu caso).

### 3. Verificar el estado del repositorio
Puedes usar `git log` para verificar que el HEAD esté ahora en el commit correcto:

```bash
git log --oneline
```

Esto mostrará los últimos commits en una línea cada uno, para que puedas asegurarte de que el HEAD esté donde quieres que esté.

### 4. Ajustar la rama remota (si es necesario)
Si ya has empujado el commit `ef1794f` a la rama remota y necesitas ajustarla también, puedes usar `git push --force` para forzar la actualización de la rama remota:

```bash
git push origin v01.03 --force
```

**Nota de precaución:** Ten cuidado al usar `git push --force` ya que sobrescribirá la historia del repositorio remoto. Esto puede causar problemas si otros colaboradores ya tienen copias del repositorio con el commit que estás eliminando.

### Resumen
- `git reset --hard HEAD^`: Revierte el HEAD al commit anterior y elimina todos los cambios hechos en el commit que quieres deshacer.
- Después de esto, verifica el estado del repositorio local y decide si necesitas ajustar la rama remota.

Siguiendo estos pasos, podrás deshacer el commit no deseado y regresar el HEAD a su estado anterior en tu rama local.