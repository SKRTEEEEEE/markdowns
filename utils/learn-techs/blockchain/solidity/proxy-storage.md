# Proxy storage patron


## Basic example

### 1. **Contrato de Almacenamiento (Storage)**

El contrato de almacenamiento almacenará todos los datos necesarios para los NFTs.

```solidity
// Storage.sol
pragma solidity ^0.8.0;

contract Storage {
    mapping(bytes32 => uint256) private uintStorage;
    mapping(bytes32 => address) private addressStorage;
    mapping(bytes32 => string) private stringStorage;

    function getUint(bytes32 key) public view returns (uint256) {
        return uintStorage[key];
    }

    function setUint(bytes32 key, uint256 value) public {
        uintStorage[key] = value;
    }

    function getAddress(bytes32 key) public view returns (address) {
        return addressStorage[key];
    }

    function setAddress(bytes32 key, address value) public {
        addressStorage[key] = value;
    }

    function getString(bytes32 key) public view returns (string memory) {
        return stringStorage[key];
    }

    function setString(bytes32 key, string memory value) public {
        stringStorage[key] = value;
    }
}
```

### 2. **Contrato de Lógica para NFTs (NFTLogic)**

Este contrato contiene la lógica para crear y manejar NFTs.

```solidity
// NFTLogic.sol
pragma solidity ^0.8.0;

import "./Storage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTLogic is ERC721, Ownable {
    Storage internal storageContract;
    uint256 internal nextTokenId;

    constructor(Storage _storage) ERC721("MyNFT", "MNFT") {
        storageContract = _storage;
        nextTokenId = 1; // Assuming we start minting from tokenId 1
    }

    function mint(address to) public onlyOwner {
        uint256 tokenId = nextTokenId;
        _mint(to, tokenId);
        storageContract.setUint(keccak256(abi.encodePacked("ownerOf", tokenId)), uint256(uint160(to)));
        storageContract.setUint(keccak256(abi.encodePacked("tokenIdExists", tokenId)), 1);
        nextTokenId++;
    }

    function tokenExists(uint256 tokenId) public view returns (bool) {
        return storageContract.getUint(keccak256(abi.encodePacked("tokenIdExists", tokenId))) == 1;
    }

    function ownerOf(uint256 tokenId) public view override returns (address) {
        return address(uint160(storageContract.getUint(keccak256(abi.encodePacked("ownerOf", tokenId)))));
    }
}
```

### 3. **Contrato Proxy (Proxy)**

El contrato proxy delega todas las llamadas al contrato de lógica.

```solidity
// Proxy.sol
pragma solidity ^0.8.0;

contract Proxy {
    address public implementation;

    constructor(address _implementation) {
        implementation = _implementation;
    }

    function updateImplementation(address _newImplementation) public {
        implementation = _newImplementation;
    }

    fallback() external payable {
        address impl = implementation;
        require(impl != address(0));
        assembly {
            let ptr := mload(0x40)
            calldatacopy(ptr, 0, calldatasize())
            let result := delegatecall(gas(), impl, ptr, calldatasize(), 0, 0)
            let size := returndatasize()
            returndatacopy(ptr, 0, size)
            switch result
            case 0 { revert(ptr, size) }
            default { return(ptr, size) }
        }
    }
}
```

### 4. **Despliegue y Uso**

Para desplegar y usar estos contratos, sigue estos pasos:

1. **Despliega el contrato de almacenamiento:**
    ```solidity
    Storage storageContract = new Storage();
    ```

2. **Despliega el contrato de lógica con la dirección del contrato de almacenamiento:**
    ```solidity
    NFTLogic nftLogic = new NFTLogic(storageContract);
    ```

3. **Despliega el contrato proxy con la dirección del contrato de lógica:**
    ```solidity
    Proxy proxy = new Proxy(address(nftLogic));
    ```

4. **Interactúa con la DApp a través del contrato proxy:**
    Utiliza la dirección del proxy para interactuar con la lógica de los NFTs. Cualquier actualización en la lógica se realiza desplegando una nueva versión del contrato de lógica y actualizando la dirección en el contrato proxy.

### Actualización del Contrato de Lógica

Para actualizar la lógica:

1. Despliega una nueva versión del contrato de lógica (e.g., `NFTLogicV2`).
2. Llama a `updateImplementation` en el contrato proxy con la nueva dirección del contrato de lógica:
    ```solidity
    proxy.updateImplementation(address(newNFTLogic));
    ```

Este enfoque asegura que el estado almacenado en el contrato de almacenamiento permanece intacto mientras se puede actualizar la lógica del contrato sin problemas.