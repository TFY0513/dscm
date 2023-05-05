// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./DurianTracker.sol";

import "./Constant.sol";
import "./User.sol";
import "./Utils.sol";
import "./DurianProcess.sol";

import "./Block.sol";
import "./FarmerBlock.sol";
import "./DistributorBlock.sol";
import "./RetailerBlock.sol";
import "./ClientBlock.sol";

contract SingleDurianTrack {
    uint256 public currentIndex = 0;
    mapping(uint256 => Block) private blocks;

    //store the current process of a single blockchain
    Constant.Process public currentProcess;

    Constant private con;
    User private u;

    constructor() {
        //set the current process as Harvest as first
        currentProcess = Constant.Process.HARVEST;
        u = User(msg.sender);
    }

    // ---Modifier---
    // modifier validRole(address uadd) {
    //     Constant.Role role;
    //     (, , , , , , , role, , , ) = u.user(uadd);
    //     require(con.allowedRole(currentProcess) == role, "FUP");
    //     _;
    // }

    modifier completedProcess() {
        require(currentProcess != Constant.Process.COMPLETED, "FPC");
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
                Utils.concatenateStrings(_data),
                _previousHash,
                currentIndex,
                block.timestamp
            )
        );

        Block blockToAdd;
        if (currentProcess == Constant.Process.HARVEST) {
            blockToAdd = DurianProcess.addBlockHarvest(
                currentIndex,
                _previousHash,
                _blockHash,
                block.timestamp,
                msg.sender,
                currentProcess,
                _data
            );
        } else if (currentProcess == Constant.Process.DISTRIBUTION) {
            blockToAdd = DurianProcess.addBlockDistribution(
                currentIndex,
                _previousHash,
                _blockHash,
                block.timestamp,
                msg.sender,
                Constant.Process.DELIVERED
            );
        } else if (currentProcess == Constant.Process.DELIVERED) {
            blockToAdd = DurianProcess.addBlockDistribution(
                currentIndex,
                _previousHash,
                _blockHash,
                block.timestamp,
                msg.sender,
                Constant.Process.PREPARED
            );
        } else if (currentProcess == Constant.Process.PREPARED) {
            blockToAdd = DurianProcess.addBlockClient(
                currentIndex,
                _previousHash,
                _blockHash,
                block.timestamp,
                msg.sender,
                Constant.Process.PURCHASE,
                Utils.stringToUint(_data[0])
            );
        } else if (currentProcess == Constant.Process.PURCHASE) {
            blockToAdd = DurianProcess.addBlockClient(
                currentIndex,
                _previousHash,
                _blockHash,
                block.timestamp,
                msg.sender,
                Constant.Process.RATING,
                0
            );
        } else {
            blockToAdd = DurianProcess.addBlockClient(
                currentIndex,
                _previousHash,
                _blockHash,
                block.timestamp,
                msg.sender,
                 Constant.Process.COMPLETED,
                Utils.stringToUint(_data[0])
            );
        }
        currentProcess = Constant.Process(uint256(currentProcess) + 1);

        blocks[currentIndex] = blockToAdd;

        currentIndex++;
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
}
