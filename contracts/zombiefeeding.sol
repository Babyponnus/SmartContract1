// SPDX-License-Identifier: GPL-3.0
//zombie feeding project

pragma solidity >=0.7.0 <0.9.0;

import "./ZombieFactory.sol";

interface Kitty {
    function getKitty(uint256 _id) external view returns(
        bool isGestating,
        bool isReady,
        uint256 cooldownIndex,
        uint256 nextActionAt,
        uint256 stringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes
    );
}

contract zombieFeeding is ZombieFactory{

    
    //Interface Kitty 
    Kitty kittyContract;

    modifier onlyownerOf(uint _zombieId) {
        require(msg.sender == zombieTOOwner[_zombieId]);
        _;
    }

    function setKittyContractAddress(address _address) external isOwner {
        kittyContract = Kitty(_address);
    }

    function _triggerCooldown(Zombie storage _zombie) internal {
        _zombie.readyTime = uint32 (block.timestamp + cooldownTime);
    }

    function _isReady(Zombie storage _zombie) internal view returns(bool) {
        return (_zombie.readyTime <= block.timestamp); 
    }
    
    function feedandMultiply(uint _zombieId, uint _targetDna, string memory _speices) internal onlyownerOf(_zombieId){
        //require(msg.sender == zombieTOOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        require(_isReady(myZombie));
        // modulus here will take last 16 digits only
        _targetDna = _targetDna % dnaModulus;
        uint newDna = (myZombie.dna + _targetDna) / 2;
        /* add 99 at end of new dna to differentiate the new zombies fed on kitties
        below hash check is because, strigs cannot be compared as such, so converting 
        to hashes and then checking.
        */
        if (keccak256(abi.encodePacked(_speices)) ==  keccak256(abi.encodePacked("kitty"))){
            newDna = newDna - newDna % 100 + 99;
        }

        _createZombies("Noname", newDna);
        _triggerCooldown(myZombie);
        
    }

    function feedOnkitty(uint _zombieId, uint _kittyId) public {
        uint kittyDna;
        (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
        feedandMultiply(_zombieId, kittyDna, "kitty");
    }

}