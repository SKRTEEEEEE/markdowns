# Mongoose
## Introducción
Resumen sobre Mongoose, una popular librería de Node.js para trabajar con bases de datos MongoDB.

1. **Conexión a la base de datos**:
   - Mongoose proporciona una forma sencilla de conectarse a una base de datos MongoDB.
   - Puedes establecer la conexión utilizando el método `mongoose.connect()` y especificando la URL de conexión.
   - Ejemplo:
     ```javascript
     const mongoose = require('mongoose');
     mongoose.connect('mongodb://localhost/mydatabase', {
       useNewUrlParser: true,
       useUnifiedTopology: true
     });
     ```

2. **Definición de esquemas y modelos**:
   - Los esquemas definen la estructura de los documentos en la base de datos.
   - A partir de los esquemas, puedes crear modelos que representan las "tablas" de la base de datos.
   - Ejemplo de definición de un esquema y modelo:
     ```javascript
     const mongoose = require('mongoose');
     const userSchema = new mongoose.Schema({
       name: String,
       email: String,
       age: Number
     });
     const User = mongoose.model('User', userSchema);
     ```

3. **Operaciones CRUD**:
   - Mongoose proporciona métodos para realizar las operaciones básicas de creación, lectura, actualización y eliminación (CRUD) en los datos.
   - Ejemplos:
     ```javascript
     // Crear un nuevo usuario
     const newUser = new User({ name: 'John Doe', email: 'john@example.com', age: 30 });
     await newUser.save();

     // Buscar usuarios
     const users = await User.find({ age: { $gte: 18 } });

     // Actualizar un usuario
     const user = await User.findById('123456789');
     user.age = 31;
     await user.save();

     // Eliminar un usuario
     await User.findByIdAndDelete('123456789');
     ```

