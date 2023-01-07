// In our app, we're going to need to be able to create some zombies. Let's create a function for that.

// Create a public function named createZombie. It should take two parameters: _name (a string), and _dna (a uint). Don't forget to pass the first argument by value by using the memory keyword

pragma solidity >=0.5.0 <0.9.0;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    // start here
    function createZombie(string memory _name, uint _dna) public{
        
    }

}