// SPDX-License-Identifier: GPL-3.0
//erc721 contract

pragma solidity >=0.7.0 <0.9.0;

contract erc721  {
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
    event Approval(address indexed _owner,address indexed _approved, uint256 indexed _tokedId);

    function balanceOf(address _owner) external view returns(uint256);
    function ownerOf(uint256 _tokenId) external view returns(address);
    function transferFrom(address _from, address _to, uint256 _tokenId) external payable;
    function approve(address _approved, uint256 _tokenId) external payable;
    
}
