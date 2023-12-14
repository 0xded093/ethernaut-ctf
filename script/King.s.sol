pragma solidity ^0.8.10;

import {Script, console2} from "forge-std/Script.sol";
import "../src/King/KingFactory.sol";
import "../src/King/KingHack.sol";
import "../src/Ethernaut.sol";

contract KingScript is Script {
    Ethernaut ethernaut;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        ethernaut = new Ethernaut();
        KingFactory kingFactory = new KingFactory();
        ethernaut.registerLevel(kingFactory);
        address levelAddress = ethernaut.createLevelInstance{value: 1 ether}(kingFactory);
        King ethernautKing = King(payable(levelAddress));

        console2.log("King is %s", ethernautKing._king());
        console2.log("King balance before prize is %s", address(ethernautKing._king()).balance);
        console2.log("Prize is %s", ethernautKing.prize());
        console2.log("msg.sender", msg.sender);
        console2.log("owner", ethernautKing.owner());

        KingHack kingHack = new KingHack(levelAddress);
        kingHack.attack{value: 1 ether}();

        console2.log("King balance after prize is %s", address(ethernautKing._king()).balance);
        console2.log("King after prize is %s", ethernautKing._king());
        console2.log("Prize now is %s", ethernautKing.prize());

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        assert(levelSuccessfullyPassed);
        vm.stopBroadcast();
    }
}
