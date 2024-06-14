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