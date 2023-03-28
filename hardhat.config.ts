import {HardhatUserConfig} from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const PRIVATE_KEY = "0x...";

const config: HardhatUserConfig = {
    solidity: "0.8.18",
    networks: {
        mainnet: {
            // avax mainnet
            url: "https://api.avax.network/ext/bc/C/rpc",
            accounts: [PRIVATE_KEY],
        },
        fuji: {
            // avax fuji testnet
            url: "https://api.avax-test.network/ext/bc/C/rpc",
            accounts: [PRIVATE_KEY],
        }
    }
};

export default config;
