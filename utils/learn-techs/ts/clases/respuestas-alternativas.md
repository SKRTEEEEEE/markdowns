
## Sección 1
### Respuestas de los Ejercicios de la Subsección 1.1: Definición y Creación de Clases

#### Ejercicio 1
**Define una clase `Estudiante` con propiedades `nombre`, `edad` y `curso`. Incluye un método `presentarse` que imprima un mensaje con esta información. Crea una instancia de `Estudiante` y llama al método `presentarse`.**

```typescript
class Estudiante {
  nombre: string;
  edad: number;
  curso: string;

  constructor(nombre: string, edad: number, curso: string) {
    this.nombre = nombre;
    this.edad = edad;
    this.curso = curso;
  }

  presentarse(): void {
    console.log(`Hola, me llamo ${this.nombre}, tengo ${this.edad} años y estoy en el curso de ${this.curso}.`);
  }
}

const estudiante1 = new Estudiante('Ana', 22, 'Matemáticas');
estudiante1.presentarse();  // Salida: Hola, me llamo Ana, tengo 22 años y estoy en el curso de Matemáticas.
```

#### Ejercicio 2
**Crea una clase `Libro` con propiedades `titulo`, `autor` y `numPaginas`. Agrega un método `descripcion` que imprima los detalles del libro. Luego, crea dos instancias de la clase `Libro` y llama al método `descripcion` para cada instancia.**

```typescript
class Libro {
  titulo: string;
  autor: string;
  numPaginas: number;

  constructor(titulo: string, autor: string, numPaginas: number) {
    this.titulo = titulo;
    this.autor = autor;
    this.numPaginas = numPaginas;
  }

  descripcion(): void {
    console.log(`Libro: ${this.titulo}, Autor: ${this.autor}, Número de páginas: ${this.numPaginas}`);
  }
}

const libro1 = new Libro('Cien años de soledad', 'Gabriel García Márquez', 417);
const libro2 = new Libro('El Quijote', 'Miguel de Cervantes', 863);

libro1.descripcion();  // Salida: Libro: Cien años de soledad, Autor: Gabriel García Márquez, Número de páginas: 417
libro2.descripcion();  // Salida: Libro: El Quijote, Autor: Miguel de Cervantes, Número de páginas: 863
```

#### Ejercicio 3
**Desarrolla una mini aplicación que gestione una lista de `Producto`. Define una clase `Producto` con propiedades `nombre`, `precio` y `categoria`. Crea métodos para agregar productos a una lista y mostrar todos los productos en la lista. Implementa pruebas unitarias para verificar la funcionalidad de agregar y listar productos.**

```typescript
class Producto {
  nombre: string;
  precio: number;
  categoria: string;

  constructor(nombre: string, precio: number, categoria: string) {
    this.nombre = nombre;
    this.precio = precio;
    this.categoria = categoria;
  }

  descripcion(): string {
    return `Producto: ${this.nombre}, Precio: ${this.precio}, Categoría: ${this.categoria}`;
  }
}

class Inventario {
  private productos: Producto[] = [];

  agregarProducto(producto: Producto): void {
    this.productos.push(producto);
  }

  mostrarProductos(): void {
    this.productos.forEach((producto) => {
      console.log(producto.descripcion());
    });
  }
}

// Creación de la mini aplicación
const inventario = new Inventario();
const producto1 = new Producto('Laptop', 1000, 'Electrónica');
const producto2 = new Producto('Camisa', 50, 'Ropa');

inventario.agregarProducto(producto1);
inventario.agregarProducto(producto2);

inventario.mostrarProductos();
// Salida:
// Producto: Laptop, Precio: 1000, Categoría: Electrónica
// Producto: Camisa, Precio: 50, Categoría: Ropa

// Pruebas unitarias (usando Jest, por ejemplo)
/*
import { describe, expect, test } from '@jest/globals';

describe('Inventario', () => {
  test('debería agregar productos y mostrarlos correctamente', () => {
    const inventario = new Inventario();
    const producto1 = new Producto('Laptop', 1000, 'Electrónica');
    const producto2 = new Producto('Camisa', 50, 'Ropa');

    inventario.agregarProducto(producto1);
    inventario.agregarProducto(producto2);

    const productosEsperados = [
      'Producto: Laptop, Precio: 1000, Categoría: Electrónica',
      'Producto: Camisa, Precio: 50, Categoría: Ropa'
    ];

    let productosMostrados: string[] = [];
    jest.spyOn(console, 'log').mockImplementation((msg) => {
      productosMostrados.push(msg);
    });

    inventario.mostrarProductos();

    expect(productosMostrados).toEqual(productosEsperados);
  });
});
*/
```

### Respuestas de los Ejercicios de la Subsección 1.2: Propiedades y Métodos

#### Ejercicio 1
**Define una clase `Persona` con propiedades `nombre` (public), `edad` (private) y `direccion` (protected). Crea métodos públicos para mostrar el nombre, y métodos privados y protegidos para mostrar la edad y la dirección. Crea una instancia de `Persona` y muestra el nombre utilizando el método público.**

```typescript
class Persona {
  public nombre: string;
  private edad: number;
  protected direccion: string;

  constructor(nombre: string, edad: number, direccion: string) {
    this.nombre = nombre;
    this.edad = edad;
    this.direccion = direccion;
  }

  public mostrarNombre(): void {
    console.log(`Nombre: ${this.nombre}`);
  }

  private mostrarEdad(): void {
    console.log(`Edad: ${this.edad}`);
  }

  protected mostrarDireccion(): void {
    console.log(`Dirección: ${this.direccion}`);
  }
}

const persona1 = new Persona('Carlos', 28, 'Calle Falsa 123');
persona1.mostrarNombre();  // Salida: Nombre: Carlos
// persona1.mostrarEdad(); // Error: método privado
// persona1.mostrarDireccion(); // Error: método protegido
```

#### Ejercicio 2
**Crea una clase `CuentaBancaria` con propiedades `titular`, `saldo` (private) y `moneda`. Incluye métodos para `depositar` (public), `retirar` (public) y un método privado `actualizarSaldo`. Utiliza métodos getters y setters para acceder y modificar el saldo. Implementa pruebas unitarias para verificar las funcionalidades.**

