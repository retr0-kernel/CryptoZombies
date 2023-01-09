/*
Let's implement cat genes in our zombie code.

First, let's change the function definition for feedAndMultiply so it takes a 3rd argument: a string named _species which we'll store in memory.

Next, after we calculate the new zombie's DNA, let's add an if statement comparing the keccak256 hashes of _species and the string "kitty". We can't directly pass strings to keccak256. Instead, we will pass abi.encodePacked(_species) as an argument on the left side and abi.encodePacked("kitty") as an argument on the right side.

Inside the if statement, we want to replace the last 2 digits of DNA with 99. One way to do this is using the logic: newDna = newDna - newDna % 100 + 99;.

Explanation: Assume newDna is 334455. Then newDna % 100 is 55, so newDna - newDna % 100 is 334400. Finally add 99 to get 334499.

Lastly, we need to change the function call inside feedOnKitty. When it calls feedAndMultiply, add the parameter "kitty" to the end.
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

  address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
  KittyInterface kittyContract = KittyInterface(ckAddress);

  // Modify function definition here:
  function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) public {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    // Add an if statement here
    if(keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))){
      newDna = newDna - newDna % 100 + 99;
    }
    _createZombie("NoName", newDna);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    // And modify function call here:
    feedAndMultiply(_zombieId, kittyDna,"kitty");
  }

}
