require('dotenv').config();
const { API_KEY } = process.env;
const axios = require('axios');
const url = `https://eth-mainnet.g.alchemy.com/v2/${API_KEY}`;

async function getTotalBalance(addresses) {
    const batch = addresses.map((address, i) => {
        return {
            jsonrpc: '2.0',
            method: 'eth_getBalance',
            params: [address, 'latest'],
            id: i
        }
    });

    const response = await axios.post(url, batch);
    
    // use this if you want to inspect the response data!
    console.log(response.data);
    
    // return the total balance of all the addresses 
    const totalBalance = response.data.reduce((acc, curr) => acc + parseInt(curr.result, 16), 0);
    return totalBalance;
}

module.exports = getTotalBalance;