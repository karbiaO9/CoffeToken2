// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract CoffeToken is ERC20, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    event CoffePurchased(address indexed receiver , address indexed  buyer);



    constructor(address defaultAdmin, address minter) ERC20("CoffeToken", "CFE") {
        _grantRole(DEFAULT_ADMIN_ROLE, defaultAdmin);
        _grantRole(MINTER_ROLE, minter);
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount * 10 ** decimals());
    }

    function buyOneCoffe() public  {
        _burn(_msgSender(), 1 * 10 ** decimals());
        emit CoffePurchased(_msgSender(), _msgSender());
    }

    function buyOneCoffeFrom(address account) public  {
        _spendAllowance(account, _msgSender(), 1 * 10 ** decimals());
        _burn(account, 1);

        emit CoffePurchased(_msgSender(), account);
    }
}