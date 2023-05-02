// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Constant {
    enum Role {
        FARMER,
        DISTRIBUTER,
        RETAILER,
        CLIENT
    }

    enum Process {
        HARVEST,
        DISTRIBUTION,
        DELIVERED,
        RETAIL,
        STOPPED,
        PURCHASE,
        RATING
    }

    //define a mapping for allowed role for the process
    mapping(Process => Role) public allowedRole;

    constructor() {
        //initiate the allowed roles for current roles
        allowedRole[Process.HARVEST] = Role.FARMER;
        allowedRole[Process.DISTRIBUTION] = Role.DISTRIBUTER;
        allowedRole[Process.DELIVERED] = Role.RETAILER;
        allowedRole[Process.RETAIL] = Role.RETAILER;
        allowedRole[Process.STOPPED] = Role.RETAILER;
        allowedRole[Process.PURCHASE] = Role.CLIENT;
        allowedRole[Process.RATING] = Role.CLIENT;
    }
}
