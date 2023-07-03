const { providers } = require('ethers');
const { ganacheProvider } = require('./config');

const provider = new providers.Web3Provider(ganacheProvider);

//hints: provider.getBlockWithTransactions(block)
/**
 * Given an ethereum address find all the addresses
 * that were sent ether from that address
 * @param {string} address - The hexadecimal address for the sender
 * @async
 * @returns {Array} all the addresses that received ether
 */
async function findEther(address) {
    const recipients = [];
    const blockNumber = await provider.getBlockNumber();
    for (let i = 0; i < blockNumber + 1; i++) {
        const block = await provider.getBlockWithTransactions(i);
        const transactions = block.transactions;
        for (let j = 0; j < transactions.length; j++) {
            const transaction = transactions[j];
            if (transaction.from === address) {
                recipients.push(transaction.to);
            }
        }
    }
    return recipients;
}

module.exports = findEther; 