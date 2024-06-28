

# Interfaces y más
## Interfaces
### Introducción

#### ¿Qué es una interfaz en TypeScript?

Una interfaz en TypeScript es una forma de definir la estructura de un objeto. Permite especificar qué propiedades y métodos debe tener un objeto sin implementar los detalles. Las interfaces son muy útiles para definir contratos en el código, asegurando que los objetos sigan una estructura específica.

#### ¿Por qué usar interfaces?

1. **Claridad y legibilidad**: Las interfaces proporcionan una forma clara y legible de definir las formas y estructuras de los objetos en tu código.
2. **Consistencia**: Al definir interfaces, puedes asegurarte de que los objetos sigan una estructura consistente a lo largo de tu código base.
3. **Mantenimiento**: Facilitan el mantenimiento y la escalabilidad del código, ya que cualquier cambio en la estructura de los objetos se puede realizar en un solo lugar.
4. **Soporte para múltiples desarrolladores**: En equipos grandes, las interfaces ayudan a los desarrolladores a entender qué propiedades y métodos se esperan en ciertos objetos.

### Usos comunes

Las interfaces se utilizan comúnmente para:

1. **Definir la forma de los objetos**:
   ```typescript
   interface User {
       name: string;
       age: number;
       email: string;
   }

   const user: User = {
       name: "Alice",
       age: 25,
       email: "alice@example.com"
   };
   ```

2. **Definir la forma de las funciones**:
   ```typescript
   interface Greet {
       (name: string): string;
   }

   const greet: Greet = (name: string) => {
       return `Hello, ${name}!`;
   };
   ```

3. **Definir tipos para las clases**:
   ```typescript
   interface Animal {
       name: string;
       makeSound(): void;
   }

   class Dog implements Animal {
       name: string;
       constructor(name: string) {
           this.name = name;
       }
       makeSound() {
           console.log("Woof!");
       }
   }
   ```

### Usos propios

#### `extends`

TypeScript permite que una interfaz extienda una o más interfaces, lo que facilita la creación de interfaces complejas a partir de otras más simples.

```typescript
interface Person {
    name: string;
    age: number;
}

interface Employee extends Person {
    employeeId: number;
    department: string;
}

const employee: Employee = {
    name: "John",
    age: 30,
    employeeId: 12345,
    department: "IT"
};
```

#### "Acumulación de Interfaces"

Una característica poderosa de TypeScript es la capacidad de acumular interfaces, permitiendo definir partes de una interfaz por separado y luego unirlas. Esto es útil en escenarios donde diferentes módulos necesitan definir propiedades adicionales en una misma interfaz.

```typescript
interface Car {
    make: string;
    model: string;
}

// En otro módulo
interface Car {
    year: number;
    color: string;
}

const myCar: Car = {
    make: "Toyota",
    model: "Corolla",
    year: 2020,
    color: "blue"
};
```

En este ejemplo, la interfaz `Car` se define en dos lugares diferentes, pero TypeScript las acumula en una sola interfaz que contiene todas las propiedades.

### `interface` vs `type`

Aunque `interface` y `type` en TypeScript pueden parecer intercambiables, tienen diferencias sutiles y casos de uso distintos. En las siguientes secciones, exploraremos sus diferencias, pros y contras, y ofreceremos una recomendación sobre cuándo usar cada uno.

#### Resumen de diferencias

1. **Extensibilidad**:
   - Las interfaces pueden extenderse unas a otras.
   - Los tipos pueden crear combinaciones complejas utilizando intersecciones (`&`).

2. **Declaraciones acumulativas**:
   - Las interfaces permiten la acumulación, es decir, puedes declarar la misma interfaz en varios lugares, y TypeScript las combinará.
   - Los tipos no permiten esto; redefinir un tipo resultará en un error.

3. **Usos específicos**:
   - Las interfaces son más adecuadas para definir la estructura de objetos y clases.
   - Los tipos son más versátiles y pueden utilizarse para alias de tipos primitivos, uniones, tuplas, y otras formas avanzadas de tipos.

##### Pros y contras de `interface`

