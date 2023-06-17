const secp = require("ethereum-cryptography/secp256k1");
const { keccak256 } = require("ethereum-cryptography/keccak");

function getAddress(publicKey) {
    const firstByte = publicKey[0];
    const restBytes = publicKey.slice(1);
    const hash = keccak256(restBytes).slice(-20);
    return hash;
}

module.exports = getAddress;