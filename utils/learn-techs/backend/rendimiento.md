
# Mejoras de rendimiento

## Uso correcto de campos en bdd con mucho uso
### Rendimiento: Campo `isAdmin` vs. Colección Separada

#### Campo `isAdmin` en cada documento de usuario

**Ventajas en términos de rendimiento:**
1. **Consulta rápida:** Almacenar el campo `isAdmin` directamente en el documento del usuario permite acceder a esta información con una sola consulta, sin necesidad de realizar joins o buscar en colecciones adicionales.
2. **Menos operaciones de I/O:** Dado que todos los datos del usuario están en un solo documento, las operaciones de lectura son más rápidas y eficientes.

**Desventajas en términos de rendimiento:**
1. **Sobrecarga de almacenamiento:** Cada documento de usuario contiene un campo `isAdmin`, aunque esta desventaja es mínima debido al pequeño tamaño del campo booleano.
2. **Actualización de datos:** Si necesitas cambiar la estructura de roles, puede ser necesario actualizar muchos documentos, lo que puede afectar el rendimiento.

#### Colección separada para administradores

**Ventajas en términos de rendimiento:**
1. **Consultas optimizadas:** Puedes optimizar la colección de administradores para consultas rápidas específicas, como saber si un usuario es administrador.
2. **Flexibilidad y escalabilidad:** Manejar roles y permisos en una colección separada permite una estructura más limpia y puede ser más eficiente a largo plazo si necesitas añadir más roles.

**Desventajas en términos de rendimiento:**
1. **Consultas adicionales:** Determinar si un usuario es administrador requiere una consulta adicional o una operación de unión a nivel de aplicación, lo que puede aumentar la latencia.
2. **Complejidad en el manejo de datos:** La necesidad de gestionar múltiples colecciones puede introducir una sobrecarga en el rendimiento, especialmente en aplicaciones con alta carga de consultas.

### Almacenamiento de datos del usuario en la sesión/cookie vs. llamada a la base de datos

#### Guardar datos en la cookie/sesión

**Ventajas en términos de rendimiento:**
1. **Reducción de consultas:** Almacenar los datos del usuario en la sesión o en cookies reduce la necesidad de hacer consultas repetitivas a la base de datos.
2. **Rápido acceso:** Acceder a los datos almacenados en la sesión es mucho más rápido que hacer una consulta a la base de datos.

**Desventajas:**
1. **Seguridad:** Almacenar demasiada información sensible en cookies puede ser un riesgo de seguridad. Se recomienda guardar solo identificadores y mínimos datos necesarios, utilizando mecanismos seguros como tokens de autenticación.
2. **Sincronización de datos:** Si los datos del usuario cambian (como cambiar de rol), necesitarás actualizar la sesión/cookie para reflejar esos cambios.

#### Llamadas a la base de datos cada vez

**Ventajas:**
1. **Datos actualizados:** Siempre obtienes los datos más recientes del usuario, garantizando que cualquier cambio se refleje inmediatamente.
2. **Menor riesgo de almacenamiento local:** No necesitas preocuparte por la gestión de datos en el cliente o en la sesión del servidor.

**Desventajas en términos de rendimiento:**
1. **Aumento de la latencia:** Hacer consultas a la base de datos en cada solicitud puede aumentar la latencia, especialmente en aplicaciones con alta carga.
2. **Carga en la base de datos:** Realizar consultas repetitivas a la base de datos puede aumentar la carga y afectar el rendimiento general de la aplicación.

### Recomendación

Para maximizar el rendimiento mientras mantienes la flexibilidad y la seguridad:

1. **Combina ambas estrategias:** Utiliza una colección separada para administradores para gestionar roles y permisos de manera flexible y escalable. Esta estructura facilita futuras expansiones y ajustes.
2. **Sesiones y caching:** Almacena en la sesión/cookie solo los datos esenciales del usuario (como el identificador y el rol `isAdmin`). Esto reduce la necesidad de consultas frecuentes a la base de datos y mejora la velocidad de respuesta.
3. **Tokens de autenticación:** Utiliza JWT (JSON Web Tokens) o similares para almacenar roles y permisos de manera segura. Esto puede ser especialmente útil para aplicaciones web donde la seguridad y la performance son críticas.
4. **Actualización de datos:** Implementa mecanismos para actualizar la sesión/cookie cuando los datos del usuario cambian, asegurando que la información almacenada localmente esté siempre actualizada.

### Ejemplo de implementación

**Sesión con datos esenciales:**
```javascript
// Al iniciar sesión, almacenar datos en la sesión del servidor
req.session.user = {
  id: user._id,
  isAdmin: user.isAdmin // Este campo puede ser obtenido de la base de datos
};

// Acceso rápido en cada solicitud
const isAdmin = req.session.user.isAdmin;
```

**Actualización de sesión:**
```javascript
// Cuando los datos del usuario cambian
req.session.user.isAdmin = updatedIsAdmin;
```

Esta combinación te permitirá mantener un equilibrio entre rendimiento, flexibilidad y seguridad en tu aplicación.

### Resumen


