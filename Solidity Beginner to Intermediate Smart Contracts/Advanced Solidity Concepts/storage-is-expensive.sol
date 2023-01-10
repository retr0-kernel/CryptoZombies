/*
In our getZombiesByOwner function, we want to return a uint[] array with all the zombies a particular user owns.

Declare a uint[] memory variable called result

Set it equal to a new uint array. The length of the array should be however many zombies this _owner owns, which we can look up from our mapping with: ownerZombieCount[_owner].

At the end of the function return result. It's just an empty array right now, but in the next chapter we'll fill it in.
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
    // Start here
    uint[] memory result = new uint[](ownerZombieCount[_owner]);
    return result;
  }

}
