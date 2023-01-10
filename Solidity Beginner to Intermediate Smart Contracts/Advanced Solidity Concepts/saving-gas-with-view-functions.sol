/*
We're going to implement a function that will return a user's entire zombie army. We can later call this function from web3.js if we want to display a user profile page with their entire army.

This function's logic is a bit complicated so it will take a few chapters to implement.

Create a new function named getZombiesByOwner. It will take one argument, an address named _owner.

Let's make it an external view function, so we can call it from web3.js without needing any gas.
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

  // Create your function here
  function getZombiesByOwner(address _owner) external view returns(uint[] memory) {

  }

}
