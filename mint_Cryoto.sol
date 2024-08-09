// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract MintYourCoins {
    address public minter;
    mapping(address => uint) public balance;
    event Sent(address from, address to, uint amount);

    // Constructor
    constructor() {
        minter = msg.sender;
    }

    // Function to mint new coins
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter, "Only the minter can mint coins.");
        require(amount < 1e60, "Amount must be less than 1e60.");
        balance[receiver] += amount;
    }

    // Function to transfer coins to another address
    function transfer(address receiver, uint amount) public {
        require(amount <= balance[msg.sender], "Insufficient balance.");
        balance[msg.sender] -= amount;
        balance[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }

    // Function to view balance of an account
    function balances(address _account) external view returns (uint) {
        return balance[_account];
    }
}