```typescript
class CuentaBancaria {
  public titular: string;
  private _saldo: number;
  public moneda: string;

  constructor(titular: string, saldo: number, moneda: string) {
    this.titular = titular;
    this._saldo = saldo;
    this.moneda = moneda;
  }

  public depositar(monto: number): void {
    this._saldo += monto;
    this.actualizarSaldo();
  }

  public retirar(monto: number): void {
    if (monto <= this._saldo) {
      this._saldo -= monto;
      this.actualizarSaldo();
    } else {
      console.log('Saldo insuficiente');
    }
  }

  private actualizarSaldo(): void {
    console.log(`El saldo actual de la cuenta de ${this.titular} es: ${this._saldo} ${this.moneda}`);
  }

  public get saldo(): number {
    return this._saldo;
  }

  public set saldo(saldo: number) {
    this._saldo = saldo;
    this.actualizarSaldo();
  }
}

const cuenta1 = new CuentaBancaria('Ana', 1000, 'USD');
cuenta1.depositar(500);   // Salida: El saldo actual de la cuenta de Ana es: 1500 USD
cuenta1.retirar(300);     // Salida: El saldo actual de la cuenta de Ana es: 1200 USD
console.log(cuenta1.saldo); // Salida: 1200

// Pruebas unitarias (usando Jest, por ejemplo)
/*
import { describe, expect, test } from '@jest/globals';

describe('CuentaBancaria', () => {
  test('debería depositar y retirar correctamente', () => {
    const cuenta = new CuentaBancaria('Ana', 1000, 'USD');
    cuenta.depositar(500);
    expect(cuenta.saldo).toBe(1500);

    cuenta.retirar(300);
    expect(cuenta.saldo).toBe(1200);
  });

  test('debería mostrar mensaje de saldo insuficiente', () => {
    const cuenta = new CuentaBancaria('Ana', 1000, 'USD');
    console.log = jest.fn();
    cuenta.retirar(1500);
    expect(console.log).toHaveBeenCalledWith('Saldo insuficiente');
  });
});
*/
```

#### Ejercicio 3
**Desarrolla una mini aplicación que gestione una lista de `Empleado`. Define una clase `Empleado` con propiedades `nombre`, `salario` (private) y `puesto`. Crea métodos para agregar empleados a una lista, mostrar todos los empleados y actualizar el salario de un empleado utilizando setters. Implementa pruebas unitarias para verificar la funcionalidad de agregar, listar y actualizar empleados.**

```typescript
class Empleado {
  public nombre: string;
  private _salario: number;
  public puesto: string;

  constructor(nombre: string, salario: number, puesto: string) {
    this.nombre = nombre;
    this._salario = salario;
    this.puesto = puesto;
  }

  public get salario(): number {
    return this._salario;
  }

  public set salario(salario: number) {
    this._salario = salario;
  }

  public descripcion(): string {
    return `Empleado: ${this.nombre}, Salario: ${this._salario}, Puesto: ${this.puesto}`;
  }
}

class Empresa {
  private empleados: Empleado[] = [];

  public agregarEmpleado(empleado: Empleado): void {
    this.empleados.push(empleado);
  }

  public mostrarEmpleados(): void {
    this.empleados.forEach((empleado) => {
      console.log(empleado.descripcion());
    });
  }

  public actualizarSalario(nombre: string, nuevoSalario: number): void {
    const empleado = this.empleados.find(emp => emp.nombre === nombre);
    if (empleado) {
      empleado.salario = nuevoSalario;
    }
  }
}

// Creación de la mini aplicación
const empresa = new Empresa();
const empleado1 = new Empleado('Luis', 3000, 'Desarrollador');
const empleado2 = new Empleado('Marta', 3500, 'Diseñadora');

empresa.agregarEmpleado(empleado1);
empresa.agregarEmpleado(empleado2);

empresa.mostrarEmpleados();
// Salida:
// Empleado: Luis, Salario: 3000, Puesto: Desarrollador
// Empleado: Marta, Salario: 3500, Puesto: Diseñadora

empresa.actualizarSalario('Luis', 3200);
empresa.mostrarEmpleados();
// Salida actualizada:
// Empleado: Luis, Salario: 3200, Puesto: Desarrollador
// Empleado: Marta, Salario: 3500, Puesto: Diseñadora

// Pruebas unitarias (usando Jest, por ejemplo)
/*
import { describe, expect, test } from '@jest/globals';

describe('Empresa', () => {
  test('debería agregar y listar empleados correctamente', () => {
    const empresa = new Empresa();
    const empleado1 = new Empleado('Luis', 3000, 'Desarrollador');
    const empleado2 = new Empleado('Marta', 3500, 'Diseñadora');

    empresa.agregarEmpleado(empleado1);
    empresa.agregarEmpleado(empleado2);

    const empleadosEsperados = [
      'Empleado: Luis, Salario: 3000, Puesto: Desarrollador',
      'Empleado: Marta, Salario: 3500, Puesto: Diseñadora'
    ];

    let empleadosMostrados: string[] = [];
    jest.spyOn(console, 'log').mockImplementation((msg) => {
      empleadosMostrados.push(msg);
    });

    empresa.mostrarEmpleados();

    expect(empleadosMostrados).toEqual(empleadosEsperados);
  });

  test('debería actualizar el salario de un empleado correctamente', () => {
    const empresa = new Empresa();
    const empleado1 = new Empleado('Luis', 3000, 'Desarrollador');
    empresa.agregarEmpleado(empleado1);
    empresa.actualizarSalario('Luis', 3200);

    expect(empleado1.salario).toBe(3200);
  });
});
*/
```



### Respuestas de los Ejercicios de la Subsección 1.3: Herencia y extensión de clases.

#### Ejercicio 1
Crea una clase `Persona` con propiedades `nombre` y `edad`, y un método `presentarse` que imprima un mensaje de presentación. Luego, crea una subclase `Estudiante` que herede de `Persona` e incluya una propiedad `grado` y sobrescriba el método `presentarse` para incluir el grado en el mensaje.

