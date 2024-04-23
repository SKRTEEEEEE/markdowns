# NextJS tips

## JS-to-CSS React librerias

- Para instalar librerias JS-to-CSS de React, como styled-div o chakra-ui, necesitamos habitar un register _(o registro, es como el registro de las normas de dicha libreria para que next sepa compilarlas como si fuese react, dicho de alguna manera)_
  
La configuración de CSS-in-JS es un proceso de suscripción de tres pasos que implica:

- 1. Un **registro de estilos** para recopilar todas las reglas CSS en un renderizado.
- 2. El nuevo `useServerInsertedHTML`gancho para inyectar reglas antes que cualquier contenido que pueda usarlas.
- 3. Un componente de cliente que envuelve su aplicación con el registro de estilo durante la representación inicial del lado del servidor.

### Encuentra toda la informacion hacerca de esto, y **que librerias estan disponibles**, [aqui](https://nextjs.org/docs/app/building-your-application/styling/css-in-js).

### Ejemplo de integracion de [Styled-components](https://styled-components.com/)

https://github.com/vercel/app-playground/tree/main/app/styling/styled-components

## Otras librerias

### Three js

Nada en especial, solo importar los componentes en "use client"

```bash
npm install three @react-three/drei @react-three/fiber
```
_el segundo comando, no me acuerdo porque pero hacen falta?_