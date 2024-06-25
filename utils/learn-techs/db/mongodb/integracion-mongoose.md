# Integración de mongoose

## NextJS
En el contexto de una aplicación Next.js, la ubicación de los middleware de Mongoose dependerá de la arquitectura de tu aplicación y dónde hayas definido tus modelos.

Generalmente, se recomienda ubicar los middleware y la definición de modelos de Mongoose en una carpeta dedicada, como por ejemplo, `models/` o `db/`. Esta es una práctica común para mantener tu código organizado y modular.

Aquí tienes algunas pautas sobre dónde colocar estos elementos en una aplicación Next.js:

1. **Definición de modelos y middleware**:
   - Crea un archivo para cada modelo, por ejemplo, `User.js`, `Post.js`, etc.
   - En cada archivo de modelo, define el esquema y los middleware correspondientes.
   - Ejemplo:
     ```javascript
     // models/User.js
     const mongoose = require('mongoose');

     const userSchema = new mongoose.Schema({
       name: String,
       email: String,
       age: Number
     });

     userSchema.pre('save', function(next) {
       // Middleware de pre-guardado
       this.email = this.email.toLowerCase();
       next();
     });

     const User = mongoose.model('User', userSchema);
     module.exports = User;
     ```

2. **Conexión a la base de datos (local)**:
   - Crea un archivo separado para manejar la conexión a la base de datos, por ejemplo, `db.js`.
   - En este archivo, establece la conexión de Mongoose y exporta funciones o variables que puedan ser utilizadas en tus páginas o componentes de Next.js.
   - Ejemplo:
     ```javascript
     // db.js
     const mongoose = require('mongoose');

     async function connectDB() {
       await mongoose.connect('mongodb://localhost/mydatabase', {
         useNewUrlParser: true,
         useUnifiedTopology: true
       });
     }

     module.exports = { connectDB };
     ```
3a. **Uso de los modelos en páginas o componentes (app router)**:
   - En tus páginas o componentes de Next.js, importa el modelo correspondiente y utilízalo para realizar las operaciones CRUD.
   - Ejemplo:
     ```javascript
     // app/page.js
     import { ExampleModelo } from "@/models/example-schema";

     export const fetchBdd = async () => {
        connectToDB();
        const examples = await ExampleModel.find();
        return examples;
        }

     export default function UsersPage async() {
       const examples = await fetchBdd()
        // Use/"fetch" the document of the bdd
        }
     ```


3b. **Uso de los modelos en páginas o componentes (pages router)**:
   - En tus páginas o componentes de Next.js, importa el modelo correspondiente y utilízalo para realizar las operaciones CRUD.
   - Ejemplo:
     ```javascript
     // pages/users.js
     import User from '../models/User';

     export async function getServerSideProps() {
       await connectDB();
       const users = await User.find({});
       return { props: { users } };
        }

     export default function UsersPage({ users }) {
       // Render the users
        }
     ```

En resumen, los middleware y la definición de modelos de Mongoose deben ubicarse en los archivos de modelo, en una carpeta dedicada como `models/` o `db/`. La conexión a la base de datos se puede manejar en un archivo separado, como `db.js`, y luego ser utilizada en tus páginas o componentes de Next.js. Esta estructura modular y organizada te ayudará a mantener tu código limpio y fácil de mantener.