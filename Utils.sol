//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Utils{
    /**
     *   Utility function to concatenate request array to be hashed
     */
    function concatenateStrings(string[] memory arr)
        public 
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

    function stringToUint(string memory s) public pure returns (uint256) {
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