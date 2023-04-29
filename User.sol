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
        string profile_pic;
        address payable wallet;
    }

    struct Clients {
        string location;
    }

    struct Farmers {
        string farmName;
        string location;
    }

    struct Retailers {
        string location;
        string shopName;
    }

    struct Distributors {
        string distributorName;
    }

    // An array of 'Todo' structs
    Users[] user;
    uint256 totalUser = 0;

    mapping(address => Farmers) farmers;

    mapping(address => Clients) clients;

    mapping(address => Retailers) retailers;

    mapping(address => Distributors) distributors;

    // constructor() {
    //     user.push(
    //         Users(
    //             1234567,
    //             "Fnag yEE",
    //             "tEE",
    //             "shink828@gmail.com",
    //             "tfy",
    //             "3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2", //123
    //             "012-222222",
    //             "Clients",
    //             block.timestamp,
    //             "profile_4.png",
    //             payable(msg.sender)
    //         )
    //     );
    //     totalUser++;
    // }

    function registerFarmer(address farmerAddress) public {
        register(
            7592712,
            "choon pin",
            "Wee",
            "shink34@gmail.com",
            "wcp",
            "3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2", //123
            "012-1234567",
            "Farmers"
        );

        farmers[farmerAddress].farmName = "HappyFarmABC";
        farmers[farmerAddress]
            .location = "Durian Farm (Appontment), Lebuhraya Kuala Lumpur - Gua Musang, 27600 Raub District, Pahang";
    }

    function registerClients(address clientsAddress) public {
        register(
            8192713,
            "chong min",
            "yeapo",
            "ycm@gmail.com",
            "ycm",
            "3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2", //123
            "019-81234213",
            "Clients"
        );

        clients[clientsAddress]
            .location = "Jalan Sekilau, Taman Ikhsan, 56000 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur";
    }

    function registerRetailers(address retailerAddress) public {
        register(
            1234567,
            "fang yee",
            "Tee",
            "shink828@gmail.com",
            "tfy",
            "3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2", //123
            "011-1234213",
            "Retailers"
        );

        retailers[retailerAddress].shopName = "Super Lariz Durian";
        retailers[retailerAddress]
            .location = "Jalan Sekilau, Taman Ikhsan, 56000 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur";
    }

    function registerDistributor(address distributorAddress) public {
        register(
            5981723,
            "Zongg Hao",
            "Ng",
            "shink@gmail.com",
            "ncp",
            "3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2", //123
            "016-8572213",
            "Distributors"
        );

        distributors[distributorAddress]
            .distributorName = "MusangKingDistributor (MSK)";
    }

    

    modifier checkUser(uint256 inputUserID, string memory oldPassword) {
        //chcek if email or usernamexistt
        bool exists = false;
        if (user.length > 0) {
            for (uint256 i = 0; i < user.length; i++) {
                if (
                    keccak256(abi.encodePacked(user[i].userID)) ==
                    keccak256(abi.encodePacked(inputUserID)) &&
                    keccak256(abi.encodePacked(user[i].password)) !=
                    keccak256(abi.encodePacked(oldPassword))
                ) {
                    exists = true;
                    break;
                }
            }
        }
        require(!exists, "Invalid old password.");
        _;
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

    modifier duplicateUsername(uint256 inputUserID, string memory username) {
        //chcek if email or usernamexistt
        bool exists = false;
        if (user.length > 0) {
            for (uint256 i = 0; i < user.length; i++) {
                if (
                    keccak256(abi.encodePacked(user[i].userID)) !=
                    keccak256(abi.encodePacked(inputUserID))
                ) {
                    if (
                        keccak256(abi.encodePacked(user[i].username)) ==
                        keccak256(abi.encodePacked(username))
                    ) {
                        exists = true;
                        break;
                    }
                }
            }
        }
        require(!exists, "The username already exist.");
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
        string memory role
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
                "profile_4.png",
                payable(msg.sender)
            )
        );
        totalUser++;
    }

    function updateProfile(
        uint256 inputUserID,
        string memory inpuUsername,
        string memory inpuFirstName,
        string memory inpuLastName,
        string memory inputContactNum
    ) public duplicateUsername(inputUserID, inpuUsername) {
        if (user.length > 0) {
            for (uint256 i = 0; i < user.length; i++) {
                if (
                    keccak256(abi.encodePacked(user[i].userID)) ==
                    keccak256(abi.encodePacked(inputUserID))
                ) {
                    user[i].username = inpuUsername;
                    user[i].firstName = inpuFirstName;
                    user[i].lastName = inpuLastName;
                    user[i].contactNum = inputContactNum;

                    break;
                }
            }
        }
    }

    function updateProfilePicture(
        uint256 inputUserID,
        string memory profileName
    ) public {
        if (user.length > 0) {
            for (uint256 i = 0; i < user.length; i++) {
                if (
                    keccak256(abi.encodePacked(user[i].userID)) ==
                    keccak256(abi.encodePacked(inputUserID))
                ) {
                    user[i].profile_pic = profileName;
                    break;
                }
            }
        }
    }

    function updatePassword(
        uint256 inputUserID,
        string memory oldPassword,
        string memory newPassword
    ) public checkUser(inputUserID, oldPassword) {
        if (user.length > 0) {
            for (uint256 i = 0; i < user.length; i++) {
                if (
                    keccak256(abi.encodePacked(user[i].userID)) ==
                    keccak256(abi.encodePacked(inputUserID))
                ) {
                    user[i].password = newPassword;
                    break;
                }
            }
        }
    }

    function retrieveProfile(string memory username)
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
            userSelected.profile_pic
        );
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
}
