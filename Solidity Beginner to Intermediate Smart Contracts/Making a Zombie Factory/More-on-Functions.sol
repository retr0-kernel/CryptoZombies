/* We're going to want a helper function that generates a random DNA number from a string.

Create a private function called _generateRandomDna. It will take one parameter named _str (a string), and return a uint. Don't forget to set the data location of the _str parameter to memory.

This function will view some of our contract's variables but not modify them, so mark it as view.

The function body should be empty at this point — we'll fill it in later.
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
    // start here
    function _generateRandomDna(string memory _str) private view returns (uint){

    }


}
