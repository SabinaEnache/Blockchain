// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./TokenBanit.sol";

contract PuncteFidelitate {
    mapping(address => uint256) public puncte;
    //event PuncteAdaugate(address indexed user, uint256 puncte);

    TokenBanit public tokenBanit;

    constructor(address tokenAddress) {
        tokenBanit = TokenBanit(tokenAddress);
    }

    function genereazaPuncte(address user, uint256 amount) external {
        require(tokenBanit.balanceOf(user) >= amount, "Insufficient tokens");
        uint256 puncteGenerate = amount / 10;
        puncte[user] += puncteGenerate;
        //emit PuncteAdaugate(user, puncteGenerate);
    }

    function folosestePuncte(address user, uint256 amount) external {
        require(puncte[user] >= amount, "Insufficient points");
        puncte[user] -= amount;
    }
}
