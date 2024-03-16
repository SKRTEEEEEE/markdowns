# Git

## Repositorio temporal
Clonar a un repositorio temporal para luego extraer en la carpeta raiz e eliminar la carpeta original(copiada de github con el seguimiento)
*Sirve para copiar repos sin permiso del autor y dejar de seguir* Para ejecutar correctamente se debe lanzar los codigos en **la carpeta donde se va a crear el proyecto**
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

*Después de ejecutar este comando, Git intentará fusionar las historias de las dos ramas. Sin embargo, ten en cuenta que es posible que tengas que resolver conflictos si existen diferencias significativas entre las ramas.*


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
*Eliminando el archivo . git*

- Navega al directorio raíz del repositorio local que deseas dejar de seguir.
- Utiliza el comando `rm -rf .git` para eliminar el directorio `.git` y todos sus contenidos.