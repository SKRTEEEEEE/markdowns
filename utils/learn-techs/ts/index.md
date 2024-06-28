







# Enums y aserciones
## Enums
### Uso de enums
### Compilación
#### enums en js
#### const enums
#### const enums vs enums
##### indicar el tipo
##### enums para "consumo externo"
Es mejor usar los enums "simples" sobretodo cuando tu enum va a ser usado fuera, por ejemplo una Libreria
## Aserciones de tipos
### Aserción simple
#### Porque es necesario
#### Ejemplo simple
##### Sin aserción
```typescript
const canvas = document.querySelector("canvas")

//null si no lo encuentra
//HTMLElement si lo encuentra

if (canvas !== null) {
    const c = canvas.getContext("2d")//❌ -> Se queja del tipo, porque es exclusivo de canvas y recupera HTMLElement
}
``` 
##### Aserción
```typescript
const canvas = document.querySelector("canvas") as HTMLCanvasElement

if (canvas !== null) {
    const c = canvas.getContext("2d")
}
```
#### Comprobación "condicional"
### `instanceof`
#### Que es y porque es necesario
#### Inferencia con TypeScript
#### Ejemplo simple
##### Explicación
#### `instanceof` vs `typeof`
##### `typeof` -> para tipos
strings, booleans, numbers, etc..
##### `instanceof` -> para instancias
fechas, etc..
### Aserciones de fetch

#### Quicktype y similares



# Interfaces y mas
## Interfaces
### Introducción
Que es, porque usar..
### Usos comunes
#### Usos propios
##### `extends`
##### "Acumulación de Interfaces"
Permite definir las Interfaces por partes
### `interface` vs `type`
#### Resumen diferencias
#### Pros y contras `interface`
#### Pros y contras `type`
#### Recomendación
## Narrowing y mas
### Narrowing
#### Introducción
Que es, porque usar..
#### Ejemplo básico
#### Ejemplo interfaz de funciones
#### Type Guard
##### Introducción
Que es, porque usar, y ejemplo explicativo
##### Compilación a JS
### `never`
## Modificadores
### Introducción
### Explicación detallada
#### `readonly`
#### `private`
#### `public`
#### `protected`
## Tipado de Classes


