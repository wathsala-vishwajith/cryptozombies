pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {
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

    //memory -> for storing the _name in the memory
    //private/public -> make functions private or public
    function _createZombie(string memory _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        emit NewZombie(id, _name, _dna);
    }

    
    //Solidity also contains pure functions, which means you're not even accessing any data in the app.
    // function _multiply(uint a, uint b) private pure returns (uint) {
    //    return a * b;
    // }
    //
    //view -> viewing the data not modifying them.
    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}
