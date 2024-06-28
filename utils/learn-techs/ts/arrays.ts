//Type indexing

type HeroProperties = {
    isActive: boolean
    address:{
        planet: string, 
        city: string
    }
}

const addressHero: HeroProperties["address"] = {
    planet: "Earth",
    city: "New York"
}

// Type from value

const address = {
    planet: "Earth",
    city: "New York"
}

type Address = typeof address //Se puede extraer de classes, funciones

const addressTwitch: Address = {
    planet: "Mars",
    city: "Twitch"
}

// Type from function return
// Por inferencia sabemos lo que devuelve la función

function fn () {
    return{
        name: "Tierra",
        age: 30
    }
}

type AddressB = ReturnType<typeof fn>

const addressBarcelona: AddressB = {
    name: "Barcelona",
    age: 4
}


// ARRAYS

const languages: string[] = ["JavaScript", "TypeScript", "Java"]
const numbers: Array<number> = [1, 2, 3];

// Array de string o de number

const orFalse: string[] | number[] = ["Hola", 1, 2, "Adios"] // ❌
const orTrue: string[] | number[] = ["Hola", "Adios"] // ✔️ 

// Arrays combinados

const combi: (string | number)[] = ["Hola", 1, 2, "Adios"] 

// Arrays objetos

type Hero = {
    name: string,
    age: number
}
const Avengers: Hero[] = [
    {name: "Thor", age: 1500},
    {name: "Spiderman", age: 20}
]



function imprimirArray<T>(array: T[]): void {
    array.forEach(elemento => console.log(elemento));
}

// MATRICES


/*
[
    ["X", "O", "X"],
    ["X", "O", "X"],
    ["X", "", "X"]
]
*/

type CellValue = "X" | "O" | ""
// Tuplas -> Array con limite de posiciones
type GameBoard = [
    [CellValue, CellValue, CellValue],
    [CellValue, CellValue, CellValue],
    [CellValue, CellValue, CellValue]
]
const gameBoard: GameBoard = [
    ["X", "O", "X"],
    ["X", "O", "X"],
    ["", "", "X"]
]

type RGB = [number, number, number]
const color: RGB = [255, 0, 0];

// Push tuplas

const colorProblema: RGB = [255, 0, 255];
colorProblema.push(255);
type RGBEstricto = readonly [number, number, number]
const colorEstatico: RGBEstricto = [255, 0, 255];
colorEstatico.push(255)






