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
}

module.exports = MerkleTree;