/*
Let's update our code from Chapter 2 to be able to change the CryptoKitties contract address.

Delete the line of code where we hard-coded ckAddress.

Change the line where we created kittyContract to just declare the variable — i.e. don't set it equal to anything.

Create a function called setKittyContractAddress. It will take one argument, _address (an address), and it should be an external function.

Inside the function, add one line of code that sets kittyContract equal to KittyInterface(_address).
*/

pragma solidity >=0.5.0 <0.9.0;

import "./zombiefactory.sol";

contract KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract ZombieFeeding is ZombieFactory {

  // 1. Remove this:
  // 2. Change this to just a declaration:
  KittyInterface kittyContract;

  // 3. Add setKittyContractAddress method here
  function setKittyContractAddress(address _address) external{
    kittyContract = KittyInterface(_address);
  }

  function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) public {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
      newDna = newDna - newDna % 100 + 99;
    }
    _createZombie("NoName", newDna);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  }

}
