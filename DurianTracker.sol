// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Block.sol";
import "./SingleDurianTrack.sol";

contract DurianTracker {
    uint256 public currentIndex = 0;

    // mapping(uint256 => mapping(uint256 => Block)) public trackerBlocks;
    mapping(uint256 => SingleDurianTrack) private duriansProcess;

    struct BlockData {
        uint256 _index;
        bytes32 _previousHash;
        bytes32 _blockHash;
        uint256 _timestamp;
        Constant.Process _process;
        address _uaddress;
        string[4] _data;
    }

    constructor() {}

    modifier checkExistance(uint256 index) {
        require(index <= currentIndex, "The block not existance");
        _;
    }

    function createDurianRecord() public {
        duriansProcess[currentIndex] = new SingleDurianTrack();
       currentIndex++;
    }

    function appendDurianBlock(uint256 index, string[] memory _data)
        public
        checkExistance(index)
    {
        SingleDurianTrack sdt = duriansProcess[index];
        // uint256 processIndex;
        // Block blockToAdd;
        sdt.addBlock(_data);

        // trackerBlocks[index][processIndex] = blockToAdd;
    }

    function getBlock(uint256 index)
        public
        view
        checkExistance(index)
        returns (BlockData[] memory)
    {
        SingleDurianTrack sdt = duriansProcess[index];

        uint256 j = sdt.currentIndex();

        BlockData[] memory blocksdata = new BlockData[](j);
        for (uint256 i = 0; i < j; i++) {
            (
                uint256 _index,
                bytes32 _previousHash,
                bytes32 _blockHash,
                uint256 _timestamp,
                Constant.Process _process,
                address _uaddress,
                string[4] memory _data
            ) = sdt.getBlock(index);
            blocksdata[i] = BlockData(
                _index,
                _previousHash,
                _blockHash,
                _timestamp,
                _process,
                _uaddress,
                _data
            );
        }

        return (blocksdata);
    }

    function displayIndex() public view returns (uint256) {

        return currentIndex;
    }
    // function getAllBlock(uint256 index) public view returns (Block[] memory) {
    //     mapping(uint256 => Block) storage blocks = trackerBlocks[index];
    //     Block[] memory blockchain;
    //     for (uint256 i = 0; ; i++) {
    //         blockchain[uint256(i)] = blocks[i];
    //     }
    //     return blockchain;
    // }
}
