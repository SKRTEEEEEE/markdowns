# Ejercicios extra de Clases y herencia en TypeScript

## Conjunto 1: Gestión de Vehículos

Necesitamos construir la lógica del dominio para gestionar distintos tipos de vehículos en una empresa de alquiler. Cada vehículo debe tener una categoría (`'Compacto'`, `'SUV'`, `'Sedán'`).

### Ejercicio 1

- **1.1)** Crea dos clases que hereden de una clase base para clasificar el tipo de vehículo (`'Eléctrico'` o `'Combustión'`).
- **1.2)** Crea una propiedad con el tipo de vehículo (`'Eléctrico'` o `'Combustión'`) dentro de la clase base y asígnale un valor en las clases extendidas.

### Ejercicio 2
> En nuestra empresa, los vehículos eléctricos tienen tarifas especiales y deben tener un identificador de recarga, mientras que los vehículos de combustión tienen una tarifa estándar y un número de litros de combustible.

- **2.1)** Usa una interfaz para que la clase base tenga un método que devuelva la tarifa de alquiler según el tipo de vehículo.
- **2.2)** Implementa la funcionalidad de ese método en las clases extendidas para que devuelvan el valor correspondiente. Si el tipo es `'Eléctrico'`, la tarifa debe ser `15` por hora, y si es `'Combustión'`, la tarifa debe ser `10` por hora.

### Ejercicio 3

- **3.1)** Crea un test que compruebe que la propiedad tipo de vehículo existe en las clases extendidas.
- **3.2)** Crea un test que compruebe que el método de devolver la tarifa de alquiler se ejecuta correctamente para ambos tipos de vehículos.

---

## Conjunto 2: Sistema de Gestión de Empleados

En una empresa, necesitamos gestionar distintos tipos de empleados. Cada empleado debe tener un rol (`'Desarrollador'`, `'Diseñador'`, `'Gerente'`).

### Ejercicio 1

- **1.1)** Crea dos clases que hereden de una clase base para clasificar el tipo de empleado (`'Tiempo Completo'` o `'Medio Tiempo'`).
- **1.2)** Crea una propiedad con el tipo de empleado (`'Tiempo Completo'` o `'Medio Tiempo'`) dentro de la clase base y asígnale un valor en las clases extendidas.

### Ejercicio 2
> Los empleados de tiempo completo tienen un salario fijo mensual y beneficios adicionales, mientras que los empleados de medio tiempo tienen un salario basado en horas trabajadas sin beneficios adicionales.

- **2.1)** Usa una interfaz para que la clase base tenga un método que devuelva el salario según el tipo de empleado.
- **2.2)** Implementa la funcionalidad de ese método en las clases extendidas para que devuelvan el valor correspondiente. Si el tipo es `'Tiempo Completo'`, la clase debe devolver un salario fijo de `3000` al mes, y si es `'Medio Tiempo'`, debe calcular el salario basado en las horas trabajadas y una tarifa de `20` por hora.

### Ejercicio 3

- **3.1)** Crea un test que compruebe que la propiedad tipo de empleado existe en las clases extendidas.
- **3.2)** Crea un test que compruebe que el método de calcular el salario se ejecuta correctamente para ambos tipos de empleados.

***
## Conjunto 3: Sistema de Gestión de Productos

Vamos a construir un sistema para gestionar diferentes tipos de productos en un inventario. Cada producto debe tener una categoría (`'Electrónico'`, `'Mueble'`, `'Ropa'`).

### Ejercicio 1

- **1.1)** Define un tipo `CategoríaProducto` que pueda ser `'Electrónico'`, `'Mueble'` o `'Ropa'`.
- **1.2)** Crea una clase base `Producto` que tenga propiedades `nombre` (de tipo `string`), `precio` (de tipo `number`), y `categoria` (de tipo `CategoríaProducto`). Usa modificadores de acceso para definir las propiedades como `private` o `protected` según corresponda.
- **1.3)** Crea dos clases que hereden de `Producto`, una para cada tipo de producto (`Electrónico` y `Mueble`). Cada clase debe tener métodos públicos para acceder y modificar las propiedades privadas.

### Ejercicio 2
> Los productos electrónicos tienen una garantía de un año, mientras que los muebles tienen un período de prueba de 30 días.

- **2.1)** Usa una interfaz `ProductoConGarantía` que tenga un método `obtenerGarantía()` para obtener la duración de la garantía.
- **2.2)** Implementa la interfaz en las clases derivadas `Electrónico` y `Mueble`. La clase `Electrónico` debe devolver `12 meses` y la clase `Mueble` debe devolver `30 días`.

### Ejercicio 3

