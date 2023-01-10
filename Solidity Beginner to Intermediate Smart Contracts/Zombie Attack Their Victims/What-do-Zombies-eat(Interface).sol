/*
We've looked up the CryptoKitties source code for you, and found a function called getKitty that returns all the kitty's data, including its "genes" (which is what our zombie game needs to form a new zombie!).

The function looks like this:

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
) {
    Kitty storage kit = kitties[_id];

    // if this variable is 0 then it's not gestating
    isGestating = (kit.siringWithId != 0);
    isReady = (kit.cooldownEndBlock <= block.number);
    cooldownIndex = uint256(kit.cooldownIndex);
    nextActionAt = uint256(kit.cooldownEndBlock);
    siringWithId = uint256(kit.siringWithId);
    birthTime = uint256(kit.birthTime);
    matronId = uint256(kit.matronId);
    sireId = uint256(kit.sireId);
    generation = uint256(kit.generation);
    genes = kit.genes;
}
The function looks a bit different than we're used to. You can see it returns... a bunch of different values. If you're coming from a programming language like Javascript, this is different — in Solidity you can return more than one value from a function.

Now that we know what this function looks like, we can use it to create an interface:

Define an interface called KittyInterface. Remember, this looks just like creating a new contract — we use the contract keyword.

Inside the interface, define the function getKitty (which should be a copy/paste of the function above, but with a semi-colon after the returns statement, instead of everything inside the curly braces.
*/

pragma solidity >=0.5.0 <0.9.0;

import "./zombiefactory.sol";

// Create KittyInterface here
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

  function feedAndMultiply(uint _zombieId, uint _targetDna) public {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    _createZombie("NoName", newDna);
  }

}
