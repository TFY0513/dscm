//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./Constant.sol";

contract User {
    struct Users {
        uint256 userID;
        string firstName;
        string lastName;
        string email;
        string username;
        string password;
        string contactNum;
        Constant.Role role;
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
    mapping(address => Users) user;
    uint256 totalUser = 0;

    mapping(address => Farmers) farmers;

    mapping(address => Clients) clients;

    mapping(address => Retailers) retailers;

    mapping(address => Distributors) distributors;

    function deployFarmer(address farmerAddress) public {
        //    uint256 userID;
        // string firstName;
        // string lastName;
        // string ;
        // string ;
        // string ;
        // string contactNum;
        // Constant.Role role;
        // uint256 ;
        // string profile_pic;
        // address payable ;

        user[farmerAddress].userID = 7592712;
        user[farmerAddress].firstName = "choon pin";
        user[farmerAddress].lastName = "Wee";
        user[farmerAddress].email = "shink34@gmail.com";
        user[farmerAddress].username = "wcp";
        user[farmerAddress]
            .password = "3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2";
        user[farmerAddress].contactNum = "012-1234567";
        user[farmerAddress].role = Constant.Role.FARMER;
        user[farmerAddress].dateJoined = block.timestamp;
        user[farmerAddress].profile_pic = "profile_4.png";
        user[farmerAddress].wallet = payable(msg.sender);

        totalUser++;

        farmers[farmerAddress].farmName = "HappyFarmABC";
        farmers[farmerAddress]
            .location = "Durian Farm (Appontment), Lebuhraya Kuala Lumpur - Gua Musang, 27600 Raub District, Pahang";
    }

    function deployClients(address clientsAddress) public {
        user[clientsAddress].userID = 8192713;
        user[clientsAddress].firstName = "chong min";
        user[clientsAddress].lastName = "yeap";
        user[clientsAddress].email = "ycm@gmail.com";
        user[clientsAddress].username = "ycm";
        user[clientsAddress]
            .password = "3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2";
        user[clientsAddress].contactNum = "019-81234213";
        user[clientsAddress].role = Constant.Role.CLIENT;
        user[clientsAddress].dateJoined = block.timestamp;
        user[clientsAddress].profile_pic = "profile_4.png";
        user[clientsAddress].wallet = payable(msg.sender);

        totalUser++;

        clients[clientsAddress]
            .location = "Jalan Sekilau, Taman Ikhsan, 56000 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur";
    }

    function deployRetailers(address retailerAddress) public {
        user[retailerAddress].userID = 1234567;
        user[retailerAddress].firstName = "fang yee";
        user[retailerAddress].lastName = "Tee";
        user[retailerAddress].email = "shink828@gmail.com";
        user[retailerAddress].username = "tfy";
        user[retailerAddress]
            .password = "3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2";
        user[retailerAddress].contactNum = "011-1234213";
        user[retailerAddress].role = Constant.Role.RETAILER;
        user[retailerAddress].dateJoined = block.timestamp;
        user[retailerAddress].profile_pic = "profile_4.png";
        user[retailerAddress].wallet = payable(msg.sender);

        totalUser++;

        retailers[retailerAddress].shopName = "Super Lariz Durian";
        retailers[retailerAddress]
            .location = "Jalan Sekilau, Taman Ikhsan, 56000 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur";
    }

    function deployDistributor(address distributorAddress) public {
        user[distributorAddress].userID = 5981723;
        user[distributorAddress].firstName = "Zongg Hao";
        user[distributorAddress].lastName = "Ng";
        user[distributorAddress].email = "shink@gmail.com";
        user[distributorAddress].username = "nzh";
        user[distributorAddress]
            .password = "3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2";
        user[distributorAddress].contactNum = "016-8572213";
        user[distributorAddress].role = Constant.Role.DISTRIBUTER;
        user[distributorAddress].dateJoined = block.timestamp;
        user[distributorAddress].profile_pic = "profile_4.png";
        user[distributorAddress].wallet = payable(msg.sender);

        totalUser++;
        distributors[distributorAddress]
            .distributorName = "MusangKingDistributor (MSK)";
    }

   

    modifier duplicateUser(address userAddress) {
        //chcek if email or usernamexistt
        bool exists = false;
        if (user[userAddress].userID != 0) {
            exists = true;
            // address exists in the mapping
            // you can perform the desired action here
        }
        require(
            !exists,
            "The user with this Ether wallet address already exist."
        );
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
        string memory location
    ) public duplicateUser(msg.sender) {
        user[msg.sender].userID = userID;
        user[msg.sender].firstName = firstName;
        user[msg.sender].lastName = lastName;
        user[msg.sender].email = email;
        user[msg.sender].username = username;
        user[msg.sender].password = password;
        user[msg.sender].contactNum = contactNum;
        user[msg.sender].role = Constant.Role.CLIENT;
        user[msg.sender].dateJoined = block.timestamp;
        user[msg.sender].profile_pic = "profile_4.png";
        user[msg.sender].wallet = payable(msg.sender);

        totalUser++;
        clients[payable(msg.sender)].location = location;
    }

   

    function retrieveProfile(address userAddress)
        public
        view
        returns (Users memory)
    {
        return user[userAddress];
        // return (
        //     user[userAddress].userID,
        //     user[userAddress].firstName,
        //     user[userAddress].lastName,
        //     user[userAddress].email,
        //     user[userAddress].username,
        //     user[userAddress].contactNum,
        //     user[userAddress].role,
        //     user[userAddress].dateJoined,
        //     user[userAddress].profile_pic,
        //     user[userAddress].wallet
        // );
    }

    function login(
        string memory inputUsername,
        string memory inputPassword,
        address userAddress
    ) public view returns (bool) {
        bool exist = false;
        if (
            keccak256(abi.encodePacked(user[userAddress].username)) ==
            keccak256(abi.encodePacked(inputUsername)) &&
            keccak256(abi.encodePacked(user[userAddress].password)) ==
            keccak256(abi.encodePacked(inputPassword))
        ) {
            exist = true;
        }

        return exist;
    }

    function displayTotalUser() public view returns (uint256) {
        return totalUser;
    }

    function displayFarmerDetail(address farmerAddress)
        public
        view
        returns (string memory farmName, string memory location)
    {
        return (
            farmers[farmerAddress].farmName,
            farmers[farmerAddress].location
        );
    }

    function displayClientsDetail(address clientsAddress)
        public
        view
        returns (string memory location)
    {
        return clients[clientsAddress].location;
    }

    function displayRetailerDetail(address retailersAddress)
        public
        view
        returns (string memory shopName, string memory location)
    {
        return (
            retailers[retailersAddress].shopName,
            retailers[retailersAddress].location
        );
    }

    function displayDistributorDetail(address distributorsAddress)
        public
        view
        returns (string memory distributorName)
    {
        return distributors[distributorsAddress].distributorName;
    }
}
