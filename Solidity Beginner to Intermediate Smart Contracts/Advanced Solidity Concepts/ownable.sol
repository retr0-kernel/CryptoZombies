/*
We've gone ahead and copied the code of the Ownable contract into a new file, ownable.sol. Let's go ahead and make ZombieFactory inherit from it.

Modify our code to import the contents of ownable.sol. If you don't remember how to do this take a look at zombiefeeding.sol.

Modify the ZombieFactory contract to inherit from Ownable. Again, you can take a look at zombiefeeding.sol if you don't remember how this is done.
*/

pragma solidity >=0.5.0 <0.9.0;

// 1. Import here
import "./ownable.sol";

// 2. Inherit here:
contract ZombieFactory is Ownable {

    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    function _createZombie(string memory _name, uint _dna) internal {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        randDna = randDna - randDna % 100;
        _createZombie(_name, randDna);
    }

}
