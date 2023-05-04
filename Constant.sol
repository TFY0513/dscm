// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Constant {

    enum Role{
        FARMER, DISTRIBUTER, RETAILER, CLIENT
    }

    enum Process{
        HARVEST, DISTRIBUTION, DELIVERED, PREPARED, PURCHASE, RATING, COMPLETED
    }

    //define a mapping for allowed role for the process
    mapping(Process => Role) public allowedRole;

    //define a mapping for status for each process for the process
    mapping(Process => string) public status;

    //mapping of the role enum to descriptive value
    // mapping(Role => string) public role;

    constructor() {
        //initiate the allowed roles for current roles
        allowedRole[Process.HARVEST] = Role.FARMER;
        allowedRole[Process.DISTRIBUTION] = Role.DISTRIBUTER;
        allowedRole[Process.DELIVERED] = Role.DISTRIBUTER;
        allowedRole[Process.PREPARED] = Role.RETAILER;
        allowedRole[Process.PURCHASE] = Role.CLIENT;
        allowedRole[Process.RATING] = Role.CLIENT;

        status[Process.HARVEST] = "Harvested";
        status[Process.DISTRIBUTION] = "Delivering";
        status[Process.DELIVERED] = "Delivered";
        status[Process.PREPARED] = "Prepared";
        status[Process.PURCHASE] = "Sold";
        status[Process.RATING] = "Rated";

      
    }
}