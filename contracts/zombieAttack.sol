// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./zombiehelper.sol";

contract zombieAttack is zombiehelper{
    
    uint256 randNonce = 0;
    uint attackVictortprobability = 70;
    
    function randMod(uint _modulus) internal returns(uint){
        randNonce++;
        return  uint(keccak256(abi.encodePacked(block.timestamp,msg.sender,randNonce))) % _modulus;       
    }

    function attack(uint _zombieId, uint _targetId) external onlyownerOf(_zombieId){
        Zombie storage myZombie = zombies[_zombieId];
        Zombie storage enemyZombie = zombies[_targetId];
        uint rand = randMod(100);
        if (rand <= attackVictortprobability){
            myZombie.wincount++;
            myZombie.level++;
            enemyZombie.losscount++;
            feedandMultiply(_zombieId,enemyZombie.dna,"zombie");
        } 
        else {
            myZombie.losscount++;
            enemyZombie.wincount++;
            _triggerCooldown(myZombie);
        }
    


    }


}