pragma solidity ^0.8.10;

import { Script, console2 } from 'forge-std/Script.sol';
import '../src/Elevator/ElevatorFactory.sol';
import '../src/Elevator/ElevatorHack.sol';
import '../src/Ethernaut.sol';

contract ElevatorScript is Script {
    Ethernaut ethernaut;

    function setUp() public { }

    function run() public {
        vm.startBroadcast();
        ethernaut = new Ethernaut();
        ElevatorFactory elevatorFactory = new ElevatorFactory();
        ethernaut.registerLevel(elevatorFactory);
        address levelAddress = ethernaut.createLevelInstance(elevatorFactory);
        Elevator elevator = Elevator(payable(levelAddress));

        console2.log('msg.sender is %s', msg.sender);

        ElevatorHack elevatorHack = new ElevatorHack(levelAddress);
        elevatorHack.attack();

        // msg.sender needs to be Building()

        bool top = elevator.top();
        uint floor = elevator.floor();
        console2.log('top: %s ', top);
        console2.log('floor: %s ', floor);

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        assert(levelSuccessfullyPassed);
        vm.stopBroadcast();
    }
}
