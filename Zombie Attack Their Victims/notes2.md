<h2> Mappings and Addresses </h2>

We introduce two new data types `mapping` and `address`

<h3>Addresses</h3>

The Ethereum blockchain is made up of accounts, which you can think of like bank accounts. An account has a balance of Ether (the currency used on the Ethereum blockchain), and you can send and receive Ether payments to other accounts, just like your bank account can wire transfer money to other bank accounts.

Each account has an address, which you can think of like a bank account number. It's a unique identifier that points to that account, and it looks like this:

`0x0cE446255506E92DF41614C46F1d6df9Cc969183`

We'll get into the nitty gritty of addresses in a later lesson, but for now you only need to understand that <b>an address is owned by a specific user (or a smart contract).</b>

So we can use it as a unique ID for ownership of our zombies. When a user creates new zombies by interacting with our app, we'll set ownership of those zombies to the Ethereum address that called the function.

<h3> Mappings </h3>

In Lesson 1 we looked at `structs` and `arrays`. `Mappings` are another way of storing organized data in Solidity.

Defining a `mapping` looks like this:

```
// For a financial app, storing a uint that holds the user's account balance:
mapping (address => uint) public accountBalance;
// Or could be used to store / lookup usernames based on userId
mapping (uint => string) userIdToName;

```
A mapping is essentially a key-value store for storing and looking up data. In the first example, the key is an `address` and the value is a `uint`, and in the second example the key is a `uint` and the value a `string`.

<h2> Msg.sender </h2>

Now that we have our mappings to keep track of who owns a zombie, we'll want to update the `_createZombie` method to use them.

In order to do this, we need to use something called `msg.sender`.

In Solidity, there are certain global variables that are available to all functions. One of these is msg.sender, which refers to the address of the person (or smart contract) who called the current function.

Here's an example of using `msg.sender` and updating a `mapping`:

```
mapping (address => uint) favoriteNumber;

function setMyNumber(uint _myNumber) public {
  // Update our favoriteNumber mapping to store _myNumber under msg.sender
  favoriteNumber[msg.sender] = _myNumber;
  // ^ The syntax for storing data in a mapping is just like with arrays
}

function whatIsMyNumber() public view returns (uint) {
  // Retrieve the value stored in the sender's address
  // Will be `0` if the sender hasn't called `setMyNumber` yet
  return favoriteNumber[msg.sender];
}

```

<h2> Require </h2>

In lesson 1, we made it so users can create new zombies by calling `createRandomZombie` and entering a name. However, if users could keep calling this function to create unlimited zombies in their army, the game wouldn't be very fun.

Let's make it so each player can only call this function once. That way new players will call it when they first start the game in order to create the initial zombie in their army.

How can we make it so this function can only be called once per player?

For that we use `require`. `require` makes it so that the function will throw an error and stop executing if some condition is not true:

```
function sayHiToVitalik(string memory _name) public returns (string memory) {
  // Compares if _name equals "Vitalik". Throws an error and exits if not true.
  // (Side note: Solidity doesn't have native string comparison, so we
  // compare their keccak256 hashes to see if the strings are equal)
  require(keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked("Vitalik")));
  // If it's true, proceed with the function:
  return "Hi!";
}

```

If you call this function with `sayHiToVitalik("Vitalik")`, it will return "Hi!". If you call it with any other input, it will throw an error and not execute.

Thus `require` is quite useful for verifying certain conditions that must be true before running a function.

<h2> Inheritance </h2>

Our game code is getting quite long. Rather than making one extremely long contract, sometimes it makes sense to split your code logic across multiple contracts to organize the code.

One feature of Solidity that makes this more manageable is contract `inheritance`:

```
contract Doge {
  function catchphrase() public returns (string memory) {
    return "So Wow CryptoDoge";
  }
}

contract BabyDoge is Doge {
  function anotherCatchphrase() public returns (string memory) {
    return "Such Moon BabyDoge";
  }
}

```
`BabyDoge` inherits from `Doge`. That means if you compile and deploy `BabyDoge`, it will have access to both `catchphrase()` and `anotherCatchphrase()` (and any other public functions we may define on Doge).

This can be used for logical inheritance (such as with a subclass, a `Cat` is an `Animal`). But it can also be used simply for organizing your code by grouping similar logic together into different contracts.

<h2> Import </h2>

When you have multiple files and you want to import one file into another, Solidity uses the `import` keyword:

```
import "./someothercontract.sol";

contract newContract is SomeOtherContract {

}
```
So if we had a file named `someothercontract.sol` in the same directory as this contract (that's what the `./` means), it would get imported by the compiler.

<h2> Storage V/s Memory (Data Location) </h2>

In Solidity, there are two locations you can store variables — in `storage` and in `memory`.

`Storage` refers to variables stored permanently on the blockchain. `Memory` variables are temporary, and are erased between external function calls to your contract. Think of it like your computer's hard disk vs RAM.

Most of the time you don't need to use these keywords because Solidity handles them by default. State variables (variables declared outside of functions) are by default `storage` and written permanently to the blockchain, while variables declared inside functions are `memory` and will disappear when the function call ends.

However, there are times when you do need to use these keywords, namely when dealing with `structs` and `arrays` within functions:

```
contract SandwichFactory {
  struct Sandwich {
    string name;
    string status;
  }

  Sandwich[] sandwiches;

  function eatSandwich(uint _index) public {
    // Sandwich mySandwich = sandwiches[_index];

    // ^ Seems pretty straightforward, but solidity will give you a warning
    // telling you that you should explicitly declare `storage` or `memory` here.

    // So instead, you should declare with the `storage` keyword, like:
    Sandwich storage mySandwich = sandwiches[_index];
    // ...in which case `mySandwich` is a pointer to `sandwiches[_index]`
    // in storage, and...
    mySandwich.status = "Eaten!";
    // ...this will permanently change `sandwiches[_index]` on the blockchain.

    // If you just want a copy, you can use `memory`:
    Sandwich memory anotherSandwich = sandwiches[_index + 1];
    // ...in which case `anotherSandwich` will simply be a copy of the 
    // data in memory, and...
    anotherSandwich.status = "Eaten!";
    // ...will just modify the temporary variable and have no effect 
    // on `sandwiches[_index + 1]`. But you can do this:
    sandwiches[_index + 1] = anotherSandwich;
    // ...if you want to copy the changes back into blockchain storage.
  }
}
```

<h2> Zombie DNA </h2>

Let's finish writing the `feedAndMultiply` function.

The formula for calculating a new zombie's DNA is simple: the average between the feeding zombie's DNA and the target's DNA.

For example:

```
function testDnaSplicing() public {
  uint zombieDna = 2222222222222222;
  uint targetDna = 4444444444444444;
  uint newZombieDna = (zombieDna + targetDna) / 2;
  // ^ will be equal to 3333333333333333
}
```

Later we can make our formula more complicated if we want to, like adding some randomness to the new zombie's DNA. But for now we'll keep it simple — we can always come back to it later.

<h2> More on Function Visibility <h2>

The code in our previous lesson has a mistake!

If you try compiling it, the compiler will throw an error.

The issue is we tried calling the `_createZombie` function from within `ZombieFeeding`, but `_createZombie` is a `private` function inside `ZombieFactory`. This means none of the contracts that inherit from `ZombieFactory` can access it.

> Internal and External

In addition to `public` and `private`, Solidity has two more types of visibility for functions: `internal` and `external`.

`internal` is the same as `private`, except that it's also accessible to contracts that inherit from this contract. (Hey, that sounds like what we want here!).

`external` is similar to `public`, except that these functions can ONLY be called outside the contract — they can't be called by other functions inside that contract. We'll talk about why you might want to use `external` vs `public` later.

For declaring `internal` or `external` functions, the syntax is the same as `private` and `public`:

```
contract Sandwich {
  uint private sandwichesEaten = 0;

  function eat() internal {
    sandwichesEaten++;
  }
}

contract BLT is Sandwich {
  uint private baconSandwichesEaten = 0;

  function eatWithBacon() public returns (string memory) {
    baconSandwichesEaten++;
    // We can call this here because it's internal
    eat();
  }
}
```

<h2> What do Zombies Eat? </h2>

It's time to feed our zombies! And what do zombies like to eat most?

Well it just so happens that CryptoZombies love to eat...

CryptoKitties! 😱😱😱

(Yes, I'm serious 😆 )

In order to do this we'll need to read the kittyDna from the CryptoKitties smart contract. We can do that because the CryptoKitties data is stored openly on the blockchain. Isn't the blockchain cool?!

Don't worry — our game isn't actually going to hurt anyone's CryptoKitty. We're only reading the CryptoKitties data, we're not able to actually delete it 😉

> Interacting with other contracts

For our contract to talk to another contract on the blockchain that we don't own, first we need to define an `interface`.

Let's look at a simple example. Say there was a contract on the blockchain that looked like this:

```
contract LuckyNumber {
  mapping(address => uint) numbers;

  function setNum(uint _num) public {
    numbers[msg.sender] = _num;
  }

  function getNum(address _myAddress) public view returns (uint) {
    return numbers[_myAddress];
  }
}
```

This would be a simple contract where anyone could store their lucky number, and it will be associated with their Ethereum address. Then anyone else could look up that person's lucky number using their address.

Now let's say we had an external contract that wanted to read the data in this contract using the `getNum` function.

First we'd have to define an `interface` of the `LuckyNumber` contract:
```
contract NumberInterface {
  function getNum(address _myAddress) public view returns (uint);
}
```

Notice that this looks like defining a contract, with a few differences. For one, we're only declaring the functions we want to interact with — in this case `getNum` — and we don't mention any of the other functions or state variables.

Secondly, we're not defining the function bodies. Instead of curly braces (`{` and `}`), we're simply ending the function declaration with a semi-colon (`;`).

So it kind of looks like a contract skeleton. This is how the compiler knows it's an interface.

By including this interface in our dapp's code our contract knows what the other contract's functions look like, how to call them, and what sort of response to expect.

We'll get into actually calling the other contract's functions in the next lesson, but for now let's declare our interface for the CryptoKitties contract.

<h2> Using an Interface </h2>

Continuing our previous example with NumberInterface, once we've defined the interface as:
```
contract NumberInterface {
  function getNum(address _myAddress) public view returns (uint);
}
```

We can use it in a contract as follows:

```
contract MyContract {
  address NumberInterfaceAddress = 0xab38... 
  // ^ The address of the FavoriteNumber contract on Ethereum
  NumberInterface numberContract = NumberInterface(NumberInterfaceAddress);
  // Now `numberContract` is pointing to the other contract

  function someFunction() public {
    // Now we can call `getNum` from that contract:
    uint num = numberContract.getNum(msg.sender);
    // ...and do something with `num` here
  }
}
```

In this way, your contract can interact with any other contract on the Ethereum blockchain, as long they expose those functions as `public` or `external`.


<h2> Handling Multiple Return Values </h2>

This `getKitty` function is the first example we've seen that returns multiple values. Let's look at how to handle them:

```
function multipleReturns() internal returns(uint a, uint b, uint c) {
  return (1, 2, 3);
}

function processMultipleReturns() external {
  uint a;
  uint b;
  uint c;
  // This is how you do multiple assignment:
  (a, b, c) = multipleReturns();
}

// Or if we only cared about one of the values:
function getLastReturnValue() external {
  uint c;
  // We can just leave the other fields blank:
  (,,c) = multipleReturns();
}
```
<h2> Bonus: Kitty Genes(if) </h2>

Our function logic is now complete... but let's add in one bonus feature.

Let's make it so zombies made from kitties have some unique feature that shows they're cat-zombies.

To do this, we can add some special kitty code in the zombie's DNA.

If you recall from lesson 1, we're currently only using the first 12 digits of our 16 digit DNA to determine the zombie's appearance. So let's use the last 2 unused digits to handle "special" characteristics.

We'll say that cat-zombies have `99` as their last two digits of DNA (since cats have 9 lives). So in our code, we'll say if a zombie comes from a cat, then set the last two digits of DNA to `99`.

> If statements

If statements in Solidity look just like javascript:
```
function eatBLT(string memory sandwich) public {
  // Remember with strings, we have to compare their keccak256 hashes
  // to check equality
  if (keccak256(abi.encodePacked(sandwich)) == keccak256(abi.encodePacked("BLT"))) {
    eat();
  }
}
```

<h2> JavaScript Implementation </h2>

Once we're ready to deploy this contract to Ethereum we'll just compile and deploy `ZombieFeeding` — since this contract is our final contract that inherits from `ZombieFactory`, and has access to all the public methods in both contracts.

Let's look at an example of interacting with our deployed contract using Javascript and web3.js:

```
var abi = /* abi generated by the compiler */
var ZombieFeedingContract = web3.eth.contract(abi)
var contractAddress = /* our contract address on Ethereum after deploying */
var ZombieFeeding = ZombieFeedingContract.at(contractAddress)

// Assuming we have our zombie's ID and the kitty ID we want to attack
let zombieId = 1;
let kittyId = 1;

// To get the CryptoKitty's image, we need to query their web API. This
// information isn't stored on the blockchain, just their webserver.
// If everything was stored on a blockchain, we wouldn't have to worry
// about the server going down, them changing their API, or the company 
// blocking us from loading their assets if they don't like our zombie game ;)
let apiUrl = "https://api.cryptokitties.co/kitties/" + kittyId
$.get(apiUrl, function(data) {
  let imgUrl = data.image_url
  // do something to display the image
})

// When the user clicks on a kitty:
$(".kittyImage").click(function(e) {
  // Call our contract's `feedOnKitty` method
  ZombieFeeding.feedOnKitty(zombieId, kittyId)
})

// Listen for a NewZombie event from our contract so we can display it:
ZombieFactory.NewZombie(function(error, result) {
  if (error) return
  // This function will display the zombie, like in lesson 1:
  generateZombie(result.zombieId, result.name, result.dna)
})
```

