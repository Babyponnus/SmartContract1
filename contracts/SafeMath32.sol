// SPDX-License-Identifier: GPL-3.0
// library

pragma solidity >=0.7.0 <0.9.0;

library SafeMath32{

    function mul(uint32 a, uint32 b) internal pure returns(uint32) {
        if(a == 0){
          return 0;
        }
        uint32 c = a* b;
        assert (c / a == b);
        return c;

    }

    function div(uint32 a, uint32 b) internal pure returns(uint32){
        uint32 c = a/b;
        return c;
    }

    function sub(uint32 a, uint32 b) internal pure returns(uint32) {
        assert (b <= a);
        return a - b;

    }

    function add(uint32 a, uint32 b) internal pure returns(uint32) {
        uint32 c = a + b;
        assert (c >= a);
        return c;
    }
}

