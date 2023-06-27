const axios = require('axios');
const path = require('path');
require('dotenv').config({ path: path.resolve(__dirname, '../../.env') });

const url = `https://eth-mainnet.g.alchemy.com/v2/${process.env.API_KEY}`;
const axiosInstance = axios.create({
    proxy: false
});

async function getBlockNumber() {
    const response = await axiosInstance.post(url, {
        jsonrpc: "2.0",
        id: 1,
        method: "eth_blockNumber",
    });

    // axios has a data prop which is the response from the server
    // TOOD: use this console log to locate the block number
    console.log(response.data); 

    // TODO: return the block number
    const blockNumber = response.data.result;
    return blockNumber;
}

// module.exports = getBlockNumber;

getBlockNumber();