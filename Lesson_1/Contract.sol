pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {
    //Events are a way for your contract to communicate that something happened on the blockchain to your app front-end,
    // which can be 'listening' for certain events and take action when they happen.
    //  // declare the event
    // event IntegersAdded(uint x, uint y, uint result);

    // function add(uint _x, uint _y) public returns (uint) {
    //   uint result = _x + _y;
    //   // fire an event to let the app know the function was called:
    //   emit IntegersAdded(_x, _y, result);
    //   return result;
    // }

    //events are fired to the frontend
    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    //arrays
    //static  array
    //Zombie[3] array
    //dynamic array
    Zombie[] public zombies;

    //mapping
    //A mapping is essentially a key-value store for storing and looking up data.
    // // For a financial app, storing a uint that holds the user's account balance:
    // mapping (address => uint) public accountBalance;
    // //Or could be used to store / lookup usernames based on userId
    // mapping (uint => string) userIdToName;

    //maps uint(key) to address(value)
    mapping(uint => address) public zombieToOwner;
    //maps address(key) to uint(value)
    mapping(address => uint) ownerZombieCount;

    //memory -> for storing the _name in the memory
    //private/public -> make functions private or public
    function _createZombie(string memory _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;

        //msg.sender -> global variable that is availible to all the functions
        //msg.sender = address of the person/smart contract who called the function.

        //save a key value on the mapping
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;

        emit NewZombie(id, _name, _dna);
    }

    //Solidity also contains pure functions, which means you're not even accessing any data in the app.
    // function _multiply(uint a, uint b) private pure returns (uint) {
    //    return a * b;
    // }
    //
    //view -> viewing the data not modifying them.
    function _generateRandomDna(
        string memory _str
    ) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
