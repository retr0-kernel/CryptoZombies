//In our app, we're going to want to create some zombies! And zombies will have multiple properties, so this is a perfect use case for a struct.
// Create a struct named Zombie.
// Our Zombie struct will have 2 properties: name (a string), and dna (a uint).

pragma solidity >=0.5.0 <0.9.0;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    // start here
    struct Zombie{
        uint dna;
        string name;
    }

}