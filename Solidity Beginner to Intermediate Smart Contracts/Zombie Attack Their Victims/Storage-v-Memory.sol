/*
It's time to give our zombies the ability to feed and multiply!

When a zombie feeds on some other lifeform, its DNA will combine with the other lifeform's DNA to create a new zombie.

Create a function called feedAndMultiply. It will take two parameters: _zombieId (a uint) and _targetDna (also a uint). This function should be public.

We don't want to let someone else feed our zombie! So first, let's make sure we own this zombie. Add a require statement to verify that msg.sender is equal to this zombie's owner (similar to how we did in the createRandomZombie function).

Notee: Again, because our answer-checker is primitive, it's expecting msg.sender to come first and will mark it wrong if you switch the order. But normally when you're coding, you can use whichever order you prefer — both are correct.

We're going to need to get this zombie's DNA. So the next thing our function should do is declare a local Zombie named myZombie (which will be a storage pointer). Set this variable to be equal to index _zombieId in our zombies array.

You should have 4 lines of code so far, including the line with the closing }.

We'll continue fleshing out this function in the next chapter!
*/

pragma solidity >=0.5.0 <0.9.0;

import "./zombiefactory.sol";

contract ZombieFeeding is ZombieFactory {

  // Start here
  function feedAndMultiply(uint _zombieId, uint _targetDna) public {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
  }

}
