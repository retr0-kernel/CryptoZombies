
//To make sure our Zombie's DNA is only 16 characters, let's make another uint equal to 10^16. That way we can later use the modulus operator % to shorten an integer to 16 digits. Create a uint named dnaModulus, and set it equal to 10 to the power of dnaDigits.

pragma solidity >= 0.5.0 <0.9.0;

contract ZombieFactory {

    uint dnaDigits = 16;
    //start here
    uint dnaModulus = 10 ** dnaDigits;
}
