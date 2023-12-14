pragma solidity ^0.8.10;

import {Script, console2} from "forge-std/Script.sol";
import "../src/Telephone/TelephoneHack.sol";
import "../src/Telephone/TelephoneFactory.sol";
import "../src/Ethernaut.sol";

contract TelephoneScript is Script {
    Ethernaut ethernaut;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        ethernaut = new Ethernaut();
        TelephoneFactory telephoneFactory = new TelephoneFactory();
        ethernaut.registerLevel(telephoneFactory);
        address levelAddress = ethernaut.createLevelInstance(telephoneFactory);
        Telephone ethernautTelephone = Telephone(payable(levelAddress));

        TelephoneHack telephoneHack = new TelephoneHack(levelAddress);
        telephoneHack.attack();

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        assert(levelSuccessfullyPassed);

        vm.stopBroadcast();
    }
}
