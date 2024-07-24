# Ethers.js & hardhat test functions

Funciones principales para testear contratos con Hardhat

## Hardhat tutorial

### TEST 1: Escribiendo test

```javascript
const { expect } = require("chai");

describe("Token contract", function () {
  it("Deployment should assign the total supply of tokens to the owner", async function () {
    const [owner] = await ethers.getSigners();

    const hardhatToken = await ethers.deployContract("Token");

    const ownerBalance = await hardhatToken.balanceOf(owner.address);
    expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);
  });
});
```

- [```Signer``` en ethers.js](https://docs.ethers.org/v6/api/providers/#Signer) es un objeto que representa una cuenta de Ethereum. *Se utiliza para enviar transacciones a contratos y otras cuentas.*

    ```javascript
    const [owner] = await ethers.getSigners();
    ```

    *Aquí obtenemos una lista de las cuentas en el nodo al que estamos conectados, que en este caso es Hardhat Network, y solo conservamos la primera.*

- ```ethers.deployContract("Token")``` iniciará la implementación de nuestro contrato de token y devolverá un archivo ```Promise```que se resuelve en un archivo ```Contract```. Este es el objeto que tiene un método para cada una de las funciones de su contrato inteligente.

    ```javascript
    const hardhatToken = await ethers.deployContract("Token");
    ```
    *Aqui estamos desplegando el contrato X(en este caso"Token", el nombre del contrato) y lo asignamos a una constante.*
    *Una vez que se implementa el contrato, podemos llamar a nuestros métodos de contrato*

- Obtenemos el saldo de la cuenta del propietario llamando al ```balanceOf()``` método del contrato.

    ```javascript
    const ownerBalance = await hardhatToken.balanceOf(owner.address);
    ```

*Recuerde que la cuenta que implementa el token obtiene todo su suministro. De forma predeterminada, ```Contract```las instancias están conectadas al primer firmante. Esto significa que la cuenta en la ```owner```variable ejecutó la implementación y ```balanceOf()```debería devolver el monto total del suministro.*
- Aquí estamos nuevamente usando nuestra ```Contract``` instancia para llamar a una función de contrato inteligente en nuestro código Solidity. ```totalSupply()```devuelve la cantidad suministrada del token y estamos comprobando que sea igual a ```ownerBalance```, como debería ser.

    *?Vale la pena recordar que esto ocurre porque en el Contrato que estamos testeando, inicialmente se le dan a la billetera que despliega el contrato todo el "supply" o cantidad de tokens circulantes*

    ```javascript
    expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);
    ```


    *Para hacer esto estamos usando [```chai```](https://www.chaijs.com/)que es una popular biblioteca de aserciones de JavaScript. Estas funciones de aserción se denominan "coincidentes" y las que usamos aquí provienen del ```@nomicfoundation/hardhat-chai-matchers``` complemento, que amplía Chai con muchos comparadores útiles para probar contratos inteligentes.*

***
_La ```ethers``` variable está disponible en el ámbito global. Si desea que su código sea siempre explícito, puede agregar esta línea en la parte superior:_
```javascript
const { ethers } = require("hardhat");
```

### TEST 2: Usando una cuenta diferente

Si necesita probar su código enviando una transacción desde una cuenta (o "Signer" en la terminología de "ethers.js") distinta a la predeterminada, puede usar el ```connect()``` método en su ```Contract``` objeto de ethers.js para conectarlo a una cuenta diferente

```javascript
const { expect } = require("chai");

describe("Token contract", function () {
  // ...previous test...

  it("Should transfer tokens between accounts", async function() {
    const [owner, addr1, addr2] = await ethers.getSigners();

    const hardhatToken = await ethers.deployContract("Token");

    // Transfer 50 tokens from owner to addr1
    await hardhatToken.transfer(addr1.address, 50);
    expect(await hardhatToken.balanceOf(addr1.address)).to.equal(50);

    // Transfer 50 tokens from addr1 to addr2
    await hardhatToken.connect(addr1).transfer(addr2.address, 50);
    expect(await hardhatToken.balanceOf(addr2.address)).to.equal(50);
  });
});
```

*Al añadir este trozo de codigo a nuestro codigo original, estamos realizando otro "testando" otra funcion dentro del "test"*

### TEST 3: Reutilizando config de prueba comunes con "fixtures"

*Las dos pruebas que escribimos comienzan con su configuración, que en este caso significa implementar el contrato del token. En proyectos más complejos, esta configuración podría implicar múltiples implementaciones y otras transacciones. Hacer eso en cada prueba significa mucha duplicación de código. Además, ejecutar muchas transacciones al comienzo de cada prueba puede hacer que el conjunto de pruebas sea mucho más lento.*
- Puede evitar la duplicación de código y mejorar el rendimiento de su conjunto de pruebas utilizando **fixtures** (o accesorios).

    *Es una función de configuración que se ejecuta sólo la primera vez que se invoca. En invocaciones posteriores, en lugar de volver a ejecutarlo, Hardhat restablecerá el estado de la red al que estaba en el momento posterior a la ejecución inicial del dispositivo.*

```javascript
const {
  loadFixture,
} = require("@nomicfoundation/hardhat-toolbox/network-helpers");
const { expect } = require("chai");

describe("Token contract", function () {
  async function deployTokenFixture() {
    const [owner, addr1, addr2] = await ethers.getSigners();

    const hardhatToken = await ethers.deployContract("Token");

    // Fixtures can return anything you consider useful for your tests
    return { hardhatToken, owner, addr1, addr2 };
  }

  it("Should assign the total supply of tokens to the owner", async function () {
    const { hardhatToken, owner } = await loadFixture(deployTokenFixture);

    const ownerBalance = await hardhatToken.balanceOf(owner.address);
    expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);
  });

  it("Should transfer tokens between accounts", async function () {
    const { hardhatToken, owner, addr1, addr2 } = await loadFixture(
      deployTokenFixture
    );

    // Transfer 50 tokens from owner to addr1
    await expect(
      hardhatToken.transfer(addr1.address, 50)
    ).to.changeTokenBalances(hardhatToken, [owner, addr1], [-50, 50]);

    // Transfer 50 tokens from addr1 to addr2
    // We use .connect(signer) to send a transaction from another account
    await expect(
      hardhatToken.connect(addr1).transfer(addr2.address, 50)
    ).to.changeTokenBalances(hardhatToken, [addr1, addr2], [-50, 50]);
  });
});
```

*Escribimos una ```deployTokenFixture``` función que realiza la configuración necesaria y devuelve cada valor que usamos más adelante en las pruebas. Luego, en cada prueba, utilizamos ```loadFixture``` para ejecutar el dispositivo y obtener esos valores. ```loadFixture``` ejecutará la configuración la primera vez y volverá rápidamente a ese estado en las otras pruebas.*

    