```typescript
class Persona {
  nombre: string;
  edad: number;

  constructor(nombre: string, edad: number) {
    this.nombre = nombre;
    this.edad = edad;
  }

  presentarse() {
    console.log(`Hola, me llamo ${this.nombre} y tengo ${this.edad} años.`);
  }
}

class Estudiante extends Persona {
  grado: string;

  constructor(nombre: string, edad: number, grado: string) {
    super(nombre, edad);
    this.grado = grado;
  }

  presentarse() {
    console.log(`Hola, me llamo ${this.nombre}, tengo ${this.edad} años y estoy en el grado ${this.grado}.`);
  }
}

const estudiante = new Estudiante("Ana", 20, "3er año");
estudiante.presentarse(); // Hola, me llamo Ana, tengo 20 años y estoy en el grado 3er año.
```

#### Ejercicio 2
Crea una clase `Empleado` con propiedades `nombre`, `salario` y un método `trabajar`. Luego, crea dos subclases `Ingeniero` y `Diseñador` que hereden de `Empleado` e incluyan propiedades adicionales y sobrescriban el método `trabajar` para que impriman un mensaje específico para cada tipo de empleado.

```typescript
class Empleado {
  nombre: string;
  salario: number;

  constructor(nombre: string, salario: number) {
    this.nombre = nombre;
    this.salario = salario;
  }

  trabajar() {
    console.log(`${this.nombre} está trabajando.`);
  }
}

class Ingeniero extends Empleado {
  especialidad: string;

  constructor(nombre: string, salario: number, especialidad: string) {
    super(nombre, salario);
    this.especialidad = especialidad;
  }

  trabajar() {
    console.log(`${this.nombre}, el ingeniero de ${this.especialidad}, está diseñando un nuevo proyecto.`);
  }
}

class Diseñador extends Empleado {
  herramienta: string;

  constructor(nombre: string, salario: number, herramienta: string) {
    super(nombre, salario);
    this.herramienta = herramienta;
  }

  trabajar() {
    console.log(`${this.nombre}, el diseñador que usa ${this.herramienta}, está creando un nuevo diseño.`);
  }
}

const ingeniero = new Ingeniero("Carlos", 50000, "software");
const diseñador = new Diseñador("Lucía", 45000, "Photoshop");

ingeniero.trabajar(); // Carlos, el ingeniero de software, está diseñando un nuevo proyecto.
diseñador.trabajar(); // Lucía, la diseñadora que usa Photoshop, está creando un nuevo diseño.
```

#### Ejercicio 3
Desarrolla una mini aplicación que modele un sistema de transporte. Crea una clase base `Transporte` con propiedades comunes como `velocidad` y `capacidad`. Luego, crea subclases `Bicicleta`, `Coche` y `Avion` que extiendan `Transporte`, añadiendo propiedades y métodos específicos para cada tipo de transporte. Implementa pruebas unitarias para asegurarte de que los métodos de cada subclase funcionen correctamente.

```typescript
class Transporte {
  velocidad: number;
  capacidad: number;

  constructor(velocidad: number, capacidad: number) {
    this.velocidad = velocidad;
    this.capacidad = capacidad;
  }

  moverse() {
    console.log(`Este transporte se mueve a una velocidad de ${this.velocidad} km/h.`);
  }
}

class Bicicleta extends Transporte {
  tipo: string;

  constructor(velocidad: number, capacidad: number, tipo: string) {
    super(velocidad, capacidad);
    this.tipo = tipo;
  }

  moverse() {
    console.log(`La bicicleta de tipo ${this.tipo} se mueve a una velocidad de ${this.velocidad} km/h.`);
  }
}

class Coche extends Transporte {
  combustible: string;

  constructor(velocidad: number, capacidad: number, combustible: string) {
    super(velocidad, capacidad);
    this.combustible = combustible;
  }

  moverse() {
    console.log(`El coche que usa ${this.combustible} se mueve a una velocidad de ${this.velocidad} km/h.`);
  }
}

class Avion extends Transporte {
  aerolinea: string;

  constructor(velocidad: number, capacidad: number, aerolinea: string) {
    super(velocidad, capacidad);
    this.aerolinea = aerolinea;
  }

  moverse() {
    console.log(`El avión de la aerolínea ${this.aerolinea} se mueve a una velocidad de ${this.velocidad} km/h.`);
  }
}

// Pruebas unitarias con Jest
// Instala Jest con: npm install --save-dev jest @types/jest ts-jest

// jest.config.js
// module.exports = {
//   preset: 'ts-jest',
//   testEnvironment: 'node',
// };

// __tests__/transporte.test.ts
import { Bicicleta, Coche, Avion } from '../src/transporte';

test('La bicicleta se mueve correctamente', () => {
  const bicicleta = new Bicicleta(25, 1, "montaña");
  expect(bicicleta.moverse()).toBe("La bicicleta de tipo montaña se mueve a una velocidad de 25 km/h.");
});

test('El coche se mueve correctamente', () => {
  const coche = new Coche(120, 5, "gasolina");
  expect(coche.moverse()).toBe("El coche que usa gasolina se mueve a una velocidad de 120 km/h.");
});

test('El avión se mueve correctamente', () => {
  const avion = new Avion(900, 180, "AeroMexico");
  expect(avion.moverse()).toBe("El avión de la aerolínea AeroMexico se mueve a una velocidad de 900 km/h.");
});
```


## Sección 2

### Respuestas de los Ejercicios de la Subsección 2.1: Interfaces en TypeScript

#### Ejercicio 1

```typescript
// Interfaz Cliente
interface Cliente {
  nombre: string;
  edad: number;
  mostrarDetalles(): void;
}

// Clase ClienteVIP
class ClienteVIP implements Cliente {
  public nombre: string;
  public edad: number;
  public nivel: string;

  constructor(nombre: string, edad: number, nivel: string) {
    this.nombre = nombre;
    this.edad = edad;
    this.nivel = nivel;
  }

  mostrarDetalles(): void {
    console.log(`Nombre: ${this.nombre}, Edad: ${this.edad}, Nivel: ${this.nivel}`);
  }
}

// Pruebas Unitarias
const cliente1 = new ClienteVIP('Ana', 30, 'Oro');
cliente1.mostrarDetalles();  // Salida: Nombre: Ana, Edad: 30, Nivel: Oro

const cliente2 = new ClienteVIP('Luis', 45, 'Plata');
cliente2.mostrarDetalles();  // Salida: Nombre: Luis, Edad: 45, Nivel: Plata

```