**Pros**:
- **Extensibilidad**: Las interfaces se pueden extender unas a otras, lo que facilita la creación de jerarquías de tipos.
- **Acumulación**: Las interfaces permiten declarar la misma interfaz en diferentes lugares, y TypeScript las combinará en una sola.
- **Compatibilidad con clases**: Las interfaces funcionan muy bien con las clases y se pueden implementar en ellas.

**Contras**:
- **Menos versátil**: No pueden usarse para definir tipos avanzados como uniones o tuplas.
- **Rigidez**: Las interfaces tienen menos flexibilidad en algunos casos específicos comparadas con los tipos.

##### Pros y contras de `type`

**Pros**:
- **Versatilidad**: Los tipos pueden usarse para definir uniones, intersecciones, tuplas, y cualquier tipo avanzado.
- **Flexibilidad**: Permiten crear combinaciones complejas de tipos.

**Contras**:
- **No acumulables**: No puedes declarar el mismo tipo en varios lugares; hacerlo causará un error.
- **Extensibilidad limitada**: Aunque los tipos pueden combinarse utilizando intersecciones, esta técnica no es tan intuitiva como la extensión de interfaces.

#### Recomendación

- **Usa `interface`** para definir la estructura de objetos, especialmente cuando se trabaja con clases y necesitas extender tipos o utilizar la acumulación de interfaces.
- **Usa `type`** para alias de tipos primitivos, uniones, intersecciones, tuplas y otros tipos avanzados que no requieran extensibilidad o acumulación.

#### Ejemplos comparativos

##### Extensibilidad

**Interface**:
```typescript
interface Animal {
    name: string;
}

interface Dog extends Animal {
    breed: string;
}

const myDog: Dog = {
    name: "Rex",
    breed: "Labrador"
};
```

**Type**:
```typescript
type Animal = {
    name: string;
};

type Dog = Animal & {
    breed: string;
};

const myDog: Dog = {
    name: "Rex",
    breed: "Labrador"
};
```

##### Acumulación

**Interface**:
```typescript
interface Car {
    make: string;
}

// En otro módulo
interface Car {
    model: string;
}

const myCar: Car = {
    make: "Toyota",
    model: "Corolla"
};
```

**Type**:
```typescript
type Car = {
    make: string;
};

// Esto causará un error
type Car = {
    model: string;
};
```


## Narrowing y más
### Narrowing
#### Introducción

El "narrowing" es el proceso de reducir el tipo de una variable a un tipo más específico y preciso. En TypeScript, esto se realiza mediante varias técnicas, como el uso de condicionales, operadores de control de flujo, y funciones de tipo guard. El propósito del narrowing es proporcionar una mayor seguridad y exactitud en el tipo de las variables, lo cual ayuda a evitar errores y mejorar la calidad del código.

#### Por qué usar Narrowing

- **Seguridad de tipos**: Garantiza que las operaciones realizadas en una variable son válidas para el tipo específico.
- **Mejora de la legibilidad**: Ayuda a entender el flujo del programa y los tipos de las variables en diferentes puntos del código.
- **Prevención de errores**: Reduce el riesgo de errores de tiempo de ejecución al asegurar que las variables sean del tipo esperado.

#### Ejemplo básico

Vamos a ver un ejemplo básico de narrowing usando condicionales:

```typescript
function printId(id: string | number) {
    if (typeof id === "string") {
        // Aquí, TypeScript sabe que 'id' es un 'string'
        console.log("El ID es: " + id.toUpperCase());
    } else {
        // Aquí, TypeScript sabe que 'id' es un 'number'
        console.log("El ID es: " + id.toFixed(2));
    }
}

printId("abc123");
printId(101);
```

En este ejemplo, usamos el operador `typeof` para verificar el tipo de `id`. Dependiendo del tipo, realizamos diferentes operaciones que son válidas para cada tipo específico.

#### Ejemplo interfaz de funciones

El narrowing también se puede aplicar en funciones que aceptan parámetros de tipos diversos. A continuación se muestra un ejemplo más complejo con una interfaz de funciones:

