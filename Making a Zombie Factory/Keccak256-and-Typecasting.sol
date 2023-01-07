/*
Let's fill in the body of our _generateRandomDna function! Here's what it should do:

The first line of code should take the keccak256 hash of abi.encodePacked(_str) to generate a pseudo-random hexadecimal, typecast it as a uint, and finally store the result in a uint called rand.

We want our DNA to only be 16 digits long (remember our dnaModulus?). So the second line of code should return the above value modulus (%) dnaModulus.
*/

pragma solidity >= 0.5.0 <0.9.0;

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

    function _generateRandomDna(string memory _str) private view returns (uint) {
        // start here
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

}
