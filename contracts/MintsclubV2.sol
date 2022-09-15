// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./MintsclubProxy.sol";
contract MintsclubV2 is MintsclubProxy{

    function setBaseUri() public pure returns(string memory) {
        return "done/";
    }
    function CurrentVersion() public  pure returns(uint){
        return 2;

    }

}