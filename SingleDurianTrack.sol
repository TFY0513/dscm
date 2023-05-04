// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./DurianTracker.sol";

import "./Constant.sol";
import "./User.sol";

import "./Block.sol";
import "./FarmerBlock.sol";
import "./DistributorBlock.sol";
import "./RetailerBlock.sol";
import "./ClientBlock.sol";
import "./Utils.sol";

contract SingleDurianTrack {
    uint256 public currentIndex = 0;
    mapping(uint256 => Block) private blocks;

    struct BlockStruct {
        uint256 index;
        bytes32 previousHash;
        bytes32 blockHash;
        uint256 timestamp;
        address uaddress;
    }

    //store the current process of a single blockchain
    Constant.Process public currentProcess;

    Constant private con;
    User private u;
    Utils private utils;

    constructor() {
        //set the current process as Harvest as first
        currentProcess = Constant.Process.HARVEST;
        u = User(msg.sender);
    }

    modifier completedProcess() {
        require(
            currentProcess != Constant.Process.COMPLETED,
            "The process had been completed"
        );
        _;
    }

    modifier validRating(uint256 rate) {
        require(
            rate >= 0 && rate <= 5,
            "The rating should be dropped between 0 to 5"
        );
        _;
    }

    // ---Modifier---

    // function addBlock(string calldata _data) public completedProcess validRole(msg.sender){
    function addBlock(string[] memory _data) public completedProcess {
        bytes32 _previousHash = 0x0000000000000000000000000000000000000000000000000000000000000000;
        if (currentIndex != 0) {
            _previousHash = blocks[currentIndex - 1].blockHash();
        }

        bytes32 _blockHash = keccak256(
            abi.encodePacked(
                utils.concatenateStrings(_data),
                _previousHash,
                currentIndex,
                block.timestamp
            )
        );

        Block blockToAdd;
        BlockStruct memory b = BlockStruct(
            currentIndex,
            _previousHash,
            _blockHash,
            block.timestamp,
            msg.sender
        );
        if (currentProcess == Constant.Process.HARVEST) {
            blockToAdd = addBlockHarvest(b, _data);
            currentProcess = Constant.Process.DISTRIBUTION;
        } else if (currentProcess == Constant.Process.DISTRIBUTION) {
            blockToAdd = addBlockDistribution(b, Constant.Process.DISTRIBUTION);
            currentProcess = Constant.Process.DELIVERED;
        } else if (currentProcess == Constant.Process.DELIVERED) {
            blockToAdd = addBlockDistribution(b, Constant.Process.DELIVERED);
            currentProcess = Constant.Process.PREPARED;
        } else if (currentProcess == Constant.Process.PREPARED) {
            blockToAdd = addBlockClient(b, utils.stringToUint(_data[0]));
            currentProcess = Constant.Process.PURCHASE;
        } else if (currentProcess == Constant.Process.PURCHASE) {
            blockToAdd = addBlockClient(b, 0);
            currentProcess = Constant.Process.RATING;
        } else {
            blockToAdd = addBlockClient(b, utils.stringToUint(_data[0]));
            currentProcess = Constant.Process.COMPLETED;
        }

        blocks[currentIndex] = blockToAdd;

        currentIndex++;
    }

    /**
     *   Append the blockchain for harvest process
     *   return FarmerBlock
     */
    function addBlockHarvest(
        BlockStruct memory _blockdata,
        string[] memory _data
    ) private returns (FarmerBlock) {
        return
            new FarmerBlock(
                _blockdata.index,
                _blockdata.previousHash,
                _blockdata.blockHash,
                _blockdata.timestamp,
                Constant.Process.HARVEST,
                _blockdata.uaddress,
                utils.stringToUint(_data[0]),
                _data[1],
                _data[2],
                utils.stringToUint(_data[3])
            );
    }

    /**
     *   Append the blockchain for distribution process
     *   return DistributorBlock
     */
    function addBlockDistribution(
        BlockStruct memory _blockdata,
        Constant.Process _process
    ) private returns (DistributorBlock) {
        return
            new DistributorBlock(
                _blockdata.index,
                _blockdata.previousHash,
                _blockdata.blockHash,
                _blockdata.timestamp,
                _process,
                _blockdata.uaddress
            );
    }

    /**
     *   Append the blockchain for distribution process
     *   return RetailerBlock
     */
    function addBlockClient(BlockStruct memory _blockdata, uint256 rate)
        private
        validRating(rate)
        returns (ClientBlock)
    {
        return
            new ClientBlock(
                _blockdata.index,
                _blockdata.previousHash,
                _blockdata.blockHash,
                _blockdata.timestamp,
                Constant.Process.DISTRIBUTION,
                _blockdata.uaddress,
                rate
            );
    }

    /**
     *   Append the blockchain for distribution process
     *   return RetailerBlock
     */
    function addBlockRetailer(
        BlockStruct memory _blockdata,
        string[] memory _data
    ) private returns (RetailerBlock) {
        return
            new RetailerBlock(
                _blockdata.index,
                _blockdata.previousHash,
                _blockdata.blockHash,
                _blockdata.timestamp,
                Constant.Process.PREPARED,
                _blockdata.uaddress,
                utils.stringToUint(_data[0]) //Price
            );
    }

    function getBlock(uint256 index)
        public
        view
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
        return blocks[index].getData();
    }

    /**
     *   Utility function to concatenate request array to be hashed
     */
    function concatenateStrings(string[] memory arr)
        private
        pure
        returns (string memory)
    {
        uint256 totalLength = 0;

        for (uint256 i = 0; i < arr.length; i++) {
            totalLength += bytes(arr[i]).length;
        }

        bytes memory result = new bytes(totalLength);
        uint256 k = 0;

        for (uint256 i = 0; i < arr.length; i++) {
            for (uint256 j = 0; j < bytes(arr[i]).length; j++) {
                result[k++] = bytes(arr[i])[j];
            }
        }

        return string(result);
    }

    function stringToUint(string memory s) private pure returns (uint256) {
        bytes memory b = bytes(s);
        uint256 result = 0;
        for (uint256 i = 0; i < b.length; i++) {
            if (uint8(b[i]) >= 48 && uint8(b[i]) <= 57) {
                result = result * 10 + (uint8(b[i]) - 48);
            }
        }
        return result;
    }
}
