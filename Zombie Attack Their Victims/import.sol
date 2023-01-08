/*
Now that we've set up a multi-file structure, we need to use import to read the contents of the other file:

Import zombiefactory.sol into our new file, zombiefeeding.sol.
*/

pragma solidity >=0.5.0 <0.9.0;

// put import statement here
import "./zombiefactory.sol";

contract ZombieFeeding is ZombieFactory {

}
