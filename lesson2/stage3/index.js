function concatenate(a, b) {
    return `Hash(${a} + ${b})`;
}

class MerkleTree {
    constructor(leaves, concat) {
        this.leaves = leaves;
        this.concat = concat;
    }
    getRoot() {
        if (this.leaves.length === 1) {
            return this.leaves[0];
        } else if (this.leaves.length > 1 && this.leaves.length % 2 === 0) {
            let newLeaves = [];
            for (let i = 0; i < this.leaves.length; i+=2) {
                let a = this.leaves[i];
                let b = this.leaves[i+1];
                let c = this.concat(a, b);
                newLeaves.push(c);
            }
            this.leaves = newLeaves;
            return this.getRoot();
        } else if (this.leaves.length > 1 && this.leaves.length % 2 === 1) {
            let lastLeaf = this.leaves[this.leaves.length - 1];
            let newLeaves = [];
            for (let i = 0; i < this.leaves.length-1; i+=2) {
                let a = this.leaves[i];
                let b = this.leaves[i+1];
                let c = this.concat(a, b);
                newLeaves.push(c);
            }
            newLeaves.push(lastLeaf);
            this.leaves = newLeaves;
            return this.getRoot();
        }
    }

    getProof(index, layer=this.leaves, proof=[]){
        if (layer.length === 1) {
            return proof;
        }
        const newLayer = [];
        for (let i = 0; i < layer.length; i+=2) {
            let left = layer[i];
            let right = layer[i+1];
            if (!right) {
                newLayer.push(left);
            } else {
                newLayer.push(this.concat(left, right));
                if (i === index || i ===index - 1) {
                    let isLeft = !(index % 2);
                    proof.push({
                        data: isLeft ? right : left,
                        left: !isLeft
                    });
                }
            }
        }
        return this.getProof(Math.floor(index/2), newLayer, proof);
    }

    verify(proof, node, root, concat) {
        let hash = node;
        for (let i = 0; i < proof.length; i++) {
            let {data, left} = proof[i];
            if (left) {
                hash = concat(data, hash);
            } else {
                hash = concat(hash, data);
            }
        }
        return hash === root;
    }
}

module.exports = MerkleTree;