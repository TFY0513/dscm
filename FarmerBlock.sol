// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Constant.sol";
import "./Block.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

//mined when the farmer harvest the durian
//initial block
contract FarmerBlock is Block {
    uint256 public durianId;
    string public durianTree;
    string public durianType;
    uint256 public weight;

    constructor(
        uint256 _index,
        bytes32 _previousHash,
        bytes32 _blockHash,
        uint256 _timestamp,
        Constant.Process _process,
        address _uaddress,
        uint256 _durianId,
        string memory _durianTree,
        string memory _durianType,
        uint256 _weight
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
        durianId = _durianId;
        durianTree = _durianTree;
        durianType = _durianType;
        weight = _weight;
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
                Strings.toString(durianId),
                durianTree,
                durianType,
                Strings.toString(weight)
            ]
        );
    }
}