- **3.1)** Crea un test que verifique que las propiedades `nombre` y `precio` están protegidas y solo accesibles mediante métodos públicos.
- **3.2)** Crea un test que compruebe que el método `obtenerGarantía()` devuelve la garantía correcta para cada tipo de producto.

---

## Conjunto 4: Gestión de Proyectos

Desarrollaremos un sistema para gestionar proyectos y empleados en una empresa. Cada empleado debe tener un rol (`'Desarrollador'`, `'Diseñador'`, `'Gerente'`).

### Ejercicio 1

- **1.1)** Define un tipo `RolEmpleado` que puede ser `'Desarrollador'`, `'Diseñador'` o `'Gerente'`.
- **1.2)** Crea una clase base `Empleado` que tenga propiedades `nombre` (de tipo `string`), `edad` (de tipo `number`), y `rol` (de tipo `RolEmpleado`). Usa modificadores de acceso para definir las propiedades como `private` o `protected` según corresponda.
- **1.3)** Crea dos clases que hereden de `Empleado`, `Desarrollador` y `Diseñador`. Cada clase debe tener métodos públicos para acceder y modificar las propiedades privadas.

### Ejercicio 2
> Los desarrolladores tienen un proyecto asignado, mientras que los diseñadores tienen un equipo asignado. Ambos deben poder devolver información relevante.

- **2.1)** Usa una interfaz `Responsabilidad` que defina un método `obtenerResponsabilidad()` que devuelva un texto descriptivo.
- **2.2)** Implementa la interfaz en las clases `Desarrollador` y `Diseñador`. La clase `Desarrollador` debe devolver el proyecto asignado y la clase `Diseñador` debe devolver el equipo asignado.

### Ejercicio 3

- **3.1)** Crea un test que verifique que las propiedades `nombre` y `edad` están protegidas y solo accesibles mediante métodos públicos.
- **3.2)** Crea un test que compruebe que el método `obtenerResponsabilidad()` devuelve la información correcta para cada tipo de rol.

***

## Conjunto 5: App Gestión Usuarios
### Paso a paso
#### Paso 1: Definir las Enumeraciones

1. **Definir Enumeración `Rol`**:
   - Define una enumeración `Rol` que tenga valores para los diferentes roles de usuario, como `Admin` y `Cliente`.

2. **Definir Enumeración `EstadoAuth`**:
   - Define una enumeración `EstadoAuth` con valores como `NoAuth` y `Auth`.

#### Paso 2: Crear la Clase Abstracta `Usuario`

1. **Propiedades Privadas**:
   - Define propiedades privadas para `id`, `nombre`, `rol`, y `estadoAuth`.

2. **Lógica del ID**:
   - Implementa una lógica de generación de ID que asegure que cada usuario tenga un ID único. Utiliza una variable estática que incremente el ID cada vez que se crea un nuevo usuario.

3. **Constructor**:
   - Crea un constructor que inicialice las propiedades. El ID debe generarse utilizando la lógica definida.

4. **Método Abstracto `getInfo`**:
   - Define un método abstracto `getInfo()` que devuelva la información del usuario en formato de cadena.

5. **Métodos Públicos**:
   - Define métodos públicos para obtener y modificar el estado de autenticación del usuario y un método público para obtener el nombre.

#### Paso 3: Implementar Clases Derivadas para Diferentes Tipos de Usuarios

1. **Clase `Admin`**:
   - Crea una clase `Admin` que extienda `Usuario`.
   - El método `getInfo()` debe devolver la información específica del administrador.

2. **Clase `Cliente`**:
   - Crea una clase `Cliente` que extienda `Usuario`.
   - El método `getInfo()` debe devolver la información específica del cliente.
   
#### Paso 4: Implementar el Sistema de Autenticación

1. **Clase `AuthService`**:
   - Crea una clase `AuthService` que gestione el proceso de autenticación de usuarios.
   - Define una estructura adecuada (como un array o un mapa) para almacenar los usuarios registrados.

2. **Método `registrarUsuario`**:
   - Implementa un método `registrarUsuario` que reciba un objeto de tipo `Usuario` y lo agregue a la estructura de usuarios.

3. **Método `iniciarSesion`**:
   - Implementa un método `iniciarSesion` que reciba un nombre de usuario y, si el usuario está registrado, actualice su estado de autenticación a `Auth`.

4. **Método `verificarAutenticacion`**:
   - Implementa un método `verificarAutenticacion` que reciba un nombre de usuario y verifique si el usuario está autenticado.

#### Paso 5: Escribir Pruebas Unitarias

1. **Pruebas de Registro y Autenticación**:
   - Escribe pruebas para verificar que los usuarios se pueden registrar correctamente.
   - Escribe pruebas para verificar que los usuarios pueden iniciar sesión y que el estado de autenticación se actualiza correctamente.


