const Block = require('./Block');
const SHA256 = require('crypto-js/sha256');

class Blockchain {
    constructor() {
        let genesisBlock = new Block('Genesis Block');
        genesisBlock.previousHash = '0';
        this.chain = [genesisBlock];
    }
    addBlock(block) {
        block.previousHash = this.chain[this.chain.length - 1].toHash();
        this.chain.push(block);
    }
    isValid() {
        for (let i = this.chain.length - 1; i > 0; i--) {
            let currentBlock = this.chain[i];
            let previousHash1 = currentBlock.previousHash.toString();
            let previousBlock = this.chain[i - 1];
            let previousHash2 = previousBlock.toHash().toString();
            if (previousHash1 !== previousHash2) {
                return false;
            }
        }
        return true;
    }
}

module.exports = Blockchain;