#### Ejercicio 2
```typescript
// Interfaz Empleado
interface Empleado {
  nombre: string;
  edad: number;
  mostrarInformacion(): void;
}

// Clase EmpleadoRegular
class EmpleadoRegular implements Empleado {
  private _nombre: string;
  protected _edad: number;

  constructor(nombre: string, edad: number) {
    this._nombre = nombre;
    this._edad = edad;
  }

  // Getters y Setters
  get nombre(): string {
    return this._nombre;
  }

  set nombre(value: string) {
    this._nombre = value;
  }

  get edad(): number {
    return this._edad;
  }

  set edad(value: number) {
    this._edad = value;
  }

  mostrarInformacion(): void {
    console.log(`Nombre: ${this._nombre}, Edad: ${this._edad}`);
  }
}

// Clase Gerente
class Gerente extends EmpleadoRegular {
  private _departamento: string;

  constructor(nombre: string, edad: number, departamento: string) {
    super(nombre, edad);
    this._departamento = departamento;
  }

  // Getters y Setters
  get departamento(): string {
    return this._departamento;
  }

  set departamento(value: string) {
    this._departamento = value;
  }

  mostrarInformacion(): void {
    console.log(`Nombre: ${this.nombre}, Edad: ${this.edad}, Departamento: ${this._departamento}`);
  }
}

// Pruebas Unitarias
const empleado = new EmpleadoRegular('Carlos', 35);
empleado.mostrarInformacion();  // Salida: Nombre: Carlos, Edad: 35

const gerente = new Gerente('María', 40, 'IT');
gerente.mostrarInformacion();  // Salida: Nombre: María, Edad: 40, Departamento: IT
```

#### Ejercicio 3
```typescript
// Interfaz Trabajador
interface Trabajador {
  salario: number;
  calcularAnual(): number;
}

// Clase EmpleadoRegular implementando Trabajador
class EmpleadoRegular implements Empleado, Trabajador {
  private _nombre: string;
  protected _edad: number;
  public salario: number;

  constructor(nombre: string, edad: number, salario: number) {
    this._nombre = nombre;
    this._edad = edad;
    this.salario = salario;
  }

  // Getters y Setters
  get nombre(): string {
    return this._nombre;
  }

  set nombre(value: string) {
    this._nombre = value;
  }

  get edad(): number {
    return this._edad;
  }

  set edad(value: number) {
    this._edad = value;
  }

  mostrarInformacion(): void {
    console.log(`Nombre: ${this._nombre}, Edad: ${this._edad}`);
  }

  calcularAnual(): number {
    return this.salario * 12;
  }
}

// Clase Contratista implementando Trabajador
class Contratista extends EmpleadoRegular {
  public horasTrabajadas: number;

  constructor(nombre: string, edad: number, salario: number, horasTrabajadas: number) {
    super(nombre, edad, salario);
    this.horasTrabajadas = horasTrabajadas;
  }

  calcularAnual(): number {
    return this.salario * this.horasTrabajadas;
  }
}

// Pruebas Unitarias
const empleadoRegular = new EmpleadoRegular('Javier', 30, 3000);
empleadoRegular.mostrarInformacion();  // Salida: Nombre: Javier, Edad: 30
console.log(`Salario Anual: ${empleadoRegular.calcularAnual()}`);  // Salida: Salario Anual: 36000

const contratista = new Contratista('Lucía', 28, 50, 160);
contratista.mostrarInformacion();  // Salida: Nombre: Lucía, Edad: 28
console.log(`Salario Anual: ${contratista.calcularAnual()}`);  // Salida: Salario Anual: 8000
```

### Respuestas de los Ejercicios de la Subsección 2.2: Tipos en TypeScript
#### Ejercicio 1

```typescript
// Definición del tipo Empleado
type Empleado = {
  nombre: string;
  edad: number;
}

// Clase EmpleadoRegular que implementa el tipo Empleado
class EmpleadoRegular implements Empleado {
  private _nombre: string;
  private _edad: number;
  private _salario: number;

  constructor(nombre: string, edad: number, salario: number) {
    this._nombre = nombre;
    this._edad = edad;
    this._salario = salario;
  }

  // Método para mostrar información del empleado
  public mostrarInformacion(): void {
    console.log(`Nombre: ${this._nombre}, Edad: ${this._edad}, Salario: ${this._salario}`);
  }
}

// Ejemplo de uso
const empleado = new EmpleadoRegular('Ana', 28, 3500);
empleado.mostrarInformacion();  // Salida: Nombre: Ana, Edad: 28, Salario: 3500
```

#### Ejercicio 2

```typescript
// Definición del tipo Empleado
type Empleado = {
  nombre: string;
  edad: number;
}

// Interfaz Trabajador
interface Trabajador {
  salario: number;
  calcularAnual(): number;
}

// Clase EmpleadoRegular que implementa el tipo Empleado y la interfaz Trabajador
class EmpleadoRegular implements Empleado, Trabajador {
  private _nombre: string;
  private _edad: number;
  private _salario: number;

  constructor(nombre: string, edad: number, salario: number) {
    this._nombre = nombre;
    this._edad = edad;
    this._salario = salario;
  }

  // Implementación del método calcularAnual de la interfaz Trabajador
  public calcularAnual(): number {
    return this._salario * 12;
  }

  // Método para mostrar información del empleado
  public mostrarInformacion(): void {
    console.log(`Nombre: ${this._nombre}, Edad: ${this._edad}, Salario: ${this._salario}, Salario Anual: ${this.calcularAnual()}`);
  }
}

// Ejemplo de uso
const empleado = new EmpleadoRegular('Carlos', 35, 4000);
empleado.mostrarInformacion();  // Salida: Nombre: Carlos, Edad: 35, Salario: 4000, Salario Anual: 48000
```

#### Ejercicio 3

