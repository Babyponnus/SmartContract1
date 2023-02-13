// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <=0.9.0;

import "./zombieAttack.sol";
import "./erc721.sol";

import "./SafeMath.sol";


contract zombieOwnership is zombieAttack, erc721{

    using SafeMath for uint256;

    mapping(uint => address) zombieApprovals;

    function balanceOf(address _owner) external override view returns(uint256){
        return ownerZombieCount[_owner];
    }

    function ownerOf(uint256 _tokenId) external override view returns(address){
        return zombieTOOwner[_tokenId];
    } 

    function _transfer(address _from, address _to, uint256 _tokenId) private {
        ownerZombieCount[_to] = ownerZombieCount[_to].add(1);
        ownerZombieCount[_from] = ownerZombieCount[_from].sub(1);
        zombieTOOwner[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) external payable override {
        require(zombieTOOwner[_tokenId]== msg.sender || zombieApprovals[_tokenId]== msg.sender);
        _transfer(_from, _to, _tokenId);
    }

    function approve(address _approved, uint256 _tokenId) external payable onlyownerOf(_tokenId) override {
        zombieApprovals[_tokenId] = _approved;
        emit Approval(msg.sender, _approved, _tokenId);
    } 



}