// SPDX-License-Identifier: GPL-3.0

//zombie factory project

pragma solidity >=0.7.0 <0.9.0;

/**
 * creating zombie army with 7 different faces
 */
import "./Owner.sol";
import "./SafeMath.sol";
import "./SafeMath16.sol";
import "./SafeMath32.sol";


contract ZombieFactory is Owner {

    using SafeMath for uint256;
    using SafeMath16 for uint16;
    using SafeMath32 for uint32;
    //start here
// delcare an event to trigger whenever a new zombie is added
    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint cooldownTime = 1 days;

    struct Zombie {
        string name;
        uint dna;
        uint16 wincount;
        uint16 losscount;
        uint32 level;
        uint32 readyTime;
    }

    Zombie[] public zombies;

    mapping (uint => address) public zombieTOOwner;
    mapping (address => uint) public ownerZombieCount;
    
    function _createZombies(string memory _name, uint _dna) internal{
        zombies.push(Zombie(_name, _dna,0,0, 1, uint32 (  block.timestamp + cooldownTime)));   
        uint id = zombies.length.sub(1);
        zombieTOOwner[id] = msg.sender;
        ownerZombieCount[msg.sender] = ownerZombieCount[msg.sender].add(1);

        emit NewZombie(id, _name, _dna);   
    }

    function _generateRandomdna(string memory _str) private view returns(uint){
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomdna(_name);
        _createZombies(_name, randDna);  
    }

  
 
}