```typescript
// Definición del tipo Persona
type Persona = {
  nombre: string;
  edad: number;
}

// Interfaz Trabajador
interface Trabajador {
  salario: number;
  calcularAnual(): number;
}

// Clase Empleado que implementa Persona y la interfaz Trabajador
class Empleado implements Persona, Trabajador {
  private _nombre: string;
  private _edad: number;
  private _salario: number;

  constructor(nombre: string, edad: number, salario: number) {
    this._nombre = nombre;
    this._edad = edad;
    this._salario = salario;
  }

  // Getters y Setters para nombre
  get nombre(): string {
    return this._nombre;
  }
  set nombre(value: string) {
    this._nombre = value;
  }

  // Getters y Setters para edad
  get edad(): number {
    return this._edad;
  }
  set edad(value: number) {
    this._edad = value;
  }

  // Getters y Setters para salario
  get salario(): number {
    return this._salario;
  }
  set salario(value: number) {
    this._salario = value;
  }

  // Implementación del método calcularAnual de la interfaz Trabajador
  public calcularAnual(): number {
    return this._salario * 12;
  }

  // Método para mostrar información del empleado
  public mostrarInformacion(): void {
    console.log(`Nombre: ${this._nombre}, Edad: ${this._edad}, Salario: ${this._salario}, Salario Anual: ${this.calcularAnual()}`);
  }
}

// Función para mostrar información de una lista de empleados
function mostrarInformacionEmpleados(empleados: Empleado[]): void {
  empleados.forEach(empleado => empleado.mostrarInformacion());
}

// Ejemplo de uso
const empleados: Empleado[] = [
  new Empleado('Laura', 30, 3500),
  new Empleado('Pedro', 40, 4500)
];

mostrarInformacionEmpleados(empleados);
// Salida:
// Nombre: Laura, Edad: 30, Salario: 3500, Salario Anual: 42000
// Nombre: Pedro, Edad: 40, Salario: 4500, Salario Anual: 54000
```

### Respuestas a los Ejercicios de la Subsección 2.3: Introducción a ´implements´
#### Ejercicio 1

**Código:**

```typescript
// Definición de la interfaz Vehiculo
interface Vehiculo {
  marca: string;
  modelo: string;
  mover(): void;
}

// Implementación de la interfaz en la clase Coche
class Coche implements Vehiculo {
  public marca: string;
  public modelo: string;
  public numeroDePuertas: number;

  constructor(marca: string, modelo: string, numeroDePuertas: number) {
    this.marca = marca;
    this.modelo = modelo;
    this.numeroDePuertas = numeroDePuertas;
  }

  public mover(): void {
    console.log(`El coche ${this.marca} ${this.modelo} está en movimiento.`);
  }
}

// Creación de un objeto Coche e impresión del mensaje
const miCoche = new Coche('Toyota', 'Corolla', 4);
miCoche.mover();  // Salida: El coche Toyota Corolla está en movimiento.
```

#### Ejercicio 2

**Código:**

```typescript
// Definición de la interfaz Persona
interface Persona {
  nombre: string;
  edad: number;
  presentarse(): void;
}

// Implementación de la interfaz en la clase Empleado
class Empleado implements Persona {
  public nombre: string;
  public edad: number;
  private salario: number;

  constructor(nombre: string, edad: number, salario: number) {
    this.nombre = nombre;
    this.edad = edad;
    this.salario = salario;
  }

  public presentarse(): void {
    console.log(`Hola, soy ${this.nombre}, tengo ${this.edad} años y mi salario es ${this.salario}.`);
  }

  // Getter para salario
  public getSalario(): number {
    return this.salario;
  }

  // Setter para salario
  public setSalario(salario: number): void {
    this.salario = salario;
  }
}

// Subclases Gerente e Ingeniero
class Gerente extends Empleado {
  public departamento: string;

  constructor(nombre: string, edad: number, salario: number, departamento: string) {
    super(nombre, edad, salario);
    this.departamento = departamento;
  }

  public presentarse(): void {
    super.presentarse();
    console.log(`Trabajo en el departamento de ${this.departamento}.`);
  }
}

class Ingeniero extends Empleado {
  public especialidad: string;

  constructor(nombre: string, edad: number, salario: number, especialidad: string) {
    super(nombre, edad, salario);
    this.especialidad = especialidad;
  }

  public presentarse(): void {
    super.presentarse();
    console.log(`Mi especialidad es ${this.especialidad}.`);
  }
}

// Ejemplos de uso
const gerente = new Gerente('Ana', 45, 8000, 'Desarrollo');
gerente.presentarse();
// Salida:
// Hola, soy Ana, tengo 45 años y mi salario es 8000.
// Trabajo en el departamento de Desarrollo.

const ingeniero = new Ingeniero('Luis', 32, 6000, 'Backend');
ingeniero.presentarse();
// Salida:
// Hola, soy Luis, tengo 32 años y mi salario es 6000.
// Mi especialidad es Backend.
```

#### Ejercicio 3

**Código:**

```typescript
// Definición de la interfaz Persona
interface Persona {
  nombre: string;
  edad: number;
  presentarse(): void;
}

// Implementación de la interfaz en la clase Empleado
class Empleado implements Persona {
  public nombre: string;
  public edad: number;
  private salario: number;

  constructor(nombre: string, edad: number, salario: number) {
    this.nombre = nombre;
    this.edad = edad;
    this.salario = salario;
  }

  public presentarse(): void {
    console.log(`Hola, soy ${this.nombre}, tengo ${this.edad} años y mi salario es ${this.salario}.`);
  }

  // Getter para salario
  public getSalario(): number {
    return this.salario;
  }

  // Setter para salario
  public setSalario(salario: number): void {
    this.salario = salario;
  }
}

// Subclases Gerente e Ingeniero
class Gerente extends Empleado {
  public departamento: string;

  constructor(nombre: string, edad: number, salario: number, departamento: string) {
    super(nombre, edad, salario);
    this.departamento = departamento;
  }

  public presentarse(): void {
    super.presentarse();
    console.log(`Trabajo en el departamento de ${this.departamento}.`);
  }
}

class Ingeniero extends Empleado {
  public especialidad: string;

  constructor(nombre: string, edad: number, salario: number, especialidad: string) {
    super(nombre, edad, salario);
    this.especialidad = especialidad;
  }

  public presentarse(): void {
    super.presentarse();
    console.log(`Mi especialidad es ${this.especialidad}.`);
  }
}

// Clase Empresa
class Empresa {
  private empleados: Empleado[] = [];

  public agregarEmpleado(empleado: Empleado): void {
    this.empleados.push(empleado);
  }

  public mostrarEmpleados(): void {
    this.empleados.forEach(empleado => empleado.presentarse());
  }

  public calcularSalarios(): number {
    return this.empleados.reduce((total, empleado) => total + empleado.getSalario(), 0);
  }
}

// Pruebas unitarias


const empresa = new Empresa();
empresa.agregarEmpleado(new Gerente('Ana', 45, 8000, 'Desarrollo'));
empresa.agregarEmpleado(new Ingeniero('Luis', 32, 6000, 'Backend'));

```


