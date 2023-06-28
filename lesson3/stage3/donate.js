const { utils, providers, Wallet } = require('ethers');
const { ganacheProvider } = require('./config');

const provider = new providers.Web3Provider(ganacheProvider);

/**
 * Donate at least 1 ether from the wallet to each charity
 * @param   {string} a hex string private key for a wallet with 10 ETH
 * @param   {array} an array of ethereum charity addresses 
 *
 * @returns {Promise} a promise that resolves after all donations have been sent
 */

async function donate(privateKey, charities) {
    // TODO: donate to charity!
    const wallet = new Wallet(privateKey, provider);
    console.log(charities);
    console.log(wallet);
    let nonce = await wallet.getTransactionCount();
    const result = await Promise.all(charities.map(charity => {
        const transaction = {
            to: charity,
            value: utils.parseEther('1.0'),
            nonce: nonce++
        };
        return wallet.sendTransaction(transaction);
    }));
    return result;
}

module.exports = donate;

