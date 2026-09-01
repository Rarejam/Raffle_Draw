// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Raffle} from "../src/Raffle.sol";
import {Script} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployRaffle is Script {
    function run() public {}

    function DeployContract() public returns (Raffle, HelperConfig) {
        HelperConfig helperConfig = new HelperConfig();
        // local -> deploy mocks, +get local config
        // sepolia -> get sepolia config
        HelperConfig.NetworkConfig memory config = helperConfig.getConfig();

        vm.startBroadcast();
        Raffle raffle = new Raffle(
            config.entranceFee,
            config.interval,
            config.gasLane,
            config.subscriptionId,
            config.callbackGasLimit,
            config.vrfCoordinator
        );
        vm.stopBroadcast();
        return (raffle, helperConfig);
    }
}
