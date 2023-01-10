/*
Our contract's createZombie function is currently public by default — this means anyone could call it and create a new Zombie in our contract! Let's make it private.

Modify createZombie so it's a private function. Don't forget the naming convention!
*/

pragma solidity >=0.5.0 <0.9.0;

contract ZombieFactory {

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function _createZombie(string memory _name, uint _dna) private {
        zombies.push(Zombie(_name, _dna));
    }

}