4. [**Middleware y ciclo de vida**](#middleware-y-ciclo-de-vida):
   - Mongoose permite definir middleware (funciones que se ejecutan antes o después de ciertas operaciones) en los esquemas.
   - Esto permite agregar lógica personalizada, como validaciones, transformaciones o tareas asíncronas.
   - Ejemplo de middleware:
     ```javascript
     userSchema.pre('save', function(next) {
       this.email = this.email.toLowerCase();
       next();
     });
     ```

5. **Consultas avanzadas y agregaciones**:
   - Mongoose permite realizar consultas avanzadas utilizando operadores de consulta y agregación.
   - Esto incluye filtros, ordenamiento, paginación, proyección y agregaciones como `$match`, `$group`, `$sort`, entre otros.
   - Ejemplo de consulta avanzada:
     ```javascript
     const result = await User.aggregate([
       { $match: { age: { $gte: 18 } } },
       { $group: { _id: '$age', count: { $count: {} } } },
       { $sort: { _id: 1 } }
     ]);
     ```

6. **Validación y manejo de errores**:
   - Mongoose proporciona un sistema de validación integrado para los esquemas.
   - Puedes definir reglas de validación en los campos del esquema, como tipos de datos, longitud, valores únicos, etc.
   - Mongoose también maneja y propaga los errores de forma eficiente, lo que facilita el manejo de excepciones en tu aplicación.

Estas son solo algunas de las características más destacadas de Mongoose. Es una herramienta poderosa que te ayudará a trabajar de manera más sencilla y eficiente con bases de datos MongoDB en tus aplicaciones de Node.js.

## Middleware y ciclo de vida

Los middleware en Mongoose son funciones que se pueden ejecutar antes o después de ciertas operaciones en los modelos. Estos permiten agregar lógica personalizada a tu aplicación, como validaciones, transformaciones de datos o tareas asíncronas.

Existen varios tipos de middleware en Mongoose:

1. **Pre-middleware**:
   - Se ejecutan antes de que se realice una operación.
   - Puedes definir middleware para los siguientes eventos:
     - `save`: Se ejecuta antes de guardar un nuevo documento o actualizar uno existente.
     - `validate`: Se ejecuta antes de validar un documento.
     - `remove`: Se ejecuta antes de eliminar un documento.
     - `find`: Se ejecuta antes de realizar una consulta.
   - Ejemplo:
     ```javascript
     userSchema.pre('save', function(next) {
       // Transformar el email a minúsculas
       this.email = this.email.toLowerCase();
       next();
     });
     ```

2. **Post-middleware**:
   - Se ejecutan después de que se realice una operación.
   - Puedes definir middleware para los siguientes eventos:
     - `save`: Se ejecuta después de guardar un nuevo documento o actualizarlo.
     - `remove`: Se ejecuta después de eliminar un documento.
   - Ejemplo:
     ```javascript
     userSchema.post('save', function(doc, next) {
       // Enviar un correo electrónico al usuario después de guardarlo
       sendWelcomeEmail(doc.email);
       next();
     });
     ```

3. **Error middleware**:
   - Se ejecutan cuando ocurre un error durante una operación.
   - Puedes definir middleware para capturar y manejar los errores.
   - Ejemplo:
     ```javascript
     userSchema.pre('save', function(next) {
       if (!this.name) {
         return next(new Error('El nombre es obligatorio'));
       }
       next();
     });
     ```

Además de los middleware, Mongoose también proporciona eventos del ciclo de vida de los documentos, que se emiten durante ciertas operaciones. Algunos de estos eventos son:

- `init`: Se emite cuando se crea una nueva instancia de un documento.
- `save`: Se emite cuando se guarda un documento.
- `update`: Se emite cuando se actualiza un documento.
- `remove`: Se emite cuando se elimina un documento.

Puedes escuchar estos eventos y ejecutar código personalizado cuando ocurran. Esto puede ser útil para tareas como registrar actividad, notificar a usuarios o realizar otras acciones en respuesta a los cambios en los datos.

Ejemplo de uso de eventos del ciclo de vida:
```javascript
userSchema.pre('save', function(next) {
  console.log('Guardando usuario:', this.name);
  next();
});

userSchema.post('save', function(doc, next) {
  console.log('Usuario guardado:', doc.name);
  next();
});
```

Estos son los conceptos clave sobre middleware y ciclo de vida en Mongoose. Permiten agregar lógica personalizada a tus modelos y mejorar la funcionalidad de tu aplicación.

## Definición de relaciones (principales)

Para definir las relaciones entre "tablas" (también conocidas como modelos) en tu modelo de Mongoose, puedes utilizar los siguientes tipos de relaciones:

1. **Relación one-to-one (uno a uno)**:
   - Se define utilizando la referencia a otro modelo a través de una propiedad.
   - Ejemplo:
     ```javascript
     const UserSchema = new mongoose.Schema({
       name: String,
       profile: { type: mongoose.Schema.Types.ObjectId, ref: 'Profile' }
     });
     const ProfileSchema = new mongoose.Schema({
       user: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
       about: String
     });
     ```

2. **Relación one-to-many (uno a muchos)**:
   - Se define utilizando un array de referencias a otro modelo.
   - Ejemplo:
     ```javascript
     const PostSchema = new mongoose.Schema({
       title: String,
       content: String,
       author: { type: mongoose.Schema.Types.ObjectId, ref: 'User' }
     });
     const UserSchema = new mongoose.Schema({
       name: String,
       posts: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Post' }]
     });
     ```

3. **Relación many-to-many (muchos a muchos)**:
   - Se define utilizando un array de referencias a otro modelo en ambos modelos.
   - Ejemplo:
     ```javascript
     const CourseSchema = new mongoose.Schema({
       name: String,
       students: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Student' }]
     });
     const StudentSchema = new mongoose.Schema({
       name: String,
       courses: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Course' }]
     });
     ```

En estos ejemplos, se utiliza el tipo `mongoose.Schema.Types.ObjectId` para hacer referencia a los identificadores únicos de los documentos en otros modelos. Cuando se utiliza la opción `ref`, Mongoose conocerá la relación entre los modelos y podrá realizar consultas y populaciones de datos de manera más eficiente.

Recuerda que al momento de realizar consultas, puedes utilizar el método `populate()` de Mongoose para traer los datos relacionados de manera automática.

## Otras relaciones

Además de las relaciones a través de referencias de ObjectId, también puedes definir relaciones entre modelos de Mongoose de otras formas:

1. **Relación embebida (embedded)**:
   - Se define incluyendo un esquema anidado dentro de otro esquema.
   - Esto significa que los datos relacionados se almacenan dentro del mismo documento.
   - Ejemplo:
     ```javascript
     const AddressSchema = new mongoose.Schema({
       street: String,
       city: String,
       state: String
     });
     const UserSchema = new mongoose.Schema({
       name: String,
       email: String,
       address: AddressSchema
     });
     ```

2. **Subdocumentos**:
   - Se define utilizando un array de subdocumentos dentro de un esquema.
   - Los subdocumentos no tienen su propia identidad y solo existen como parte del documento principal.
   - Ejemplo:
     ```javascript
     const CommentSchema = new mongoose.Schema({
       text: String,
       createdAt: Date
     });
     const PostSchema = new mongoose.Schema({
       title: String,
       content: String,
       comments: [CommentSchema]
     });
     ```

3. **Relación virtual**:
   - Se define utilizando propiedades virtuales en los esquemas.
   - Las propiedades virtuales no se almacenan en la base de datos, pero se calculan dinámicamente.
   - Ejemplo:
     ```javascript
     const UserSchema = new mongoose.Schema({
       name: String,
       age: Number
     });
     UserSchema.virtual('isAdult').get(function() {
       return this.age >= 18;
     });
     ```

Cada una de estas formas de definir relaciones tiene sus propias ventajas y desventajas en términos de rendimiento, flexibilidad y complejidad. La elección de la mejor opción dependerá de las necesidades específicas de tu aplicación.

