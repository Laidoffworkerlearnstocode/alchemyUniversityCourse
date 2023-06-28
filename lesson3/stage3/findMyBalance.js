const { Wallet, providers } = require('ethers');
const { ganacheProvider } = require('./config');

const provider = new providers.Web3Provider(ganacheProvider);

function findMyBalance(privateKey) {
    // retrieve the balance, given a private key
    const wallet = new Wallet(privateKey, provider);
    const myBalance = wallet.getBalance();
    return myBalance;
}

module.exports = findMyBalance;