const { sha256 } = require("ethereum-cryptography/sha256");
const { toHex, utf8ToBytes } = require("ethereum-cryptography/utils");

// the possible colors that the hash could represent
const COLORS = ['red', 'green', 'blue', 'yellow', 'pink', 'orange'];

// given a hash, return the color that created the hash
function findColor(hash) {
    const colorHexArry = COLORS.map((color) => {
        return toHex(sha256(utf8ToBytes(color)))
    })
    const hex = toHex(hash)
    const colorIndex = colorHexArry.indexOf(hex)
    const color = COLORS[colorIndex]
    return color
}

module.exports = findColor;