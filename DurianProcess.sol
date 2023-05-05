// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./FarmerBlock.sol";
import "./DistributorBlock.sol";
import "./RetailerBlock.sol";
import "./ClientBlock.sol";

import "./Utils.sol";

library DurianProcess {
    modifier validRating(uint256 rate) {
        require(
            rate >= 0 && rate <= 5,
            "The rating should be dropped between 0 to 5"
        );
        _;
    }

    /**
     *   Append the blockchain for harvest process
     *   return FarmerBlock
     */
    function addBlockHarvest(
        uint256 _index,
        bytes32 _previousHash,
        bytes32 _blockHash,
        uint256 _timestamp,
        address _uaddress,
        Constant.Process _process,
        string[] memory _data
    ) internal returns (FarmerBlock) {
        return
            new FarmerBlock(
                _index,
                _previousHash,
                _blockHash,
                _timestamp,
                _process,
                _uaddress,
                Utils.stringToUint(_data[0]),
                _data[1],
                _data[2],
                Utils.stringToUint(_data[3])
            );
    }

    /**
     *   Append the blockchain for distribution process
     *   return DistributorBlock
     */
    function addBlockDistribution(
        uint256 _index,
        bytes32 _previousHash,
        bytes32 _blockHash,
        uint256 _timestamp,
        address _uaddress,
        Constant.Process _process
    ) internal returns (DistributorBlock) {
        return
            new DistributorBlock(
                _index,
                _previousHash,
                _blockHash,
                _timestamp,
                _process,
                _uaddress
            );
    }

    /**
     *   Append the blockchain for distribution process
     *   return RetailerBlock
     */
    function addBlockClient(
        uint256 _index,
        bytes32 _previousHash,
        bytes32 _blockHash,
        uint256 _timestamp,
        address _uaddress,
        Constant.Process _process,
        uint256 rate
    ) internal validRating(rate) returns (ClientBlock) {
        return
            new ClientBlock(
                _index,
                _previousHash,
                _blockHash,
                _timestamp,
                _process,
                _uaddress,
                rate
            );
    }

    /**
     *   Append the blockchain for distribution process
     *   return RetailerBlock
     */
    function addBlockRetailer(
        uint256 _index,
        bytes32 _previousHash,
        bytes32 _blockHash,
        uint256 _timestamp,
        address _uaddress,
        Constant.Process _process,
        uint256 price
    ) internal returns (RetailerBlock) {
        return
            new RetailerBlock(
                _index,
                _previousHash,
                _blockHash,
                _timestamp,
                _process,
                _uaddress,
                price
            );
    }
}
