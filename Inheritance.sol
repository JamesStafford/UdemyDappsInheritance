// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.5.7;
contract Will
{
    address owner;
    uint fortune;
    bool isDeceased;

    constructor() payable public
    {
        owner = msg.sender;
        fortune = msg.value;
        isDeceased = false;
    }

    modifier onlyOwner
    {
        require(msg.sender == owner);
        _;
    }

    modifier mustBeDeceased
    {
        require(isDeceased == true);
        _;
    }

    address payable[] familyWallets;

    mapping(address => uint) inheritance;

    function setInheritance(address payable wallet, uint amount) public
    {
        // to add wallets to familyWallets
        familyWallets.push(wallet);
        inheritance[wallet] = amount;
    }

    function payout() private mustBeDeceased
    {
        for(uint familyWalletIndex = 0; familyWalletIndex < familyWallets.length; familyWalletIndex++)
        {
            address payable familyWallet = familyWallets[familyWalletIndex];
            familyWallet.transfer(inheritance[familyWallet]);
        }
    }

    function deceased() public onlyOwner
    {
        isDeceased = true;
        payout();
    }
}
