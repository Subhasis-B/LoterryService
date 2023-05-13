// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Loterry{
    address private owner;
    address payable[] public players;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {
        require(msg.value == 1 ether);
        players.push(payable(msg.sender));
    }

    function getBalence() private view returns (uint){
        return address(this).balance;
    }

    function winer() public {
        require(msg.sender == owner && players.length > 5);
        uint i = uint(keccak256(abi.encodePacked(block.timestamp,owner,players))) % players.length;
        players[i].transfer(getBalence());
    }
}