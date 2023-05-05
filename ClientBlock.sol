// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Constant.sol";
import "./Block.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

//mined for client
contract ClientBlock is Block {
    uint256 public rate;

    constructor(
        uint256 _index,
        bytes32 _previousHash,
        bytes32 _blockHash,
        uint256 _timestamp,
        Constant.Process _process,
        address _uaddress,
        uint256 _rate
    )
        Block(
            _index,
            _previousHash,
            _blockHash,
            _timestamp,
            _process,
            _uaddress
        )
    {
        rate = _rate;
    }

    function getData()
        public
        view
        override
        returns (
            uint256,
            bytes32,
            bytes32,
            uint256,
            Constant.Process,
            address,
            string[4] memory
        )
    {
        return (
            index,
            previousHash,
            blockHash,
            timestamp,
            process,
            uaddress,
            [
                Strings.toString(rate),"","",""
            ]
        );
    }
}