```typescript
interface User {
    name: string;
    email: string;
}

interface Admin {
    name: string;
    email: string;
    role: "admin";
}

function printUser(user: User | Admin) {
    console.log(`Name: ${user.name}`);
    console.log(`Email: ${user.email}`);
    
    if ("role" in user) {
        // Aquí, TypeScript sabe que 'user' es un 'Admin'
        console.log(`Role: ${user.role}`);
    }
}

const user: User = { name: "John Doe", email: "john@example.com" };
const admin: Admin = { name: "Jane Doe", email: "jane@example.com", role: "admin" };

printUser(user);
printUser(admin);
```

En este ejemplo, usamos el operador `in` para verificar si la propiedad `role` existe en el objeto `user`. Esto nos permite realizar un narrowing y manejar el caso específico en el que `user` es de tipo `Admin`.

#### Type Guard
##### Introducción

Los Type Guards (guardias de tipos) son funciones que permiten a TypeScript inferir un tipo más específico dentro de un bloque condicional. Un Type Guard devuelve un valor booleano y, basado en este valor, TypeScript estrecha (narrow) el tipo de una variable a un tipo más preciso. Esto mejora la seguridad de tipos y permite al desarrollador trabajar con tipos más específicos dentro de un contexto controlado.

##### Por qué usar Type Guards

- **Seguridad y precisión de tipos**: Garantiza que las variables son del tipo esperado antes de realizar operaciones específicas de tipo.
- **Mejora la legibilidad y mantenimiento del código**: Clarifica las intenciones del código y facilita el manejo de tipos complejos.
- **Evita errores de tiempo de ejecución**: Al asegurarse de que las variables son del tipo correcto, se reduce la posibilidad de errores.

##### Ejemplo explicativo

Vamos a ver un ejemplo de un Type Guard que distingue entre dos tipos de interfaces:

```typescript
interface Dog {
    bark: () => void;
    breed: string;
}

interface Cat {
    meow: () => void;
    color: string;
}

// Type Guard para distinguir entre Dog y Cat
function isDog(pet: Dog | Cat): pet is Dog {
    return (pet as Dog).bark !== undefined;
}

function makeSound(pet: Dog | Cat) {
    if (isDog(pet)) {
        pet.bark();
    } else {
        pet.meow();
    }
}

const myDog: Dog = { bark: () => console.log("Woof!"), breed: "Labrador" };
const myCat: Cat = { meow: () => console.log("Meow!"), color: "Black" };

makeSound(myDog); // "Woof!"
makeSound(myCat); // "Meow!"
```

En este ejemplo, `isDog` es un Type Guard que comprueba si `pet` tiene la propiedad `bark`, lo cual indica que `pet` es un `Dog`. Dentro del bloque `if (isDog(pet))`, TypeScript sabe que `pet` es de tipo `Dog`, y por lo tanto, permite llamar a `pet.bark()`. Si no es un `Dog`, entonces TypeScript asume que es un `Cat` y permite llamar a `pet.meow()`.

##### Compilación a JS

Cuando TypeScript compila a JavaScript, los Type Guards se convierten en simples comprobaciones lógicas sin añadir ningún tipo de anotación de tipos. Aquí está el código JavaScript resultante del ejemplo anterior:

```javascript
function isDog(pet) {
    return pet.bark !== undefined;
}

function makeSound(pet) {
    if (isDog(pet)) {
        pet.bark();
    } else {
        pet.meow();
    }
}

const myDog = { bark: () => console.log("Woof!"), breed: "Labrador" };
const myCat = { meow: () => console.log("Meow!"), color: "Black" };

makeSound(myDog); // "Woof!"
makeSound(myCat); // "Meow!"
```

En el código JavaScript compilado, las comprobaciones de tipo se mantienen como comprobaciones lógicas simples, y las anotaciones de tipos se eliminan, ya que JavaScript no tiene soporte nativo para tipos.

### `never`

El tipo `never` representa un valor que nunca ocurre. Es utilizado en funciones que no retornan, como las que siempre lanzan una excepción o aquellas que entran en un bucle infinito.

