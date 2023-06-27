const path = require('path');
require('dotenv').config({ path: path.resolve(__dirname, '../../.env') });
const { API_KEY } = process.env;

const axios = require('axios');
const axiosInstance = axios.create({
    proxy: false
});

const url = `https://eth-mainnet.g.alchemy.com/v2/${API_KEY}`;

async function getBalance(address) {
    const response = await axiosInstance.post(url, {
        jsonrpc: "2.0",
        id: 1,
        method: "eth_getBalance", // <-- fill in the method
        params: ["0xe5cB067E90D5Cd1F8052B83562Ae670bA4A211a8", "latest"],  // <-- fill in the params
    });

    // use this if you want to inspect the response data!
    console.log(response.data);

    // TODO: return the balance of the address
    return response.data.result;
}

// module.exports = getBalance;
getBalance();