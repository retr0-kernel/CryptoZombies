//We're going to want to store an army of zombies in our app. And we're going to want to show off all our zombies to other apps, so we'll want it to be public.

// Create a public array of Zombie structs, and name it zombies.

pragma solidity >=0.5.0 <0.9.0;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }
    // start here

    Zombie[] public zombies;

}