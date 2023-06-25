
function verify(proof, node, root, concat) {
    let hash = node;
    for (let i = 0; i < proof.length; i++) {
        let { data, left } = proof[i];
        if (left) {
            hash = concat(data, hash);
        } else {
            hash = concat(hash, data);
        }
    }
    return hash === root;
}

module.exports = verify;