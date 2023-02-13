// SPDX-License-Identifier: GPL-3.0
// library

pragma solidity >=0.7.0 <0.9.0;

library SafeMath16{

    function mul(uint16 a, uint16 b) internal pure returns(uint16) {
        if(a == 0){
          return 0;
        }
        uint16 c = a* b;
        assert (c / a == b);
        return c;

    }

    function div(uint16 a, uint16 b) internal pure returns(uint16){
        uint16 c = a/b;
        return c;
    }

    function sub(uint16 a, uint16 b) internal pure returns(uint16) {
        assert (b <= a);
        return a - b;

    }

    function add(uint16 a, uint16 b) internal pure returns(uint16) {
        uint16 c = a + b;
        assert (c >= a);
        return c;
    }
}