#### Introducción

El tipo `never` es un tipo especial en TypeScript que indica valores que nunca suceden. Esto es útil para funciones que no retornan normalmente y ayuda a TypeScript a verificar la exhaustividad de los casos en switch statements o condicionales.

##### Ejemplo

Vamos a ver un ejemplo de una función que siempre lanza una excepción y, por lo tanto, nunca retorna:

```typescript
function error(message: string): never {
    throw new Error(message);
}

function fail() {
    return error("Algo salió mal");
}

function infiniteLoop(): never {
    while (true) {
        // Un bucle infinito que nunca termina
    }
}
```

En este ejemplo, las funciones `error` y `infiniteLoop` son de tipo `never` porque nunca retornan un valor. La función `fail` llama a `error`, y su tipo de retorno también se puede considerar `never`.

#### Uso en comprobación exhaustiva

El tipo `never` es especialmente útil para asegurarse de que todas las posibilidades se manejan en una estructura condicional, como un switch statement:

```typescript
type Shape = 
    | { kind: "circle"; radius: number }
    | { kind: "square"; side: number };

function area(shape: Shape): number {
    switch (shape.kind) {
        case "circle":
            return Math.PI * shape.radius ** 2;
        case "square":
            return shape.side ** 2;
        default:
            const _exhaustiveCheck: never = shape;
            return _exhaustiveCheck; // Esto asegurará que todas las variantes de 'Shape' se manejan
    }
}
```

En este ejemplo, si se añade un nuevo tipo a `Shape` y no se actualiza el switch statement, TypeScript generará un error de tipo en `_exhaustiveCheck`, indicando que el switch statement no maneja todas las posibilidades.

## Modificadores en TypeScript

Los modificadores en TypeScript son palabras clave que se utilizan para definir la visibilidad y el comportamiento de los miembros (propiedades y métodos) dentro de las clases y, en algunos casos, también en interfaces y objetos literales. Estos modificadores son:

- **`readonly`**: Define que una propiedad solo puede ser asignada una vez y no puede ser modificada después de su inicialización.
  
- **`private`**: Indica que el miembro es accesible solo dentro de la misma clase donde se declara.

- **`public`**: Es el modificador predeterminado para los miembros de una clase. Indica que el miembro es accesible desde cualquier lugar donde se pueda acceder a la instancia de la clase.

- **`protected`**: Indica que el miembro es accesible dentro de la misma clase y en las clases derivadas (subclases) que extienden la clase donde se declara el miembro.

### Aplicación de Modificadores

#### En Objetos Literales

En los objetos literales, los modificadores pueden definirse para controlar la visibilidad y la mutabilidad de propiedades:

```typescript
const person = {
    name: "Alice",
    age: 30,
    readonly address: "Wonderland", // Propiedad de solo lectura
    private salary: 3000, // Propiedad privada
    public job: "Developer", // Propiedad pública (predeterminada)
    protected yearsInCompany: 5 // Propiedad protegida
};
```

#### En Interfaces

Desde TypeScript 3.8, los modificadores también se pueden utilizar en interfaces para definir la visibilidad de los miembros, aunque solo se utilizan para propósitos de verificación estática y no tienen efecto en JavaScript generado:

```typescript
interface Person {
    name: string;
    readonly age: number;
    private salary: number;
    public job: string;
    protected yearsInCompany: number;
}
```

Estos modificadores ayudan a definir contratos más precisos en interfaces, pero no afectan el comportamiento de las propiedades en tiempo de ejecución.

### Resumen

Los modificadores (`readonly`, `private`, `public`, `protected`) son herramientas fundamentales en TypeScript para controlar el acceso a los miembros y garantizar la integridad de los datos. Aunque se utilizan comúnmente en el contexto de las clases, también se pueden aplicar en objetos literales y, desde TypeScript 3.8, en interfaces para mejorar la precisión y claridad de los contratos de tipos.

Entendido, vamos a continuar con la sección sobre modificadores en TypeScript, centrándonos en cómo se aplican y qué significan fuera del contexto de las clases.

