// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Constant.sol";
import "./Block.sol";

//mined for distributor, for two block involving 2 processes, delivering and delivered
contract DistributorBlock is Block {


    constructor(
        uint256 _index,
        bytes32 _previousHash,
        bytes32 _blockHash,
        uint256 _timestamp,
        Constant.Process _process,
        address _uaddress
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
               
                 "", "", "", ""
            ]
        );
    }
}