### Respuestas a los Ejercicios de la Subsección 2.4: Implementación Avanzada

#### Ejercicio 1

```typescript
abstract class FiguraGeometrica {
  abstract calcularArea(): number;

  mostrarArea(): void {
    console.log(`El área es: ${this.calcularArea()}`);
  }
}

class Circulo extends FiguraGeometrica {
  constructor(private radio: number) {
    super();
  }

  calcularArea(): number {
    return Math.PI * this.radio ** 2;
  }
}

class Triangulo extends FiguraGeometrica {
  constructor(private base: number, private altura: number) {
    super();
  }

  calcularArea(): number {
    return (this.base * this.altura) / 2;
  }
}

// Ejemplo de uso
const circulo = new Circulo(5);
circulo.mostrarArea();  // Salida: El área es: 78.53981633974483

const triangulo = new Triangulo(10, 5);
triangulo.mostrarArea();  // Salida: El área es: 25
```

#### Ejercicio 2

```typescript
interface Empleado {
  nombre: string;
  salario: number;
  presentarse(): void;
}

abstract class EmpleadoBase implements Empleado {
  protected salario: number;

  constructor(public nombre: string, salario: number) {
    this.salario = salario;
  }

  abstract presentarse(): void;

  get getSalario(): number {
    return this.salario;
  }

  set setSalario(salario: number) {
    this.salario = salario;
  }
}

class Gerente extends EmpleadoBase {
  constructor(nombre: string, salario: number, private departamento: string) {
    super(nombre, salario);
  }

  presentarse(): void {
    console.log(`Hola, soy ${this.nombre}, gerente del departamento ${this.departamento} y mi salario es ${this.salario}`);
  }
}

class Ingeniero extends EmpleadoBase {
  constructor(nombre: string, salario: number, private proyecto: string) {
    super(nombre, salario);
  }

  presentarse(): void {
    console.log(`Hola, soy ${this.nombre}, ingeniero en el proyecto ${this.proyecto} y mi salario es ${this.salario}`);
  }
}

// Ejemplo de uso
const gerente = new Gerente('Ana', 8000, 'Desarrollo');
gerente.presentarse();  // Salida: Hola, soy Ana, gerente del departamento Desarrollo y mi salario es 8000

const ingeniero = new Ingeniero('Luis', 6000, 'Web');
ingeniero.presentarse();  // Salida: Hola, soy Luis, ingeniero en el proyecto Web y mi salario es 6000
```

#### Ejercicio 3

```typescript
interface Libro {
  titulo: string;
  autor: string;
  mostrarDetalles(): void;
}

abstract class LibroBase implements Libro {
  constructor(
    public titulo: string,
    public autor: string,
    protected fechaPublicacion: Date
  ) {}

  abstract mostrarDetalles(): void;
}

class LibroDigital extends LibroBase {
  constructor(
    titulo: string,
    autor: string,
    fechaPublicacion: Date,
    private tamanoArchivo: number // en MB
  ) {
    super(titulo, autor, fechaPublicacion);
  }

  mostrarDetalles(): void {
    console.log(`Título: ${this.titulo}, Autor: ${this.autor}, Fecha de Publicación: ${this.fechaPublicacion.toDateString()}, Tamaño del Archivo: ${this.tamanoArchivo} MB`);
  }
}

class LibroFisico extends LibroBase {
  constructor(
    titulo: string,
    autor: string,
    fechaPublicacion: Date,
    private numeroPaginas: number
  ) {
    super(titulo, autor, fechaPublicacion);
  }

  mostrarDetalles(): void {
    console.log(`Título: ${this.titulo}, Autor: ${this.autor}, Fecha de Publicación: ${this.fechaPublicacion.toDateString()}, Número de Páginas: ${this.numeroPaginas}`);
  }
}

class Biblioteca {
  private libros: LibroBase[] = [];

  agregarLibro(libro: LibroBase): void {
    this.libros.push(libro);
  }

  calcularTamanoTotalDigital(): number {
    return this.libros
      .filter(libro => libro instanceof LibroDigital)
      .reduce((total, libro) => total + (libro as LibroDigital).tamanoArchivo, 0);
  }

  mostrarDetallesLibros(): void {
    this.libros.forEach(libro => libro.mostrarDetalles());
  }
}

// Ejemplo de uso
const biblioteca = new Biblioteca();
const libroDigital = new LibroDigital('El gran libro', 'Autor A', new Date('2024-01-01'), 15);
const libroFisico = new LibroFisico('Otro libro', 'Autor B', new Date('2023-05-15'), 300);

biblioteca.agregarLibro(libroDigital);
biblioteca.agregarLibro(libroFisico);

biblioteca.mostrarDetallesLibros();
// Salida:
// Título: El gran libro, Autor: Autor A, Fecha de Publicación: Mon Jan 01 2024, Tamaño del Archivo: 15 MB
// Título: Otro libro, Autor: Autor B, Fecha de Publicación: Mon May 15 2023, Número de Páginas: 300

console.log(`Tamaño total digital: ${biblioteca.calcularTamanoTotalDigital()} MB`);
// Salida: Tamaño total digital: 15 MB
```

##### Pruebas Unitarias usando Jest

