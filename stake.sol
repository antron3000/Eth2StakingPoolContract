pragma solidity ^0.6.12;

import "./E2.sol";

contract stake{
    address admin;

    address payable stakingPool;

    E2 t;

    constructor (address payable _stakingPool) public {
        stakingPool = _stakingPool;
        t = new E2();
    }

    function deposit() public payable{
        t.mintE2(msg.sender,msg.value);
    }

    function withdraw() public {
        uint balance = t.balanceOf(msg.sender);
        uint EthToReceive = EthToReceive(balance);
        t.burnE2(msg.sender,balance);
        msg.sender.transfer(EthToReceive);
    }

    //gets the amount
    function EthToReceive(uint amountTokens) public view returns(uint) {
        return((address(this).balance*amountTokens)/t.totalSupply());
    }

    function depositToPool() public {
        require(msg.sender==admin);
        stakingPool.transfer(address(this).balance);
    }

    function withdrawFromPool() public{

    }

}