## Modificadores en TypeScript

Los modificadores en TypeScript son palabras clave que se utilizan para definir la visibilidad y el comportamiento de los miembros (propiedades y métodos) dentro de las clases y, en algunos casos, también en interfaces y objetos literales. Estos modificadores son:

- **`readonly`**: Define que una propiedad solo puede ser asignada una vez y no puede ser modificada después de su inicialización.
  
- **`private`**: Indica que el miembro es accesible solo dentro de la misma clase donde se declara.

- **`public`**: Es el modificador predeterminado para los miembros de una clase. Indica que el miembro es accesible desde cualquier lugar donde se pueda acceder a la instancia de la clase.

- **`protected`**: Indica que el miembro es accesible dentro de la misma clase y en las clases derivadas (subclases) que extienden la clase donde se declara el miembro.

### Aplicación de modificadores
En TypeScript, los modificadores (`readonly`, `private`, `public`, `protected`) se pueden aplicar en diferentes contextos para controlar la visibilidad y la mutabilidad de los miembros. Aquí te explico en qué contextos específicos se pueden utilizar:

#### 1. **En Tipos (`type`)**:
   - A partir de TypeScript 3.8, se pueden usar modificadores en los tipos definidos con `type`. Esto permite especificar la visibilidad y mutabilidad de los miembros dentro de un tipo.

   ```typescript
   type Person = {
       name: string;
       readonly age: number;
       private salary: number;
       public job: string;
       protected yearsInCompany: number;
   };
   ```

   Sin embargo, es importante mencionar que los modificadores en los tipos solo se utilizan para verificación estática y no tienen ningún impacto en JavaScript generado, ya que TypeScript no genera código para tipos.

#### 2. **En Interfaces**:
   - Los modificadores también se pueden usar en interfaces para definir la visibilidad de los miembros. Esto se introdujo en TypeScript 3.8 y se utiliza para mejorar la precisión y claridad de los contratos de tipos.

   ```typescript
   interface IPerson {
       name: string;
       readonly age: number;
       private salary: number;
       public job: string;
       protected yearsInCompany: number;
   }
   ```

   Al igual que con los tipos, los modificadores en interfaces no tienen efecto en el código JavaScript generado, pero ayudan en la verificación estática durante el desarrollo.

#### 3. **En Objetos Literales**:
   - En los objetos literales, los modificadores se pueden utilizar para controlar la visibilidad y la mutabilidad de las propiedades. Esto no es específico de TypeScript, sino una característica de JavaScript que TypeScript hereda y tipa.

   ```typescript
   const person = {
       name: "Alice",
       age: 30,
       readonly address: "Wonderland", // Propiedad de solo lectura
       private salary: 3000, // Propiedad privada
       public job: "Developer", // Propiedad pública (predeterminada)
       protected yearsInCompany: 5 // Propiedad protegida
   };
   ```

   En este caso, TypeScript proporciona verificación estática para estos modificadores, pero no afectan el comportamiento en tiempo de ejecución.

#### 4. **En Clases**:
   - Finalmente, los modificadores son más comúnmente utilizados en clases para controlar el acceso a los miembros dentro de la clase y en las subclases.

   ```typescript
   class Person {
       public name: string;
       private age: number;
       protected job: string;
       readonly yearsInCompany: number;

       constructor(name: string, age: number, job: string, yearsInCompany: number) {
           this.name = name;
           this.age = age;
           this.job = job;
           this.yearsInCompany = yearsInCompany;
       }
   }
   ```

   En este ejemplo, `public`, `private`, `protected` y `readonly` se utilizan para definir la visibilidad y la mutabilidad de los miembros de la clase.

En resumen, los modificadores en TypeScript se pueden aplicar en tipos (`type`), interfaces, objetos literales y clases. Cada uno tiene un propósito específico para controlar cómo se accede y se modifica cada miembro dentro de su contexto respectivo.

Para abordar la sección final sobre el tipado de clases en TypeScript, vamos a explorar cómo TypeScript extiende y mejora el manejo de clases en comparación con JavaScript estándar. A continuación, estructuraré la sección de manera detallada:

