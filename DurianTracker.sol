// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// import "./Block.sol";
import "./SingleDurianTrack.sol";

contract DurianTracker {
    uint256 public currentIndex = 0;

    mapping(uint256 => SingleDurianTrack) private duriansProcess;

    struct BlockData {
        uint256 _index;
        bytes32 _previousHash;
        bytes32 _blockHash;
        uint256 _timestamp;
        Constant.Process _process;
        address _uaddress;
        string[] _data;
    }

    constructor() {}

    modifier checkExistance(uint256 index) {
        require(index <= currentIndex, "The block not existance");
        _;
    }

    function createDurianRecord(string[] memory _data, address userAddress) public {
        duriansProcess[currentIndex] = new SingleDurianTrack();
        duriansProcess[currentIndex].addBlock(userAddress,_data);
        currentIndex++;
    }

    function displayIndex() public view returns (uint256) {
        return currentIndex;
    }

    function appendDurianBlock(uint256 index, string[] memory _data, address userAddress)
        public
        checkExistance(index)
    {
        SingleDurianTrack sdt = duriansProcess[index];
        sdt.addBlock(userAddress,_data);
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
                string[] memory _data
            ) = sdt.getBlock(i);
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
}