```typescript
import { LibroDigital, LibroFisico, Biblioteca } from './libros'; // Asegúrate de que el path es correcto

describe('Biblioteca', () => {
  let biblioteca: Biblioteca;
  let libroDigital: LibroDigital;
  let libroFisico: LibroFisico;

  beforeEach(() => {
    biblioteca = new Biblioteca();
    libroDigital = new LibroDigital('El gran libro', 'Autor A', new Date('2024-01-01'), 15);
    libroFisico = new LibroFisico('Otro libro', 'Autor B', new Date('2023-05-15'), 300);
  });

  test('debería agregar libros a la biblioteca', () => {
    biblioteca.agregarLibro(libroDigital);
    biblioteca.agregarLibro(libroFisico);
    expect(biblioteca['libros']).toHaveLength(2);
  });

  test('debería calcular el tamaño total digital correctamente', () => {
    biblioteca.agregarLibro(libroDigital);
    biblioteca.agregarLibro(libroFisico); // Este libro no debería contar para el tamaño digital
    expect(biblioteca.calcularTamanoTotalDigital()).toBe(15);
  });

  test('debería mostrar detalles de los libros', () => {
    // Redefine `console.log` para capturar la salida
    const consoleLogSpy = jest.spyOn(console, 'log').mockImplementation();
    biblioteca.agregarLibro(libroDigital);
    biblioteca.agregarLibro(libroFisico);

    biblioteca.mostrarDetallesLibros();

    expect(consoleLogSpy).toHaveBeenCalledWith('Título: El gran libro, Autor: Autor A, Fecha de Publicación: Mon Jan 01 2024, Tamaño del Archivo: 15 MB');
    expect(consoleLogSpy).toHaveBeenCalledWith('Título: Otro libro, Autor: Autor B, Fecha de Publicación: Mon May 15 2023, Número de Páginas: 300');

    consoleLogSpy.mockRestore(); // Restaurar `console.log` a su implementación original
  });
});
```

##### Explicación de las Pruebas

1. **`beforeEach`**: Se configura el entorno para cada prueba, creando una nueva instancia de `Biblioteca`, `LibroDigital` y `LibroFisico`.

2. **Prueba 1 - Agregar libros**:
   - Verifica que los libros se agregan correctamente a la biblioteca.
   - Usa `toHaveLength` para asegurarse de que el array de libros tenga la longitud esperada.

3. **Prueba 2 - Calcular tamaño total digital**:
   - Agrega un libro digital y uno físico a la biblioteca.
   - Verifica que el tamaño total digital calculado es correcto.

4. **Prueba 3 - Mostrar detalles de los libros**:
   - Usa `jest.spyOn` para capturar las salidas de `console.log`.
   - Verifica que los detalles de los libros se muestran correctamente.
   - Restaura `console.log` a su implementación original después de la prueba.

## Sección 3
### Respuestas a los Ejercicios de la Subsección 3.1: Polimorfismo y composición

#### Ejercicio 1
Define un tipo `Meth` con métodos `tocar()` y `vender()`. Extiende este tipo en una clase base abstracta `Instrumento` que implemente el tipo `Meth`. Crea dos clases derivadas `Guitarra` y `Piano` que sobrescriban el método `tocar()` y muestren un mensaje específico. Implementa el método `vender()` en la clase `Instrumento` para que retorne un mensaje basado en el `modelo`. Crea instancias de `Guitarra` y `Piano` y llama al método `tocar()` usando una referencia de tipo `Meth`.

**Código:**

```typescript
type Meth = {
    tocar(): string;
    vender(): string;
};

abstract class Instrumento implements Meth {
    protected modelo: string;

    constructor(modelo: string) {
        this.modelo = modelo;
    }

    abstract tocar(): string;

    vender(): string {
        if (this.modelo === "de cola") {
            return "Te lo compro por 10000€";
        } else if (this.modelo === "eléctrica") {
            return "Te doy 400€";
        } else {
            return "No compramos este modelo";
        }
    }
}

class Guitarra extends Instrumento {
    tocar(): string {
        return `Estás tocando la guitarra ${this.modelo}.`;
    }
}

class Piano extends Instrumento {
    tocar(): string {
        return `Estás tocando el piano ${this.modelo}.`;
    }
}

const guitarra = new Guitarra("eléctrica");
const piano = new Piano("de cola");

const tocarInstrumento = (meth: Meth) => {
    return meth.tocar();
};

console.log(tocarInstrumento(guitarra));
console.log(tocarInstrumento(piano));
```

#### Ejercicio 2
Añade una propiedad `protected` `modelo` a la clase `Instrumento`. Ajusta las clases `Guitarra` y `Piano` para que utilicen el `modelo` en el método `tocar()`. Crea una lista de instrumentos y llama al método `tocar()` para cada uno, utilizando una referencia de tipo `Meth`.

**Código:**

```typescript
type Meth = {
    tocar(): string;
    vender(): string;
};

abstract class Instrumento implements Meth {
    protected modelo: string;

    constructor(modelo: string) {
        this.modelo = modelo;
    }

    abstract tocar(): string;

    vender(): string {
        if (this.modelo === "de cola") {
            return "Te lo compro por 10000€";
        } else if (this.modelo === "eléctrica") {
            return "Te doy 400€";
        } else {
            return "No compramos este modelo";
        }
    }
}

class Guitarra extends Instrumento {
    tocar(): string {
        return `Estás tocando la guitarra ${this.modelo}.`;
    }
}

class Piano extends Instrumento {
    tocar(): string {
        return `Estás tocando el piano ${this.modelo}.`;
    }
}

const guitarra = new Guitarra("eléctrica");
const piano = new Piano("de cola");

const instrumentos: Meth[] = [guitarra, piano];

instrumentos.forEach(instrumento => {
    console.log(instrumento.tocar());
});
```

#### Ejercicio 3
Define una interfaz `Reparable` con un método `reparar()`. Implementa esta interfaz en las clases `Guitarra` y `Piano`. Crea una función que reciba un objeto de tipo `Reparable` y llame a su método `reparar()`. Escribe pruebas unitarias para verificar el correcto funcionamiento del método `reparar()` en ambas clases.

**Código:**

