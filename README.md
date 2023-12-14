## Ethernaut CTF solved with Foundry

Solving Ethernaut CTF with Foundry scripts for on-chain testing.

- ✅ 1. Fallback
- ❌ 2. Fallout
- ❌ 3. CoinFlip
- ✅ 4. Telephone
- ✅ 5. Token
- ✅ 6. Delegation
- ❌ 7. Force
- ❌ 8. Vault
- ❌ 9. King
- ❌ 10. Re-Entrancy
- ❌ 11. Elevator
- ❌ 12. Privacy
- ❌ 13. GatekeeperOne
- ❌ 14. GatekeeperTwo
- ❌ 15. NaughtCoin
- ❌ 16. Preservation
- ❌ 17. Recovery
- ❌ 18. Magic Number
- ❌ 19. AlienCodex
- ❌ 20. Denial
- ❌ 21. Shop
- ❌ 22. Dex
- ❌ 23. Dex Two
- ❌ 24. PuzzleWallet
- ❌ 25. Motorbike

### How to run

Run local testnet

```shell
anvil
```

Add Private Key and RPC URL to `test.env` config file

```shell
PRIVATE_KEY=0x00000000000000000000000000000000000000000000000000
RPC_URL=http://127.0.0.1:8545
```

```shell
source test.env
```

Run forge script for level 1 - Fallback

```shell
forge script --private-key $PRIVATE_KEY --rpc-url $RPC_URL -vvvvv --broadcast --verify src/script/Fallback.s.sol:FallbackScript
```

Example `cast` command to call a function

```shell
cast call $CONTRACT_ADDRESS "getContribution()(uint)" \
--private-key $PRIVATE_KEY --rpc-url $RPC_URL
```
