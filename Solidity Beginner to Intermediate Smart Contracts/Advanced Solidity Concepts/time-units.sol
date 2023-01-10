/*
Let's add a cooldown time to our DApp, and make it so zombies have to wait 1 day after attacking or feeding to attack again.

Declare a uint called cooldownTime, and set it equal to 1 days. (Forgive the poor grammar — if you set it equal to "1 day", it won't compile!)

Since we added a level and readyTime to our Zombie struct in the previous chapter, we need to update _createZombie() to use the correct number of arguments when we create a new Zombie struct.

Update the zombies.push line of code to add 2 more arguments: 1 (for level), and uint32(now + cooldownTime) (for readyTime).

Notee: The uint32(...) is necessary because now returns a uint256 by default. So we need to explicitly convert it to a uint32.

now + cooldownTime will equal the current unix timestamp (in seconds) plus the number of seconds in 1 day — which will equal the unix timestamp 1 day from now. Later we can compare to see if this zombie's readyTime is greater than now to see if enough time has passed to use the zombie again.

We'll implement the functionality to limit actions based on readyTime in the next chapter.
*/

pragma solidity >=0.5.0 <0.9.0;

import "./ownable.sol";

contract ZombieFactory is Ownable {

    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    // 1. Define `cooldownTime` here
    uint cooldownTime = 1 days;

    struct Zombie {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
    }

    Zombie[] public zombies;

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    function _createZombie(string memory _name, uint _dna) internal {
        // 2. Update the following line:
        uint id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime))) - 1;
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
