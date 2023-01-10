/*
Let's finish our getZombiesByOwner function by writing a for loop that iterates through all the zombies in our DApp, compares their owner to see if we have a match, and pushes them to our result array before returning it.

Declare a uint called counter and set it equal to 0. We'll use this variable to keep track of the index in our result array.

Declare a for loop that starts from uint i = 0 and goes up through i < zombies.length. This will iterate over every zombie in our array.

Inside the for loop, make an if statement that checks if zombieToOwner[i] is equal to _owner. This will compare the two addresses to see if we have a match.

Inside the if statement:

Add the zombie's ID to our result array by setting result[counter] equal to i.
Increment counter by 1 (see the for loop example above).
That's it — the function will now return all the zombies owned by _owner without spending any gas.
*/

pragma solidity >=0.5.0 <0.9.0;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

  modifier aboveLevel(uint _level, uint _zombieId) {
    require(zombies[_zombieId].level >= _level);
    _;
  }

  function changeName(uint _zombieId, string calldata _newName) external aboveLevel(2, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].name = _newName;
  }

  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].dna = _newDna;
  }

  function getZombiesByOwner(address _owner) external view returns(uint[] memory) {
    uint[] memory result = new uint[](ownerZombieCount[_owner]);
    // Start here
    uint counter = 0;
    for (uint i = 0; i < zombies.length; i++) {
      if (zombieToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

}