1. Usar dos tablas/colecciones:
   - Mantén una tabla/colección de usuarios con la información básica de cada usuario (nombre, email, contraseña hasheada, etc.).
   - Crea una tabla/colección separada para los administradores, donde almacenes solo el ID del usuario y su rol de administrador.

2. Manejo de sesiones y caché:
   - Al iniciar sesión, consulta la tabla de usuarios para obtener los datos básicos del usuario.
   - Verifica si ese usuario es administrador consultando la tabla/colección de administradores.
   - Almacena en la sesión/cookie solo la información esencial: ID de usuario y bandera de "isAdmin".
   - Utiliza caché para evitar consultas frecuentes a la base de datos, especialmente para verificar el rol de administrador.

3. Autenticación con tokens:
   - Usa tokens de autenticación, como JSON Web Tokens (JWT), para manejar la sesión de forma segura.
   - Codifica en el token la información del usuario, como el ID y el rol (isAdmin).
   - Verifica la validez y la integridad del token en cada solicitud, sin necesidad de consultar la base de datos.

4. Actualización de datos:
   - Implementa procesos para actualizar la información almacenada en la sesión/cookie cuando los datos del usuario cambien en la base de datos (p. ej., cambio de rol de administrador).
   - Puedes utilizar eventos de base de datos o mensajería asíncrona para notificar los cambios y actualizar las sesiones de usuario.

Esta estructura te permitirá manejar de manera eficiente y escalable las autenticaciones y roles de usuario, incluso con un gran volumen de usuarios y pocos administradores. Combina el uso de tablas/colecciones separadas, sesiones, caché y tokens de autenticación para optimizar el rendimiento y la seguridad de tu aplicación.

## Sobrecarga session/cookies


Por ejemplo, en un caso donde el nickname del usuario se utiliza con frecuencia en tu aplicación, es una buena práctica almacenarlo en la cookie/sesión del usuario.

Aquí te explico por qué:

1. Rendimiento:
   - Almacenar el nickname en la cookie/sesión evita tener que consultar la base de datos cada vez que necesites acceder a esa información. Esto mejora significativamente el rendimiento de tu aplicación, especialmente en escenarios de alta carga.
   - Las consultas a la base de datos pueden ser costosas en términos de tiempo de respuesta, especialmente si tienes un gran número de usuarios.

2. Experiencia de usuario:
   - Al tener el nickname disponible en la sesión, puedes mostrarlo de manera inmediata en la interfaz de usuario sin tener que esperar a una consulta a la base de datos.
   - Esto mejora la percepción de rendimiento y fluidez de la aplicación para los usuarios.

3. Escalabilidad:
   - Al evitar consultas frecuentes a la base de datos, reduces la carga en el sistema y lo haces más escalable, lo que es especialmente importante cuando tienes un gran número de usuarios concurrentes.

4. Seguridad:
   - Asegúrate de almacenar la información del usuario de manera segura en la cookie/sesión, por ejemplo, utilizando técnicas criptográficas como el uso de tokens de autenticación (JWT).

En resumen, es una buena práctica almacenar el nickname del usuario en la cookie/sesión, siempre y cuando lo hagas de manera segura. Esto mejorará el rendimiento y la experiencia de usuario de tu aplicación, especialmente en escenarios con un alto volumen de usuarios.

## Sobrecarga JWT

Hay algunos principios que debes tener en cuenta a la hora de decidir qué datos almacenar en la sesión y en el JWT (JSON Web Token):

1. Tamaño del JWT:
   - El tamaño del JWT debe mantenerse lo más pequeño posible, ya que se envía en cada solicitud del cliente al servidor.
   - Un JWT demasiado grande puede afectar al rendimiento, especialmente en redes lentas o dispositivos móviles.
   - Como regla general, se recomienda mantener el JWT por debajo de 4 KB.

2. Datos esenciales:
   - Solo almacena en el JWT los datos más esenciales del usuario, como su ID, rol, permisos, etc.
   - Evita incluir datos grandes o que cambien con frecuencia, como el perfil completo del usuario.

3. Sesión vs. JWT:
   - Utiliza la sesión del servidor para almacenar datos que no necesitan ser enviados en cada solicitud, como preferencias del usuario, carritos de compra, etc.
   - El JWT debe contener solo la información mínima necesaria para autenticar y autorizar al usuario.

4. Rendimiento y escalabilidad:
   - Recuerda que el JWT se envía en cada solicitud, así que su tamaño puede afectar al rendimiento, especialmente en aplicaciones con mucho tráfico.
   - Mantén el JWT lo más pequeño posible para optimizar el rendimiento y la escalabilidad de tu aplicación.

5. Seguridad:
   - Asegúrate de que los datos almacenados en el JWT no contengan información sensible, como contraseñas o datos financieros.
   - Utiliza algoritmos de cifrado seguros para firmar y cifrar el JWT.

En resumen, debes evitar almacenar en el JWT datos de uso común que no sean esenciales para la autenticación y autorización del usuario. Mantén el tamaño del JWT lo más pequeño posible, preferentemente por debajo de 4 KB, y utiliza la sesión del servidor para almacenar datos de usuario más extensos o que cambien con frecuencia. Esto te ayudará a mantener un buen rendimiento y escalabilidad, sin comprometer la seguridad de tu aplicación.