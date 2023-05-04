// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Constant.sol";

abstract contract Block {
    uint256 public index;
    bytes32 public previousHash;
    bytes32 public blockHash;
    uint256 public timestamp;
    Constant.Process public process;
    address public uaddress;

    constructor(
        uint256 _index,
        bytes32 _previousHash,
        bytes32 _blockHash,
        uint256 _timestamp,
        Constant.Process _process,
        address _uaddress
    ) {
        index = _index;
        previousHash = _previousHash;
        blockHash = _blockHash;
        timestamp = _timestamp;
        process = _process;
        uaddress = _uaddress;
    }

    function getData() public view virtual returns(uint256, bytes32, bytes32, uint256, Constant.Process, address, string[4] memory);
}