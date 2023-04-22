//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract User {
    struct Users {
        uint256 userID;
        string firstName;
        string lastName;
        string email;
        string username;
        string password;
        string contactNum;
        string role;
        uint256 dateJoined;
        string homeAddress;
        string profile_pic;
    }

    // An array of 'Todo' structs
    Users[] user;
    uint256 totalUser = 0;

    constructor() {
        user.push(
            Users(
                1,
                "Fnag yEE",
                "tEE",
                "shink828@gmail.com",
                "tfy",
                "123",
                "012-222222",
                "Retailer",
                block.timestamp,
                "6, jlnm bukit pemrjia, taman nbulti, 56100 kl",
                "profile_4.png"
            )
        );
        totalUser++;
    }

    modifier duplicateUser(string memory email, string memory username) {
        //chcek if email or usernamexistt
        bool exists = false;
        if (user.length > 0) {
            for (uint256 i = 0; i < user.length; i++) {
                if (
                    keccak256(abi.encodePacked(user[i].email)) ==
                    keccak256(abi.encodePacked(email)) ||
                    keccak256(abi.encodePacked(user[i].username)) ==
                    keccak256(abi.encodePacked(username))
                ) {
                    exists = true;
                    break;
                }
            }
        }
        require(!exists, "The email or username already exist.");
        _;
    }

    function register(
        uint256 userID,
        string memory firstName,
        string memory lastName,
        string memory email,
        string memory username,
        string memory password,
        string memory contactNum,
        string memory role,
        string memory homeAddress
    ) public duplicateUser(email, username) {
        user.push(
            Users(
                userID,
                firstName,
                lastName,
                email,
                username,
                password,
                contactNum,
                role,
                block.timestamp,
                homeAddress,
                "profile_4.png"
            )
        );
        totalUser++;
    }

    function showProfile(uint256 index) public view returns (Users memory) {
        Users storage userSelected = user[index];
        return userSelected;
    }

    function displayProfile(string memory username)
        public
        view
        returns (
            uint256,
            string memory,
            string memory,
            string memory,
            string memory,
            string memory,
            string memory,
            uint256,
            string memory,
            string memory
        )
    {

        Users storage userSelected = user[0];
        if (user.length > 0) {
            for (uint256 i = 0; i < user.length; i++) {
                if (
                    keccak256(abi.encodePacked(user[i].username)) ==
                    keccak256(abi.encodePacked(username))
                ) {
                    userSelected = user[i];
                    break;
                }
            }
        }
        return (
            userSelected.userID,
            userSelected.firstName,
            userSelected.lastName,
            userSelected.email,
            userSelected.username,
            userSelected.contactNum,
            userSelected.role,
            userSelected.dateJoined,
            userSelected.homeAddress,
            userSelected.profile_pic
        );
    }

    function deletePerson() public {
        user.pop();
        totalUser--;
    }

    function login(string memory inputUsername, string memory inputPassword)
        public
        view
        returns (bool)
    {
        bool exist = false;
        for (uint256 i = 0; i < user.length; i++) {
            if (
                keccak256(abi.encodePacked(user[i].username)) ==
                keccak256(abi.encodePacked(inputUsername)) &&
                keccak256(abi.encodePacked(user[i].password)) ==
                keccak256(abi.encodePacked(inputPassword))
            ) {
                exist = true;
            }
        }

        return exist;
    }

    // function updateProfile(
    //     uint256 _index,
    //     string memory _fristName,
    //     string memory _lastName
    // ) public {
    //     Person storage ppl = people[_index];
    //     ppl._fristName = _fristName;
    //     ppl._lastName = _lastName;
    // }

    // function deletePerson() public {
    //     people.pop();
    //     peopleCount--;
    // }

    // function getTotalIndex() public view returns (uint256) {
    //     return peopleCount;
    // }
}
