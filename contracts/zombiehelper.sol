// SPDX-License-Identifier: GPL-3.0
//zombie helper project

pragma solidity >=0.7.0 <0.9.0;

import "./zombiefeeding.sol";

contract zombiehelper is zombieFeeding{
    
    uint levelupFee = 0.001 ether;
   
    //modifier with arguments
    modifier aboveLevel(uint _level, uint _zombieId){
        require(zombies[_zombieId].level >= _level);
        _;
    }

    function withdraw() external isOwner() {
        address payable owner = payable (getOwner());
        //address payable owner = address(uint160(getOwner()));
        owner.transfer(address(this).balance);
    }
    
    function setLevelupFee(uint _fee) external isOwner{
        levelupFee = _fee;
    }

    function levelUp (uint _zombieId) external payable{
        require(msg.value == levelupFee);
        zombies[_zombieId].level++;
    }

    function changeName (uint _zombieId, string calldata newname) external aboveLevel (2, _zombieId) onlyownerOf(_zombieId) {
        //require (msg.sender == zombieTOOwner[_zombieId]); this line replaced with modifier onlyownerOf
        zombies[_zombieId].name = newname;
    } 

     function changeDna (uint _zombieId, uint newDna) external aboveLevel (20, _zombieId) onlyownerOf(_zombieId){
        //require(msg.sender == zombieTOOwner[_zombieId]);
        zombies[_zombieId].dna = newDna;
    } 

    function getZombieByOwner (address _owner) external view returns (uint[] memory) {
        uint[] memory result = new uint[](ownerZombieCount[_owner]);
        uint counter = 0;
        for (uint i=0; i < zombies.length; i++){
            if (zombieTOOwner[i] == _owner){
                result[counter] = i;
                counter++;
            }
        }
        return result;
        
    }


}

    
   