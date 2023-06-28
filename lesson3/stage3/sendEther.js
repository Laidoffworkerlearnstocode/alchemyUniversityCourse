const { Wallet, utils, providers } = require('ethers');
const { ganacheProvider, PRIVATE_KEY } = require('./config');

// TODO: replace undefined with a new web3 provider
const provider = new providers.Web3Provider(ganacheProvider);

const wallet = new Wallet(PRIVATE_KEY, provider);

async function sendEther({ value, to}) {
    // TODO: send the transaction and return the transaction promise
    const tx =await wallet.sendTransaction({value, to});
    return tx;
}

module.exports = sendEther;