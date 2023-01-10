/*
We want an event to let our front-end know every time a new zombie was created, so the app can display it.

Declare an event called NewZombie. It should pass zombieId (a uint), name (a string), and dna (a uint).

Modify the _createZombie function to fire the NewZombie event after adding the new Zombie to our zombies array.

You're going to need the zombie's id. array.push() returns a uint of the new length of the array - and since the first item in an array has index 0, array.push() - 1 will be the index of the zombie we just added. Store the result of zombies.push() - 1 in a uint called id, so you can use this in the NewZombie event in the next line.
*/

pragma solidity >=0.5.0 <0.9.0;

contract ZombieFactory {

    // declare our event here
    event NewZombie(uint zombieId, string name, uint dna);


    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function _createZombie(string memory _name, uint _dna) private {
        // and fire it here
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}
