# Hardhat tutorial 

Tutorial de [hardhat oficial](https://hardhat.org/tutorial)

## Requisitos

- Node.js ```>=16.0 ```

## Comandos para iniciar

- Crear una carpeta para el proyecto

```bash
mkdir hardhat-tutorial
cd hardhat-tutorial
```

- Iniciar proyecto node

```bash
npm init
```

- Instalar Hardhat e inicializar

```bash
npm install --save-dev hardhat
npx hardhat init
```

- Escojemos ```empty hardhat.config.js```

*Aqui podemos ver la arcitectura actual de Hardhat*

## Plugins

*Hardhat viene con unos plugins predefinidos, que se puden quitar, pero te deja configurar con todos los plugins que necesites*

- Instalamos [```@nomicfoundation/hardhat-toolbox```](https://hardhat.org/hardhat-runner/plugins/nomicfoundation-hardhat-toolbox)

```bash
npm install --save-dev @nomicfoundation/hardhat-toolbox
```
- Lo importamos en ```hardhat.config.js```

```javascript
require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.24",
};
```

## Contracts

- Creamos una carpeta llamada ```contracts``` y ahi ponemos nuestro contrato

- Ejecutamos ```npx hardhat compile``` para hacer uso de la **task** ```compile```

```bash
$ npx hardhat compile
Compiled 1 Solidity file successfully (evm target: paris).
```

## 5. Testing contracts

Para test utilizaremos **Hardhat Network**, una red local de Eth diseñada para desarollo (viene con hardhat).
Vamos a utilizar [**ethers.js**](https://docs.ethers.org/v6/) para interactuar con el contrato Eth. Y [**Mocha**](https://mochajs.org/https://mochajs.org/) para ejecutar nuestro test.

- Creamos un directorio llamado ```test```, dentro un archivo con el nombre del contrato pero terminado en *.js* y creamos el archivo para el test.

- Ejecutamos ```npx hardhat test```.

### [Ethers.js y hardhat test functions](/utils/learn-techs/blockchain-techs/ethers-test.md)

## 6. Debugging (depuración) con Hardhat Network

*Hardhat viene integrado con Hardhat Network, una red local de Ethereum diseñada para el desarrollo. Le permite implementar sus contratos, ejecutar sus pruebas y depurar su código, todo dentro de los límites de su máquina local. Es la red predeterminada a la que se conecta Hardhat, por lo que no necesita configurar nada para que funcione. Simplemente ejecute sus pruebas.*

### [Solidity ```console.log()```](https://hardhat.org/hardhat-network/docs/overview#console.log)

- Al ejecutar sus contratos y pruebas en Hardhat Network, puede imprimir mensajes de registro y variables de contrato llamando console.log() desde su código Solidity. Para usarlo tienes que importarlo ```hardhat/console.sol``` en tu código de contrato.

    ```javascript
    pragma solidity ^0.8.0;

    import "hardhat/console.sol";

    contract Token {
    //...
    }
    ```

- Luego puedes simplemente agregar algunas ```console.log``` llamadas a la ```transfer()``` función como si la estuvieras usando en JavaScript:

    *Asi quedaria nuestra funcion transfer del contrato*

    ```javascript
    function transfer(address to, uint256 amount) external {
    require(balances[msg.sender] >= amount, "Not enough tokens");

    console.log(
        "Transferring from %s to %s %s tokens",
        msg.sender,
        to,
        amount
    );

    balances[msg.sender] -= amount;
    balances[to] += amount;

    emit Transfer(msg.sender, to, amount);
    }
    ```

## 7. Implementación en una red activa

*A nivel de software, implementar en una red de prueba es lo mismo que implementar en una red principal. La única diferencia es a qué red te conectas. Veamos cómo se vería el código para implementar sus contratos usando ethers.js.*

*Los principales conceptos utilizados son **"Signer" y "Contract"** que explicamos en la sección de **test**. No hay nada nuevo que deba hacerse en comparación con las pruebas, dado que cuando prueba sus contratos, en realidad está realizando una implementación en su red de desarrollo. Esto hace que el código sea muy similar, o incluso igual.*

- Creemos un nuevo directorio ```scripts``` dentro del directorio raíz del proyecto y peguemos lo siguiente en un archivo ```deploy.js``` en ese directorio:

    ```javascript
    async function main() {
    const [deployer] = await ethers.getSigners();

    console.log("Deploying contracts with the account:", deployer.address);

    const token = await ethers.deployContract("Token");

    console.log("Token address:", await token.getAddress());
    }

    main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
    ```

- Para indicarle a Hardhat que se conecte a una red Ethereum específica, puede usar el paramentro ```--network``` al ejecutar cualquier tarea, como esta:

    ```bash
    npx hardhat run scripts/deploy.js --network <network-name>
    ```

- *Con nuestra configuración actual, ejecutarlo sin el parámetro ```--network``` haría que el código se ejecutara en una instancia integrada de Hardhat Network. En este escenario, la implementación en realidad se pierde cuando Hardhat termina de ejecutarse, pero aún así es útil probar que nuestro código de implementación funciona:*

    ```bash
    $ npx hardhat run scripts/deploy.js
    Deploying contracts with the account: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
    Token address: 0x5FbDB2315678afecb367f032d93F642f64180aa3
    ```

### Implementación en redes remotas

- Para implementar en una red remota como la red principal o cualquier red de prueba, debe agregar una "network" de entrada a su ```hardhat.config.js``` archivo. Usaremos Sepolia para este ejemplo, pero puedes agregar cualquier red de manera similar:


    ```javascript
    require("@nomicfoundation/hardhat-toolbox");

    // Go to https://infura.io, sign up, create a new API key
    // in its dashboard, and replace "KEY" with it
    const INFURA_API_KEY = "KEY";

    // Replace this private key with your Sepolia account private key
    // To export your private key from Coinbase Wallet, go to
    // Settings > Developer Settings > Show private key
    // To export your private key from Metamask, open Metamask and
    // go to Account Details > Export Private Key
    // Beware: NEVER put real Ether into testing accounts
    const SEPOLIA_PRIVATE_KEY = "YOUR SEPOLIA PRIVATE KEY";

    module.exports = {
    solidity: "0.8.24",
    networks: {
        sepolia: {
        url: `https://sepolia.infura.io/v3/${INFURA_API_KEY}`,
        accounts: [SEPOLIA_PRIVATE_KEY]
        }
    }
    };
    ```

    *Estamos usando [Infura](https://www.infura.io/) o [Alchemy](https://www.alchemy.com/), pero apuntando urla cualquier nodo o puerta de enlace de Ethereum. Toma tu clave API y regresa.*












