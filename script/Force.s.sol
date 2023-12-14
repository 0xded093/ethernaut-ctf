pragma solidity ^0.8.10;

import {Script, console2} from "forge-std/Script.sol";
import "../src/Force/ForceFactory.sol";
import "../src/Force/ForceHack.sol";
import "../src/Ethernaut.sol";

contract ForceScript is Script {
    Ethernaut ethernaut;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        ethernaut = new Ethernaut();
        ForceFactory forceFactory = new ForceFactory();
        ethernaut.registerLevel(forceFactory);
        address levelAddress = ethernaut.createLevelInstance(forceFactory);
        Force ethernautForce = Force(payable(levelAddress));

        ForceHack forceHack = (new ForceHack){value: 0.1 ether}(payable(levelAddress));

        console2.log(address(levelAddress).balance);

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        assert(levelSuccessfullyPassed);
    }
}
