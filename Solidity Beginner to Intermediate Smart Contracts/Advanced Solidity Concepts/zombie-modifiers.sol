/*
Create a function called changeName. It will take 2 arguments: _zombieId (a uint), and _newName (a string with the data location set to calldata ), and make it external. It should have the aboveLevel modifier, and should pass in 2 for the _level parameter. (Don't forget to also pass the _zombieId).
Notee: calldata is somehow similar to memory, but it's only available to external functions.

In this function, first we need to verify that msg.sender is equal to zombieToOwner[_zombieId]. Use a require statement.

Then the function should set zombies[_zombieId].name equal to _newName.

Create another function named changeDna below changeName. Its definition and contents will be almost identical to changeName, except its second argument will be _newDna (a uint), and it should pass in 20 for the _level parameter on aboveLevel. And of course, it should set the zombie's dna to _newDna instead of setting the zombie's name.
*/

pragma solidity >=0.5.0 <0.9.0;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

  modifier aboveLevel(uint _level, uint _zombieId) {
    require(zombies[_zombieId].level >= _level);
    _;
  }

  // Start here
  function changeName(uint _zombieId, string calldata _newName) external aboveLevel(2, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].name = _newName;
  }

  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].dna = _newDna;
  }

}