```typescript
type Meth = {
    tocar(): string;
    vender(): string;
};

interface Reparable {
    reparar(): void;
}

abstract class Instrumento implements Meth {
    protected modelo: string;

    constructor(modelo: string) {
        this.modelo = modelo;
    }

    abstract tocar(): string;

    vender(): string {
        if (this.modelo === "de cola") {
            return "Te lo compro por 10000€";
        } else if (this.modelo === "eléctrica") {
            return "Te doy 400€";
        } else {
            return "No compramos este modelo";
        }
    }
}

class Guitarra extends Instrumento implements Reparable {
    tocar(): string {
        return `Estás tocando la guitarra ${this.modelo}.`;
    }

    reparar(): void {
        console.log(`Reparando guitarra ${this.modelo}`);
    }
}

class Piano extends Instrumento implements Reparable {
    tocar(): string {
        return `Estás tocando el piano ${this.modelo}.`;
    }

    reparar(): void {
        console.log(`Reparando piano ${this.modelo}`);
    }
}

const repararInstrumento = (reparable: Reparable) => {
    reparable.reparar();
};

const guitarra = new Guitarra("eléctrica");
const piano = new Piano("de cola");

repararInstrumento(guitarra);
repararInstrumento(piano);
```

##### Pruebas Unitarias (Ejemplo usando Jest)

```typescript
// Asumiendo que estás utilizando Jest para las pruebas unitarias

test('Guitarra debe reparar correctamente', () => {
    const guitarra = new Guitarra("eléctrica");
    console.log = jest.fn(); // Mock para capturar la salida del console.log
    guitarra.reparar();
    expect(console.log).toHaveBeenCalledWith('Reparando guitarra eléctrica');
});

test('Piano debe reparar correctamente', () => {
    const piano = new Piano("de cola");
    console.log = jest.fn(); // Mock para capturar la salida del console.log
    piano.reparar();
    expect(console.log).toHaveBeenCalledWith('Reparando piano de cola');
});
```
### Respuestas a los Ejercicios de la Subsección 3.2: Composición vs. Herencia

#### Ejercicio 1
   Crea una clase `Computadora` utilizando composición. Debe tener componentes `CPU`, `Monitor` y `Teclado`, cada uno con métodos específicos. Luego, instancia `Computadora` y utiliza sus métodos.

   ```typescript
   class CPU {
     ejecutarProceso() {
       console.log('CPU ejecutando proceso');
     }
   }

   class Monitor {
     mostrarImagen() {
       console.log('Monitor mostrando imagen');
     }
   }

   class Teclado {
     escribirTexto() {
       console.log('Teclado escribiendo texto');
     }
   }

   class Computadora {
     private cpu: CPU;
     private monitor: Monitor;
     private teclado: Teclado;

     constructor() {
       this.cpu = new CPU();
       this.monitor = new Monitor();
       this.teclado = new Teclado();
     }

     encender() {
       this.cpu.ejecutarProceso();
       this.monitor.mostrarImagen();
       this.teclado.escribirTexto();
       console.log('Computadora encendida');
     }
   }

   const miComputadora = new Computadora();
   miComputadora.encender();
   ```

#### Ejercicio 2
   Crea una clase `Robot` que puede `caminar` y `hablar` utilizando composición. Define clases separadas `Caminar` y `Hablar` con sus respectivos métodos. Instancia `Robot` y muestra su funcionalidad.

   ```typescript
   class Caminar {
     ejecutar() {
       console.log('El robot camina');
     }
   }

   class Hablar {
     ejecutar() {
       console.log('El robot habla');
     }
   }

   class Robot {
     private caminar: Caminar;
     private hablar: Hablar;

     constructor() {
       this.caminar = new Caminar();
       this.hablar = new Hablar();
     }

     realizarCaminar() {
       this.caminar.ejecutar();
     }

     realizarHablar() {
       this.hablar.ejecutar();
     }
   }

   const miRobot = new Robot();
   miRobot.realizarCaminar();
   miRobot.realizarHablar();
   ```

#### Ejercicio 3
   Diseña una mini aplicación que modele un sistema de vehículos. Utiliza herencia para definir clases base `Vehículo` y subclases `Coche` y `Moto`. Luego, utiliza composición para añadir funcionalidades como `ReproductorDeMusica` y `GPS` a los vehículos. Añade pruebas unitarias para verificar la funcionalidad de cada clase y componente.

   ```typescript
   // Herencia
   class Vehiculo {
     encender() {
       console.log('Vehículo encendido');
     }
   }

   class Coche extends Vehiculo {
     conducir() {
       console.log('Conduciendo coche');
     }
   }

   class Moto extends Vehiculo {
     conducir() {
       console.log('Conduciendo moto');
     }
   }

   // Composición
   class ReproductorDeMusica {
     reproducir() {
       console.log('Reproduciendo música');
     }
   }

   class GPS {
     navegar() {
       console.log('Navegando con GPS');
     }
   }

   class VehiculoConCaracteristicas {
     private vehiculo: Vehiculo;
     private reproductorDeMusica: ReproductorDeMusica;
     private gps: GPS;

     constructor(vehiculo: Vehiculo) {
       this.vehiculo = vehiculo;
       this.reproductorDeMusica = new ReproductorDeMusica();
       this.gps = new GPS();
     }

     encenderVehiculo() {
       this.vehiculo.encender();
     }

     reproducirMusica() {
       this.reproductorDeMusica.reproducir();
     }

     navegarConGPS() {
       this.gps.navegar();
     }
   }

   // Ejemplo de uso
   const miCoche = new VehiculoConCaracteristicas(new Coche());
   miCoche.encenderVehiculo();
   miCoche.reproducirMusica();
   miCoche.navegarConGPS();

   const miMoto = new VehiculoConCaracteristicas(new Moto());
   miMoto.encenderVehiculo();
   miMoto.reproducirMusica();
   miMoto.navegarConGPS();

   // Pruebas unitarias (utilizando Jest)
   // Nota: Agrega Jest a tu proyecto para ejecutar estas pruebas
   /*
   test('Coche con características', () => {
     const coche = new VehiculoConCaracteristicas(new Coche());
     coche.encenderVehiculo();
     coche.reproducirMusica();
     coche.navegarConGPS();
   });

   test('Moto con características', () => {
     const moto = new VehiculoConCaracteristicas(new Moto());
     moto.encenderVehiculo();
     moto.reproducirMusica();
     moto.navegarConGPS();
   });
   */
   ```