---

# Tipado de Classes en TypeScript

Las clases en TypeScript permiten definir estructuras de datos complejas y organizar la lógica de la aplicación de manera más clara y mantenible. A continuación, exploraremos cómo TypeScript proporciona herramientas para mejorar la tipificación y la robustez de las clases.

## Introducción

Las clases en TypeScript son una forma de definir tipos de datos complejos que pueden contener propiedades y métodos. A diferencia de JavaScript estándar, TypeScript agrega características adicionales para mejorar la seguridad y la comprensión del código.

## Decoradores

Los decoradores son una característica experimental de TypeScript que permite añadir metadatos y modificar clases y sus miembros durante la declaración. Su uso es común en bibliotecas y frameworks modernos de JavaScript y TypeScript, como Angular.

```typescript
// Ejemplo de decorador de clase
function logged(target: Function) {
    console.log(`Clase ${target.name} ha sido creada.`);
}

@logged
class Persona {
    constructor(public nombre: string, public edad: number) {}
}

const persona = new Persona('Juan', 30); // Salida: "Clase Persona ha sido creada."
```

## Métodos

En TypeScript, los métodos pueden ser públicos, privados o protegidos, lo cual ayuda a controlar el acceso a la lógica interna de la clase.

```typescript
class Persona {
    private edad: number;

    constructor(public nombre: string, edad: number) {
        this.edad = edad;
    }

    public obtenerEdad(): number {
        return this.edad;
    }
}

const persona = new Persona('Ana', 25);
console.log(persona.obtenerEdad()); // Salida: 25
```

## Propiedades

Las propiedades también pueden tener modificadores de acceso como `public`, `private`, `protected` y `readonly`, que controlan cómo se accede y se modifica cada propiedad de la instancia de la clase.

```typescript
class Persona {
    readonly id: number;
    public nombre: string;

    constructor(id: number, nombre: string) {
        this.id = id;
        this.nombre = nombre;
    }
}

const persona = new Persona(1, 'Carlos');
console.log(persona.nombre); // Acceso a la propiedad pública
// persona.id = 2; // Error: la propiedad 'id' es de solo lectura
```

## Herencia

TypeScript soporta la herencia de clases, permitiendo que una clase herede propiedades y métodos de otra clase base. Esto facilita la reutilización del código y la organización jerárquica de las clases.

```typescript
class Empleado extends Persona {
    private salario: number;

    constructor(id: number, nombre: string, salario: number) {
        super(id, nombre);
        this.salario = salario;
    }

    public obtenerSalario(): number {
        return this.salario;
    }
}

const empleado = new Empleado(2, 'Luis', 3000);
console.log(empleado.nombre); // Acceso a la propiedad heredada 'nombre'
console.log(empleado.obtenerSalario()); // Salida: 3000
```

## Modificadores de Acceso

Los modificadores de acceso (`public`, `private`, `protected`) permiten controlar la visibilidad de los miembros dentro de la clase y en las subclases. Esto mejora la encapsulación y evita el acceso no autorizado a los datos de la clase.

```typescript
class Animal {
    protected nombre: string;

    constructor(nombre: string) {
        this.nombre = nombre;
    }

    protected hacerSonido(): void {
        console.log('Haciendo sonido...');
    }
}

class Perro extends Animal {
    private raza: string;

    constructor(nombre: string, raza: string) {
        super(nombre);
        this.raza = raza;
    }

    public informacionPerro(): void {
        console.log(`Nombre: ${this.nombre}, Raza: ${this.raza}`);
        this.hacerSonido(); // Acceso al método protegido desde la subclase
    }
}

const miPerro = new Perro('Rex', 'Labrador');
miPerro.informacionPerro(); // Salida: Nombre: Rex, Raza: Labrador

// No se puede acceder a miPerro.nombre directamente desde fuera de la clase o subclase
// miPerro.hacerSonido(); // Error: hacerSonido() es un método protegido y no puede ser accedido desde fuera de la clase o subclase
```

