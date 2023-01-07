
> State Variables and Integers 

State variables are permanently stored in contract storage. This means they're written to the Ethereum blockchain. Think of them like writing to a DB.

<h3>Example:</h3>

contract Example {
  // This will be stored permanently in the blockchain
  uint myUnsignedInteger = 100;
}

In this example contract, we created a uint called myUnsignedInteger and set it equal to 100.

<h3>Unsigned Integers: uint</h3>

The uint data type is an unsigned integer, meaning its value must be non-negative. There's also an int data type for signed integers.

Note: In Solidity, uint is actually an alias for uint256, a 256-bit unsigned integer. You can declare uints with less bits — uint8, uint16, uint32, etc.. But in general you want to simply use uint except in specific cases, which we'll talk about in later lessons.

<h2> Math Operations </h2>

Math in Solidity is pretty straightforward. The following operations are the same as in most programming languages:

Addition: x + y
Subtraction: x - y,
Multiplication: x * y
Division: x / y
Modulus / remainder: x % y (for example, 13 % 5 is 3, because if you divide 5 into 13, 3 is the remainder)

Solidity also supports an exponential operator (i.e. "x to the power of y", x^y):
<b>uint x = 5 ** 2; // equal to 5^2 = 25 </b>

<h2> Structs </h2>

Sometimes you need a more complex data type. For this, Solidity provides structs:

struct Person {
  uint age;
  string name;
}

Structs allow you to create more complicated data types that have multiple properties.

<b> Note: that we just introduced a new type, string. Strings are used for arbitrary-length UTF-8 data. Ex. string greeting = "Hello world!" <b>

<h2> Arrays </h2>

When you want a collection of something, you can use an array. There are two types of arrays in Solidity: fixed arrays and dynamic arrays:

Array with a fixed length of 2 elements:
// uint[2] fixedArray;
another fixed Array, can contain 5 strings:
// string[5] stringArray;

A dynamic Array - has no fixed size, can keep growing:
uint[] dynamicArray;

You can also create an array of structs. Using the previous chapter's Person struct:

Person[] people; // dynamic Array, we can keep adding to it

Remember that state variables are stored permanently in the blockchain? So creating a dynamic array of structs like this can be useful for storing structured data in your contract, kind of like a database.

<h3> Public Arrays </h3>

You can declare an array as public, and Solidity will automatically create a getter method for it. The syntax looks like:

Person[] public people;
Other contracts would then be able to read from, but not write to, this array. So this is a useful pattern for storing public data in your contract.

<h2> Function Declarations </h2>

A function declaration in solidity looks like the following:

function eatHamburgers(string memory _name, uint _amount) public {

}
This is a function named eatHamburgers that takes 2 parameters: a string and a uint. For now the body of the function is empty. Note that we're specifying the function visibility as public. We're also providing instructions about where the _name variable should be stored- in memory. This is required for all reference types such as arrays, structs, mappings, and strings.

What is a reference type you ask?

Well, there are two ways in which you can pass an argument to a Solidity function:

By value, which means that the Solidity compiler creates a new copy of the parameter's value and passes it to your function. This allows your function to modify the value without worrying that the value of the initial parameter gets changed.
By reference, which means that your function is called with a... reference to the original variable. Thus, if your function changes the value of the variable it receives, the value of the original variable gets changed.

Note : 
Note: It's convention (but not required) to start function parameter variable names with an underscore (_) in order to differentiate them from global variables. We'll use that convention throughout our tutorial.

<h3> Private/Public Functions </h3>

In Solidity, functions are public by default. This means anyone (or any other contract) can call your contract's function and execute its code.

Obviously this isn't always desirable, and can make your contract vulnerable to attacks. Thus it's good practice to mark your functions as private by default, and then only make public the functions you want to expose to the world.

Let's look at how to declare a private function:

uint[] numbers;

function _addToArray(uint _number) private {
  numbers.push(_number);
}

This means only other functions within our contract will be able to call this function and add to the numbers array.

As you can see, we use the keyword private after the function name. And as with function parameters, it's convention to start private function names with an underscore (_).

<h2> More on Functions </h2>

<h3> Return Values </h3>

To return a value from a function, the declaration looks like this:

string greeting = "What's up dog";

function sayHello() public returns (string memory) {
  return greeting;
}
In Solidity, the function declaration contains the type of the return value (in this case string).

<h3> Function modifiers <h3>
The above function doesn't actually change state in Solidity — e.g. it doesn't change any values or write anything.

So in this case we could declare it as a view function, meaning it's only viewing the data but not modifying it:

function sayHello() public view returns (string memory) {


Solidity also contains pure functions, which means you're not even accessing any data in the app. Consider the following:

function _multiply(uint a, uint b) private pure returns (uint) {
  return a * b;
}
This function doesn't even read from the state of the app — its return value depends only on its function parameters. So in this case we would declare the function as pure.

<h2> Keccak256 and Typecasting </h2>

We want our _generateRandomDna function to return a (semi) random uint. How can we accomplish this?

Ethereum has the hash function keccak256 built in, which is a version of SHA3. A hash function basically maps an input into a random 256-bit hexadecimal number. A slight change in the input will cause a large change in the hash.

It's useful for many purposes in Ethereum, but for right now we're just going to use it for pseudo-random number generation.

Also important, keccak256 expects a single parameter of type bytes. This means that we have to "pack" any parameters before calling keccak256:

Example:
//6e91ec6b618bb462a4a6ee5aa2cb0e9cf30f7a052bb467b0ba58b8748c00d2e5
keccak256(abi.encodePacked("aaaab"));
//b1f078126895a1424524de5321b339ab00408010b7cf0e6ed451514981e58aa9
keccak256(abi.encodePacked("aaaac"));

As you can see, the returned values are totally different despite only a 1 character change in the input.

<h3> Typecasting </h3>

Sometimes you need to convert between data types. Take the following example:

uint8 a = 5;
uint b = 6;
// throws an error because a * b returns a uint, not uint8:
uint8 c = a * b;
// we have to typecast b as a uint8 to make it work:
uint8 c = a * uint8(b);

In the above, a * b returns a uint, but we were trying to store it as a uint8, which could cause potential problems. By casting it as a uint8, it works and the compiler won't throw an error.
