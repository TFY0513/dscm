// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Constant.sol";
import "./Block.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

//mined for retailer, for update the durian status as prepared to be purchase
contract RetailerBlock is Block {
    uint256 public price;



    constructor(
        uint256 _index,
        bytes32 _previousHash,
        bytes32 _blockHash,
        uint256 _timestamp,
        Constant.Process _process,
        address _uaddress,
        uint256 _price
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
        price = _price;
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
                Strings.toString(price),"","",""
            ]
        );
    }
}